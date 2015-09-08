<%-- 
    Document   : infoUsuario
    Created on : 28/08/2015, 03:54:10 PM
    Author     : Jean
--%>

<%@page import="Logica.DataTypes.DataCalificacion"%>
<%@page import="Logica.Fecha"%>
<%@page import="Logica.DataTypes.DataIndividual"%>
<%@page import="Logica.DataTypes.DataPromocion"%>
<%@page import="Logica.DataTypes.DataProdPedido"%>
<%@page import="java.util.HashMap"%>
<%@page import="Logica.Estado"%>
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
    ControladorUsuario CU = null;
    if (session.getAttribute("CU") == null) {
        CU = new ControladorUsuario();
    } else {
        CU = (ControladorUsuario) session.getAttribute("CU");
    }
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
                    out.print(urlImg);%> " class="img-thumbnail" style=" width:190px; height:190px;" />

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
            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                <%
                    Iterator it = CU.getDataPedidos(nick).entrySet().iterator();
                    while (it.hasNext()) {
                        Map.Entry entry = (Map.Entry) it.next();
                        DataPedido DP = (DataPedido) entry.getValue();
                        if (!DP.getEstado().equals(Estado.aconfirmar)) {
                %>
                <div class="panel panel-pedido  panel-default">
                    <div class="panel-heading" role="tab" id="<%=DP.getNumero()%>">
                        <div class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse<%=DP.getNumero()%>" aria-expanded="true" aria-controls="collapseOne">
                                <b>Fecha:</b> <%=new Fecha(DP.getFecha()).toString()%>  |  <b>Restaurante:</b> <%=CU.buscarRestaurante(DP.getRestaurante()).getNombre()%> | <b>Total:</b> $<%=DP.getPrecio()%>
                            </a>
                            <%
                                DataCalificacion calificacion = CU.obtenerCalificacionPedido(DP.getNumero());
                                if (calificacion.getPuntaje() == 0) {
                            %>
                            <a href="<%=DP.getNumero()%>" style="float: right;" class="calificarPedido"><span class="glyphicon glyphicon-pencil"></span></a>
                                <%
                                    } else {
                                        for (int i = 0; i < 5; i++) {
                                            out.print("<p style=\"float: right;\">");
                                            if (i < calificacion.getPuntaje()) {
                                                out.print("<span class=\"glyphicon glyphicon-star\" style=\"color:orange;\"></span>");
                                            } else {
                                                out.print("<span class=\"glyphicon glyphicon-star\" style=\"color:gray;\"></span>");
                                            }
                                            out.print("</p>");

                                        }
                                    }
                                %>
                        </div>
                    </div>
                    <div id="collapse<%=DP.getNumero()%>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="<%=DP.getNumero()%>">
                        <div class="row" style="padding: 10px; " >
                            <ul class="media-list col-lg-7">
                                <%
                                    HashMap DataProdPedido = DP.getProdPedidos();
                                    Iterator it2 = DataProdPedido.entrySet().iterator();
                                    while (it2.hasNext()) {
                                        Map.Entry entry2 = (Map.Entry) it2.next();
                                        DataProdPedido DPP = (DataProdPedido) entry2.getValue();
                                %>
                                <li class="media" id="<%=DP.getNumero()%>_<%=DP.getRestaurante()%>_<%=DPP.getProducto().getNombre()%>">
                                    <div class="media-left">
                                        <img class="media-object img-thumbnail" src="<%=DPP.getProducto().getImagen()%>" alt="<%=DPP.getProducto().getNombre()%>"  class="img img-thumbnail" style=" width:105px; height:105px;">
                                    </div>
                                    <div class="media-body">
                                        <h4 class="media-heading" ><%=DPP.getProducto().getNombre()%></h4>
                                        Precio unitario: $<%=DPP.getProducto().getPrecio()%> <br/>
                                        cantidad:<%=DPP.getCantidad()%> <br/>
                                        Subtotal: $<%=(DPP.getProducto().getPrecio() * DPP.getCantidad())%> <br/>
                                        <%
                                            if (DPP.getProducto() instanceof DataPromocion) {
                                        %>
                                        Tipo: Promocional (<%=((DataPromocion) DPP.getProducto()).getDescuento()%>% Descuento)<br/> 
                                        <%
                                            }
                                            if (DPP.getProducto() instanceof DataIndividual) {
                                        %>
                                        Tipo: Individual <br/> 
                                        <%
                                            }
                                        %>
                                    </div>
                                </li>
                                <%}%><%-- Esta llave cierra  el segundo while--%>

                            </ul>
                            <ul class="col-lg-5">
                                <%
                                    if (calificacion.getPuntaje() != 0) {
                                %>
                                <div class="verCal">
                                    <p>Comentario:</p>
                                    <p style="text-align: center; "><%=calificacion.getComentario()%></p>
                                    <p><br/></p>
                                </div>
                                <%
                                    }
                                %>
                            </ul>
                        </div> 
                    </div>
                </div>
                <%        }
                    }
                %>
            </div>
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
        $('#ModalPedido').modal({remote: 'modalCarga.html'});
        $('#ModalPedido').removeData('bs.modal');
        $('#ModalPedido').modal({remote: 'verPedido.jsp?x=' + x});
        $('#ModalPedido').modal('show');
    };
    $(".calificarPedido").each(function () {
        var href = $(this).attr("href");
        if (href !== "#") {
            $(this).removeAttr("href");
            $(this).click(function () {
                calPed(href);

            });
        }
    });
    calPed = function (x) {
        $('#ModalPedido').removeData('bs.modal');
        $('#ModalPedido').modal({remote: 'calificarPedido.jsp?pedido=' + x});
        $('#ModalPedido').modal('show');
    };
</script>    

