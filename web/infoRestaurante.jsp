<%-- 
    Document   : infoRestaurante
    Created on : 29/08/2015, 01:38:02 AM
    Author     : Jean
--%>

<%@page import="ClienteWS.Fecha"%>
<%@page import="ClienteWS.DataCliente"%>
<%@page import="ClienteWS.DataPedido"%>
<%@page import="ClienteWS.DataIndividual"%>
<%@page import="ClienteWS.DataPromocion"%>
<%@page import="java.util.List"%>
<%@page import="ClienteWS.DataRestaurante"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        out.print("<div class=\"Exception\"> " + e.getMessage() + "</div>");
        return;
    }
    ClienteWS.WSQuickOrder port = service.getWSQuickOrderPort();

    if (request.getParameter("r") == null) {
        response.sendRedirect("index.jsp");
    }
    String nick = (String) request.getParameter("r");
    DataRestaurante DR = port.buscarRestaurante(nick);
    if (DR == null) {                                           // si no se encuentra el restaurante
        out.print("<h1>No se encontro este restaurante</h1>");  // muestro el mensaje
        return;                                                 // y me las tomo
    }
    float promedio = port.getPromedioCalificaciones(DR.getNickname());
    Iterator it;
%>
<!DOCTYPE html>
<div id="content">
    <div class="DatosRestaurante">
        <%
            String portada = "";
            if (port.restauranteGetImagenes(DR.getNickname()).size() > 0) {
                it = port.restauranteGetImagenes(DR.getNickname()).iterator();
                int x = 0;
                out.print("<div id=\"myCarousel\" class=\"carousel slide\" data-ride=\"carousel\">");
                out.print("<div class=\"carousel-inner\" role=\"listbox\">");
                while (it.hasNext()) {
                    Object entry = (Object) it.next();
                    String img = ((String) entry);
                    portada = img;
                    if (x == 0) {
                        out.print("<div class=\"item active\">");
                    } else {
                        out.print("<div class=\"item\">");
                    }
                    out.print("<img src=\"" + img + "\" alt=\"" + x + "\" class=\" img-thumbnail FotoPerfilRestaurante\">");
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

            } else {// si no hay imagenes solo pongo una imagen que dice que no hay xD
                portada = "img/imagenrestaurante.jpg";
                out.print("<div  class=\"carousel\" ><img src=\"img/sin_img.jpg\" class=\"img-thumbnail FotoPerfilRestaurante\" /> </div>");
            }
        %>
        <img src="<%=portada%>" class="fondo" />
        <div class="info">
            <h1><%=DR.getNombre()%></h1>
            <p> 
                <b>Direccion:</b> <%=DR.getDireccion()%></br>
                <b>Email:</b> <%=DR.getEmail()%></br>                
                <%
                    out.print("<p class=\"Estrellas\">");
                    out.print("<span class=\"badge alert-warning\">" + promedio + "</span> ");
                    int parteEntera = (int) promedio;
                    for (int i = 0; i < 5; i++) {
                        if (i < parteEntera) {
                            out.print("<span class=\"glyphicon glyphicon-star\" style=\"color:orange;\" />");
                        } else {
                            out.print("<span class=\"glyphicon glyphicon-star\" style=\"color:gray;\" />");
                        }
                    }
                    out.print("</p>");
                %>
            </p>
        </div>

    </div>
    <div class="PestaniasRestaurante">
        <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
            <li class="active"><a href="#Productos" data-toggle="tab">Productos</a></li>
            <li><a href="#Calificaciones" data-toggle="tab">Calificaciones</a></li>
        </ul>
        <div id="my-tab-content" class="tab-content">
            <div class="tab-pane active" id="Productos">
                </br>
                <div class="row"><%--Productos--%>
                    <%
                        it = port.restauranteGetPromociones(DR.getNickname()).iterator();
                        while (it.hasNext()) {
                            Object entry = (Object) it.next();
                            DataPromocion DP = (DataPromocion) entry;
                            String urlImg = DP.getImagen();
                            if (urlImg == null || urlImg.equals("sin_imagen")) {
                                urlImg = "img/imagenrestaurante.jpg";
                            }
                    %>
                    <div class="col-lg-6 col-sm-12 Producto">
                        <div class="row contenedor">
                            <div class="col-sm-10 contenido">
                                <img src="<%=urlImg%>" alt="<%=DP.getNombre()%>" /> 
                                <p class="precio">Precio $<%=DP.getPrecio()%></p>
                                <h3 class="nombre"><%=DP.getNombre()%></h3>
                                <p class="descripcion"><%=DP.getDescripcion()%><br>
                                <p class="activa">
                                    <%
                                        if (DP.isActivo()) {
                                            out.print("<a onclick=\"verPromo('" + DP.getRestaurante() + "_" + DP.getNombre() + "');\"><b>Promocion Activa</a>");
                                        } else {
                                            out.print("<b>Promocion Inactiva");
                                        }

                                        out.print(" " + DP.getDescuento() + "% </b>");
                                    %>
                                </p>
                            </div>
                            <div class=" col-sm-2 controles">
                                <a href="<%=DP.getRestaurante() + "_" + DP.getNombre()%>" class="btn verPedidosProducto" role="button" title="Ver Pedidos"> <span class="glyphicon glyphicon-open-file" aria-hidden="true"></span></a>
                                    <%
                                        if (session.getAttribute("nick") != null && DP.isActivo()) {
                                    %>
                                <input id="<%="Cantidad_" + DP.getRestaurante() + "_" + DP.getNombre()%>" class="number" type="number" min="1" max="100" step="1" value="1" title="Modificar cantidad" />
                                <a href="<%=DP.getRestaurante() + "_" + DP.getNombre()%>" class="btn agregarProducto" role="button" title="Agregar Al Carrito" > <span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span></a>
                                    <%
                                        }
                                    %>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                        it = port.restauranteGetIndividuales(DR.getNickname()).iterator();
                        while (it.hasNext()) {
                            Object entry = (Object) it.next();
                            DataIndividual DI = (DataIndividual) entry;
                            String urlImg = DI.getImagen();
                            if (urlImg == null || urlImg.equals("sin_imagen")) {
                                urlImg = "img/imagenrestaurante.jpg";
                            }
                    %>
                    <div class="col-lg-6  col-sm-12 Producto">
                        <div class="row contenedor">
                            <div class="col-sm-10 contenido">
                                <img src="<%=urlImg%>" alt="<%=DI.getNombre()%>" /> 
                                <p class="precio">Precio $<%=DI.getPrecio()%></p>
                                <h3 class="nombre"><%=DI.getNombre()%></h3>
                                <p class="descripcion"><%=DI.getDescripcion()%> </p>
                            </div>
                            <div class=" col-sm-2 controles">
                                <a href="<%=DI.getRestaurante() + "_" + DI.getNombre()%>" class="btn verPedidosProducto" role="button" title="Ver Pedidos"> <span class="glyphicon glyphicon-open-file" aria-hidden="true"></span></a>
                                    <%
                                        if (session.getAttribute("nick") != null) {
                                    %>
                                <input id="<%="Cantidad_" + DI.getRestaurante() + "_" + DI.getNombre()%>" class="number" type="number" min="1" max="100" step="1" value="1" title="Modificar cantidad" />
                                <a href="<%=DI.getRestaurante() + "_" + DI.getNombre()%>" class="btn agregarProducto" role="button" title="Agregar Al Carrito" > <span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span></a>
                                    <%
                                        }
                                    %>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>       
            <div class="tab-pane" id="Calificaciones"><%-- tercer panel --%>
                <br>
                <%
                    boolean hay_cal = false;
                    it = port.getPedidosRestaurante(DR.getNickname()).iterator();
                    while (it.hasNext()) {
                        Object entry = (Object) it.next();
                        DataPedido DP = (DataPedido) entry;
                        if (DP.getCalificacion().getPuntaje() > 0) {
                            hay_cal = true;
                            DataCliente DC = port.buscarCliente(DP.getCliente());
                            out.print(" <div class=\"row lineaCalificacionRestaurante\">");
                            out.print("<div class=\"col-sm-4\">" + (new DataTypes.Fecha(DP.getFecha())).toString() + "</div>");
                            out.print("<div class=\"col-sm-2\">" + DC.getNombre() + " " + DC.getApellido() + "</div>");
                            out.print("<div class=\"col-sm-4\">" + DP.getCalificacion().getComentario() + "</div>");
                            out.print("<div class=\"col-sm-2\">");
                            out.print("<a  href=\"#\" data-toggle=\"popover\" data-trigger=\"focus\" title=\"Comentario\" data-content=\"" + DP.getCalificacion().getComentario() + "\" >");
                            for (int i = 0; i < 5; i++) {
                                if (i < DP.getCalificacion().getPuntaje()) {
                                    out.print("<span class=\"glyphicon glyphicon-star\" style=\"color:orange;\" />");
                                } else {
                                    out.print("<span class=\"glyphicon glyphicon-star\" style=\"color:gray;\" />");
                                }
                            }
                            out.print("</a>");
                            out.print("</div>");
                            out.print("</div>");
                        }
                    }
                    if (!hay_cal) {
                        out.print("<p>No hay calificaciones registradas por el momento</p>");
                    }
                %>

            </div>
        </div>
    </div>
</div>

<div id="ModalPromocion" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content modal-transparent" id="ModalPromocionContenido">

        </div>
    </div>
</div>

<div id="ModalProductosPedidos" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content modal-transparent" id="ModalPromocionContenido">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h3 class="form-signin-heading text-muted" style="color:white; text-align: center;"> </h3>
            </div>
            <div class="modal-body"  style="color:black;">
                <p style="text-align: center;"></p>
            </div>
            <div class="modal-footer">

            </div>
        </div>
    </div>
</div>               
<script>
    $(document).ready(function () {
        cambiarTitulo('<%=DR.getNombre()%>');
        $('[data-toggle="popover"]').popover();
        $('[data-toggle="popover"').click(function () {
            return false;
        });
        linksVerPedidos();
        linksAgregarProducto();
        var pagina = "<%=request.getRequestURI().toString()%>?r=<%=DR.getNickname()%>";
                var navegador = new NavegadorSistema();
                $.ajax({
                    url: "historialVisita",
                    data: {
                        navegador: navegador.fullName,
                        sistema: navegador.platform,
                        pagina: pagina
                    }
                });

            });
</script>
