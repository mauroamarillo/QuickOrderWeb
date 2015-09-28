<%-- 
    Document   : index
    Created on : 27/08/2015, 11:35:58 PM
    Author     : Jean
--%>

<%@page import="Logica.ControladorUsuario"%>
<%@page import="java.util.Random"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ControladorUsuario CU = new ControladorUsuario();
    session.setAttribute("CU", CU);
    String error;
    if (request.getParameter("error") != null) {
        error = request.getParameter("error");
    } else {
        error = "0";
    }
%>
<!DOCTYPE HTML>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Quick　Order</title><%-- 天 --%>
        <link href ="css/bootstrap.min.css" rel="stylesheet" />
        <link href ="css/estilos.css" rel="stylesheet" />
        <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen" />
        <link rel="icon" type="image/png" href="img/icono.png" />
        <style>
            body{ 
                background: url(img/car<%
                    Random r = new Random();
                    out.print(r.nextInt(5) + 1);
                    %>.jpg) no-repeat center center fixed !important; 
                -webkit-background-size: cover !important;
                -moz-background-size: cover !important;
                -o-background-size: cover !important;
                background-size: cover !important;
            }
        </style>
    </head>
    <%  if (error.equals("1")) {
            out.print("<body  onload=\"mostrarRespuesta('<b> Usuario Invalido  </b>',false)\" >");
        } else if (error.equals("2")) {
            out.print("<body onload=\"mostrarRespuesta('<b> Contraseña Invalida </b>',false)\" >");
        } else if (session.getAttribute("nick") == null) {
            out.print("<body onload=\"mostrarRespuesta('<b> Bienvenido Invitado! </b>',true)\" >");
        } else {
            out.print("<body onload=\"mostrarRespuesta('<b> Bienvenido " + session.getAttribute("nick") + "! </b>',true)\" >");
        }
    %>
    <nav class="navbar navbar-inverse navbar-static-top " >
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#BARRA-QUE-SE-OCULTA" aria-expanded="false" aria-control="navbar">
                    <span class="sr-only">Este boton despliega la barra</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand frameLink" href="bienvenida.jsp">Quick Order</a><%-- 天 --%>
            </div>
            <div id="BARRA-QUE-SE-OCULTA" class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li>
                        <a class="frameLink" href="busquedaProducto.jsp"> Listar Productos </a>
                    </li>
                </ul>
                <ul class="nav navbar-nav navbar-form">
                    <li>
                        <input type="text" id="inputBusquedaProducto" placeholder="Busqueda Producto" class="form-control" onkeyup="busquedaProducto(document.getElementById('inputBusquedaProducto').value)"/>
                    </li>
                </ul>

                <ul class="nav navbar-nav navbar-right">
                    <%
                        if (session.getAttribute("nick") == null) {
                            out.print("<li><a href=\"#\" data-toggle=\"modal\" data-target=\"#ModalLogin\">  Iniciar Sesion </a></li> "
                                    + "<li><a href=\"#\" data-toggle=\"modal\" data-target=\"#ModalRegistro\"> Registro </a></li>");
                        } else {
                            out.print("<li><a href=\"infoUsuario.jsp\" class=\"frameLink\">" + session.getAttribute("nombre") + "</a></li> "
                                    + "<li><a href=\"carrito.jsp\" class=\"frameLink\"> Ver Carrito </a></li>"
                                    + "<li><a href=\"logout\"> Cerrar Sesion </a></li>");
                        }
                    %>

                </ul>
            </div>
        </div>
    </nav>
    <%-- Saludo al entrar --%>
    <div id="respuesta" class="navbar navbar-left"></div>
    <div class="container">
        <div class="row">
            <div class="col-md-3">
                <div class="panel panel-default panel-transparent ">
                    <div id="tituloBarraRestaurantes" class="panel-heading" style=" position: relative;">   
                        <i class="glyphicon glyphicon-search" style="position: absolute;padding-top:17px; padding-left: 5px;pointer-events: none;"></i>
                        <input type="text" id="inputBusquedaRestaurante" class="form-control" placeholder="Busqueda Restaurantes" onkeyup="busquedaRestaurante(document.getElementById('inputBusquedaRestaurante').value)"/>
                    </div>
                    <div class="panel-body" id="barraRestauranes" >
                    </div>
                </div>
            </div>
            <div class="col-md-9">
                <div class="panel panel-default panel-transparent">
                    <div class="panel-heading">
                        <span id="frameIcono" class="glyphicon glyphicon-asterisk" aria-hidden="true"></span><span id="frameTitulo" > Quick<%-- 天 --%> Order</span>
                    </div>
                    <div class="panel-body" id ="frameContainer" >

                    </div>
                </div>
            </div>
        </div>
    </div>
    <%-- fin del ocntenedor principal --%>
    <%--    Formulario De Resgistro    --%>
    <div class="modal fade " id="ModalRegistro" tabindex="-1" role="dialog" aria-labelledby="ModalRegistroLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content modal-transparent">
                <form class="form-signin" action="registro" onsubmit="return evitarSubmit()" method="post" autocomplete="off">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h3 class="modal-title " id="exampleModalLabel" style="color:white; text-align: center;">Nuevo Registro</h3>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <input type="text" name="nick" id="nick" onkeyup="verificarNick()" class="form-control" placeholder="Nickname*" required />
                            <div id="resultado"></div>
                        </div> 
                        <div class="form-group">
                            <input type="text" name="nombre" id="nombre" class="form-control" placeholder="Nombre*" required/>
                        </div> 
                        <div class="form-group">
                            <input type="text" name="apellido" id="apellido" class="form-control" placeholder="Apellido*" required/>
                        </div> 
                        <div class="form-group">
                            <input type="text" name="direccion" id="direccion" class="form-control" placeholder="direccion*" required/>
                        </div> 
                        <div class="form-group ">
                            <input type="email" name="email" id="email" onkeyup="verificarEmail()" class="form-control " placeholder="Email*" required/>
                            <div id="resultadoEmail"></div>
                        </div> 
                        <div class="form-group">
                            <input type="password" name="passwd" id="passwd" class="form-control" placeholder="Contraseña*"  onkeyup="compararPass()" required/>
                        </div> 
                        <div id="re-passwd-group" class="form-group has-warning has-feedback">
                            <input type="password" name="passwd" id="re-passwd" class="form-control" placeholder="Vereficar Contraseña*" onkeyup="compararPass()" required/>
                            <span id="re-passwd-icono" class="glyphicon glyphicon-warning-sign form-control-feedback"></span>
                        </div> 
                        <div class="form-group">
                            <div class="input-group date form_date" data-date="" data-date-format="dd MM yyyy" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
                                <input type="text" id="fecha" name="fecha" onkeydown="return false;" class="form-control" size="16" placeholder="Fecha Nacimiento*" required />
                                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                            </div>
                            <input type="hidden" id="dtp_input2" value="" /><br/>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button value="Send" class="btn btn-primary" type="submit" id="submit">Confirmar</button>
                    </div>
                </form>
            </div>
        </div>
    </div> <%--    Fin de Formulario De Resgistro    --%>


    <%--   Formulario De Login   --%>
    <div class="modal fade" id="ModalLogin" tabindex="-1" role="dialog" aria-labelledby="ModalLoginLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content modal-transparent">
                <form class="form-signin"  action="login" method="post">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h3 class="form-signin-heading text-muted" style="color:white; text-align: center;">Iniciar Sesion</h3>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <input type="text" name="nick" class="form-control" placeholder="Nick o Email" required="" autofocus="">
                        </div> 
                        <div class="form-group">
                            <input type="password" name="passwd" class="form-control" placeholder="Password" required="">
                        </div> 
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-lg btn-primary btn-block" type="submit">Aceptar</button>
                    </div>
                </form>
            </div>
        </div>
    </div><%--   Fin de Formulario De Login   --%>

    <script src="js/jquery.min.js" ></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/scripts.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
    <script type="text/javascript" src="js/bootstrap-datetimepicker.es.js" charset="UTF-8"></script>
    <script>
                                    !window.jQuery && document.write('<script src="js/jquery.min.js"><\/script>');
    </script>
    <script type="text/javascript">

        $(document).ready(function () {
            cargarBienvenida();         // Frame bienvenida
            cargarBarraRestaurantes();  // Barra Restaurantes por categorias
            programarFrameLinks();      // hacer que los 'FrameLinks' carguen los datos en el contenedor principal

            $('#tabs').tab();
            $('.form_date').datetimepicker({// codigo nocesario para el calendario
                language: 'es',
                weekStart: 1,
                todayBtn: 1,
                autoclose: 1,
                todayHighlight: 1,
                startView: 2,
                minView: 2,
                forceParse: 0
            });
        });
    </script>
</body>
</html>