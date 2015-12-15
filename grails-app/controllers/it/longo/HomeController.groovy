package it.longo

import grails.plugin.springsecurity.annotation.Secured
import groovy.time.Duration
import groovy.time.TimeCategory
import groovy.time.TimeDuration

import java.text.SimpleDateFormat

@Secured(['ROLE_USER', 'ROLE_ADMIN'])
class HomeController {

    def springSecurityService

    def timeService

    def index() {

        def todayDate = new Date()
        def today = todayDate.parse("dd/MM/yyyy", todayDate.format("dd/MM/yyyy")).clearTime()
        def todayRecord = RecordTime.findByDataRecordAndUtente(today, springSecurityService.currentUser)

        if(!todayRecord) {
            todayRecord = new RecordTime(params)
        }

        Map statistics = timeService.calculateStatistics(todayDate)

        def criteria = RecordTime.createCriteria()
        def recordList = criteria.list([max: 5]) {
            eq("utente", springSecurityService.currentUser)
            order("dataRecord", "desc")
        }

        def oraUscita = calcoloUscita(todayRecord, 0)

        def liveCountFirst = "${formatDate(format: 'MMMM dd', date: todayRecord.uscitaTime ? todayDate+1 : todayDate, locale: new Locale("en","EN"))}"
        def liveCountStart = todayRecord.entrataTime?:"00:00"
        if(todayRecord.entrataTime && todayRecord.inizioPausaTime && todayRecord.finePausaTime) {
            def intIngresso = timeService.fromStringHoursToInt(todayRecord.entrataTime)
            def intInizio = timeService.fromStringHoursToInt(todayRecord.inizioPausaTime)
            def intFine = timeService.fromStringHoursToInt(todayRecord.finePausaTime)
            liveCountStart = timeService.fromIntHoursToString(intIngresso + (intFine-intInizio))
        }
        def liveCountSecond = "${todayDate.format('yyyy')} ${liveCountStart}:00"

        render view: 'index', model: [recordTimeInstance: todayRecord, recordList: recordList,
                oraUscita: oraUscita,
                statistics: statistics,
                liveCountFirst: liveCountFirst, liveCountSecond: liveCountSecond,
                isFirstVisit: springSecurityService.currentUser?.firstLogin]

    }

    def calcoloUscita(RecordTime todayRecord, def minutesToCount) {

        def todayDate = new Date()
        def oraUscita

        if(todayRecord.entrataTime && todayRecord.inizioPausaTime && todayRecord.finePausaTime) {

            def ingresso = Date.parse("dd/MM/yyyy HH:mm", todayDate.format("dd/MM/yyyy")+" "+todayRecord.entrataTime)
            def inizioPausa = Date.parse("dd/MM/yyyy HH:mm", todayDate.format("dd/MM/yyyy")+" "+todayRecord.inizioPausaTime)
            def finePausa = Date.parse("dd/MM/yyyy HH:mm", todayDate.format("dd/MM/yyyy")+" "+todayRecord.finePausaTime)

            TimeDuration durataMattina = TimeCategory.minus(inizioPausa, ingresso)
            TimeDuration durataPausaPranzo = TimeCategory.minus(finePausa, inizioPausa)

            use( TimeCategory ) {

                if(durataPausaPranzo < 30.minutes) {
                    println "La pausa pranzo è durata meno di 30 minuti"
                    finePausa+=(30.minutes - durataPausaPranzo)
                }

                def oreLavorate = 7.hours + (45+minutesToCount).minutes - durataMattina
                oraUscita = finePausa + oreLavorate
            }
        }

        return oraUscita
    }

    def calcoloUscitaAjax() {

        def todayDate = new Date()
        def today = todayDate.parse("dd/MM/yyyy", todayDate.format("dd/MM/yyyy")).clearTime()
        def todayRecord = RecordTime.findByDataRecordAndUtente(today, springSecurityService.currentUser)
        def oraCalcolata

        if(todayRecord) {
            oraCalcolata = calcoloUscita(todayRecord, params.int("valore"))
        }

        render template: 'ora_uscita', model: [oraUscita: oraCalcolata]
    }


    def profile() {
        def countTotaleLavorati = RecordTime.countByUtente(springSecurityService.currentUser)
        render(view: 'profile', model: [utente: springSecurityService.currentUser, totaleGiorni: countTotaleLavorati])
    }

    def updateProfile() {
        Utente user = springSecurityService.currentUser
        bindData(user, params)
        user.validate()
        if(user.hasErrors()) {
            println "Errore durante l'aggiornamento dell'utente: "+user.errors
            render(view: 'profile', model: [utente: user, errors: user.errors])
            return
        }

        user.save flush: true
        springSecurityService.reauthenticate user.username

        flash.message = "Il tuo profilo è stato aggiornato correttamente"
        render(view: 'profile', model: [utente: springSecurityService.currentUser])
    }
}
