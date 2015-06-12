<html>

<head>
    <title><g:message code='spring.security.ui.login.title'/></title>
    <meta name='layout' content='register'/>
</head>

<body class="login-page">


<g:if test='${emailSent}'>
    <div style="width: 600px;" id="login" class="animated bounceIn">
        <h1 style="color: white; font-size: 35px;">MyHours</h1>
        <div class="row">
            <div class="col-lg-6 col-lg-offset-2">
                <div class="jumbotron text-center" style="padding: 60px;">
                    <h1>Perfetto!</h1>
                    <br/>
                    <p><g:message code='spring.security.ui.register.sent'/></p>
                </div>
            </div>
        </div>
    </div>
</g:if>
<g:else>
<!-- Start #login -->
<div id="login" class="animated bounceIn">

    <h1 style="color: white; font-size: 35px;">MyHours</h1>
    <!-- Start .login-wrapper -->
    <div class="login-wrapper">
        <div id="myTabContent" class="tab-content bn">
            <div class="tab-pane fade active in" id="log-in">
                    <g:form class="form-horizontal mt20" action='register' name='registerForm'>
                        <div class="form-group ${hasErrors(bean:command,field:'nome', 'has-error')}">
                            <div class="col-lg-12">
                                <s2ui:textFieldRow class="form-control" name='nome' labelCode='user.nome.label' bean="${command}"
                                                   size='40' labelCodeDefault='Nome*' value="${command.nome}"/>
                            </div>
                        </div>
                        <div class="form-group ${hasErrors(bean:command,field:'cognome', 'has-error')}">
                            <div class="col-lg-12">
                                <s2ui:textFieldRow class="form-control" name='cognome' labelCode='user.cognome.label' bean="${command}"
                                                   size='40' labelCodeDefault='Cognome*' value="${command.cognome}"/>
                            </div>
                        </div>
                        <div class="form-group ${hasErrors(bean:command,field:'username', 'has-error')}">
                            <div class="col-lg-12">
                                <s2ui:textFieldRow class="form-control" name='username' labelCode='user.username.label' bean="${command}"
                                                   size='40' labelCodeDefault='Email*' value="${command.username}"/>
                            </div>
                        </div>
                        <div class="form-group ${hasErrors(bean:command,field:'password', 'has-error')}">
                            <div class="col-lg-12">
                                <s2ui:passwordFieldRow class="form-control" name='password' labelCode='user.password.label' bean="${command}"
                                                       size='40' labelCodeDefault='Password*' value="${command.password}"/>
                            </div>
                        </div>
                        <div class="form-group ${hasErrors(bean:command,field:'password2', 'has-error')}">
                            <div class="col-lg-12">
                                <s2ui:passwordFieldRow class="form-control" name='password2' labelCode='user.password2.label' bean="${command}"
                                                       size='40' labelCodeDefault='Ripeti password*' value="${command.password2}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-12">
                                <label for="sesso">Sesso*</label>
                                <g:select class="form-control" name="sesso" from="['Uomo', 'Donna']" value="${command.sesso}"/>
                            </div>
                        </div>

                        <br/>

                        <div class="form-group text-center">
                            <button class="btn btn-success btn-lg" id="loginButton" type="submit">Registrati</button>
                        </div>
                    </g:form>
            </div>

        </div>
    </div>
</div>
</g:else>

<script>
    $(document).ready(function() {
        $('#nome').focus();
    });

    <s2ui:initCheckboxes/>

</script>

</body>
</html>
