<%-- 
    Document   : verPedidosProducto
    Created on : 07/09/2015, 11:56:23 PM
    Author     : Jean
--%>

<%@page import="Logica.DataTypes.DataCliente"%>
<%@page import="Logica.Fecha"%>
<%@page import="Logica.DataTypes.DataCalificacion"%>
<%@page import="Logica.DataTypes.DataPedido"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="Logica.ControladorUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String r = request.getParameter("r");
    String p = request.getParameter("p");
    ControladorUsuario CU = null;
    if (session.getAttribute("CU") == null) {
        CU = new ControladorUsuario();
        session.setAttribute("CU", CU);
    } else {
        CU = (ControladorUsuario) session.getAttribute("CU");
    }
    HashMap pedidos = CU.getDataPedidosProducto(r, p);

    if (pedidos.size() < 1) {
        out.print("<p style=\"text-align: center;\">No hay pedidos para este producto</p>");
        return;
    }
    Iterator it = pedidos.entrySet().iterator();
    while (it.hasNext()) {
        Map.Entry entry = (Map.Entry) it.next();
        DataPedido DP = (DataPedido) entry.getValue();
        DataCliente DC = CU.buscarCliente(DP.getCliente());
%>
<!DOCTYPE html >
<div class="row">
    <label class="col-lg-5"><%=new Fecha(DP.getFecha()).toString()%></label>
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
