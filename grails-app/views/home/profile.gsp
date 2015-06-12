<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Il mio profilo</title>
    <asset:javascript src="bootstrap-datetimepicker.js"/>
</head>

<body>

<div class="row">

    <div class="col-lg-12 heading">
        <h1 class="page-header"><i class="fa fa-user"></i> Il mio profilo</h1>

        <ul id="crumb" class="breadcrumb">
        </ul>
    </div>

</div>

<div class="row">
    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">

        <div class="panel panel-default plain profile-widget">

            <div class="panel-heading white-bg pl0 pr0">
                <img class="profile-image img-responsive" src="${resource(dir: 'images', file: 'profile-cover.jpg')}" alt="profile cover">
            </div>
            <div class="panel-body">
                <div class="col-lg-4 col-md-4 col-sm-12">
                    <div class="profile-avatar">
                        <img class="img-responsive" src="${resource(dir: 'images', file: '132.jpg')}" alt="@roybarberuk">
                    </div>
                </div>
                <div class="col-lg-8 col-md-8 col-sm-12">
                    <div class="profile-name">
                        ${utente?.nome} ${utente?.cognome}
                    </div>
                    <div class="profile-quote">
                        <p>${utente.posizione}</p>
                    </div>
                    <div class="profile-stats-info">
                        <a href="#" class="tipB" title="Totale giorni lavorati"><i class="fa fa-suitcase"></i> <strong>${totaleGiorni}</strong></a>
                    </div>
                </div>
            </div>
            <div class="panel-footer white-bg">
                <ul class="profile-info">
                    <li><i class="fa fa-calendar"></i> ${formatDate(format: 'dd/MM/yyyy', date: utente.dataNascita)}</li>
                    <li><i class="ec-location"></i> Milano, Italia</li>
                    <li><i class="ec-mail"></i> ${utente?.username}</li>
                </ul>
            </div>
        </div>

    </div>

    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">

        <div class="panel panel-default plain">

            <g:if test="${flash.message}">
                <div class="alert alert-success fade in">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                    <i class="fa-ok alert-icon s24"></i>
                    <strong>Bene!</strong> Il tuo profilo è stato aggiornato correttamente.
                </div>
            </g:if>
            <div class="panel-heading white-bg">
                <h4 class="panel-title"><i class="ec-user"></i> Aggiorna i tuoi dati</h4>
            </div>
            <div class="panel-body">
                <g:form controller="home" action="updateProfile" class="form-vertical hover-stripped" role="form">
                    <div class="form-group">
                        <label class="control-label">Nome</label>
                        <input type="text" name="nome" class="form-control" required="required" value="${utente.nome}">
                    </div>
                    <div class="form-group">
                        <label class="control-label">Cognome</label>
                        <input type="text" name="cognome" class="form-control" required="required" value="${utente.cognome}">
                    </div>
                    <div class="form-group">
                        <label class="control-label">Data di nascita</label>
                        <input type="text" name="dataNascita" class="form-control datepickerYear" required="required" value="${formatDate(format: 'dd/MM/yyyy', date: utente.dataNascita)}">
                    </div>
                    <div class="form-group">
                        <label class="control-label">Posizione lavorativa</label>
                        <input type="text" name="posizione" class="form-control" required="required" value="${utente.posizione}">
                    </div>
                    <div class="form-group mb15">
                        <button type="submit" class="btn btn-primary">Aggiorna</button>
                    </div>

                </g:form>
            </div>
        </div>

    </div>

</div>

<g:javascript>
    $(document).ready(function() {
        $(".datepickerYear").datetimepicker({
            format: "dd/mm/yyyy",
            autoclose: true,
            startView: 4,
            minView: 2,
            autoclose: true,
            todayBtn: false,
            pickerPosition: "bottom-left",
            changeMonth: true,
            changeYear: true,
            pickTime: false
        });
    });
</g:javascript>

</body>
</html>