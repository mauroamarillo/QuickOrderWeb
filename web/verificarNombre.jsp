<%-- 
    Document   : verificarNombre
    Created on : 28/08/2015, 10:54:10 AM
    Author     : Jean
--%>

<%@page import = "Logica.ControladorUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ControladorUsuario CU = null;
    if (session.getAttribute("CU") == null) {
        CU = new ControladorUsuario();
    } else {
        CU = (ControladorUsuario) session.getAttribute("CU");
    }
    String user = request.getParameter("nick");
    if (user == null) {
        out.print("<span style='font-weight:bold;color:white;'>Ingrese un nickname</span>");
        return;
    }
    if (!user.isEmpty()) {
        try {
            if (!CU.nickOcupado(user)) {
                out.print("<span style='font-weight:bold;color:green;'>Disponible.</span>");
            } else {
                out.print("<span style='font-weight:bold;color:red;'>El nombre de usuario ya existe.</span>");
            }

        } catch (Exception e) {
            out.print("<span style='font-weight:bold;color:red;'>Error: " + e + "</span>");
        }
    } else {
        out.print("<span style='font-weight:bold;color:white;'>Ingrese un nickname</span>");
    }
%> 