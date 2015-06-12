<%@ page import="it.longo.Preferences" %>
<!DOCTYPE html>
<html>
	<head>
		<g:set var="entityName" value="${message(code: 'preferences.label', default: 'Preferences')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
        <asset:javascript src="jquery.onoff.min.js"/>
	</head>
	<body>

		<div id="list-preferences" class="content scaffold-list" role="main">
			<h1><i class="fa fa-gears"></i> Le tue impostazioni</h1>
			<g:if test="${flash.message}">
                <div class="alert alert-success fade in">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                    <i class="fa-ok alert-icon s24"></i>
                    <strong>Bene!</strong> ${flash.message}
                </div>
			</g:if>

            <br/>

            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-primary" id="spr_1">
                        <div class="panel-heading">
                            <h4 class="panel-title">Le mie preferenze</h4>
                            <div class="" style="display: none;"></div>
                        </div>
                        <div class="panel-body">
                            <g:form class="form-horizontal group-border" controller="preferences" action="update" method="PUT">
                                <g:hiddenField name="id" value="${preferencesInstance?.id}"/>
                                <div class="form-group">
                                    <label class="col-lg-3 col-md-3 col-sm-12 control-label">Sabato è straordinario</label>
                                    <div class="col-lg-9 col-md-9">
                                        <g:checkBox class="switch noStyle" name="isSaturdayExtra" value="${preferencesInstance?.isSaturdayExtra}"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-3 col-md-3 col-sm-12 control-label">Contratto half time</label>
                                    <div class="col-lg-9 col-md-9">
                                        <g:checkBox class="switch noStyle" name="isHalfTime" value="${preferencesInstance?.isHalfTime}"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-3 col-md-3 col-sm-12 control-label">Tempo mimino pausa pranzo (in minuti)</label>
                                    <div class="col-lg-9 col-md-9">
                                        <input type="number" class="form-control" name="minPausaPranzo" value="${preferencesInstance?.minPausaPranzo}"/>
                                    </div>
                                </div>
                                <div class="form-group row text-center">
                                    <div class="col-lg-12">
                                        <input type="submit" class="btn btn-success btn-lg" value="Aggiorna">
                                    </div>
                                </div>
                            </g:form>
                        </div>
                    </div>
                </div>
            </div>

		</div>

    <g:javascript>
        $(document).ready(function() {
            $('input.switch').onoff();
            //disabled switch
            $('input.switch:disabled').onoff('disable').closest('div.onoffswitch').addClass('onoffswitch-disabled');
        });
    </g:javascript>

    </body>
</html>
