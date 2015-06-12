<%@ page import="it.longo.Preferences" %>



<div class="fieldcontain ${hasErrors(bean: preferencesInstance, field: 'isSaturdayExtra', 'error')} ">
	<label for="isSaturdayExtra">
		<g:message code="preferences.isSaturdayExtra.label" default="Is Saturday Extra" />
		
	</label>
	<g:checkBox name="isSaturdayExtra" value="${preferencesInstance?.isSaturdayExtra}" />
</div>

<div class="fieldcontain ${hasErrors(bean: preferencesInstance, field: 'isHalfTime', 'error')} ">
	<label for="isHalfTime">
		<g:message code="preferences.isHalfTime.label" default="Is Half Time" />
		
	</label>
	<g:checkBox name="isHalfTime" value="${preferencesInstance?.isHalfTime}" />
</div>

<div class="fieldcontain ${hasErrors(bean: preferencesInstance, field: 'minPausaPranzo', 'error')} ">
	<label for="minPausaPranzo">
		<g:message code="preferences.minPausaPranzo.label" default="Min Pausa Pranzo" />
		
	</label>
	<g:field type="number" name="minPausaPranzo" value="${fieldValue(bean: preferencesInstance, field: 'minPausaPranzo')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: preferencesInstance, field: 'utente', 'error')} required">
	<label for="utente">
		<g:message code="preferences.utente.label" default="Utente" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="utente" name="utente.id" from="${it.longo.Utente.list()}" optionKey="id" required="" value="${preferencesInstance?.utente?.id}" class="many-to-one"/>
</div>

