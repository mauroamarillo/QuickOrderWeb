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
    .LineaProducto{
        padding: 10px;
        
    }
    .Producto{
        height: 100px;
        font-family: serif;
        background: white;
    }
    .Producto .contenedor{
        height: 100%;
    }
    .Producto .contenido{
        height: 100%;
        background: white;
        border: 2px solid white;
        overflow:hidden;
        border-bottom-left-radius: 5px;
        border-top-left-radius: 5px;
    }
    .Producto .contenido img{
        z-index:0; 
        position:absolute;
        top:50%;
        left:50%;
        opacity: 0.2;
        transform: translate(-50%, -50%);
        -webkit-transform: translate(-50%, -50%);
        max-width:100%;
        min-height: 100%;
        min-width: 100%;
    } 
    .Producto .contenido .nombre{
        margin: 0;
        position: relative;
        z-index:1;
        opacity: 1;
        color: white;
        text-shadow: 0 0 1px black,
            0 0 2px black,
            0 0 2px black,
            0 0 2px black,
            0 0 2px black,
            0 0 2px black,
            0 0 2px black,
            0 0 2px black!important;
    }
    .Producto .contenido .precio{
        margin: 0;
        position: relative;
        z-index:1;
        opacity: 1;
        color: black;
    }
    .Producto .contenido .descripcion{
        padding: 5px;
        font-style: oblique;
        margin: 0;
        position: relative;
        z-index:1;
        opacity: 1;
        color: gray;
    }
    .Producto:hover .contenido img{
        opacity: 0.6;
    }
    .Producto:hover .contenido .nombre, .Producto:hover .contenido .precio{
        color: black;
        text-shadow: 0 0 5px white,
            0 0 2px  white,
            0 0 2px white,
            0 0 2px white,
            0 0 2px white,
            0 0 2px white,
            0 0 2px white,
            0 0 2px white!important;
    }
    .Producto:hover .contenido .descripcion{
        color: black;
        text-shadow: 0 0 5px white,
            0 0 2px  white,
            0 0 2px white,
            0 0 2px white,
            0 0 2px white,
            0 0 2px white,
            0 0 2px white,
            0 0 2px white!important;
    }
    .Producto .controles{
        height: 100%;
        padding: 1px;
        background: white;
        border: 1px solid white;
        overflow:hidden;
        border-bottom-right-radius:  5px;
        border-top-right-radius: 5px;
    }
    .Producto .controles .btn{
        width: 100%;
        border: solid 1px black;
    }
    .Producto .controles .number{
        text-align: center;
        border: solid 1px black;
        border-radius: 2px;
        width: 100%;
        margin: 1px;
        color: black;
    }

</style>
<%--
 DataIndividual Prueba = CU.getCP().buscarDataIndividual("Empanada Americana", "bocatti");
--%>
<div class="row LineaProducto">
    <div class="col-lg-6 Producto">
        <div class="row contenedor">
            <div class="col-lg-10 contenido">
                <img src="img/car1.jpg<%--=Prueba.getImagen().replace("127.0.0.1", request.getLocalAddr()--%>" alt="Hola<%--=Prueba.getNombre()--%>" /> 

                <h3 class="nombre">Nombre Producto</h3>
                <h5 class="precio">Precio $120</h5>
                <h5 class="descripcion">descripcion del producto donde se ve la descripcion </h5>
            </div>
            <div class=" col-lg-2 controles">
                <a href="#" class="btn verPedidosProducto" role="button" title="Ver Pedidos"> <span class="glyphicon glyphicon-open-file" aria-hidden="true"></span></a>
                <input id="Cantidad" class="number" type="number" min="1" max="100" step="1" value="1" />
                <a href="#" class="btn agregarProducto" role="button" title="Agregar Al Carrito" > <span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span></a>

            </div>
        </div>
    </div>
    <div class="col-lg-6 Producto">
        <div class="row contenedor">
            <div class="col-lg-10 contenido">
                <img src="img/car1.jpg<%--=Prueba.getImagen().replace("127.0.0.1", request.getLocalAddr()--%>" alt="Hola<%--=Prueba.getNombre()--%>" /> 

                <h3 class="nombre">Nombre Producto</h3>
                <h5 class="precio">Precio $120</h5>
                <h5 class="descripcion">descripcion del producto donde se ve la descripcion </h5>
            </div>
            <div class=" col-lg-2 controles">
                <a href="#" class="btn verPedidosProducto" role="button" title="Ver Pedidos"> <span class="glyphicon glyphicon-open-file" aria-hidden="true"></span></a>
                <input id="Cantidad" class="number" type="number" min="1" max="100" step="1" value="1" />
                <a href="#" class="btn agregarProducto" role="button" title="Agregar Al Carrito" > <span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span></a>

            </div>
        </div>
    </div>
    <div class="col-lg-6 Producto">
        <div class="row contenedor">
            <div class="col-lg-10 contenido">
                <img src="img/car1.jpg<%--=Prueba.getImagen().replace("127.0.0.1", request.getLocalAddr()--%>" alt="Hola<%--=Prueba.getNombre()--%>" /> 

                <h3 class="nombre">Nombre Producto</h3>
                <h5 class="precio">Precio $120</h5>
                <h5 class="descripcion">descripcion del producto donde se ve la descripcion </h5>
            </div>
            <div class=" col-lg-2 controles">
                <a href="#" class="btn verPedidosProducto" role="button" title="Ver Pedidos"> <span class="glyphicon glyphicon-open-file" aria-hidden="true"></span></a>
                <input id="Cantidad" class="number" type="number" min="1" max="100" step="1" value="1" />
                <a href="#" class="btn agregarProducto" role="button" title="Agregar Al Carrito" > <span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span></a>

            </div>
        </div>
    </div>
    <div class="col-lg-6 Producto">
        <div class="row contenedor">
            <div class="col-lg-10 contenido">
                <img src="img/car1.jpg<%--=Prueba.getImagen().replace("127.0.0.1", request.getLocalAddr()--%>" alt="Hola<%--=Prueba.getNombre()--%>" /> 

                <h3 class="nombre">Nombre Producto</h3>
                <h5 class="precio">Precio $120</h5>
                <h5 class="descripcion">descripcion del producto donde se ve la descripcion </h5>
            </div>
            <div class=" col-lg-2 controles">
                <a href="#" class="btn verPedidosProducto" role="button" title="Ver Pedidos"> <span class="glyphicon glyphicon-open-file" aria-hidden="true"></span></a>
                <input id="Cantidad" class="number" type="number" min="1" max="100" step="1" value="1" />
                <a href="#" class="btn agregarProducto" role="button" title="Agregar Al Carrito" > <span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span></a>

            </div>
        </div>
    </div>
