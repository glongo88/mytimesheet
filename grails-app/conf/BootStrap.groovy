import it.longo.Ruolo
import it.longo.Utente
import it.longo.UtenteRuolo

class BootStrap {

    def springSecurityService

    def init = { servletContext ->

        /*def adminRole = new Ruolo(authority: 'ROLE_ADMIN').save(flush: true)
        def userRole = new Ruolo(authority: 'ROLE_USER').save(flush: true)

        def testUser = new Utente(username: 'admin', password: 'admin')
        testUser.save(flush: true)

        UtenteRuolo.create testUser, adminRole, true
        UtenteRuolo.create testUser, userRole, true*/

    }
    def destroy = {
    }
}
