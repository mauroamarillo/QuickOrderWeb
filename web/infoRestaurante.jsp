<%-- 
    Document   : infoRestaurante
    Created on : 29/08/2015, 01:38:02 AM
    Author     : Jean
--%>

<%@page import="Logica.DataTypes.DataCliente"%>
<%@page import="Logica.Fecha"%>
<%@page import="Logica.DataTypes.DataPedido"%>
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
    ControladorUsuario CU = null;
    if (session.getAttribute("CU") == null) {
        CU = new ControladorUsuario();
    } else {
        CU = (ControladorUsuario) session.getAttribute("CU");
    }
    DataRestaurante DR = CU.buscarRestaurante(nick);
    if (DR == null) {                                           // si no se encuentra el restaurante
        out.print("<h1>No se encontro este restaurante</h1>");  // muestro el mensaje
        return;                                                 // y me las tomo
    }
    float promedio = CU.getPromedioCalificaciones(DR.getNickname());
    Iterator it;
%>
<!DOCTYPE html>

<div id="content">
    <div class="DatosRestaurante">
        <%
            HashMap IMGs = DR.getImagenes();
            String portada = "";
            if (IMGs.size() > 0) {

                it = IMGs.entrySet().iterator();
                int x = 0;
                out.print("<div id=\"myCarousel\" class=\"carousel slide\" data-ride=\"carousel\">");
                out.print("<div class=\"carousel-inner\" role=\"listbox\">");
                while (it.hasNext()) {
                    Map.Entry entry = (Map.Entry) it.next();
                    String img = ((String) entry.getValue()).replace("127.0.0.1", request.getLocalAddr());
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
                        it = DR.getPromociones().entrySet().iterator();
                        int contador = 0;
                        while (it.hasNext()) {
                            Map.Entry entry = (Map.Entry) it.next();
                            DataPromocion DP = (DataPromocion) entry.getValue();
                            String urlImg = DP.getImagen().replace("127.0.0.1", request.getLocalAddr());
                            if (urlImg.equals("sin_imagen")) {
                                urlImg = "img/sin_img.jpg";
                            }
                            out.print("<div class=\"col-sm-6 col-md-4 transparente\">");
                            out.print("     <div class=\"thumbnail\">");
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
                            out.print(" <input type=\"button\" onclick=\"verPromo('" + DP.getRestaurante() + "_" + DP.getNombre() + "');\" hidden=\"true\" id= \"Prod_" + DP.getNombre() + "\"/> <label class=\"botonListaDetallePromo\"  for=\"Prod_" + DP.getNombre() + "\"> <span class=\"glyphicon glyphicon-list-alt\" aria-hidden=\"true\"></span></label>");
                            out.print("                     <a href=\"" + DP.getRestaurante() + "_" + DP.getNombre() + "\" class=\"btn btn-primary verPedidosProducto\" role=\"button\" style=\"width: 100%;\">Pedidos Relacionados      </a>");
                            if (session.getAttribute("nick") != null && DP.isActivo()) {
                                out.print("                     <input id=\"Cantidad_" + DP.getRestaurante() + "_" + DP.getNombre() + "\" class=\"number\" type=\"number\" min=\"1\" max=\"1000\" step=\"1\" value=\"1\">");
                                out.print("                     <a href=\"" + DP.getRestaurante() + "_" + DP.getNombre() + "\" class=\"btn btn-primary agregarProducto\" role=\"button\" >Agregar Al Carrito</a>");
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
                            String urlImg = DI.getImagen().replace("127.0.0.1", request.getLocalAddr());
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
                            out.print("                     <a href=\"" + DI.getRestaurante() + "_" + DI.getNombre() + "\" class=\"btn btn-primary verPedidosProducto\" role=\"button\" style=\"width: 100%;\">Pedidos Relacionados      </a>");
                            if (session.getAttribute("nick") != null) {
                                out.print("                     <input id=\"Cantidad_" + DI.getRestaurante() + "_" + DI.getNombre() + "\" class=\"number\" type=\"number\" min=\"1\" max=\"1000\" step=\"1\" value=\"1\">");
                                out.print("                     <a href=\"" + DI.getRestaurante() + "_" + DI.getNombre() + "\" class=\"btn btn-primary agregarProducto\" role=\"button\">Agregar Al Carrito</a>");
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
            <div class="tab-pane" id="Calificaciones"><%-- tercer panel --%>
                <br>
                <%
                    boolean hay_cal = false;
                    HashMap Pedidos = CU.getPedidosRestaurante(nick);
                    it = Pedidos.entrySet().iterator();
                    while (it.hasNext()) {
                        Map.Entry entry = (Map.Entry) it.next();
                        DataPedido DP = (DataPedido) entry.getValue();
                        if (DP.getCalificacion().getPuntaje() > 0) {
                            hay_cal = true;
                            DataCliente DC = CU.buscarCliente(DP.getCliente());
                            out.print(" <div class=\"row lineaCalificacionRestaurante\">");
                            out.print("<div class=\"col-sm-4\">" + new Fecha(DP.getFecha()).toString() + "</div>");
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
        $('[data-toggle="popover"]').popover();
    });
</script>
<script type="text/javascript">
    jQuery(document).ready(function ($) {
        $('#tabs').tab();
    });
</script> 
<script type="text/javascript">
    verPromo = function (x) {
        $('#ModalPromocion').removeData('bs.modal');
        $('#ModalPromocion').modal({remote: 'modalCarga.html'});
        $('#ModalPromocion').modal('show');
        $('#ModalPromocion').removeData('bs.modal');
        $('#ModalPromocion').modal({remote: 'verPromo.jsp?x=' + x});
    };</script> 
<script type="text/javascript">
    $(".agregarProducto").each(function () {
        var producto = $(this).attr("href");
        if (producto !== "#") {
            $(this).removeAttr("href");
            $(this).click(function () {
                var cantidad = document.getElementById("Cantidad_" + producto).value;
                var parametros = {
                    P: producto,
                    C: cantidad
                };
                /* Este metodo tambien sirve lo dejo por si se necesita despues
                 *  $.ajax({
                 type: "POST",
                 url: "agregarACarrito",
                 data: parametros,
                 dataType: "html",
                 error: function (data) {
                 mostrarRespuesta(data, false);
                 },
                 success: function (data) {
                 mostrarRespuesta(data, true);
                 }
                 });*/
                $.post("agregarACarrito", parametros, function (result) {
                    mostrarRespuesta(result, true);
                });
            });
        }
    });
</script>        
<script type="text/javascript">
    $(".verPedidosProducto").each(function () {
        var producto = $(this).attr("href");
        var datos = producto.split("_");
        $(this).click(function () {
            $(this).removeAttr("href");
            var parametros = {
                r: datos[0],
                p: datos[1]
            };
            $.ajax({
                type: "POST",
                url: "verPedidosProducto.jsp",
                data: parametros,
                beforeSend: function () {
                    $('#ModalProductosPedidos').removeData('bs.modal');
                    $('#ModalProductosPedidos').modal({remote: 'modalCarga.html'});
                    $('#ModalProductosPedidos').modal('show');
                },
                success: function (data) {
                    $('#ModalProductosPedidos').removeData('bs.modal');
                    $('#ModalProductosPedidos').find('h3').html(datos[1].toString());
                    $('#ModalProductosPedidos').find('.modal-body').html(data);
                }
            });
        });
    });
</script>   
