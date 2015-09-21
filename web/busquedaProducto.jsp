<%--
    Document   : verProductos
    Created on : 10/09/2015, 01:19:35 PM
    Author     : Jean
--%>

<%@page import="Logica.DataTypes.DataRestaurante"%>
<%@page import="Logica.DataTypes.DataProducto"%>
<%@page import="Logica.DataTypes.DataIndividual"%>
<%@page import="Logica.DataTypes.DataPromocion"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="Logica.ControladorUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ControladorUsuario CU = null;
    if (session.getAttribute("CU") == null) {
        CU = new ControladorUsuario();
    } else {
        CU = (ControladorUsuario) session.getAttribute("CU");
    }

    String filtro = "";
    if (request.getParameter("filtro") != null) {
        filtro = request.getParameter("filtro");
    }
    HashMap ListaProductos = new HashMap();
    ListaProductos.putAll(CU.getCP().getDataIndividuales());
    ListaProductos.putAll(CU.getCP().getDataPromociones());
%>
<!DOCTYPE html>
<style>


</style>
<div class="row">
    <%
        Iterator it = ListaProductos.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            if (((DataProducto) entry.getValue()).getNombre().toLowerCase().contains(filtro.toLowerCase())) {
                DataRestaurante DR = CU.buscarRestaurante(((DataProducto) entry.getValue()).getRestaurante());
                if (entry.getValue() instanceof DataPromocion) {
                    DataPromocion DP = (DataPromocion) entry.getValue();
                    String urlImg = DP.getImagen().replace("127.0.0.1", request.getLocalAddr());
                    if (urlImg.equals("sin_imagen")) {
                        urlImg = "img/imagenrestaurante.jpg";
                    }
    %>
    <div class="col-lg-6 col-sm-12 Producto">
        <div class="row contenedor">
            <div class="col-sm-10 contenido">
                <img src="<%=urlImg%>" alt="<%=DP.getNombre()%>" /> 
                <p class="precio">Precio $<%=DP.getPrecio()%></p>
                <h3 class="nombre"><%=DP.getNombre()%></h3>
                <p class="restaurante"><b><%=CU.buscarRestaurante(DP.getRestaurante()).getNombre()%></b></p>
                <p class="descripcion"><%=DP.getDescripcion()%></p>
                <p class="activa">
                    <%
                        if (DP.isActivo()) {
                            out.print("                 <a onclick=\"verPromo('" + DP.getRestaurante() + "_" + DP.getNombre() + "');\"><b>Promocion Activa</a>");
                        } else {
                            out.print("                 <b>Promocion Inactiva");
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
    <%                } else {
        DataIndividual DI = (DataIndividual) entry.getValue();
        String urlImg = DI.getImagen().replace("127.0.0.1", request.getLocalAddr());
        if (urlImg.equals("sin_imagen")) {
            urlImg = "img/imagenrestaurante.jpg";
        }
    %>
    <div class="col-lg-6  col-sm-12 Producto">
        <div class="row contenedor">
            <div class="col-sm-10 contenido">
                <img src="<%=urlImg%>" alt="<%=DI.getNombre()%>" /> 
                <p class="precio">Precio $<%=DI.getPrecio()%></p>
                <h3 class="nombre"><%=DI.getNombre()%></h3>
                <p class="restaurante"><b><%=CU.buscarRestaurante(DI.getRestaurante()).getNombre()%></b></p>
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
            }
        }
    %>
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
        cambiarTitulo('Productos');
    });
</script>
<script type="text/javascript">
    verPromo = function (x) {
        $('#ModalPromocion').removeData('bs.modal');
        $('#ModalPromocion').modal({remote: 'modalCarga.html'});
        $('#ModalPromocion').modal('show');
        $('#ModalPromocion').removeData('bs.modal');
        $('#ModalPromocion').modal({remote: 'verPromo.jsp?x=' + x});

    };
</script>
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
                $.post("agregarACarrito", parametros, function (result) {
                    mostrarRespuesta(result, true);
                });
            });
        }
    });
</script> 
<script type="text/javascript">
    $(".verPedidosProducto").each(function () {
        var producto = $(this).attr("href");    // esto tiene el kay de producto con este formato: nombreRestaurante_nombreProducto
        var datos = producto.split("_");        // lo separo en  para guardarlos en variables diferentes
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