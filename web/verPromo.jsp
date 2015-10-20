<%-- 
    Document   : verPromo
    Created on : 31/08/2015, 04:08:52 PM
    Author     : Jean
--%>

<%@page import="ClienteWS.DataProdPromo"%>
<%@page import="ClienteWS.DataPromocion"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
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
    DataPromocion DP = null;
    if (request.getParameter("x") == null) {
        out.print("ERROR AL CARGAR DETALLE DEL PEDIDO");
        return;
    } else {
        DP = (DataPromocion) port.buscarDataXRestauranteProducto(request.getParameter("x"));
        if (DP == null) {
            out.print("ERROR AL CARGAR DETALLE DEL PEDIDO");
            return;
        }
    }

%>
<!DOCTYPE html>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
    <h3 class="form-signin-heading text-muted"  style="color:white; text-align: center;"><%=DP.getNombre()%></h3>
</div>
<div class="modal-body"  style="color:black;">
    <p>Descuento: <%=DP.getDescuento()%>%</p>
    <div class="tituloLista row "> 
        <label class="col-xs-6 lista-comun" > Producto </label>
        <label class="col-xs-2 lista-num" > Precio </label>
        <label class="col-xs-2 lista-num" > Cantidad </label>
    </div>
    <%
        Iterator it = port.promocionGetProdPromo(DP.getRestaurante() + "_" + DP.getNombre()).iterator();
        int x = 1;
        String ultimo = "";
        while (it.hasNext()) {
            Object entry = it.next();
            DataProdPromo DPP = (DataProdPromo) entry;
            if (!it.hasNext()) {
                ultimo = "lista-ultimo";
            }
            out.print(" <div class=\"row lista" + x + " " + ultimo + "\"> <input type=\"button\" \" hidden=\"true\" class=\"col-xs-1 btn-xs \" id= \"checkProd" + DPP.getIndividual().getNombre() + "\"/>");
            out.print(" <label class=\"col-xs-6 lista-comun\" for=\"checkProd" + DPP.getIndividual().getNombre() + "\">" + DPP.getIndividual().getNombre() + " </label>");
            out.print(" <label class=\"col-xs-2 lista-num\" for=\"checkProd" + DPP.getIndividual().getNombre() + "\">$" + DPP.getIndividual().getPrecio() + " </label>");
            out.print(" <label class=\"col-xs-2 lista-num\" for=\"checkProd" + DPP.getIndividual().getNombre() + "\">" + DPP.getCantidad() + " </label> ");
            out.print(" </div> ");
            if (x == 1) {
                x = 2;
            } else {
                x = 1;
            }
        }
    %>
</div>
<div class="modal-footer">

</div>
