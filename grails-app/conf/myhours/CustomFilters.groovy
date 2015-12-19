package myhours

import it.longo.Utente

class CustomFilters {

    def springSecurityService

    def filters = {
        all(controller:'home', action:'index') {
            before = {

            }
            after = { Map model ->

            }
            afterView = { Exception e ->
                Utente utente = springSecurityService.currentUser
                if(utente?.firstLogin) {
                    utente?.firstLogin = false
                    utente?.save(flush: true, failOnError: true)
                }

            }
        }
    }
}
