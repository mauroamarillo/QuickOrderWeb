<%@page import="Logica.DataTypes.DataCliente"%>
<%@page import ="Logica.ControladorUsuario" %>
<%
    ControladorUsuario CU = new ControladorUsuario();
    String user = request.getParameter("nick");
    String pass = request.getParameter("passwd");
    if (CU.nickOcupado(user)) {
        DataCliente DC = CU.buscarCliente(user);
        // falta pedir arreglar la funcion para que retorne el pass de este cliente y comprobar que coincidan
        session.setAttribute("nick", user);
        response.sendRedirect("index.jsp");
    } else {
        response.sendRedirect("index.jsp?error=1");
    }
%>