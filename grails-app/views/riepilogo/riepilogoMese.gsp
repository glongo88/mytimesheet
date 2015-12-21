<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Riepilogo mese</title>
    <asset:javascript src="date.js" />
    <asset:javascript src="jquery.flot.js" />
    <asset:javascript src="jquery.flot.time.js" />
    <asset:javascript src="bootstrap-datetimepicker.js"/>

</head>

<body>

<mh:breadcrumb leaf="Riepilogo mese"/>

<div class="row">
    <div class="col-lg-3 col-md-3 text-center">
        <div class="input-group">
            <input id="monthValue" style="height: 50px;" class="form-control datepicker" type="text" value="" placeholder="Seleziona un altro mese">
            <span class="input-group-addon"><i class="fa-calendar"></i></span>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-lg-12 col-md-12 text-center">
        <div class="panel title-month-white"><i class="fa fa-calendar"></i> <span id="monthTitle"></span></div>
    </div>
</div>

<div class="row">

    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">

        <div class="panel panel-marine plain toggle panelClose panelRefresh animated zoomInRight">
            <div class="panel-body">
                <div class="p-title"><i class="fa fa-line-chart"></i> Totale</div>
                <div class="row" style="margin-top: 15px;">
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 text-center">
                        <div class="box-riepilogo" style="background-color: #48D1CC;">
                            <div class="riepilogo-label">Giorni</div>
                            <div class="riepilogo-value">${stats['numeroGiorni']}</div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 text-center">
                        <div class="box-riepilogo" style="background-color: #48D1CC;">
                            <div class="riepilogo-label">Ore</div>
                            <div class="riepilogo-value"><mh:printMinutesSimple minuti="${stats['totaleLavorato']}"/></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">

        <div class="panel panel-marine plain toggle panelClose panelRefresh animated zoomInRight">
            <div class="panel-body">
                <div class="p-title"><i class="fa fa-bar-chart"></i> Medie</div>
                <div class="row" style="margin-top: 15px;">
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 text-center">
                        <div class="box-riepilogo" style="background-color: #48D1CC;">
                            <div class="riepilogo-label">Media ore al giorno</div>
                            <div class="riepilogo-value"><mh:printMinutesSimple minuti="${stats['avgTotaleLavorato']}"/></div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 text-center">
                        <div class="box-riepilogo" style="background-color: #48D1CC;">
                            <div class="riepilogo-label">Media pausa pranzo</div>
                            <div class="riepilogo-value"><mh:printMinutesSimple minuti="${stats['avgPausaPranzo']}"/></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

</div>

<div class="row">

    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">

        <div class="panel panel-marine plain toggle panelClose panelRefresh animated zoomInLeft">
            <div class="panel-body">
                <div class="p-title"><i class="fa fa-money"></i> Totale straordinari</div>
                <div class="row" style="margin-top: 15px;">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center">
                        <div class="box-riepilogo" style="background-color: #48D1CC;">
                            <div class="riepilogo-label">Ore</div>
                            <div class="riepilogo-value"><mh:printMinutesSimple minuti="${stats['minutiStraordinario']}"/></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

</div>

<br/>

%{--<div class="row">
    <div class="col-xs-4">
        <div class="tile-stats b brall mb25 blue-bg">
            <a href="#">
                <div class="tile-stats-icon"><i class="im-clock color-white"></i>
                </div>
                <div class="tile-stats-content">
                    <div class="tile-stats-number color-white"><util:printMinutes minuti="${stats['totaleLavorato']}"/></div>
                    <div class="tile-stats-text color-white">Totale ore lavorate</div>
                </div>
                <div class="clearfix"></div>
            </a>
        </div>
    </div>
    <div class="col-xs-4">
        <div class="tile-stats b brall mb25 green-bg">
            <a href="#">
                <div class="tile-stats-icon"><i class="fa fa-money color-white"></i>
                </div>
                <div class="tile-stats-content">
                    <div class="tile-stats-number color-white"><util:printMinutes minuti="${stats['minutiStraordinario']}"/></div>
                    <div class="tile-stats-text color-white">Totale straordinario</div>
                </div>
                <div class="clearfix"></div>
            </a>
        </div>
    </div>
    <div class="col-xs-4">
        <div class="tile-stats b brall mb25 dark-bg">
            <a href="#">
                <div class="tile-stats-icon"><i class="im-clock color-white"></i>
                </div>
                <div class="tile-stats-content">
                    <div class="tile-stats-number color-white"><util:printMinutes minuti="${stats['avgTotaleLavorato']}"/></div>
                    <div class="tile-stats-text color-white">Media ore al giorno</div>
                </div>
                <div class="clearfix"></div>
            </a>
        </div>
    </div>
</div>--}%

