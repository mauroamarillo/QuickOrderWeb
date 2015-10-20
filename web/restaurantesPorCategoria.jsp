<%-- 
    Document   : restaurantesPorCategoria
    Created on : 29/08/2015, 12:56:39 AM
    Author     : Jean
--%>

<%@page import="ClienteWS.DataRestaurante"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
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
        Iterator it = port.consultarCategorias().iterator();
        while (it.hasNext()) {
            Object entry = (Object) it.next();
            //Set<Entry> entries = categorias.entrySet();
            // for (Entry entry : entries) {
            String cate = (String) entry;
            String cat = cate.replace(' ', '_'); //si tiene espacios se me meya todo, por eso los saco F
            int cantidad = port.cantidadPorCategoria(cate);
            if (cantidad > 0) {
    %>
    <div class="panel panel-transparent  panel-default">
        <div class="panel-heading" role="tab" id="<%=cat%>">
            <h5 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse<%=cat%>" aria-expanded="true" aria-controls="collapseOne">
                    <span class="badge"><%=cantidad%></span> <%=cate%>
                </a>
            </h5>
        </div>
        <div id="collapse<%=cat%>" class="panel-collapse collapse " role="tabpanel" aria-labelledby="<%=cat%>" style=" margin-top: 5px; padding-right: 5px; padding-left: 5px;">
            <%
                Iterator it2 = port.consultarRestaurantesPorCategoria(cate).iterator();
                while (it2.hasNext()) {
                    Object entry2 = it2.next();
                    DataRestaurante DR = (DataRestaurante) entry2;
                    /*agregado*/
                    String img = "img/imagenrestaurante.jpg";
                    float promedio = port.getPromedioCalificaciones(DR.getNickname());
                    int cantFotos = port.restauranteGetImagenes(DR.getNickname()).size();
                    int seleccionada = 0;
                    if (cantFotos > 0) {
                        Random r = new Random();
                        seleccionada = r.nextInt(cantFotos);
                        img = (String) port.restauranteGetImagenes(DR.getNickname()).get(seleccionada);
                        img = img;
                    }
                    /*---*/
            %>
            <div class="row">                
                <div class="Busqueda col-xs-12">
                    <div class="restaurante" onclick="cargarResaurante('<%=DR.getNickname()%>')">
                        <img alt="<%=DR.getNombre()%>" src="<%=img%>" />
                        <div class="info">
                            <h1><%=DR.getNombre()%></h1>
                            <p class="Estrellas" >
                                <span class="badge alert-warning"><%=promedio%></span>
                                <%
                                    int parteEntera = (int) promedio;
                                    for (int i = 0; i < 5; i++) {
                                        if (i < parteEntera) {
                                            out.print("<span class=\"glyphicon glyphicon-star activa\"></span>\n");
                                        } else {
                                            out.print("<span class=\"glyphicon glyphicon-star inactiva\"></span>\n");
                                        }
                                    }
                                %>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <%}%><%-- Esta llave cierra  el segundo while--%>
        </div>
    </div>
    <%}%><%-- Esta llave cierra  el if--%>
    <%}%><%-- Esta llave cierra  el primer while--%>
</div>