</div>
<br/>
<div class="row">
    <%
        Iterator it = ListaProductos.entrySet().iterator();
        int contador = 0;
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            if (((DataProducto) entry.getValue()).getNombre().toLowerCase().contains(filtro.toLowerCase())) {
                DataRestaurante DR = CU.buscarRestaurante(((DataProducto) entry.getValue()).getRestaurante());
                if (entry.getValue() instanceof DataPromocion) {
                    DataPromocion DP = (DataPromocion) entry.getValue();
                    String urlImg = DP.getImagen().replace("127.0.0.1", request.getLocalAddr());
                    if (urlImg.equals("sin_imagen")) {
                        urlImg = "img/sin_img.jpg";
                    }
                    out.print("<div class=\"col-md-4 producto\">");
                    out.print("     <div class=\"thumbnail\">");
                    out.print("<img src=\"" + urlImg + "\" style=\"width: 100%; height: 150px;\"alt=\"" + DP.getNombre() + "\">");
                    out.print("         <div class=\"caption\">");
                    out.print("             <h3>" + DP.getNombre() + "</h3>");
                    out.print("                 <p>" + DR.getNombre() + "</p>");
                    out.print("                 <p>" + DP.getDescripcion() + "</p>");
                    out.print("                 <p>Precio: $" + DP.getPrecio() + "</p>");
                    out.print("                 <p>Descuento: " + DP.getDescuento() + "%</p>");
                    if (DP.isActivo()) {
                        out.print("                 <p><b>Promocion Activa</b>");
                    } else {
                        out.print("                 <p><b>Promocion Inactiva</b>");
                    }
                    out.print(" <input type=\"button\" onclick=\"verPromo('" + DP.getRestaurante() + "_" + DP.getNombre() + "');\" hidden=\"true\" id= \"Prod_" + DP.getNombre() + "\"/> <label class=\"botonListaDetallePromo\"  for=\"Prod_" + DP.getNombre() + "\"> <span class=\"glyphicon glyphicon-list-alt\" aria-hidden=\"true\"></span></label>");
                    out.print("                     <a href=\"" + DP.getRestaurante() + "_" + DP.getNombre() + "\" class=\"btn btn-primary verPedidosProducto\" role=\"button\" style=\"width: 100%;\">Pedidos Relacionados</a>");
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
                                + "<div class=\"row lineaProducto\">");
                    }

                } else {
                    DataIndividual DI = (DataIndividual) entry.getValue();
                    String urlImg = DI.getImagen().replace("127.0.0.1", request.getLocalAddr());
                    if (urlImg.equals("sin_imagen")) {
                        urlImg = "img/sin_img.jpg";
                    }
                    out.print("<div class=\" col-md-4 producto\">");
                    out.print("     <div class=\"thumbnail\">");
                    out.print("<img src=\"" + urlImg + "\" style=\"width: 100%; height: 150px;\"alt=\"" + DI.getNombre() + "\">");
                    out.print("         <div class=\"caption\">");
                    out.print("             <h3>" + DI.getNombre() + "</h3>");
                    out.print("                 <p>" + DR.getNombre() + "</p>");
                    out.print("                 <p>" + DI.getDescripcion() + "</p>");
                    out.print("                 <p>Precio: $" + DI.getPrecio() + "</p>");
                    out.print("                     <a href=\"" + DI.getRestaurante() + "_" + DI.getNombre() + "\" class=\"btn btn-primary verPedidosProducto\" role=\"button\" style=\"width: 100%;\">Pedidos Relacionados      </a>");
                    if (session.getAttribute("nick") != null) {
                        out.print("                     <input id=\"Cantidad_" + DI.getRestaurante() + "_" + DI.getNombre() + "\" class=\"number\" type=\"number\" min=\"1\" max=\"1000\" step=\"1\" value=\"1\">");
                        out.print("                     <a href=\"" + DI.getRestaurante() + "_" + DI.getNombre() + "\" class=\"btn btn-primary agregarProducto\" role=\"button\" >Agregar Al Carrito</a>");
                    }
                    out.print("         </div>");
                    out.print("     </div>");
                    out.print("</div>");
                    contador++;
                    if (contador == 3) {
                        contador = 0;
                        out.print("</div>"
                                + "<div class=\"row lineaProducto\">");
                    }
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
<script type="text/javascript">
    var Height = 0;
    $('div.lineaProducto').children('div.producto').each(function () {
        if (Height < $(this).outerHeight(true))
            Height = $(this).outerHeight(true);
    }), $('div.lineaProducto').children('div.producto').each(function () {
        $(this).children('.thumbnail').height(Height);
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