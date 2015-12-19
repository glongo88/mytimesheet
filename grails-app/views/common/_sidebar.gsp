<div id="nav-col">
    <section id="col-left" class="col-left-nano">
        <div id="col-left-inner" class="col-left-nano-content">
            <div id="user-left-box" class="clearfix hidden-sm hidden-xs dropdown profile2-dropdown">
                <g:img dir="images" file="user.png"/>
                <div class="user-box">
                    <span class="name">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <sec:loggedInUserInfo field="nome"/>
                            <i class="fa fa-angle-down"></i>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a href="user-profile.html"><i class="fa fa-user"></i>Profile</a></li>
                            <li><a href="#"><i class="fa fa-cog"></i>Settings</a></li>
                            <li><a href="#"><i class="fa fa-envelope-o"></i>Messages</a></li>
                            <li><a href="#"><i class="fa fa-power-off"></i>Logout</a></li>
                        </ul>
                    </span>
                    <span class="status">
                        <i class="fa fa-circle"></i> Online
                    </span>
                </div>
            </div>
            <div class="collapse navbar-collapse navbar-ex1-collapse" id="sidebar-nav">
                <ul class="nav nav-pills nav-stacked">
                    <li class="nav-header nav-header-first hidden-sm hidden-xs">
                        Navigation
                    </li>
                    <li class="${controllerName.equals('home') ? 'active':''}">
                        <g:link controller="home">
                            <i class="fa fa-dashboard"></i>
                            <span>Dashboard</span>
                            %{--<span class="label label-primary label-circle pull-right">28</span>--}%
                        </g:link>
                    </li>
                    <li class="${controllerName.equals('recordTime') ? 'active':''}">
                        <g:link mapping="dettaglio-mese" params="[month: new Date().format('MM'), year: new Date().format('yyyy')]">
                            <i class="fa fa-list"></i>
                            <span>Dettaglio mese</span>
                        </g:link>
                    </li>
                    <li class="${controllerName.equals('riepilogo') ? 'active':''}">
                        <g:link mapping="riepilogo-mese" params="[month: new Date().format('MM'), year: new Date().format('yyyy')]">
                            <i class="fa fa-line-chart"></i>
                            <span>Riepilogo mese</span>
                        </g:link>
                    </li>
                </ul>
            </div>
        </div>
    </section>
    <div id="nav-col-submenu"></div>
</div>