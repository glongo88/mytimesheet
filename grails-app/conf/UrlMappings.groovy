class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        name 'dettaglio-mese': "/dettaglio/$month/$year" (controller: "recordTime", action: "index"){
            constraints {
                year(matches:/\d{4}/)
                month(matches:/\d{2}/)
            }
        }
        name 'riepilogo-mese': "/riepilogo/$month/$year" (controller: "riepilogo", action: "riepilogoMese"){
            constraints {
                year(matches:/\d{4}/)
                month(matches:/\d{2}/)
            }
        }
        "/recordTime/selectMonth/$month/$year" (controller: "recordTime", action: "selectMonth")
        "/recordTime/createLive/$day/$month/$year" (controller: "recordTime", action: "createLive") {
            constraints {
                day(matches:/\d{2}/)
                year(matches:/\d{4}/)
                month(matches:/\d{2}/)
            }
        }
        "/"(controller: 'home')
        "500"(view:'/error')
	}
}
