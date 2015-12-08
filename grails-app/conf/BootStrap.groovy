import it.longo.Ruolo
import it.longo.Utente
import it.longo.UtenteRuolo

class BootStrap {

    def springSecurityService

    def init = { servletContext ->

        Ruolo adminRole = Ruolo.findByAuthority('ROLE_ADMIN') ?: new Ruolo(authority: 'ROLE_ADMIN').save(failOnError: true)
        Ruolo userRole = Ruolo.findByAuthority('ROLE_USER') ?: new Ruolo(authority: 'ROLE_USER').save(failOnError: true)

        /* Inserimento user admin */
        if(!Utente.findByUsername("peppe6000@yahoo.it")) {
            def admin = new Utente(username: 'peppe6000@yahoo.it', userRealName: 'admin',
                    password: 'admin',
                    nome: 'Giuseppe',
                    cognome: 'Longo',
                    enabled: true, email: 'peppe6000@yahoo.it')
            admin.save(failOnError: true)
            UtenteRuolo.create(admin, adminRole)
            UtenteRuolo.create(admin, userRole)
        }

    }
    def destroy = {
    }
}
