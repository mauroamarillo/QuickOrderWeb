<%-- 
    Document   : bienvenida
    Created on : 10/09/2015, 04:00:31 PM
    Author     : Jean
--%>

<%@page import="Logica.DataTypes.DataIndividual"%>
<%@page import="Logica.DataTypes.DataPromocion"%>
<%@page import="Logica.DataTypes.DataRestaurante"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="Logica.ControladorUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    ControladorUsuario CU = null;
    if (session.getAttribute("CU") == null) {
        CU = new ControladorUsuario();
    } else {
        CU = (ControladorUsuario) session.getAttribute("CU");
    }
    HashMap restaurantes = CU.getDataRestaurantes();
%>
<style>
    .carousel-caption h1, .carousel-caption p{
        color: black;
        text-shadow: 0 0 10px white,
            0 0 5px  white,
            0 0 5px white,
            0 0 5px   white,
            0 0 5px  white,
            0 0 5px  white,
            0 0 5px white,
            0 0 5px white!important;
    }
    .imagenCarrusel{
        height: 384px!important;
        width: 100%!important;
        
        // -webkit-animation: filter-animation 1s infinite;
    }
    @-webkit-keyframes filter-animation {
        0% {
            -webkit-filter: sepia(0) saturate(2);
        }
        50% {
            -webkit-filter: sepia(1) saturate(8);
        }
        100% {
            -webkit-filter: sepia(0) saturate(2);
        }
    }
</style>
<!--<embed src="borrar/mp3.mp3" width="240" height="160" style=" visibility: hidden; position: absolute;" /> -->
<div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
        <%
            for (int x = 0; x < restaurantes.size(); x++) {
                if (x == 0) {
                    out.print("<li data-target=\"#myCarousel\" data-slide-to=\"" + x + "\" class=\"active\"></li>");
                } else {
                    out.print("<li data-target=\"#myCarousel\" data-slide-to=\"" + x + "\"></li>");
                }
            }
        %>
    </ol>
    <div class="carousel-inner" role="listbox">
        <%
            Iterator it = restaurantes.entrySet().iterator();
            String activo = "active";
            while (it.hasNext()) {
                Map.Entry entry = (Map.Entry) it.next();
                DataRestaurante DR = (DataRestaurante) entry.getValue();
                DataIndividual DI = ((DataIndividual) ((Map.Entry) DR.getIndividuales().entrySet().iterator().next()).getValue());
                out.print("<div class=\"item " + activo + "\">");
                out.print(" <img class=\"" + DR.getNombre() + "-slide imagenCarrusel\" src=\"" + DI.getImagen() + "\" alt=\"" + DR.getNombre() + "\"/>");
                out.print("<div class=\"container\">");
                out.print("<div class=\"carousel-caption\">");
                out.print("<h1>" + DI.getNombre() + "</h1>");
                out.print("<p>" + DI.getDescripcion() + "</p>");
                out.print(" <p><a class=\"btn btn-lg btn-primary\" href=\"#\" role=\"button\">Visitar Restaurante</a></p>");
                out.print("</div>");
                out.print("</div>");
                out.print("</div>");
                activo = "";
            }
        %>
        <!--<div class="item active">
            <img class="first-slide imagenCarrusel" src="img/car1.jpg" alt="First slide"/>
            <div class="container">
                <div class="carousel-caption">
                    <h1>Titulo</h1>
                    <p>Texto con una descripcion re loca</p>
                    <p><a class="btn btn-lg btn-primary" href="#" role="button">Boton que lleva al restaurante</a></p>
                </div>
            </div>
        </div>
         <div class="item">
            <img class="second-slide" src="img/car2.jpg" alt="Second slide">
            <div class="container">
                <div class="carousel-caption">
                    <h1>Another example headline.</h1>
                    <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
                    <p><a class="btn btn-lg btn-primary" href="#" role="button">Learn more</a></p>
                </div>
            </div>
        </div>
        <div class="item">
            <img class="third-slide" src="img/car3.jpg" alt="Third slide">
            <div class="container">
                <div class="carousel-caption">
                    <h1>One more for good measure.</h1>
                    <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
                    <p><a class="btn btn-lg btn-primary" href="#" role="button">Browse gallery</a></p>
                </div>
            </div>
        </div> -->
    </div>
    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>
