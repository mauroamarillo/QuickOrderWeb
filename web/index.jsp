<%-- 
    Document   : index
    Created on : 27/08/2015, 11:35:58 PM
    Author     : Jean
--%>

<%@page import="java.util.Random"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String error;
    if (request.getParameter("error") != null) {
        error = request.getParameter("error");
    } else {
        error = "0";
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Quick天Order</title>
        <link href ="css/bootstrap.min.css" rel="stylesheet" />
        <link href ="css/estilos.css" rel="stylesheet" />
        <link href="js/fancybox/jquery.fancybox-1.3.4.css" rel="stylesheet" type="text/css" media="screen" />
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
            out.print("<body  onload=\"mostrarRespuesta('<b>ERROR AL INICIAR  SESION  </b>',false)\" >");
        } else {
            if (session.getAttribute("nick") == null) {
                out.print("<body onload=\"mostrarRespuesta('<b>Bienvenido Invitado!</b>',true)\" >");
            } else {
                out.print("<body onload=\"mostrarRespuesta('<b>Bienvenido " + session.getAttribute("nick") + "!</b>',true)\" >");
            }
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
                <a class="navbar-brand" href="#">Quick天Order</a>
            </div>
            <div id="BARRA-QUE-SE-OCULTA" class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li><a class="frameLink" href="#"> Buscar Productos </a></li>
                        <%-- <li><a class="frameLink" href="#"> Imagenes </a></li>
                            <li><a class="frameLink" href="#"> Musica </a></li>--%>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <%
                        if (session.getAttribute("nick") == null) {
                            out.print("<li><a href=\"#\" data-toggle=\"modal\" data-target=\"#ModalLogin\">  Iniciar Sesion </a></li> "
                                    + "<li><a href=\"#\" data-toggle=\"modal\" data-target=\"#ModalRegistro\"> Registro </a></li>");
                        } else {
                            out.print("<li><a href=\"infoUsuario.jsp\" class=\"frameLink\">" + session.getAttribute("nick") + " </a></li> "
                                    + "<li><a href=\"logout.jsp\"> Cerrar Sesion </a></li>");
                        }
                    %>

                </ul>
            </div>
        </div>
    </nav>
    <%-- Carrusel de Restaurantes todavia no esta bien :v--%>
    <%-- <div id="myCarousel" class="carousel slide">
          <div class="carousel-inner">
              <div class="item active">
                  <img src="img/car1.jpg" style="width: 100%; height: 246px;" alt="">
                  <div class="container">
                      <div class="carousel-caption">
                          <h1>Example headline.</h1>
                          <p class="lead">Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
                          <a class="btn btn-large btn-primary" href="#">Sign up today</a>
                      </div>
                  </div>
              </div>
              <div class="item">
                  <img src="img/car2.jpg" style="width: 100%; height: 246px;" alt="">
                  <div class="container">
                      <div class="carousel-caption">
                          <h1>Another example headline.</h1>
                          <p class="lead">Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
                          <a class="btn btn-large btn-primary" href="#">Learn more</a>
                      </div>
                  </div>
              </div>
              <div class="item">
                  <img src="img/car3.jpg" style="width: 100%; height: 246px;" alt="">
                  <div class="container">
                      <div class="carousel-caption">
                          <h1>One more for good measure.</h1>
                          <p class="lead">Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
                          <a class="btn btn-large btn-primary" href="#">Browse gallery</a>
                      </div>
                  </div>
              </div>
          </div>
          <a class="left carousel-control" href="#myCarousel" data-slide="prev">&lsaquo;</a>
          <a class="right carousel-control" href="#myCarousel" data-slide="next">&rsaquo;</a>
      </div> --%>
    <%-- Fin de carrusel --%>
    <%-- Saludo al entrar --%>
    <div id="respuesta" class="navbar navbar-left"></div>
    <div class="container">
        <div class="row">
            <div class="col-md-3">
                <div class="panel panel-default panel-transparent ">
                    <div class="panel-heading">
                        <span class="glyphicon glyphicon-star-empty" aria-hidden="true"></span><span> Restaurantes</span>
                    </div>
                    <div class="panel-body" id="barraRestauranes" >
                    </div>
                </div>
            </div>
            <div class="col-md-9">
                <div class="panel panel-default panel-transparent">
                    <div class="panel-heading">
                        <span class="glyphicon glyphicon-asterisk" aria-hidden="true"></span><span id="frameTitulo" > Quick天Order</span>
                    </div>
                    <div class="panel-body" id ="frameContainer" >
                        Bienvenido
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
                <form class="form-signin" action="registro.jsp" method="post" autocomplete="off">

                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h3 class="modal-title " id="exampleModalLabel" style="color:white;">Nuevo Registro</h3>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <input type="text" name="nick" id="nick" class="form-control" placeholder="Nickname*" required />
                            <div id="resultado"></div>
                        </div> 
                        <div class="form-group">
                            <input type="text" name="nombre" id="nombre" class="form-control" placeholder="Nombre Usuario*" required>
                        </div> 
                        <div class="form-group">
                            <input type="text" name="direccion" id="direccion" class="form-control" placeholder="direccion*" required>
                        </div> 
                        <div class="form-group">
                            <input type="email" name="email" id="email" class="form-control" placeholder="Email*" required>
                            <div id="resultadoEmail"></div>
                        </div> 
                        <div class="form-group">
                            <input type="password" name="passwd" id="passwd" class="form-control" placeholder="Contraseña*" required>
                        </div> 
                        <div class="form-group">
                            <div class="input-group date form_date" data-date="" data-date-format="dd MM yyyy" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
                                <input type="text" name="fecha" class="form-control" size="16" placeholder="Fecha Nacimiento*" required >
                                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                            </div>
                            <input type="hidden" id="dtp_input2" value="" /><br/>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button value=" Send" class="btn btn-primary" type="submit" id="submit">Confirmar</button>
                    </div>
                </form>
            </div>
        </div>
    </div> <%--    Fin de Formulario De Resgistro    --%>


    <%--   Formulario De Login   --%>
    <div class="modal fade" id="ModalLogin" tabindex="-1" role="dialog" aria-labelledby="ModalLoginLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content modal-transparent">
                <form class="form-signin"  action="login.jsp" method="post">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h3 class="form-signin-heading text-muted" style="color:white;">Iniciar Sesion</h3>
                    </div>
                    <div class="modal-body">

                        <input type="text" name="nick" class="form-control" placeholder="Nick o Email" required="" autofocus="">
                        <input type="password" name="passwd" class="form-control" placeholder="Password" required="">

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
    <script type="text/javascript" src="js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
    <script type="text/javascript" src="js/bootstrap-datetimepicker.es.js" charset="UTF-8"></script>
    <script>
        !window.jQuery && document.write('<script src="js/jquery.min.js"><\/script>');
    </script>
    <script type="text/javascript">
        $("#barraRestauranes").load("restaurantesPorCategoria.jsp");
    </script>
    <script type="text/javascript">
        cargarResaurante = function (r) {
            $.ajax({
                type: "POST",
                url: "infoRestaurante.jsp",
                data: "r=" + r,
                dataType: "html",
                error: function () {
                    $("#frameContainer").html("Error al cargar restaurante");
                    $("#frameTitulo").html(" ERROR");
                    n();
                },
                success: function (data) {
                    $("#frameContainer").html(data);
                    $("#frameTitulo").html(" Restaurantes");
                    n();
                }
            });
            // $("#frameContainer").load({url: "infoRestaurante.jsp", data: "r=" + r, type: "POST", dataType: "html"});
        };
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            var consulta;
            //comprobamos si se pulsa una tecla
            $("#nick").keyup(function (e) {
                //obtenemos el texto introducido en el campo
                consulta = $("#nick").val();
                //hace la búsqueda          
                $("#resultado").delay(1000).queue(function (n) {
                    // antes ponia un botoncito como que estaba cargando, pero incha bastabte
                    // $("#resultado").html('<img src="img/ajax-loader.gif" />');
                    $.ajax({
                        type: "POST",
                        url: "verificarNombre.jsp",
                        data: "nick=" + consulta,
                        dataType: "html",
                        error: function () {
                            $("#resultado").html("Error en la peticion ajax");
                            n();
                        },
                        success: function (data) {
                            $("#resultado").html(data);
                            n();
                        }
                    });
                });
            });

            // $("#barraSup").load("barraSup.jsp");
            //cargo la direccion de los links frameLink en el frameContainer
            $(".frameLink").each(function () {
                var href = $(this).attr("href");
                if (href !== "#") {
                    $(this).attr({href: "#"});
                    $(this).click(function () {
                        $("#frameContainer").load(href);
                        $("#frameTitulo").html(" " + $(this).html());
                    });
                }
            });
        });
    </script>

    <script type="text/javascript">
        /* Este es el script para que se despliege el calendario*/
        $('.form_date').datetimepicker({
            language: 'es',
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            minView: 2,
            forceParse: 0
        });
        //mostrar mensajes
        function mostrarRespuesta(mensaje, ok) {
            $("#respuesta").removeClass('alert alert-success').removeClass('alert alert-danger').html(mensaje);
            if (ok) {
                $("#respuesta").addClass('alert alert-success');
            } else {
                $("#respuesta").addClass('alert alert-danger');
            }
            $('#respuesta').show().delay(3000).fadeOut("slow");
        }
    </script>

</body>
</html>