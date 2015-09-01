<%-- 
    Document   : infoUsuario
    Created on : 28/08/2015, 03:54:10 PM
    Author     : Jean
--%>

<%@page import="Logica.DataTypes.DataPedido"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import= "Logica.DataTypes.DataCliente"%>
<%@page import= "Logica.ControladorUsuario" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("nick") == null) {
        response.sendRedirect("index.jsp");
    }
    String nick = (String) session.getAttribute("nick");
    ControladorUsuario CU = new ControladorUsuario();
    DataCliente DC = CU.buscarCliente(nick);
%>
<div id="content">
    <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
        <li class="active"><a href="#Datos" data-toggle="tab">Datos <%=DC.getNombre()%></a></li>
        <li><a href="#Pedidos" data-toggle="tab">Pedidos</a></li>
        <li><a href="#Configuracion" data-toggle="tab">Configuracion</a></li>
    </ul>
    <div id="my-tab-content" class="tab-content">
        <div class="tab-pane active" id="Datos" style="color:white;">
            </br>
            <div class="col-lg-3 ">
                <img src="<%String urlImg = DC.getImagen();
                    if (urlImg.equals("sin_imagen")) {
                        urlImg = "img/sin_img.jpg";
                    }
                    out.print(urlImg);%> " class="img-thumbnail 
                    " style=" width:
                     190px;
                     height:
                     190px;" />
            </div
            > <div 
                class  

                ="col-lg-9">
                <h1><%=DC.getNickname()%></h1>
                <p> 
                    <b>Nombre:</b> <%=DC.getNombre()%></br> 
                    <b>Apellido:</b> <%=DC.getApellido()%></br> 
                    <b>Fecha de Nacimiento:</b> <%=DC.getFechaNac()%></br>
                    <b>Direccion:</b> <%=DC.getDireccion()%></br>
                    <b>Email:</b> <%=DC.getEmail()%></br>
                </p>
            </div>
        </div>
        </br>
        <div class="tab-pane" id="Pedidos">
            <div class="col-xs-12 tituloLista"> 
                <label class="col-xs-3" > Numero </label>
                <label class="col-xs-3 lista-num" > Precio </label>
                <label class="col-xs-3" > Fecha </label>
                <label class="col-xs-3" > Restaurante </label>
            </div>
            <%
                Iterator IT = DC.getPedidos().entrySet().iterator();
                int x = 1;
                String ultimo = "";

                while (IT.hasNext()) {
                    Map.Entry entry = (Map.Entry) IT.next();
                    DataPedido DP = (DataPedido) entry.getValue();
                    if (!IT.hasNext()) {
                        ultimo = "lista-ultimo";
                    }
                    out.print(" <div class=\"col-xs-12 lista" + x + " " + ultimo + "\"> <input type=\"button\" onclick=\"verPedido(" + DP.getNumero() + ");\" hidden=\"true\" id= \"checkProd" + DP.getNumero() + "\"/>");
                    out.print(" <label class=\"col-xs-3\" for=\"checkProd" + DP.getNumero() + "\">" + DP.getNumero() + " </label>");
                    out.print(" <label class=\"col-xs-3 lista-num\" for=\"checkProd" + DP.getNumero() + "\">$" + DP.getPrecio() + " </label>");
                    out.print(" <label class=\"col-xs-3\" for=\"checkProd" + DP.getNumero() + "\">" + DP.getFecha() + " </label> ");
                    out.print(" <label class=\"col-xs-3\" for=\"checkProd" + DP.getNumero() + "\">" + DP.getRestaurante() + " </label> ");
                    out.print(" </div> ");
                    if (x == 1) {
                        x = 2;
                    } else {
                        x = 1;
                    }
                }
            %>
        </div>
        <div class="tab-pane" id="Configuracion">
            <h1>Configuracion</h1>
            <p>aca se va a poder modificar informacion del cliente</p>
        </div>
    </div>
</div>
<div id="ModalPedido" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content modal-transparent">

        </div>
    </div>
</div>
<script type="text/javascript">
    jQuery(document).ready(function ($) {
        $('#tabs').tab();
    });
    verPedido = function (x) {
        $('#ModalPedido').removeData('bs.modal');
        $('#ModalPedido').modal({remote: 'verPedido.jsp?x=' + x});
        $('#ModalPedido').modal('show');
    };
</script>    

