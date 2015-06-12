<%@ page import="it.longo.RecordTime" %>



<div class="fieldcontain ${hasErrors(bean: recordTimeInstance, field: 'entrataTime', 'error')} ">
	<label for="entrataTime">
		<g:message code="recordTime.entrataTime.label" default="Entrata Time" />
		
	</label>
	<joda:timePicker name="entrataTime" value="${recordTimeInstance?.entrataTime}" default="none" noSelection="['': '']"></joda:timePicker>
</div>

<div class="fieldcontain ${hasErrors(bean: recordTimeInstance, field: 'inizioPausaTime', 'error')} ">
	<label for="inizioPausaTime">
		<g:message code="recordTime.inizioPausaTime.label" default="Inizio Pausa Time" />
		
	</label>
	<joda:timePicker name="inizioPausaTime" value="${recordTimeInstance?.inizioPausaTime}" default="none" noSelection="['': '']"></joda:timePicker>
</div>

<div class="fieldcontain ${hasErrors(bean: recordTimeInstance, field: 'finePausaTime', 'error')} ">
	<label for="finePausaTime">
		<g:message code="recordTime.finePausaTime.label" default="Fine Pausa Time" />
		
	</label>
	<joda:timePicker name="finePausaTime" value="${recordTimeInstance?.finePausaTime}" default="none" noSelection="['': '']"></joda:timePicker>
</div>

<div class="fieldcontain ${hasErrors(bean: recordTimeInstance, field: 'uscitaTime', 'error')} ">
	<label for="uscitaTime">
		<g:message code="recordTime.uscitaTime.label" default="Uscita Time" />
		
	</label>
	<joda:timePicker name="uscitaTime" value="${recordTimeInstance?.uscitaTime}" default="none" noSelection="['': '']"></joda:timePicker>
</div>

