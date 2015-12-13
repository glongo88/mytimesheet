<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Calcolo uscita</title>

    <asset:javascript src="jquery.flot.js"/>
    <asset:javascript src="jquery.flot.time.min.js"/>
    <asset:javascript src="bootstrap-slider.js"/>

    <asset:javascript src="jquery.flipTimer.js"/>
    <asset:stylesheet href="flipTimer.css"/>

</head>

<body>

<div class="row">
    <div class="col-lg-12 heading">
        <h1 class="page-header"><i class="fa fa-dashboard"></i> Dashboard</h1>
        <ul id="crumb" class="breadcrumb"></ul>
    </div>
</div>

<div class="row">
    <div class="col-xs-8">

        <div class="row">

            <div class="col-xs-4 ui-248">
                <div class="item">
                    <div class="icon bg-danger"><i class="fa fa-hourglass-start"></i></div>
                    <div class="category-title-box-index"><h3><a style="color: white; margin-top: 3px;" href="#">Tot. Settimana</a></h3></div>
                    <h2 class="text-right"><span class="blue numberClass">${util.printMinutesSimple(minuti: statistics['totaleLavoratoSettimana'])?:"0:0"}</span></h2>
                </div>
            </div>

            <div class="col-xs-4 ui-248">
                <div class="item">
                    <div class="icon bg-yellow"><i class="fa fa-hourglass-end"></i></div>
                    <div class="category-title-box-index"><h3><a style="color: white; margin-top: 3px;" href="#">Tot. Mese</a></h3></div>
                    <h2 class="text-right"><span class="blue numberClass">${util.printMinutesSimple(minuti: statistics['totaleLavoratoMese'])?:"0:0"}</span></h2>
                </div>
            </div>

            <div class="col-xs-4 ui-248">
                <div class="item">
                    <div class="icon bg-green"><i class="fa fa-money"></i></div>
                    <div class="category-title-box-index"><h3><a style="color: white; margin-top: 3px;" href="#">Straordinari</a></h3></div>
                    <h2 class="text-right"><span class="blue numberClass">${util.printMinutesSimple(minuti: statistics['minutiStraordinarioMese'])?:"0:0"}</span></h2>
                </div>
            </div>

        </div>

        <div class="row">
            <div class="col-xs-12">
                <div class="panel panel-marine" id="spr_3">
                    <div class="panel-body">

                        <div class="p-title"><i class="fa fa-calculator"></i> Calcolo uscita</div>

                        <div class="row">
                            <div class="col-lg-8 col-xs-8">
                                <input id="basic-slider" data-slider-id="slider1" type="text"><br/><br/>
                                Uscita dopo <span id="orario">7 ore e 45 minuti</span>:
                            </div>
                            <div id="calcoloUscita" class="col-lg-4 col-xs-4 text-center">
                                <span id="oraUscitaStart" style="display: none;">${formatDate(format: 'HH:mm', date: oraUscita)}</span>
                                <g:render template="ora_uscita"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="text-center hidden-lg hidden-xlg"><g:render template="templateCounter"/></div>

        <div class="panel panel-marine plain toggle panelClose panelRefresh">

            <div class="panel-body">

                <div class="p-title"><i class="fa fa-list"></i> Ultimi inserimenti</div>

                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th class="per20">Data</th>
                        <th class="per20">Entrata</th>
                        <th class="per20">Inizio pausa</th>
                        <th class="per20">Fine pausa</th>
                        <th class="per20">Uscita</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${recordList}" var="record">
                        <tr>
                            <td>${formatDate(format: 'dd/MM/yyyy', date: record.dataRecord)}</td>
                            <td>${record.entrataTime}</td>
                            <td>${record.inizioPausaTime}</td>
                            <td>${record.finePausaTime}</td>
                            <td>${record.uscitaTime}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
    <div class="col-xs-4">

        <div class="panel">
            <div class="panel-body">
                <div class="p-title"><i class="fa fa-edit"></i> Inserisci gli orari di oggi</div>
                <g:set var="azione" value="${recordTimeInstance.id?'update':'save'}"/>
                <g:form id="formId" url="[resource:recordTimeInstance, action: azione]">
                    <g:hiddenField name="dataRecord" value="" id="hiddenDate"/>
                    <div class="row">
                        <div class="col-xs-3">
                            <i style="font-size: 65px;" class="fa fa-calendar-empty"></i>
                        </div>
                        <div class="col-xs-9">
                            <div id="todayDay"></div><br/><div id="todayDate"></div>
                        </div>
                    </div>
                    <br/>
                    <div class="row">
                        <div class="col-xs-6">
                            <label for="entrataTime">Entrata</label>
                            <div class="input-group bootstrap-timepicker">
                                <input name="entrataTime" id="entrataTime" type="time" class="form-control" value="${recordTimeInstance?.entrataTime}">
                                %{--<joda:timePicker name="entrataTime" class="form-control timepicker" value="${recordTimeInstance?.entrataTime}" default="none" noSelection="['': '']"></joda:timePicker>--}%
                                <span class="input-group-addon"><i class="fa fa-time"></i></span>
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <label for="inizioPausaTime">Inizio pausa</label>
                            <div class="input-group bootstrap-timepicker">
                                <input name="inizioPausaTime" formatString="${joda.inputPattern()}" id="inizioPausaTime" type="time" class="form-control" value="${recordTimeInstance?.inizioPausaTime}">
                                <span class="input-group-addon"><i class="fa fa-time"></i></span>
                            </div>
                        </div>
                    </div>
                    <br/>
                    <div class="row">
                        <div class="col-xs-6">
                            <label for="finePausaTime">Fine pausa</label>
                            <div class="input-group bootstrap-timepicker">
                                <input name="finePausaTime" id="finePausaTime" type="time" class="form-control" value="${recordTimeInstance?.finePausaTime}">
                                <span class="input-group-addon"><i class="fa fa-time"></i></span>
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <label for="uscitaTime">Uscita</label>
                            <div class="input-group bootstrap-timepicker">
                                <input name="uscitaTime" id="uscitaTime" type="time" class="form-control" value="${recordTimeInstance?.uscitaTime}">
                                <span class="input-group-addon"><i class="fa fa-time"></i></span>
                            </div>
                        </div>
                    </div>
                    <br/>
                    <div class="row text-center">
                        <input id="submitButton" type="submit" onclick="checkValues()" class="btn btn-success btn-lg" value="${recordTimeInstance.id?'Aggiorna':'Salva'}">
                    </div>
                </g:form>

            </div>
        </div>

        <div class="hidden-xs hidden-sm hidden-md"><g:render template="templateCounter"/></div>

    </div>

