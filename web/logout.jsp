<%-- 
    Document   : cerrarSesion
    Created on : 28/08/2015, 01:24:16 PM
    Author     : Jean
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.removeAttribute("nick");
    response.sendRedirect("index.jsp");
%>