<%-- 
    Document   : verPedidosProducto
    Created on : 07/09/2015, 11:56:23 PM
    Author     : Jean
--%>

<%@page import="ClienteWS.DataCliente"%>
<%@page import="ClienteWS.DataPedido"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String r = request.getParameter("r");
    String p = request.getParameter("p");

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

    if (port.getDataPedidosProducto(r, p).size() < 1) {
        out.print("<p style=\"text-align: center;\">No hay pedidos para este producto</p>");
        return;
    }
    Iterator it = port.getDataPedidosProducto(r, p).iterator();
    while (it.hasNext()) {
        Object entry = it.next();
        DataPedido DP = (DataPedido) entry;
        DataCliente DC = port.buscarCliente(DP.getCliente());
%>
<!DOCTYPE html >
<div class="row">
    <label class="col-lg-5"><%=(new DataTypes.Fecha(DP.getFecha())).toString()%></label>
    <label class="col-lg-3"><%=DC.getNombre()%> <%=DC.getApellido()%></label>
    <label class="col-lg-2" style="text-align: right;">$ <%=DP.getPrecio()%></label>
    <label class="col-lg-2"><%
        if (DP.getCalificacion().getPuntaje() == 0) {
            out.print("S/C");
        } else {
            out.print("<a  href=\"#\" data-toggle=\"popover\" data-trigger=\"focus\" title=\"Comentario\" data-content=\"" + DP.getCalificacion().getComentario() + "\" >");
            for (int i = 0; i < 5; i++) {
                if (i < DP.getCalificacion().getPuntaje()) {
                    out.print("<span class=\"glyphicon glyphicon-star\" style=\"color:orange;\"></span>");
                } else {
                    out.print("<span class=\"glyphicon glyphicon-star\" style=\"color:gray;\"></span>");
                }
            }
            out.print("</a>");
        }
        %></label>
</div>
<%
    }
%>
<script>
    $('[data-toggle="popover"]').popover();
    $('[data-toggle="popover"').click(function () {
        return false;
    });
</script>
