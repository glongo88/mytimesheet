package it.longo

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.authentication.dao.NullSaltSource
import grails.plugin.springsecurity.ui.RegisterCommand
import grails.plugin.springsecurity.ui.RegistrationCode
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.Authentication
import org.springframework.security.core.context.SecurityContextHolder

class RegisterController extends grails.plugin.springsecurity.ui.RegisterController {

    def sendMailService

    @Override
    def register(RegisterCommand command) {

        if (command.hasErrors()) {
            println "Errori: ${command.errors}"
            render view: 'index', model: [command: command]
            return
        }

        String salt = saltSource instanceof NullSaltSource ? null : command.username
        def user = lookupUserClass().newInstance(username: command.username, nome: command.nome, cognome: command.cognome,
                dataNascita: new Date(), sesso: command.sesso, accountLocked: true, enabled: true)

        RegistrationCode registrationCode = springSecurityUiService.register(user, command.password, salt)
        if (registrationCode == null || registrationCode.hasErrors()) {
            // null means problem creating the user
            flash.error = message(code: 'spring.security.ui.register.miscError')
            flash.chainedParams = params
            redirect action: 'index'
            return
        }

        String url = generateLink('verifyRegistration', [t: registrationCode.token])

        def conf = SpringSecurityUtils.securityConfig
        def body = conf.ui.register.emailBody
        if (body.contains('$')) {
            body = evaluate(body, [user: user, url: url])
        }

        sendMailService.sendMail(conf.ui.register.emailFrom, command.username, conf.ui.register.emailSubject, body.toString())

        render view: 'index', model: [emailSent: true]
    }

}
