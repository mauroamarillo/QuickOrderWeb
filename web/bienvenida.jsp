<%-- 
    Document   : bienvenida
    Created on : 10/09/2015, 04:00:31 PM
    Author     : Jean
--%>

<%@page import="java.util.Random"%>
<%@page import="java.util.List"%>
<%@page import="ClienteWS.DataIndividual"%>
<%@page import="ClienteWS.DataRestaurante"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    ClienteWS.WSQuickOrder_Service service = null;
    String rutaWS = configuracion.configuracion.URLWS();
    try {
        if (rutaWS == null) {
            service = new ClienteWS.WSQuickOrder_Service();
        } else {
            service = new ClienteWS.WSQuickOrder_Service(new java.net.URL(rutaWS));
        }
    } catch (javax.xml.ws.WebServiceException e) {
        out.print("<div class=\"Exception\"> "+e.getMessage()+"</div>");
        return;
    }
    ClienteWS.WSQuickOrder port = service.getWSQuickOrderPort();
    if (port.getDataRestaurantes() == null) {
        out.print("<div class=\"Exception\"> Problemas en al obtener listado de resturantes </div>");
        return;
    }
%>
<head>
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
</head>
<!--<embed src="borrar/mp3.mp3" width="240" height="160" style=" visibility: hidden; position: absolute;" /> -->
<div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
        <%
            for (int x = 0; x < port.getDataRestaurantes().size(); x++) {
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
            Iterator it = port.getDataRestaurantes().iterator();
            String activo = "active";
            while (it.hasNext()) {
                Object entry = (Object) it.next();
                DataRestaurante DR = (DataRestaurante) entry;
                List<Object> aux = port.restauranteGetIndividuales(DR.getNickname());
                Random r = new Random();
                int seleccionado = r.nextInt(aux.size());
                DataIndividual DI = ((DataIndividual) aux.get(seleccionado));
                out.print("<div class=\"item " + activo + "\">");
                out.print(" <img class=\"" + DR.getNombre() + "-slide imagenCarrusel\" src=\"" + DI.getImagen() + "\" alt=\"" + DR.getNombre() + "\"/>");
                out.print("<div class=\"container\">");
                out.print("<div class=\"carousel-caption\">");
                out.print("<h1><b>" + DR.getNombre() + "</b></h1>");
                out.print("<h1>" + DI.getNombre() + "</h1>");
                out.print("<p>" + DI.getDescripcion() + "</p>");
                out.print(" <p><a class=\"btn btn-lg btn-primary\" href=\"#\" onclick=\"cargarResaurante('" + DR.getNickname() + "');return false;\" role=\"button\">Visitar Restaurante</a></p>");
                out.print("</div>");
                out.print("</div>");
                out.print("</div>");
                activo = "";
            }
        %>
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

<script>
    $(document).ready(function () {
        cambiarTitulo('Quick Order');
    });
</script>