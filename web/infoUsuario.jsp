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
            <h1>Modificar Datos</h1>
            <div class="row">
                <div class="col-lg-3 " >
                    <p style=" text-align: center;">
                    <div class="cambioImagenPerfil ">
                        <img id="imagenPerfilNueva"<%--onclick="seleccionarArchivo();" --%> src="<%=urlImg%> " class="img-thumbnail" style="width:190px; height:190px;" />
                        <span  onclick="seleccionarArchivo();" class="spanCambio"><span>Click para <br/>cambiar imagen</span></span>
                    </div>
                    </p>
                    <input id="selectorArchivos" name="selectorArchivos" type="file" style="visibility: hidden;" />
                </div>
                <div class="col-lg-6 " >
                    <form id ="formCambiarDatos" method="post">
                        <%-- este valor es para saber si la imagen seleccionada cambio --%> 
                        <input id="cambioImagen" name="cambioImagen" type="number" hidden="true" value="0" />
                        <div class="form-group">
                            <input type="text" name="nombre" id="nombre" value="<%=DC.getNombre()%>" class="form-control" placeholder="Nombre*" required/>
                        </div> 
                        <div class="form-group">
                            <input type="text" name="apellido" id="apellido" value="<%=DC.getApellido()%>" class="form-control" placeholder="Apellido*" required/>
                        </div> 
                        <div class="form-group">
                            <input type="text" name="direccion" id="direccion" value="<%=DC.getDireccion()%>" class="form-control" placeholder="direccion*" required/>
                        </div> 
                        <div class="form-group">
                            <input type="email" name="email" id="email" value="<%=DC.getEmail()%>"class="form-control " placeholder="Email*" required/>
                            <div id="resultadoEmail"></div>
                        </div> 
                        <div class="form-group">
                            <input type="password" name="passwd" id="passwd" value="<%=DC.getPwd()%>" class="form-control" placeholder="Contraseña*" required/>
                        </div> 
                        <button class="btn btn-primary" type="submit" if="confirmarCambios">Confirmar</button>
                    </form>
                </div>
            </div>
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
    /*operaciones para cambiar imagen*/
    document.getElementById('selectorArchivos').addEventListener('change', archivo, false);
    function seleccionarArchivo() {
        var elem = document.getElementById("selectorArchivos");
        if (elem && document.createEvent) {
            var evt = document.createEvent("MouseEvents");
            evt.initEvent("click", true, false);
            elem.dispatchEvent(evt);
        }
    }
    function archivo(evt) {
        var files = evt.target.files; // FileList object
        // Obtenemos la imagen del campo "selectorArchivos".
        for (var i = 0, f; f = files[i]; i++) {
            //Solo admitimos imágenes.
            if (!f.type.match('image.*')) {
                continue;
            }
            var reader = new FileReader();

            reader.onload = (function () {
                return function (e) {
                    $('#imagenPerfilNueva').attr('src', e.target.result);
                    $.post("guardarImgTemporal",
                            {img: e.target.result}
                    );
                    $('#cambioImagen').attr('value', '1');
                };
            })(f);
            reader.readAsDataURL(f);
        }
    }
</script>


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
<script>
    $(function () {
        $("#confirmarCambios").click(function (event) {
            event.preventDefault();
            $.ajax({
                type: "POST",
                url: "cambiarDatosCliente",
                data: $("#formCambiarDatos").serialize(),
                success: function (data) {
                    mostrarRespuesta(data, true);
                    // $("#frameContainer").load("infoUsuario.jsp");
                }
            });
            return false; // Evitar ejecutar el submit del formulario.
        });
    });
</script>

<style>
    .cambioImagenPerfil {
        list-style-type: none;
        margin: 0;
        padding: 0;
        text-align: center;
    }

    .cambioImagenPerfil {
        display: inline-block;
        height: 190px;
        margin: 0 1em 1em 0;
        position: relative;
        width: 190px;
    }
    .spanCambio {
        background: rgba(0,0,0,0.5);
        color: white;
        cursor: pointer;
        display: table;
        height: 190px;
        left: 0;
        position: absolute;
        top: 0;
        width: 150px;
    }

    .spanCambio span {
        display: table-cell;
        text-align: center;
        font-size: 20px;
        vertical-align: middle;
    }
    .spanCambio  {
        background: rgba(0,0,0,0.5);
        color: white;
        cursor: pointer;
        display: table;
        height: 190px;
        left: 0;
        position: absolute;
        top: 0;
        width: 190px;
        opacity: 0;
    }

    .cambioImagenPerfil:hover .spanCambio {
        opacity: 1;
    }
    .spanCambio  {
        background: rgba(0,0,0,0.5);
        color: white;
        cursor: pointer;
        display: table;
        height: 190px;
        left: 0;
        position: absolute;
        top: 0;
        width: 190px;
        opacity: 0;
        -webkit-transition: opacity 500ms;
        -moz-transition: opacity 500ms;
        -o-transition: opacity 500ms;
        transition: opacity 500ms;
    }
</style>