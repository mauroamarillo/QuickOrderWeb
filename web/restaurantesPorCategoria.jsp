<%-- 
    Document   : restaurantesPorCategoria
    Created on : 29/08/2015, 12:56:39 AM
    Author     : Jean
--%>

<%@page import="java.util.Random"%>
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
        <div id="collapse<%=cat%>" class="panel-collapse collapse " role="tabpanel" aria-labelledby="<%=cat%>" style=" margin-top: 5px; padding-right: 5px; padding-left: 5px;">
            <%
                HashMap restaurantes = CU.consultarRestaurantesPorCategoria(cate);
                Iterator it2 = restaurantes.entrySet().iterator();
                while (it2.hasNext()) {
                    Map.Entry entry2 = (Map.Entry) it2.next();
                    DataRestaurante DR = (DataRestaurante) entry2.getValue();
                    /*agregado*/
                    String img = "img/imagenrestaurante.jpg";
                    float promedio = CU.getPromedioCalificaciones(DR.getNickname());
                    int cantFotos = DR.getImagenes().size();
                    int seleccionada = 0;
                    if (cantFotos > 0) {
                        Random r = new Random();
                        seleccionada = r.nextInt(cantFotos);
                        img = (String) DR.getImagenes().get(seleccionada + 1);
                        img = img.replace("127.0.0.1", request.getLocalAddr());
                    }
                    /*---*/
            %>
            <div class="row">
                <!-- ** Esto era lo que tenia antes **
                <input type="button" onclick="cargarResaurante('<%=DR.getNickname()%>')" hidden="true" class="col-xs-1 btn-xs " id="<%=DR.getNickname()%>"/>
                <label class="col-xs-12 listaRestaurante" for="<%=DR.getNickname()%>" > <%=DR.getNombre()%> </label> 
                -->
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