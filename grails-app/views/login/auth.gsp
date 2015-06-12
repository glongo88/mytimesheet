<html>

<head>
<title><g:message code='spring.security.ui.login.title'/></title>
<meta name='layout' content='register'/>
</head>

<body class="login-page">

<!-- Start #login -->
<div id="login" class="animated bounceIn">

    <h1 style="color: white; font-size: 35px;">MyHours</h1>
    <!-- Start .login-wrapper -->
    <div class="login-wrapper">
        <div id="myTabContent" class="tab-content bn">
            <div class="tab-pane fade active in" id="log-in">
                <div class="social-buttons text-center mt10">
                    <a href="#" class="btn btn-primary btn-alt btn-round btn-lg mr10"><i class="fa-facebook s24"></i></a>
                    <a href="#" class="btn btn-primary btn-alt btn-round btn-lg mr10"><i class="fa-twitter s24"></i></a>
                    <a href="#" class="btn btn-danger btn-alt btn-round btn-lg mr10"><i class="fa-google-plus s24"></i></a>
                    <a href="#" class="btn btn-info btn-alt btn-round btn-lg"><i class="fa-linkedin s24"></i></a>
                </div>
                <div class="seperator">
                    <strong>o</strong>
                    <hr>
                </div>
                <form action='${postUrl}' class="form-horizontal mt20" method='POST' id="login-form" name="loginForm" autocomplete='off'>
                    <div class="form-group">
                        <div class="col-lg-12">
                            <input type="text" name="j_username" id="username" class="form-control left-icon" value="" placeholder="La tua email">
                            <i class="ec-user s16 left-input-icon"></i>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-12">
                            <input type="password" name="j_password" id="password" class="form-control left-icon" value="" placeholder="La tua password">
                            <i class="ec-locked s16 left-input-icon"></i>
                            <span class="help-block"><a href="#"><small>Password dimenticata?</small></a></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-8">
                            <label class="checkbox">
                                <input type="checkbox" name="remember" id="remember" value="option">Ricordami?
                            </label>
                        </div>

                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-4">
                            %{--<s2ui:submitButton class="btn btn-success btn-block" elementId='loginButton' form='loginForm' messageCode='Login'/>--}%
                            <button class="btn btn-success btn-block" id="loginButton" type="submit">Login</button>
                        </div>

                    </div>
                </form>

                <div class="seperator">
                    <strong>Nuovo account</strong>
                    <hr>
                </div>
                <div class="text-center">
                    Non hai ancora un account?<br/><br/>
                    <g:link controller="register">
                        <button class="btn btn-primary">Registrati</button>
                    </g:link>
                </div>


            </div>



        </div>
    </div>

</div>


<script>
$(document).ready(function() {
	$('#username').focus();
});

<s2ui:initCheckboxes/>

</script>

</body>
</html>
