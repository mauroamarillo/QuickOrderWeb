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
        out.print("<h>Error: <h1>");
        return;
    }
    String nick = (String) session.getAttribute("nick");
    ControladorUsuario CU = new ControladorUsuario();
    HashMap pedidos = CU.getDataPedidos(nick);
    boolean aconfirmar = false; // en un futuro vamoa a usar una funcion que devuelva solo los pedidos a confirmar, pero por ahora lo dejamos asi
    for (Object value : pedidos.values()) {
        if (((DataPedido) value).getEstado().equals(Estado.aconfirmar)) {
            aconfirmar = true;
            break;
        }
    }
    if(!aconfirmar)
        out.print("<p>No hay pedidos a confirmar</p>");
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
    <div class="panel panel-pedido  panel-default">
        <div class="panel-heading" role="tab" id="<%=DP.getNumero()%>">
            <div class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse<%=DP.getNumero()%>" aria-expanded="true" aria-controls="collapseOne">
                    Fecha: <%=DP.getFecha()%> - Restaurante: <%=DP.getRestaurante()%> - Total: $<%=DP.getPrecio()%>
                </a>
                <a href="<%=DP.getNumero()%>" style="float: right;" class="confirmarPedido"><span class="glyphicon glyphicon-ok"></span></a>
            </div>
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
<script type="text/javascript">
    $(".confirmarPedido").each(function () {
        var pedido = $(this).attr("href");
        if (pedido !== "#") {
            $(this).removeAttr("href");
            $(this).click(function () {
                $(this).removeClass("confirmarPedido");
                $(this).html("OK");
                $.post("confirmarPedido",
                        {p: pedido},
                function (result) {
                    $("#frameContainer").load("carrito.jsp");
                    mostrarRespuesta(result, true);
                }
                );
            });
        }
    });
</script>    