package it.longo

class Preferences {

    Boolean isSaturdayExtra = true
    Boolean isHalfTime = false

    Integer minPausaPranzo = 0
    Integer totaleOreGiornaliere = 8

    static belongsTo = [utente: Utente]

    static constraints = {
        isSaturdayExtra nullable: true
        isHalfTime nullable: true

        minPausaPranzo nullable: true
    }
}
