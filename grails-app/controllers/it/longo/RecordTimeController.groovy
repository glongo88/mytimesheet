package it.longo

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import groovy.time.TimeCategory
import groovy.time.TimeDuration
import org.joda.time.DateTime
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter

import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(['ROLE_USER', 'ROLE_ADMIN'])
@Transactional(readOnly = true)
class RecordTimeController {

    def springSecurityService

    def timeService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", editLive:"POST"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        Date prevMonth
        Date nextMonth

        def monthPrevNumber = params.month.toInteger()-1
        def monthNextNumber = params.month.toInteger()+1

        DateTime dateTime = new DateTime(params.year.toInteger(), params.month.toInteger(), 1, 0, 0);
        def lista = RecordTime.where {
            utente == springSecurityService.currentUser
            year(dataRecord) == dateTime.toDate().format("yyyy")
            month(dataRecord) == dateTime.toDate().format("MM")
        }.list()
        Map records = [:]
        lista.each {
            records.put(it.dataRecord, it)
        }

        if(monthPrevNumber>0) {
            prevMonth = new DateTime(params.year.toInteger(), monthPrevNumber, 1, 0, 0).toDate()
        } else {
            prevMonth = new DateTime(params.year.toInteger()-1, 12, 1, 0, 0).toDate()
        }

        if(monthNextNumber<12) {
            nextMonth = new DateTime(params.year.toInteger(), monthNextNumber, 1, 0, 0).toDate()
        } else {
            nextMonth = new DateTime(params.year.toInteger()+1, 1, 1, 0, 0).toDate()
        }

        render view: 'index', model: [month: params.month, year: params.year, prevMonth: prevMonth, nextMonth: nextMonth, records: records]
    }

    def selectMonth(String month, String year) {
        redirect(action: 'index', params: [month: month, year: year])
    }

    def show(RecordTime recordTimeInstance) {
        respond recordTimeInstance
    }

    def create() {
        respond new RecordTime(params)
    }

    @Transactional
    def save(RecordTime recordTimeInstance) {

        if (recordTimeInstance == null) {
            notFound()
            return
        }

        Utente utente = springSecurityService.currentUser
        recordTimeInstance.utente = utente

        if (recordTimeInstance.hasErrors()) {
            println "Errori: ${recordTimeInstance.errors}"
            redirect(controller: 'home')
            return
        }

        timeService.setMinutiLavorati(recordTimeInstance)
        timeService.setMinutiPausa(recordTimeInstance)
        timeService.setStraordinario(recordTimeInstance, utente?.preferenze?.totaleOreGiornaliere)

        flash.title = "${message(code: 'record.creato.title')}"
        flash.message = "${message(code: 'record.creato.messaggio')}"

        recordTimeInstance.save flush: true

        redirect(controller: 'home')
    }

    @Transactional
    def saveInstance(RecordTime recordTimeInstance) {

        if (recordTimeInstance == null) {
            notFound()
            return
        }

        Utente utente = springSecurityService.currentUser
        recordTimeInstance.utente = utente

        if (recordTimeInstance.hasErrors()) {
            println "Errori: ${recordTimeInstance.errors}"
            redirect(controller: 'home')
            return
        }

        timeService.setMinutiLavorati(recordTimeInstance)
        timeService.setMinutiPausa(recordTimeInstance)
        timeService.setStraordinario(recordTimeInstance, utente?.preferenze?.totaleOreGiornaliere)

        flash.title = "${message(code: 'record.creato.title')}"
        flash.message = "${message(code: 'record.creato.messaggio')}"

        recordTimeInstance.save flush: true
    }

    def edit(RecordTime recordTimeInstance) {
        respond recordTimeInstance
    }

    def editLive = {
        Utente utente = springSecurityService.currentUser
        RecordTime recordTimeInstance = RecordTime.get(params.pk)
        recordTimeInstance."${params.name}" = "${params.value}"
        timeService.setMinutiLavorati(recordTimeInstance)
        timeService.setMinutiPausa(recordTimeInstance)
        timeService.setStraordinario(recordTimeInstance, utente?.preferenze?.totaleOreGiornaliere)
        saveInstance(recordTimeInstance)
        render 'ok'
        //response.status = 200
    }

    def updateValuesLive = {
        Map returnValues = [:]
        if(params.id!="undefined") {
            def ore
            def minuti
            RecordTime recordTimeInstance = RecordTime.get(params.id)
            if(recordTimeInstance) {
                ore = (int)recordTimeInstance?.totaleLavorato/60
                minuti = recordTimeInstance?.totaleLavorato%60
                returnValues.put("totaleLavorato","${ore} ore e ${minuti} minuti")
                ore = (int)recordTimeInstance?.minutiStraordinario/60
                minuti = recordTimeInstance?.minutiStraordinario%60
                returnValues.put("minutiStraordinario","${ore} ore e ${minuti} minuti")
            }
            render returnValues as JSON
        }
    }

    @Transactional
    def createLive(String day, String month, String year) {

        RecordTime recordTimeInstance = new RecordTime()
        recordTimeInstance.dataRecord = new DateTime(year.toInteger(), month.toInteger(), day.toInteger(), 0, 0).toDate()
        recordTimeInstance.entrataTime = params.entrataTime
        recordTimeInstance.inizioPausaTime = params.inizioPausaTime
        recordTimeInstance.finePausaTime = params.finePausaTime
        recordTimeInstance.uscitaTime = params.uscitaTime

        Utente utente = springSecurityService.currentUser
        recordTimeInstance.utente = utente

        timeService.setMinutiLavorati(recordTimeInstance)
        timeService.setMinutiPausa(recordTimeInstance)
        timeService.setStraordinario(recordTimeInstance, utente?.preferenze?.totaleOreGiornaliere)

        saveInstance(recordTimeInstance)

        render recordTimeInstance as JSON

    }

    @Transactional
    def update() {

        RecordTime recordTimeInstance = RecordTime.findByDataRecordAndUtente(new Date().clearTime(), springSecurityService.currentUser)
        if (recordTimeInstance == null) {
            notFound()
            return
        }

        bindData(recordTimeInstance, params, [exclude:['dataRecord']])

        Utente utente = springSecurityService.currentUser
        recordTimeInstance.utente = utente

        if (recordTimeInstance.hasErrors()) {
            println "Errori: ${recordTimeInstance.errors}"
            redirect(controller: 'home')
            return
        }

        timeService.setMinutiLavorati(recordTimeInstance)
        timeService.setMinutiPausa(recordTimeInstance)
        timeService.setStraordinario(recordTimeInstance, utente?.preferenze?.totaleOreGiornaliere)

        recordTimeInstance.save flush: true

        flash.title = "${message(code: 'record.aggiornato.title')}"
        flash.message = "${message(code: 'record.aggiornato.messaggio')}"

        redirect(controller: 'home')
    }

    @Transactional
    def delete(RecordTime recordTimeInstance) {

        if (recordTimeInstance == null) {
            notFound()
            return
        }

        recordTimeInstance.delete flush: true

        render 'ok'
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'recordTime.label', default: 'RecordTime'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
