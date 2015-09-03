<%-- 
    Document   : carrito
    Created on : 02/09/2015, 08:16:15 PM
    Author     : Jean
--%>

<%@page import="Logica.DataTypes.DataProdPedido"%>
<%@page import="Logica.Estado"%>
<%@page import="Logica.DataTypes.DataPedido"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="Logica.ControladorUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("nick") == null) {
        out.print("<h1>chupala<h1>");
        return;
    }
    String nick = (String) session.getAttribute("nick");
    ControladorUsuario CU = new ControladorUsuario();
    HashMap pedidos = CU.getDataPedidos(nick);
%>
<!DOCTYPE html>
<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
    <%
        Iterator it = pedidos.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            DataPedido DP = (DataPedido) entry.getValue();
            if (DP.getEstado().equals(Estado.aconfirmar)) {
    %>
    <div class="panel panel-transparent  panel-default">
        <div class="panel-heading" role="tab" id="<%=DP.getNumero()%>">
            <h5 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse<%=DP.getNumero()%>" aria-expanded="true" aria-controls="collapseOne">
                    Fecha: <%=DP.getFecha()%> - Restaurante: <%=DP.getRestaurante()%> - Total: $<%=DP.getPrecio()%>
                </a>
            </h5>
        </div>
        <div id="collapse<%=DP.getNumero()%>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="<%=DP.getNumero()%>">
            <div style="padding: 10px; " >
                <div class="row">
                    <%
                        HashMap DataProdPedido = DP.getProdPedidos();
                        Iterator it2 = DataProdPedido.entrySet().iterator();
                        while (it2.hasNext()) {
                            Map.Entry entry2 = (Map.Entry) it2.next();
                            DataProdPedido DPP = (DataProdPedido) entry2.getValue();
                    %>
                    <div class="col-md-4">
                        <div class="panel panel-default ">
                            <div class="panel-heading">
                                <span><%=DPP.getProducto().getNombre()%></span>
                            </div>
                            <div class="panel-body" >
                                <div class="col-md-4">
                                    <img src="<%=DPP.getProducto().getImagen()%>" height="100%" width="100%">
                                </div>
                                <div class="col-md-8">
                                    Precio unitario: $<%=DPP.getProducto().getPrecio()%> <br/>
                                    cantidad:<%=DPP.getCantidad()%> <br/>
                                    Subtotal: $<%=(DPP.getProducto().getPrecio() * DPP.getCantidad())%> <br/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%}%><%-- Esta llave cierra  el segundo while--%>

                </div>
            </div> 
        </div>
    </div>
    <%        }
        }
    %>
</div>