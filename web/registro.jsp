<%-- 
    Document   : registro
    Created on : 28/08/2015, 12:51:54 AM
    Author     : Jean
--%>

<%@page import="Logica.ControladorUsuario"%>
<%@page import ="java.io.File" %>
<%@page import ="java.lang.String" %>
<%
    ControladorUsuario CU = new ControladorUsuario();
    String nick = request.getParameter("nick");
    String pwd = request.getParameter("passwd");
    String nombre = request.getParameter("nombre");
    String direccion = request.getParameter("direccion");
    String apellido = "apellido";
    String email = request.getParameter("email");
    String fecha = request.getParameter("fecha");
    String separador = " ";
    String[] temp;
    temp = fecha.split(separador); // reparo la fecha en 3

    try {
        CU.insertarCliente(nick, email, direccion, nombre, apellido, temp[0], temp[1].toLowerCase(), temp[2], null, pwd);
        session.setAttribute("nick", nick);
        response.sendRedirect("index.jsp");
        // String nick, String email, String dir, String nombre, String apellido, String D, String M, String A, File img, String pwd
    } catch (Exception e) {
        out.print("<span style='font-weight:bold;color:red;'>" + e.getMessage() + "</span>");
        out.print("</br><a href=\"index.jsp\">volver</a>");
    }

%>