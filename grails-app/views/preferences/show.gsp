
<%@ page import="it.longo.Preferences" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'preferences.label', default: 'Preferences')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-preferences" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-preferences" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list preferences">
			
				<g:if test="${preferencesInstance?.isSaturdayExtra}">
				<li class="fieldcontain">
					<span id="isSaturdayExtra-label" class="property-label"><g:message code="preferences.isSaturdayExtra.label" default="Is Saturday Extra" /></span>
					
						<span class="property-value" aria-labelledby="isSaturdayExtra-label"><g:formatBoolean boolean="${preferencesInstance?.isSaturdayExtra}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${preferencesInstance?.isHalfTime}">
				<li class="fieldcontain">
					<span id="isHalfTime-label" class="property-label"><g:message code="preferences.isHalfTime.label" default="Is Half Time" /></span>
					
						<span class="property-value" aria-labelledby="isHalfTime-label"><g:formatBoolean boolean="${preferencesInstance?.isHalfTime}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${preferencesInstance?.minPausaPranzo}">
				<li class="fieldcontain">
					<span id="minPausaPranzo-label" class="property-label"><g:message code="preferences.minPausaPranzo.label" default="Min Pausa Pranzo" /></span>
					
						<span class="property-value" aria-labelledby="minPausaPranzo-label"><g:fieldValue bean="${preferencesInstance}" field="minPausaPranzo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${preferencesInstance?.utente}">
				<li class="fieldcontain">
					<span id="utente-label" class="property-label"><g:message code="preferences.utente.label" default="Utente" /></span>
					
						<span class="property-value" aria-labelledby="utente-label"><g:link controller="utente" action="show" id="${preferencesInstance?.utente?.id}">${preferencesInstance?.utente?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:preferencesInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${preferencesInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
