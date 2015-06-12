package it.longo

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_USER'])
class RiepilogoController {

    def timeService

    def springSecurityService

    def riepilogoMese = {
        def data = new Date()
        data.set(month: params.int('month')-1, year: params.int('year'))
        Map stats = timeService.riepilogoMese(data)

        def query = RecordTime.where {
            eq("utente", springSecurityService.currentUser)
            year(dataRecord) == data.format("yyyy")
            month(dataRecord) == data.format("MM")
            isNotNull("totaleLavorato")
            ne("totaleLavorato", 0)
        }

        def lista = query.list(sort: "dataRecord", order: "asc")

        render view: 'riepilogoMese', model: [stats: stats, month: params.month, year: params.year, lista: lista]
    }

}