<div class="row">
    <div class="col-lg-12">
        <div class="animated flipInY panel panel-primary plain toggle">
            <div class="panel-heading">
                <h4 class="panel-title"><i class="im-bars"></i> Minuti per giorno</h4>
            </div>
            <div class="panel-body blue-bg">
                <div id="line-chart-dots" style="width: 100%; height:250px;"></div>
            </div>
        </div>
    </div>
</div>

<g:javascript>

    function suffixFormatter(val, axis) {
        if (val > 1000000)
            return (val / 1000000).toFixed(axis.tickDecimals) + " MB";
        else if (val > 1000)
            return (val / 1000).toFixed(axis.tickDecimals) + " kB";
        else
            return val.toFixed(axis.tickDecimals) + " B";
    }

    $(document).ready(function() {

        $.fn.datetimepicker.dates['en'] = {
            days: ["Domenica", "Lunedi", "Martedi", "Mercoledi", "Giovedi", "Venerdi", "Sabato", "Domenica"],
            daysShort: ["Dom", "Lun", "Mar", "Mer", "Gio", "Ven", "Sab", "Dom"],
            daysMin: ["Do", "Lu", "Ma", "Me", "Gi", "Ve", "Sa", "Do"],
            months: ["Gennaio", "Febbraio", "Marzo", "Aprile", "Maggio", "Giugno", "Luglio", "Agosto", "Settembre", "Ottobre", "Novembre", "Dicembre"],
            monthsShort: ["Gen", "Feb", "Mar", "Apr", "Mag", "Giu", "Lug", "Ago", "Set", "Ott", "Nov", "Dic"],
            today: "Oggi",
            suffix: [],
            meridiem: [],
            weekStart: 1
        };

        $(".datepicker").datetimepicker({
            format: "MM yyyy",
            autoclose: true,
            startView: 3,
            minView: 3,
            autoclose: true,
            todayBtn: true,
            pickerPosition: "bottom-left",
            changeMonth: true,
            changeYear: true
        }).on('changeDate', function(ev){
            var mese = moment(ev.date);
            var value = $('#monthValue').val();
            var link2 = encodeURI('${createLink(uri: '/riepilogo')}');
            window.location = link2 + '/' + mese.format("MM") + '/' + mese.format("YYYY");
        });

       $('#monthTitle').html(moment('${month}').format('MMMM')+ " " +moment('${year}').format('YYYY'));

       //generate random number for charts
        randNum = function(){
            return (Math.floor( Math.random()* (1+150-50) ) ) + 80;
        }

        //------------- LIne charts with dots -------------//
        $(function() {

            //first line chart
            var d1 = [];
            <g:each in="${lista}" var="record" status="i">
                d1.push([${record.dataRecord.getTime()}, ${record.totaleLavorato}]);
            </g:each>


            var chartMinDate = d1[0][0]; //first day
            var chartMaxDate = d1[${lista.size()-1}][0];//last day

            var tickSize = [1, "day"];
            var tformat = "%d/%m/%y";

            var total = 0;
            //calculate total earnings for this period
            for (var i = 0; i < ${lista.size()-1}; i++) {
                total = d1[i][1] + total;
            }

            var options = {
                grid: {
                    show: true,
                    aboveData: true,
                    color: "#ffffff",
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
                        symbol: "circle",
                        show:true,
                        radius: 4,
                        lineWidth: 2.5,
                        fill: true,
                        fillColor: "#fff"
                    }
                },
                colors: ["#ffffff"],
                legend: {
                    position: "ne",
                    margin: [0,-25],
                    noColumns: 0,
                    labelBoxBorderColor: null,
                    labelFormatter: function(label, series) {
                        return '<div style="padding: 10px; font-size:20px;font-weight:bold;">'+ label + ': '+ total +'</div>';
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
                    min: 0,
                    //ticks: suffixFormatter(v, axis)
                    ticks: [[0, "0 ore"], [100, "${mh.printMinutes(minuti: 100)}"], [200, "${mh.printMinutes(minuti: 200)}"],
                    [300, "${mh.printMinutes(minuti: 300)}"], [400, "${mh.printMinutes(minuti: 400)}"], [500, "${mh.printMinutes(minuti: 500)}"],
                    [600, "${mh.printMinutes(minuti: 600)}"]]
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
                    label: "Totale minuti",
                    data: d1
                }], options
            );

        });

    });
</g:javascript>

</body>
</html>