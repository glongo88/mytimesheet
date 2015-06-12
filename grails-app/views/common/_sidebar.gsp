<!-- Start #sidebar -->
<div id="sidebar">
    <!-- Start .sidebar-inner -->
    <div class="sidebar-inner">
        <!-- Start #sideNav -->
        <ul id="sideNav" class="nav nav-pills nav-stacked">
            <li><g:link class="${controllerName.equals('home') ? 'active':''}" controller="home" action="index">Dashboard <i class="fa fa-dashboard"></i></g:link></li>
            <li><g:link class="${controllerName.equals('recordTime') ? 'active':''}" mapping="dettaglio-mese" params="[month: new Date().format('MM'), year: new Date().format('yyyy')]">Dettaglio mese <i class="fa fa-calendar"></i></g:link></li>
            <li><g:link class="${controllerName.equals('riepilogo') ? 'active':''}" mapping="riepilogo-mese" params="[month: new Date().format('MM'), year: new Date().format('yyyy')]">Riepilogo mese <i class="fa fa-line-chart"></i></g:link></li>
        </ul>
        <!-- End #sideNav -->
    </div>
    <!-- End .sidebar-inner -->
</div>
<!-- End #sidebar -->