package calcolouscita

import grails.transaction.Transactional

@Transactional
class SendMailService {

    def mailService

    def sendMail(String from, String to, String subject, String body) {
        log.info("Sending email from: ${from} - to: ${to} - subject: ${subject} - body: ${body}")
        try {
            mailService.sendMail {
                to to
                from from
                subject subject
                html body
            }
        } catch (Exception e) {
            log.error("Errore nell'invio mail: "+e.message)
        }
    }
}
