package it.longo

import org.grails.databinding.BindingFormat
import org.joda.time.LocalTime

class RecordTime {

    @BindingFormat('dd/MM/yyyy')
    Date dataRecord

    String entrataTime
    String inizioPausaTime
    String finePausaTime
    String uscitaTime

    int totaleLavorato
    int minutiStraordinario
    int minutiDaRecuperare
    int minutiPausaPranzo

    Utente utente

    static constraints = {
        dataRecord nullable: true, unique: 'utente'
        entrataTime nullable: true
        inizioPausaTime nullable: true
        finePausaTime nullable: true
        uscitaTime nullable: true
        utente nullable: true
        totaleLavorato nullable: true
        minutiStraordinario nullable: true
        minutiDaRecuperare nullable: true
        minutiPausaPranzo nullable: true
    }
}
