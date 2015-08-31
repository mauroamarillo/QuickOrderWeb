<%-- 
    Document   : registro
    Created on : 28/08/2015, 12:51:54 AM
    Author     : Jean
--%>

<%@page import = "java.io.File" %>
<%@page import = "Logica.ControladorUsuario" %>
<%@page import = "java.lang.String" %>
<%
    ControladorUsuario CU = new ControladorUsuario();
    String user = request.getParameter("nick");
    String pwd = request.getParameter("passwd");
    String nombre = request.getParameter("nombre");
    String apellido = "apellido";
    String email = request.getParameter("email");
    String fecha = request.getParameter("fecha");
    String separador = " ";
    String[] temp;
    temp = fecha.split(separador);
    
     try {
      CU.insertarCliente(user, email, pwd, nombre, apellido, temp[0], temp[1].toLowerCase(), temp[2], null);
     out.print("<br /> De  fiesta");
     } catch (Exception e) {
     out.print("ERROR! " + e.getMessage());
     }
    session.setAttribute("nick", user);
    response.sendRedirect("index.jsp");
%>