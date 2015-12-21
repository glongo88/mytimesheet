package it.longo

import grails.transaction.Transactional
import groovy.time.TimeCategory
import groovy.time.TimeDuration
import it.longo.RecordTime
import it.longo.Utente
import org.joda.time.DateTime

@Transactional
class TimeService {

    def springSecurityService

    def calculateStatistics(Date data) {

        Map returnStats = [:]

        def query = RecordTime.where {
            utente == springSecurityService.currentUser
            year(dataRecord) == data.format("yyyy")
            month(dataRecord) == data.format("MM")
        }

        def sumTotaleLavoratoMese = query.sum("totaleLavorato")
        def sumStraordinariMese = query.sum("minutiStraordinario")

        returnStats.put("totaleLavoratoMese", sumTotaleLavoratoMese.get())
        returnStats.put("minutiStraordinarioMese", sumStraordinariMese.get())

        int sumLavoratoSettimana = 0
        DateTime oggi = new DateTime()
        query.each {
            if(new DateTime(it.dataRecord)?.weekOfWeekyear().get()==oggi.weekOfWeekyear().get()) {
                sumLavoratoSettimana+=it.totaleLavorato
            }
        }

        returnStats.put("totaleLavoratoSettimana", sumLavoratoSettimana)

        return returnStats

    }

    def setMinutiLavorati(RecordTime recordTimeInstance) {

        //c'è la pausa pranzo
        if(recordTimeInstance.entrataTime!=null && recordTimeInstance.inizioPausaTime!=null && recordTimeInstance.finePausaTime!=null && recordTimeInstance.uscitaTime!=null) {
            if(recordTimeInstance.entrataTime!="vuoto" && recordTimeInstance.inizioPausaTime!="vuoto" && recordTimeInstance.finePausaTime!="vuoto" && recordTimeInstance.uscitaTime!="vuoto") {
                def ingressoDate = Date.parse("dd/MM/yyyy HH:mm", new Date().format("dd/MM/yyyy")+" "+recordTimeInstance.entrataTime)
                def inizioPausaDate = Date.parse("dd/MM/yyyy HH:mm", new Date().format("dd/MM/yyyy")+" "+recordTimeInstance.inizioPausaTime)
                def finePausaDate = Date.parse("dd/MM/yyyy HH:mm", new Date().format("dd/MM/yyyy")+" "+recordTimeInstance.finePausaTime)
                def uscitaDate = Date.parse("dd/MM/yyyy HH:mm", new Date().format("dd/MM/yyyy")+" "+recordTimeInstance.uscitaTime)

                TimeDuration durataTotale = TimeCategory.minus(inizioPausaDate, ingressoDate) + TimeCategory.minus(uscitaDate, finePausaDate)

                recordTimeInstance.totaleLavorato = durataTotale.hours*60 + durataTotale.minutes
            }
        //non c'è la pausa pranzo
        } else if(recordTimeInstance.entrataTime!=null && recordTimeInstance.inizioPausaTime==null && recordTimeInstance.finePausaTime==null && recordTimeInstance.uscitaTime!=null) {

            def ingressoDate = Date.parse("dd/MM/yyyy HH:mm", new Date().format("dd/MM/yyyy")+" "+recordTimeInstance.entrataTime)
            def uscitaDate = Date.parse("dd/MM/yyyy HH:mm", new Date().format("dd/MM/yyyy")+" "+recordTimeInstance.uscitaTime)

            TimeDuration durataTotale = TimeCategory.minus(uscitaDate, ingressoDate)

            recordTimeInstance.totaleLavorato = durataTotale.hours*60 + durataTotale.minutes

        }

    }

    def setMinutiPausa(RecordTime recordTimeInstance) {

        if(recordTimeInstance.inizioPausaTime && recordTimeInstance.finePausaTime) {
            if(recordTimeInstance.inizioPausaTime!="vuoto" && recordTimeInstance.finePausaTime!="vuoto") {
                def inizioPausaDate = Date.parse("dd/MM/yyyy HH:mm", new Date().format("dd/MM/yyyy")+" "+recordTimeInstance.inizioPausaTime)
                def finePausaDate = Date.parse("dd/MM/yyyy HH:mm", new Date().format("dd/MM/yyyy")+" "+recordTimeInstance.finePausaTime)

                TimeDuration durataPausa = TimeCategory.minus(finePausaDate, inizioPausaDate)

                recordTimeInstance.minutiPausaPranzo = durataPausa.hours*60 + durataPausa.minutes
            }
        }

    }

    def setStraordinario(RecordTime recordTimeInstance, Integer totaleOreGiornaliere = 8) {
        if(recordTimeInstance.totaleLavorato) {
            if((recordTimeInstance.totaleLavorato - totaleOreGiornaliere*60)>0) {
                recordTimeInstance.minutiStraordinario = recordTimeInstance.totaleLavorato - totaleOreGiornaliere*60
            } else {
                recordTimeInstance.minutiStraordinario = 0
            }
        }
    }

    def riepilogoMese(Date data) {

        Map stats = [:]

        def query = RecordTime.where {
            eq("utente", springSecurityService.currentUser)
            year(dataRecord) == data.format("yyyy")
            month(dataRecord) == data.format("MM")
            isNotNull("totaleLavorato")
            ne("totaleLavorato", 0)
        }

        def numeroGiorni = query.count()
        def sumTotaleLavorato = query.sum("totaleLavorato")
        def sumStraordinari = query.sum("minutiStraordinario")
        def avgTotaleLavorato = query.avg("totaleLavorato")
        def avgPausa = query.avg("minutiPausaPranzo")

        stats.totaleLavorato = sumTotaleLavorato.get()
        stats.minutiStraordinario = sumStraordinari.get()
        stats.avgTotaleLavorato = avgTotaleLavorato.get()
        stats.numeroGiorni = numeroGiorni
        stats.avgPausaPranzo = avgPausa.get()

        return stats
    }

    def fromStringHoursToInt(String hour) {
        def (ore, minuti) = hour.tokenize(':')
        return (ore.toInteger()*60)+minuti.toInteger()
    }

    def fromIntHoursToString(Integer minutes) {
        def ore = (int)minutes/60
        def minuti = (int)minutes%60
        return "${ore<9?'0':''}${ore>0?ore:0}:${minuti<9?'0':''}${minuti>0?minuti:0}"
    }

    def updateStraordinari() {
        Utente utente = springSecurityService.currentUser
        RecordTime.createCriteria().list {
            utente == springSecurityService.currentUser
        }?.each {
            setStraordinario(it, utente?.preferenze?.totaleOreGiornaliere)
        }
    }

}
