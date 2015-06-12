
<%@ page import="it.longo.RecordTime" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'recordTime.label', default: 'RecordTime')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-recordTime" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-recordTime" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list recordTime">
			
				<g:if test="${recordTimeInstance?.entrataTime}">
				<li class="fieldcontain">
					<span id="entrataTime-label" class="property-label"><g:message code="recordTime.entrataTime.label" default="Entrata Time" /></span>
					
						<span class="property-value" aria-labelledby="entrataTime-label"><g:fieldValue bean="${recordTimeInstance}" field="entrataTime"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${recordTimeInstance?.inizioPausaTime}">
				<li class="fieldcontain">
					<span id="inizioPausaTime-label" class="property-label"><g:message code="recordTime.inizioPausaTime.label" default="Inizio Pausa Time" /></span>
					
						<span class="property-value" aria-labelledby="inizioPausaTime-label"><g:fieldValue bean="${recordTimeInstance}" field="inizioPausaTime"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${recordTimeInstance?.finePausaTime}">
				<li class="fieldcontain">
					<span id="finePausaTime-label" class="property-label"><g:message code="recordTime.finePausaTime.label" default="Fine Pausa Time" /></span>
					
						<span class="property-value" aria-labelledby="finePausaTime-label"><g:fieldValue bean="${recordTimeInstance}" field="finePausaTime"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${recordTimeInstance?.uscitaTime}">
				<li class="fieldcontain">
					<span id="uscitaTime-label" class="property-label"><g:message code="recordTime.uscitaTime.label" default="Uscita Time" /></span>
					
						<span class="property-value" aria-labelledby="uscitaTime-label"><g:fieldValue bean="${recordTimeInstance}" field="uscitaTime"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:recordTimeInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${recordTimeInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
