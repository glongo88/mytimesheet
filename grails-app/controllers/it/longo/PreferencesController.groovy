package it.longo



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PreferencesController {

    def springSecurityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {
        render view: 'index', model: [preferencesInstance: springSecurityService.currentUser?.preferenze]
    }

    def show(Preferences preferencesInstance) {
        respond preferencesInstance
    }

    def create() {
        respond new Preferences(params)
    }

    @Transactional
    def save(Preferences preferencesInstance) {
        if (preferencesInstance == null) {
            notFound()
            return
        }

        if (preferencesInstance.hasErrors()) {
            respond preferencesInstance.errors, view: 'create'
            return
        }

        preferencesInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'preferences.label', default: 'Preferences'), preferencesInstance.id])
                redirect preferencesInstance
            }
            '*' { respond preferencesInstance, [status: CREATED] }
        }
    }

    def edit(Preferences preferencesInstance) {
        respond preferencesInstance
    }

    @Transactional
    def update(Preferences preferencesInstance) {
        if (preferencesInstance == null) {
            notFound()
            return
        }

        if (preferencesInstance.hasErrors()) {
            respond preferencesInstance.errors, view: 'edit'
            return
        }

        preferencesInstance.save flush: true

        flash.message = "Impostazioni aggiornate correttamente"

        redirect(action: 'index')

        /*request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Preferences.label', default: 'Preferences'), preferencesInstance.id])
                redirect preferencesInstance
            }
            '*' { respond preferencesInstance, [status: OK] }
        }*/
    }

    @Transactional
    def delete(Preferences preferencesInstance) {

        if (preferencesInstance == null) {
            notFound()
            return
        }

        preferencesInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Preferences.label', default: 'Preferences'), preferencesInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'preferences.label', default: 'Preferences'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
