<%@ page import="it.longo.RecordTime" %>
<!DOCTYPE html>
<html>
	<head>
		<title>Dettaglio mese</title>
        <asset:stylesheet src="bootstrap-editable.css"/>
        <asset:javascript src="monthpicker.js"/>
        <asset:stylesheet src="monthpicker.css"/>
	</head>
	<body>

    <mh:breadcrumb leaf="Dettaglio mese"/>

    <div class="row">
        <div class="col-xs-12">
            <div class="alert alert-info">
                <i class="fa fa-info-circle fa-fw fa-lg"></i>
                <strong>Come si usa?</strong>
                <p>Clicca su un orario per modificarlo.</p>
                <p style="margin-top: -5px;">Se è il primo orario di un giorno, clicca sul pulsante verde che comparirà per salvarlo.</p>
                <p style="margin-top: -5px;">Per eliminare tutti gli orari di un giorno, clicca sul pulsante rosso 'Elimina'.</p>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-xs-12">
            <div class="panel panel-default plain">
                <div class="panel-heading white-bg">
                    <div class="row">
                        <div class="col-xs-1">
                            <g:link mapping="dettaglio-mese" params="[month: prevMonth.format('MM'), year: prevMonth.format('yyyy')]"><h2 class="title-month"><i class="fa fa-chevron-left"></i></h2></g:link>
                        </div>
                        <div class="col-xs-5 text-right">
                            <h2 class="title-month-blue" id="monthTitle"></h2>
                        </div>
                        <div class="col-xs-3">
                            <div style="margin-top: 20px;" class="input-group">
                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                <input type="text" class="form-control" id="datepickerDate">
                            </div>
                        </div>
                        <div class="col-xs-offset-2 col-xs-1 text-right">
                            <g:link mapping="dettaglio-mese" params="[month: nextMonth.format('MM'), year: nextMonth.format('yyyy')]"><h2 class="title-month"><i class="fa fa-chevron-right"></i></h2></g:link>
                        </div>
                    </div>
                </div>
                <div class="panel-body">
                    <table class="table table-hover" id="recordTable2">
                        <thead>
                        <tr>
                            <g:sortableColumn width="15%" property="dataRecord" title="${message(code: 'recordTime.dataRecord.label', default: 'Data')}" />
                            <g:sortableColumn width="10%" property="entrataTime" title="${message(code: 'recordTime.entrataTime.label', default: 'Entrata')}" />
                            <g:sortableColumn width="15%" property="inizioPausaTime" title="${message(code: 'recordTime.inizioPausaTime.label', default: 'Inizio Pausa')}" />
                            <g:sortableColumn width="15%" property="finePausaTime" title="${message(code: 'recordTime.finePausaTime.label', default: 'Fine Pausa')}" />
                            <g:sortableColumn width="15%" property="uscitaTime" title="${message(code: 'recordTime.uscitaTime.label', default: 'Uscita')}" />
                            <g:sortableColumn width="15%" property="totaleLavorato" title="${message(code: 'recordTime.totaleLavorato.label', default: 'Totale')}" />
                            <g:sortableColumn width="15%" property="minutiStraordinario" title="${message(code: 'recordTime.minutiStraordinario.label', default: 'Straordinario')}" />
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <mh:printTable records="${records}" month="${month}" year="${year}"/>
                        </tbody>
                    </table>
                    <div class="pagination">
                        <g:paginate total="${recordTimeInstanceCount ?: 0}" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="loadingModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
        <div class="modal-dialog modal-dialog-center" style="margin-top: -103px; margin-left: -300px;">
            <div class="modal-content" style="max-height: 394px;">
                <div class="modal-header">
                    <h4 class="modal-title" id="myModal3Label">Caricamento</h4>
                </div>
                <div class="modal-body" style="max-height: 346px;">
                    <p style="font-size: 28px; font-weight: bold;">
                        <i class="fa fa-spinner fa-spin"></i> Sto aggiornando i dati...
                    </p>
                </div>
            </div>
        </div>
    </div>

    <g:javascript>

        function formatMonthNumber(n){
            return n > 9 ? "" + n: "0" + n;
        }

        $(document).ready(function() {

            $('#datepickerDate').datepicker( {
                changeMonth: true,
                changeYear: true,
                showButtonPanel: true,
                dateFormat: 'MM yy',
                onClose: function(dateText, inst) {
                    var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
                    var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                    $(this).datepicker('setDate', new Date(year, month, 1));

                    var value = $('#monthValue').val();
                    var link2 = encodeURI('${createLink(controller: 'recordTime' , action:'selectMonth')}');
                    window.location = link2 + '/' + formatMonthNumber(parseInt(month)+1) + '/' + year;

                }
            });

            $("#helpBtn").click(function() {
                $("#helpBox").toggle("slow");
            });

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
                    var link2 = encodeURI('${createLink(controller: 'recordTime' , action:'selectMonth')}');
                    window.location = link2 + '/' + mese.format("MM") + '/' + mese.format("YYYY");
                });

            $('#monthTitle').html(moment('${month}').format('MMMM')+ " " +moment('${year}').format('YYYY'));


            $.fn.editableform.loading = "<div class='editableform-loading text-center'><i class='fa fa-spinner fa-spin'></i></div>";

            $('.editable').editable({
                emptytext: "vuoto",
                validate: function(value) {
                    if($.trim(value) == '') {
                        return 'Inserire un orario';
                    }
                }
            });

            $('.dataEditable').editable({
                display: false,
                emptytext: "vuoto"
            });

            $('.myeditable').on('save.newuser', function(){
                var that = this;
                setTimeout(function() {
                    $(that).closest('tr').next().find('.myeditable').editable('show');
                }, 200);
            });

            $('.editable').on('hidden', function(e, reason) {
                if(reason === 'save') {
                    var count = e.target.id.split("-").pop();
                    $('#saveButton'+count).show();
                    var id = $(e.target).attr('data-pk');
                    <g:remoteFunction controller="recordTime" action="updateValuesLive" params="'id='+id" onSuccess="updateTotale(count, data)"/>
                }
            });

            function updateTotale(count, data) {
                $("#totale-"+count).text(data.totaleLavorato);
                $("#straordinario-"+count).text(data.minutiStraordinario);
            }

            $('.btn-save-data').click(function() {
                var dataValue = "\\"+$('#dataRecord'+this.value).attr('data-formatted');
                var currVAL = this.value;
                $('.myeditable'+this.value).editable('submit', {
                   url: "${createLink(controller: 'recordTime', action: 'createLive')}"+dataValue,
                   ajaxOptions: {
                       dataType: 'json'
                   },
                   success: function(data, config) {
                       if(data && data.id) {  //record created, response like {"id": 2}
                           $(this).editable('option', 'pk', data.id);
                           $(this).removeClass('editable-unsaved');
                           var msg = 'Dati inseriti correttamente';
                           $('#msg').addClass('alert-success').removeClass('alert-error').html(msg).show();
                           $('#save-btn').hide();
                           $(this).off('save.newuser');
                       } else if(data && data.errors){
                           //server-side validation error, response like {"errors": {"username": "username already exist"} }
                           config.error.call(this, data.errors);
                       }
                       //$('#saveButton'+currVAL).tooltip('hide');
                       //$('#saveButton'+currVAL).replaceWith("<button id='eliminaButton"+currVAL+"' onclick='confirmDelete("+data.id+")' data-toggle='tooltip' data-placement='top' title='Elimina' class='btn btn-danger modify'><i class='fa fa-trash'></i></button>");
                       swal({
                            title: "Grande!",
                            text: "Dati salvati con successo! Attendi mentre aggiorno i dati...",
                            type: "success",
                            showConfirmButton: false
                       });
                       /*$('#loadingModal').modal({
                                backdrop: 'static',
                                keyboard: false
                           });*/
                       location.reload(true);
                   },
                   error: function(errors) {
                   console.log(errors);
                       var msg = '';
                       if(errors && errors.responseText) { //ajax error, errors = xhr object
                           msg = errors.responseText;
                       } else { //validation error (client-side or server-side)
                           $.each(errors, function(k, v) { msg += k+": "+v+"<br>"; });
                       }
                       $('#msg').removeClass('alert-success').addClass('alert-error').html(msg).show();
                   }
               });
            });

            $('#reset-btn').click(function() {
                $('.myeditable').editable('setValue', null)  //clear values
                    .editable('option', 'pk', null)          //clear pk
                    .removeClass('editable-unsaved');        //remove bold css

                $('#save-btn').show();
                $('#msg').hide();
            });

        });

        function confirmDelete(id) {
                swal({
                    title: "Sei sicuro?",
                    text: "Non potrai più recuperare questi dati!",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "Si, cancella!",
                    cancelButtonText: "No, non adesso",
                    closeOnConfirm: false
                }, function(){
                    <g:remoteFunction controller="recordTime" action="delete" params="'id='+id" onSuccess="afterDelete()"/>
            });
        }

        function afterDelete() {
            swal({
                title: "Cancellato!",
                text: "Il record è stato cancellato. Attendi mentre aggiorno i dati...",
                type: "success",
                showConfirmButton: false
            });
            location.reload(true);
        }
    </g:javascript>
	</body>
</html>
