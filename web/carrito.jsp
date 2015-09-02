<%-- 
    Document   : carrito
    Created on : 02/09/2015, 08:16:15 PM
    Author     : Jean
--%>

<%@page import="java.util.HashMap"%>
<%@page import="Logica.ControladorUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("nick") == null) {
        out.print("<h1>chupala<h1>");
        return;
    }
    String nick = (String) session.getAttribute("nick");
    ControladorUsuario CU = new ControladorUsuario();
    HashMap pedidos = CU.getDataPedidos(nick);
    
%>
<!DOCTYPE html>