<%-- 
    Document   : verPedido
    Created on : 28/08/2015, 08:28:41 PM
    Author     : Jean
--%>

<%@page import="ClienteWS.DataProdPedido"%>
<%@page import="ClienteWS.DataProdPedido"%>
<%@page import="ClienteWS.DataPedido"%>
<%@page import= "java.util.Map"%>
<%@page import= "java.util.Iterator"%>
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
    DataPedido DP = null;
    if (request.getParameter("x") == null) {
        out.print("ERROR AL CARGAR DETALLE DEL PEDIDO");
        return;
    } else {
        DP = port.getDataPedido(Integer.valueOf(request.getParameter("x")));
        if (DP == null) {
            out.print("ERROR AL CARGAR DETALLE DEL PEDIDO");
            return;
        }
    }

%>
<!DOCTYPE html>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
    <h3 class="form-signin-heading text-muted" style="color:white;">Pedido N° <%=DP.getNumero()%> (<%=DP.getCliente()%>) </h3>
</div>
<div class="modal-body"  style="color:black;">
    <p> 
        <b>Restaurante:</b> <%=DP.getRestaurante()%></br> 
        <b>Fecha:</b> <%=DP.getFecha()%></br>
        <b>Precio Total: </b> $<%=DP.getPrecio()%></br>
        <b>Estado:</b> <%=DP.getEstado()%></br>
    </p>

</div>
<div class="modal-footer">
    <div class="col-xs-12">
        <div class="tituloLista row "> 
            <label class="col-xs-6 lista-comun" > Producto </label>
            <label class="col-xs-2 lista-num" > Precio </label>
            <label class="col-xs-2 lista-num" > Cantidad </label>
            <label class="col-xs-2 lista-num" > SubTotal </label>
        </div>
        <%
            Iterator it = DP.getProdPedidos().entrySet().iterator();
            int x = 1;
            String ultimo = "";
            while (it.hasNext()) {
                Map.Entry entry = (Map.Entry) it.next();
                DataProdPedido DPP = (DataProdPedido) entry.getValue();
                if (!it.hasNext()) {
                    ultimo = "lista-ultimo";
                }
                out.print(" <div class=\"row lista" + x + " " + ultimo + "\"> <input type=\"button\" \" hidden=\"true\" class=\"col-xs-1 btn-xs \" id= \"checkProd" + DPP.getProducto().getNombre() + "\"/>");
                out.print(" <label class=\"col-xs-6 lista-comun\" for=\"checkProd" + DPP.getProducto().getNombre() + "\">" + DPP.getProducto().getNombre() + " </label>");
                out.print(" <label class=\"col-xs-2 lista-num\" for=\"checkProd" + DPP.getProducto().getNombre() + "\">$" + DPP.getProducto().getPrecio() + " </label>");
                out.print(" <label class=\"col-xs-2 lista-num\" for=\"checkProd" + DPP.getProducto().getNombre() + "\">" + DPP.getCantidad() + " </label> ");
                out.print(" <label class=\"col-xs-2 lista-num\" for=\"checkProd" + DPP.getProducto().getNombre() + "\">$" + DPP.getProducto().getPrecio() * DPP.getCantidad() + " </label> ");
                out.print(" </div> ");
                if (x == 1) {
                    x = 2;
                } else {
                    x = 1;
                }
            }
        %>
    </div>
</div>
