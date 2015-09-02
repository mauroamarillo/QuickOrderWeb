<%-- 
    Document   : infoRestaurante
    Created on : 29/08/2015, 01:38:02 AM
    Author     : Jean
--%>
<%@page import="Logica.DataTypes.DataPromocion"%>
<%@page import="Logica.DataTypes.DataIndividual"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="Logica.DataTypes.DataRestaurante"%>
<%@page import="Logica.ControladorUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (request.getParameter("r") == null) {
        response.sendRedirect("index.jsp");
    }
    String nick = (String) request.getParameter("r");
    ControladorUsuario CU = new ControladorUsuario();
    DataRestaurante DR = CU.buscarRestaurante(nick);
    if (DR == null) {                                           // si no se encuentra el restaurante
        out.print("<h1>No se encontro este restaurante</h1>");  // muestro el mensaje
        return;                                                 // y me las tomo
    }
%>
<!DOCTYPE html>

<div id="content">
    <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
        <li class="active"><a href="#Productos" data-toggle="tab">Productos</a></li>
        <li ><a href="#Datos" data-toggle="tab">Datos <%=DR.getNombre()%></a></li>
        <li><a href="#Calificaciones" data-toggle="tab">Calificaciones</a></li>
    </ul>
    <div id="my-tab-content" class="tab-content">
        <div class="tab-pane active" id="Productos">
            </br>
            <div class="row"><%--Productos--%>
                <%
                    Iterator it = DR.getPromociones().entrySet().iterator();
                    int contador = 0;
                    while (it.hasNext()) {
                        Map.Entry entry = (Map.Entry) it.next();
                        DataPromocion DP = (DataPromocion) entry.getValue();
                        String urlImg = DP.getImagen();
                        if (urlImg.equals("sin_imagen")) {
                            urlImg = "img/sin_img.jpg";
                        }
                        out.print("<div class=\"col-sm-6 col-md-4\">");
                        out.print("     <div class=\"thumbnail\" >");
                        out.print("<img src=\"" + urlImg + "\" style=\"width: 100%; height: 150px;\"alt=\"" + DP.getNombre() + "\">");
                        out.print("         <div class=\"caption\">");
                        out.print("             <h3>" + DP.getNombre() + "</h3>");
                        out.print("                 <p>" + DP.getDescripcion() + "</p>");
                        out.print("                 <p>Precio: $" + DP.getPrecio() + "</p>");
                        out.print("                 <p>Descuento: " + DP.getDescuento() + "%</p>");
                        if (DP.isActivo()) {
                            out.print("                 <p><b>Promocion Activa</b>");
                        } else {
                            out.print("                 <p><b>Promocion Inactiva</b>");
                        }
                        out.print(" <input type=\"button\" onclick=\"verPromo('" + DP.getRestaurante() + "_" + DP.getNombre() + "');\" hidden=\"true\" id= \"Prod_" + DP.getNombre() + "\"/> <label  for=\"Prod_" + DP.getNombre() + "\"> <span class=\"glyphicon glyphicon-list-alt\" aria-hidden=\"true\"></span></label>");
                        out.print("                     <a href=\"#\" class=\"btn btn-primary\" role=\"button\" style=\"width: 100%;\">Pedidos Relacionados      </a>");
                        if (session.getAttribute("nick") != null && DP.isActivo()) {
                            out.print("                     <a href=\"#\" class=\"btn btn-primary\" role=\"button\" style=\"width: 100%;\">Agregar A Pedido Existente</a>"
                                    + "                     <a href=\"#\" class=\"btn btn-primary\" role=\"button\" style=\"width: 100%;\">Crear Nuevo Pedido        </a>");
                        }
                        out.print("         </div>");
                        out.print("     </div>");
                        out.print("</div>");
                        contador++;
                        if (contador == 3) {
                            contador = 0;
                            out.print("</div>"
                                    + "<div class=\"row\">");
                        }
                    }
                    it = DR.getIndividuales().entrySet().iterator();
                    while (it.hasNext()) {
                        Map.Entry entry = (Map.Entry) it.next();
                        DataIndividual DI = (DataIndividual) entry.getValue();
                        String urlImg = DI.getImagen();
                        if (urlImg.equals("sin_imagen")) {
                            urlImg = "img/sin_img.jpg";
                        }
                        out.print("<div class=\"col-sm-6 col-md-4\">");
                        out.print("     <div class=\"thumbnail\" >");
                        out.print("<img src=\"" + urlImg + "\" style=\"width: 100%; height: 150px;\"alt=\"" + DI.getNombre() + "\">");
                        out.print("         <div class=\"caption\">");
                        out.print("             <h3>" + DI.getNombre() + "</h3>");
                        out.print("                 <p>" + DI.getDescripcion() + "</p>");
                        out.print("                 <p>Precio: $" + DI.getPrecio() + "</p>");
                        out.print("                     <a href=\"#\" class=\"btn btn-primary\" role=\"button\" style=\"width: 100%;\">Pedidos Relacionados      </a>");
                        if (session.getAttribute("nick") != null) {
                            out.print("                     <a href=\"#\" class=\"btn btn-primary\" role=\"button\" style=\"width: 100%;\">Agregar A Pedido Existente</a>"
                                    + "                     <a href=\"#\" class=\"btn btn-primary\" role=\"button\" style=\"width: 100%;\">Crear Nuevo Pedido        </a>");
                        }
                        out.print("         </div>");
                        out.print("     </div>");
                        out.print("</div>");
                        contador++;
                        if (contador == 3) {
                            contador = 0;
                            out.print("</div>"
                                    + "<div class=\"row\">");
                        }
                    }
                %>
            </div>
        </div>
        <div class="tab-pane" id="Datos" style="color:white;">
            <div class="col-lg-3 ">
                </br>
                <%-- Aca cargo las imagenes del restaurante si las tiene, si no le meto que no hay imagen--%>
                <%                    HashMap IMGs = DR.getImagenes();
                    if (IMGs.size() > 0) {
                        it = IMGs.entrySet().iterator();
                        int x = 0;
                        out.print("<div id=\"myCarousel\" class=\"carousel slide\" data-ride=\"carousel\">");
                        out.print("<ol class=\"carousel-indicators\">");
                        while (it.hasNext()) {
                            it.next();
                            if (x == 0) {
                                out.print("<li data-target=\"#myCarousel\" data-slide-to=\"" + x + "\" class=\"active\"></li>");
                            } else {
                                out.print("<li data-target=\"#myCarousel\" data-slide-to=\"" + x + "\"></li>");
                            }
                            x++;
                        }
                        out.print("</ol>");
                        out.print("<div class=\"carousel-inner\" role=\"listbox\">");
                        it = IMGs.entrySet().iterator();
                        x = 0;
                        while (it.hasNext()) {
                            Map.Entry entry = (Map.Entry) it.next();
                            String img = (String) entry.getValue();
                            if (x == 0) {
                                out.print("<div class=\"item active\">");
                            } else {
                                out.print("<div class=\"item\">");
                            }
                            out.print("<img src=\"" + img + "\" alt=\"" + x + "\" style=\" width: 190px; height: 190px;\">");
                            out.print("</div>");
                            x++;
                        }
                        out.print("</div>");
                        //se crean los controles 
                        out.print("<a class=\"left carousel-control\" href=\"#myCarousel\" role=\"button\" data-slide=\"prev\">"
                                + "     <span class=\"glyphicon glyphicon-chevron-left\" aria-hidden=\"true\"></span>"
                                + "     <span class=\"sr-only\">Previous</span>"
                                + "</a>"
                                + "<a class=\"right carousel-control\" href=\"#myCarousel\" role=\"button\" data-slide=\"next\">"
                                + "     <span class=\"glyphicon glyphicon-chevron-right\" aria-hidden=\"true\"></span>"
                                + "     <span class=\"sr-only\">Next</span>"
                                + " </a>"
                                //se cierar el div del carrusel
                                + "</div>");

                    } else {// si no hay imagenes solo pongo una imagen que dce que no hay xD
                        out.print("<img src=\"img/sin_img.jpg\" class=\"img-thumbnail\" style=\" width: 190px; height: 190px;\" />");
                    }
                %>
            </div>
            <div class="col-lg-9">
                <h1><%=DR.getNombre()%></h1>
                <p> 
                    <b>Direccion:</b> <%=DR.getDireccion()%></br>
                    <b>Email:</b> <%=DR.getEmail()%></br>
                </p>
            </div>
        </div>
        <div class="tab-pane" id="Calificaciones">
            <h1>Calificaciones</h1>
            <p>Ta geno pa meter algo aca :v</p>
        </div>
    </div>
</div>
<div id="ModalPromocion" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content modal-transparent" id="ModalPromocionContenido">

        </div>
    </div>
</div>
<script type="text/javascript">
    jQuery(document).ready(function ($) {
        $('#tabs').tab();
    });
    verPromo = function (x) {
        $('#ModalPromocion').removeData('bs.modal');
        $('#ModalPromocion').modal({remote: 'modalCarga.html'});
        $('#ModalPromocion').removeData('bs.modal');
        $('#ModalPromocion').modal({remote: 'verPromo.jsp?x=' + x});
        $('#ModalPromocion').modal('show');
    };
</script>                   