</div>

<g:javascript>

    $('#formId').submit(function (evt) {
        if(!$("#entrataTime").val() && !$("#inizioPausaTime").val() && !$("#finePausaTime").val() && !$("#uscitaTime").val() ) {
            swal("Inserisci almeno un orario!");
            evt.preventDefault();
            return false;
        }
        return true;
    });

    function checkValues() {
        if(!$("#entrataTime").val() && !$("#inizioPausaTime").val() && !$("#finePausaTime").val() && !$("#uscitaTime").val() ) {
            swal("Inserisci almeno un orario!");
            return;
        } else {
            $('#formId').submit();
        }
    }

    var slider;
    $(document).ready(function() {

        $('.flipTimer').flipTimer({
            direction: 'up',
            days: false,
            date: '${liveCountFirst}, ${liveCountSecond}'
        });

        <g:if test="${flash.message}">
            $('body').pgNotification({
                style: 'circle',
                title: '${flash.title}',
                message: "${flash.message}",
                position: "top-right",
                timeout: 0,
                type: "success",
                thumbnail: '<i style="margin-left: 13px;font-size: 34px;margin-top: 5px;" class="fa fa-thumbs-o-up"></i>'
            }).show();
        </g:if>



    moment.locale('it', {
        months : [
            "Gennaio", "Febbraio", "Marzo", "Aprile", "Maggio", "Giugno", "Luglio",
            "Agosto", "Settembre", "Ottobre", "Novembre", "Dicembre"
        ],
        weekdays : [
            "Domenica","Lunedì","Martedì","Mercoledì","Giovedì","Venerdì","Sabato"
        ]
    });

    var localLocale = moment();
    localLocale.locale('it');

    $('#hiddenDate').val(localLocale.format('DD/MM/YYYY'));

    $('#todayDay').text(localLocale.format('dddd'));
    $('#todayDate').text(localLocale.format('DD MMM YY'));

    $('.timepicker').timepicker({
        showMeridian: false,
        showSeconds: false,
        minuteStep: 1,
        defaultTime: false
    });

    $('#basic-slider').slider({
        min: 0,
        max: 90,
        step: 15,
        value: 0,
        formater: function(value) {
            switch(value)  {
            case 0:
                return "7 ore e 45 minuti";
                break;
            case 15:
                return "8 ore";
                break;
            case 30:
                return "8 ore e 15 minuti";
                break;
            case 45:
                return "8 ore e 30 minuti";
                break;
            case 60:
                return "8 ore e 45 minuti";
                break;
            case 75:
                return "9 ore";
                break;
            case 90:
                return "9 ore e 15 minuti";
                break;
        }
        }
    });
    $("#basic-slider").on('slideStop', function(slideEvt) {
        var startOrario = $('#oraUscita').text();
        addMinutes(slideEvt.value);
        aggiornaLabel(slideEvt.value);
    });

    removeAnimation();

});

