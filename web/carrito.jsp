<%-- 
    Document   : carrito
    Created on : 02/09/2015, 08:16:15 PM
    Author     : Jean
--%>

<%@page import="Logica.Fecha"%>
<%@page import="Logica.DataTypes.DataIndividual"%>
<%@page import="Logica.DataTypes.DataPromocion"%>
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
        out.print("<h>Error: sesion caducada<h1>");
        return;
    }
    String nick = (String) session.getAttribute("nick");
    ControladorUsuario CU = null;
    if (session.getAttribute("CU") == null) {
        CU = new ControladorUsuario();
        session.setAttribute("CU", CU);
    } else {
        CU = (ControladorUsuario) session.getAttribute("CU");
    }
    HashMap pedidos = CU.getPedidosCarrito(nick);

    if (pedidos.size() < 1) {
        out.print("<p>No hay pedidos a confirmar</p>");
        return;
    }
%>
<!DOCTYPE html>
<div style="height: 40px;">
    <a style="float: right;" class="confirmarTodo btn btn-primary">Confirmar todos</a> 
</div>
<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
    <%
        Iterator it = pedidos.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            DataPedido DP = (DataPedido) entry.getValue();
            if (DP.getEstado().equals(Estado.aconfirmar)) {
    %>
    <div class="panel panel-pedido panel-default" id="Pedido<%=DP.getNumero()%>">
        <div class="panel-heading" role="tab" id="<%=DP.getNumero()%>">
            <div class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse<%=DP.getNumero()%>" aria-expanded="true" aria-controls="collapseOne">
                    <b>Fecha:</b> <%=new Fecha(DP.getFecha()).toString()%>  |  <b>Restaurante:</b> <%=CU.buscarRestaurante(DP.getRestaurante()).getNombre()%> | <b>Total:</b> $<%=DP.getPrecio()%>
                </a>

                <a href="<%=DP.getNumero()%>" style="float: right; font-size:20px;" class="confirmarPedido"><span class="glyphicon glyphicon-ok-sign"></span></a>
                <a id="cancelar<%=DP.getNumero()%>" href="<%=DP.getNumero()%>" style="float: right; font-size:20px; padding-right: 20px;" class="cancelarPedido"><span class="glyphicon glyphicon-remove-sign"></span></a>
            </div>
        </div>
        <div id="collapse<%=DP.getNumero()%>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="<%=DP.getNumero()%>">
            <div style="padding: 10px; " >
                <ul class="media-list" id="Lista<%=DP.getNumero()%>">
                    <%
                        HashMap DataProdPedido = DP.getProdPedidos();
                        Iterator it2 = DataProdPedido.entrySet().iterator();
                        while (it2.hasNext()) {
                            Map.Entry entry2 = (Map.Entry) it2.next();
                            DataProdPedido DPP = (DataProdPedido) entry2.getValue();
                    %>
                    <li class="media" id="<%=DP.getNumero()%>_<%=DP.getRestaurante()%>_<%=DPP.getProducto().getNombre()%>">
                        <a href="<%=DP.getNumero()%>_<%=DP.getRestaurante()%>_<%=DPP.getProducto().getNombre()%>" style="float: right;" class="elimimarLineaPedido"><span class="glyphicon glyphicon-remove"></span></a>
                        <div class="media-left">
                            <img class="media-object img-thumbnail" src="<%=DPP.getProducto().getImagen().replace("127.0.0.1", request.getLocalAddr())%>" alt="<%=DPP.getProducto().getNombre()%>"  class="img img-thumbnail" style=" width:105px; height:105px;">
                        </div>
                        <div class="media-body">
                            <h4 class="media-heading" ><%=DPP.getProducto().getNombre()%></h4>
                            Precio unitario: $<%=DPP.getProducto().getPrecio()%> <br/>
                            cantidad:<%=DPP.getCantidad()%> <br/>
                            Subtotal: $<%=(DPP.getProducto().getPrecio() * DPP.getCantidad())%> <br/>
                            <%
                                if (DPP.getProducto() instanceof DataPromocion) {
                            %>
                            Tipo: Promocional (<%=((DataPromocion) DPP.getProducto()).getDescuento()%>% Descuento)<br/> 
                            <%
                                }
                                if (DPP.getProducto() instanceof DataIndividual) {
                            %>
                            Tipo: Individual <br/> 
                            <%
                                }

                            %>
                        </div>
                    </li>
                    <%}%><%-- Esta llave cierra  el segundo while--%>

                </ul>
            </div> 
        </div>
    </div>
    <%        }
        }
    %>
</div>
<script>
    $(document).ready(function () {
        cambiarTitulo('<%=" Carrito " + session.getAttribute("nombre")%>');
        $('[data-toggle="popover"]').popover();
        $('[data-toggle="popover"').click(function () {
            return false;
        });
        linksConfirmarPedido();
        linksCancelarPedido();
        linksConfirmarTodo();
        linksEliminarLineaPedido();
    });
</script>