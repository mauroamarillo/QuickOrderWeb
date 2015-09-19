<%-- 
    Document   : restaurantesPorCategoria
    Created on : 29/08/2015, 12:56:39 AM
    Author     : Jean
--%>

<%@page import="java.util.Set"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="Logica.DataTypes.DataRestaurante"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import= "java.util.HashMap"%>
<%@page import="Logica.ControladorUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
    <%
        ControladorUsuario CU = null;
        if (session.getAttribute("CU") == null) {
            CU = new ControladorUsuario();
        } else {
            CU = (ControladorUsuario) session.getAttribute("CU");
        }
        HashMap categorias = CU.getCategorias();
        Iterator it = categorias.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            //Set<Entry> entries = categorias.entrySet();
            // for (Entry entry : entries) {
            String cate = (String) entry.getValue();
            String cat = cate.replace(' ', '_'); //si tiene espacios se me meya todo, por eso los saco F
            int cantidad = CU.cantidadPorCategoria(cate);
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
        <div id="collapse<%=cat%>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="<%=cat%>">
            <%
                HashMap restaurantes = CU.consultarRestaurantesPorCategoria(cate);
                Iterator it2 = restaurantes.entrySet().iterator();
                while (it2.hasNext()) {
                    Map.Entry entry2 = (Map.Entry) it2.next();
                    DataRestaurante DR = (DataRestaurante) entry2.getValue();
            %>
            <div class="row">
                <input type="button" onclick="cargarResaurante('<%=DR.getNickname()%>')" hidden="true" class="col-xs-1 btn-xs " id="<%=DR.getNickname()%>"/>
                <label class="col-xs-12 listaRestaurante" for="<%=DR.getNickname()%>" > <%=DR.getNombre()%> </label>
            </div>
            <%}%><%-- Esta llave cierra  el segundo while--%>
        </div>
    </div>
    <%}%><%-- Esta llave cierra  el if--%>
    <%}%><%-- Esta llave cierra  el primer while--%>
</div>