function removeAnimation() {
    $('#oraUscita').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
        $(this).removeClass('animated flipInY');
    });
}

function addMinutes(minutes) {
    var t = moment($('#oraUscitaStart').text(),"HH:mm").add({minutes: minutes});;
    $('#oraUscita').text(t.format('HH:mm'));
    $('#oraUscita').addClass('animated flipInY');
    removeAnimation();
}

function aggiornaLabel(value) {
    switch(value)  {
            case 0:
                $("#orario").text("7 ore e 45 minuti");
                break;
            case 15:
                $("#orario").text("8 ore");
                break;
            case 30:
                $("#orario").text("8 ore e 15 minuti");
                break;
            case 45:
                $("#orario").text("8 ore e 30 minuti");
                break;
            case 60:
                $("#orario").text("8 ore e 45 minuti");
                break;
            case 75:
                $("#orario").text("9 ore");
                break;
            case 90:
                $("#orario").text("9 ore e 15 minuti");
                break;
        }
}

//------------- LIne charts with dots -------------//
/*
$(function() {

    randNum = function(){
        return (Math.floor( Math.random()* (1+150-50) ) ) + 80;
    }

    var d1 = [];

    for (var i = 0; i < 8; i++) {
        var date1 = new Date().getDate()+i;
        var time = new Date(date1).getTime();
        d1.push([time,randNum()]);
    }

    var chartMinDate = d1[0][0]; //first day
    var chartMaxDate = d1[7][0];//last day

    var tickSize = [1, "day"];
    var tformat = "%d/%m/%y";

    var total = 0;
    //calculate total earnings for this period
    for (var i = 0; i < 8; i++) {
        total = d1[i][1] + total;
    }

    var options = {
        grid: {
            show: true,
            aboveData: true,
            color: "white" ,
            labelMargin: 20,
            axisMargin: 0,
            borderWidth: 0,
            borderColor:null,
            minBorderMargin: 5 ,
            clickable: true,
            hoverable: true,
            autoHighlight: true,
            mouseActiveRadius: 100
        },
        series: {
            grow: {
                active: true,
                duration: 1500
            },
            lines: {
                show: true,
                fill: false,
                lineWidth: 2.5
            },
            points: {
                show:true,
                radius: 4,
                lineWidth: 2.5,
                fill: true,
                fillColor: "#75b9e6"
            }
        },
        colors: ["white"],
        legend: {
            position: "ne",
            margin: [0,-25],
            noColumns: 0,
            labelBoxBorderColor: null,
            labelFormatter: function(label, series) {
                return '<div style="padding: 10px; font-size:20px;font-weight:bold;">'+ label + ': $'+ total +'</div>';
                },
                backgroundColor: "#75b9e6",
                backgroundOpacity: 0.5,
                hideSquare: true //hide square color helper
            },
            shadowSize:0,
            tooltip: true, //activate tooltip
            tooltipOpts: {
                content: "$%y.0",
                xDateFormat: "%d/%m",
                shifts: {
                    x: -30,
                    y: -50
                },
                theme: 'dark',
                defaultTheme: false
            },
            yaxis: {
                min: 0
            },
            xaxis: {
                mode: "time",
                minTickSize: tickSize,
                timeformat: tformat,
                min: chartMinDate,
                max: chartMaxDate,
                tickLength: 0

            }
        }

        var plot = $.plot($("#line-chart-dots"),[{
            label: "Earnings",
            data: d1
        }], options
        );

    });*/
</g:javascript>

</body>
</html>