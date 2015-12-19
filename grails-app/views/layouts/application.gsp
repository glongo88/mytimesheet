<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="Calcolo uscita"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${assetPath(src: 'apple-touch-icon.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${assetPath(src: 'apple-touch-icon-retina.png')}">

    <asset:javascript src="jquery-2.1.1.min.js"/>
    <asset:javascript src="jquery-ui-1.10.4.min.js"/>
    <asset:javascript src="bootstrap-timepicker.js"/>

    <asset:stylesheet src="bootstrap.min.css"/>
    <asset:stylesheet src="jquery-ui.css"/>
    <asset:stylesheet src="bootstrap-timepicker.min.css"/>
    <asset:stylesheet src="sweet-alert.css"/>
    <asset:stylesheet src="theme_styles.css"/>
    <asset:stylesheet src="custom.css"/>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
    <link rel='stylesheet' type='text/css' href='http://fonts.googleapis.com/css?family=Open+Sans:400,700|Droid+Sans:400,700' />
    <link href='https://fonts.googleapis.com/css?family=Luckiest+Guy|Fredoka+One|Fjalla+One|Paytone+One|Candal|Carter+One|Knewave|Lilita+One' rel='stylesheet' type='text/css'>
    <!-- google font libraries -->
    <link href='//fonts.googleapis.com/css?family=Open+Sans:400,600,700,300|Titillium+Web:200,300,400' rel='stylesheet' type='text/css'>

    <g:layoutHead/>

</head>
<body class="theme-whbl fixed-header">

<div id="theme-wrapper">

    <g:render template="/common/header"/>

    <div id="page-wrapper" class="container">

        <g:render template="/common/sidebar"/>

        <div id="content-wrapper">

            <div class="row">
                <div class="col-lg-12">

                    <g:layoutBody/>

                </div>
            </div>

            <g:render template="/common/footer"/>

        </div>
    </div>
</div>
</div>

</body>
</html>
