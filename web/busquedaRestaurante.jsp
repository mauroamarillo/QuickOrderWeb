<%-- 
    Document   : busquedaRestaurante
    Created on : 25/09/2015, 01:00:52 PM
    Author     : Jean
--%>
<%@page import="java.util.List"%>
<%@page import="ClienteWS.DataRestaurante"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
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
    String filtro = "";
    boolean hayResultado = false;
    if (request.getParameter("filtro") != null) {
        filtro = request.getParameter("filtro");
    }
%>

<div class="Busqueda">
    <%
        Iterator it = port.getDataRestaurantes().iterator();
        while (it.hasNext()) {
            Object entry = it.next();
            DataRestaurante DR = (DataRestaurante) entry;
            if (DR.getNombre().toLowerCase().contains(filtro.toLowerCase())) {
                hayResultado = true;
                String img = "img/imagenrestaurante.jpg";
                float promedio = port.getPromedioCalificaciones(DR.getNickname());
                int cantFotos = port.restauranteGetImagenes(DR.getNickname()).size();//DR.getImagenes().size();
                int seleccionada = 0;
                if (cantFotos > 0) {
                    Random r = new Random();
                    seleccionada = r.nextInt(cantFotos);
                    img = (String) port.restauranteGetImagenes(DR.getNickname()).get(seleccionada);
                }
    %>
    <div class="restaurante" onclick="cargarResaurante('<%=DR.getNickname()%>')" title="Visitar <%=DR.getNombre()%>" >
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
    <%
            }
        }
        if (!hayResultado) {
            out.print("<div style=\"color: red;\"><b><span class=\"glyphicon glyphicon-warning-sign \"></span> No hay resultados</b></div>");
        }
    %>
</div>
