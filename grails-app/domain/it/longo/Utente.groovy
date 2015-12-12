package it.longo

import org.grails.databinding.BindingFormat

class Utente {

    transient springSecurityService

    String password
    String username

    String nome
    String cognome
    String citta
    @BindingFormat('dd/MM/yyyy')
    Date dataNascita
    String sesso
    String posizione = "Posizione lavorativa"
    String azienda

    Preferences preferenze = new Preferences()

    boolean enabled = true
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired

    static transients = ['springSecurityService']

    static constraints = {
        username blank: false, unique: true, email: true
        password blank: false
        nome blank: true
        cognome blank: true
        dataNascita nullable: true
        sesso nullable: true
        posizione nullable: true
        citta nullable: true
        azienda nullable: true
    }

    static mapping = {
        password column: '`password`'
    }

    Set<Ruolo> getAuthorities() {
        UtenteRuolo.findAllByUtente(this).collect { it.ruolo }
    }

    def beforeInsert() {
        encodePassword()
    }

    def beforeUpdate() {
        if (isDirty('password')) {
            encodePassword()
        }
    }

    protected void encodePassword() {
        password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
    }

    enum Sesso {
        M, F
    }
}
