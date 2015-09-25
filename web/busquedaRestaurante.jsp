<%-- 
    Document   : busquedaRestaurante
    Created on : 25/09/2015, 01:00:52 PM
    Author     : Jean
--%>
<%@page import="java.util.Random"%>
<%@page import="Logica.DataTypes.DataRestaurante"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="Logica.ControladorUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ControladorUsuario CU = null;
    String filtro = "";
    boolean hayResultado = false;
    if (session.getAttribute("CU") == null) {
        CU = new ControladorUsuario();
    } else {
        CU = (ControladorUsuario) session.getAttribute("CU");
    }
    if (request.getParameter("filtro") != null) {
        filtro = request.getParameter("filtro");
    }
%>
<div class="Busqueda">
    <%
        HashMap restaurantes = CU.getDataRestaurantes();
        Iterator it = restaurantes.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            DataRestaurante DR = (DataRestaurante) entry.getValue();
            if (DR.getNombre().toLowerCase().contains(filtro.toLowerCase())) {
                hayResultado = true;
                String img = "img/imagenrestaurante.jpg";
                float promedio = CU.getPromedioCalificaciones(DR.getNickname());
                int cantFotos = DR.getImagenes().size();
                int seleccionada = 0;
                if (cantFotos > 0) {
                    Random r = new Random();
                    seleccionada = r.nextInt(cantFotos);
                    img = (String) DR.getImagenes().get(seleccionada + 1);
                }
    %>
    <div class="restaurante" onclick="cargarResaurante('<%=DR.getNickname()%>')">
        <img alt="<%=DR.getNombre()%>" src="<%=img%>" />
        <div class="info">
            <h1><%=DR.getNombre()%></h1>
            <p> 
                <b>Direccion:</b> <%=DR.getDireccion()%><br/>
                <b>Email:</b> <%=DR.getEmail()%><br/>                
                <%
                    out.print("<p class=\"Estrellas\">");
                    out.print("<span class=\"badge alert-warning\">" + promedio + "</span> ");
                    int parteEntera = (int) promedio;
                    for (int i = 0; i < 5; i++) {
                        if (i < parteEntera) {
                            out.print("<span class=\"glyphicon glyphicon-star\" style=\"color:orange;\" />");
                        } else {
                            out.print("<span class=\"glyphicon glyphicon-star\" style=\"color:gray;\" />");
                        }
                    }
                    out.print("</p>");
                %>
            </p>
        </div>
    </div>
    <%
            }
        }
    %>
</div>
