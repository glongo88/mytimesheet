<!-- Start #header -->
<div id="header">
<div class="container-fluid">
<div class="navbar">
    <div class="navbar-header">
        <g:link class="navbar-brand" controller="home">
            <span style="margin-left: 20px;" class="text-logo">My</span><span class="text-slogan">HOURS</span>
        </g:link>
    </div>
    <nav class="top-nav" role="navigation">
        <ul class="nav navbar-nav pull-left">
            <li id="toggle-sidebar-li">
                <a href="#" id="toggle-sidebar"><i class="fa fa-list"></i></a>
            </li>
        </ul>
        <ul class="nav navbar-nav pull-right">
            <sec:ifLoggedIn>
                <li class="dropdown"><a href="#" data-toggle="dropdown"><i style="margin-right: 10px;" class="fa fa-user"></i> Ciao <sec:loggedInUserInfo field="nome"/>!</a>
                    <ul class="dropdown-menu right animated flipInY" role="menu">
                        <li><g:link controller="home" action="profile"><i class="st-user"></i> Il mio profilo</g:link></li>
                        <li><g:link controller="preferences" action="index"><i class="fa fa-gears"></i> Impostazioni</g:link></li>
                        <li><a href="${createLink(controller: 'logout')}"> <i class="im-exit"></i> Logout</a></li>
                    </ul>
                </li>
            </sec:ifLoggedIn>
            <sec:ifNotLoggedIn>
                <li><g:link controller='login' action='auth'>Login</g:link></li>
            </sec:ifNotLoggedIn>
        </ul>
    </nav>
</div>
</div>
<!-- Start .header-inner -->
</div>
<!-- End #header -->