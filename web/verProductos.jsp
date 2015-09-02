<%-- 
    Document   : verProductos
    Created on : 02/09/2015, 06:19:35 PM
    Author     : Jean
--%>

<%@page import="Logica.DataTypes.DataIndividual"%>
<%@page import="Logica.DataTypes.DataPromocion"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="Logica.ControladorUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ControladorUsuario CU = new ControladorUsuario();
    HashMap ListaProductos = new HashMap();
    ListaProductos.putAll(CU.getCP().getDataIndividuales());
    ListaProductos.putAll(CU.getCP().getDataPromociones());

%>
<!DOCTYPE html>
</br>
<div class="row">
    <%        Iterator it = ListaProductos.entrySet().iterator();
        int contador = 0;
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();

            if (entry.getValue() instanceof DataPromocion) {
                DataPromocion DP = (DataPromocion) entry.getValue();
                String urlImg = DP.getImagen();
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

            } else {
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
        }
    %>
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
        $('#ModalPromocion').modal('show');
        $('#ModalPromocion').removeData('bs.modal');
        $('#ModalPromocion').modal({remote: 'verPromo.jsp?x=' + x});

    };
</script>