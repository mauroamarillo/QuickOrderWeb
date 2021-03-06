<%-- 
    Document   : infoUsuario
    Created on : 28/08/2015, 03:54:10 PM
    Author     : Jean
--%>

<%@page import="ClienteWS.DataIndividual"%>
<%@page import="ClienteWS.DataPromocion"%>
<%@page import="ClienteWS.DataProdPedido"%>
<%@page import="ClienteWS.DataCalificacion"%>
<%@page import="ClienteWS.Estado"%>
<%@page import="ClienteWS.DataPedido"%>
<%@page import="ClienteWS.DataCliente"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ClienteWS.WSQuickOrder_Service service = null;
    String rutaWS = configuracion.configuracion.URLWS();
    try {
        if (rutaWS == null) {
            service = new ClienteWS.WSQuickOrder_Service();
        } else {
            service = new ClienteWS.WSQuickOrder_Service(new java.net.URL(rutaWS));
        }
    } catch (javax.xml.ws.WebServiceException e) {
        out.print("<div class=\"Exception\"> "+e.getMessage()+"</div>");
        return;
    }
    ClienteWS.WSQuickOrder port = service.getWSQuickOrderPort();
    if (session.getAttribute("nick") == null) {
        response.sendRedirect("index.jsp");
    }
    String nick = (String) session.getAttribute("nick");

    DataCliente DC = port.buscarCliente(nick);
%>
<!DOCTYPE HTML>
<div id="content">
    <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
        <li class="active"><a href="#Datos" data-toggle="tab">Datos <%=DC.getNombre()%></a></li>
        <li><a href="#Pedidos" data-toggle="tab">Pedidos</a></li>
        <li><a href="#Configuracion" data-toggle="tab">Configuracion</a></li>
    </ul>
    <div id="my-tab-content" class="tab-content">
        <div class="tab-pane active" id="Datos" style="color:white;">
            <br/>
            <div class="col-lg-3 ">
                <img src="<%String urlImg = DC.getImagen();
                    if (urlImg == null || urlImg.equals("sin_imagen")) {
                        urlImg = "img/sin_img.jpg";
                    }
                    out.print(urlImg);%> " class="img-thumbnail" style=" width:190px; height:190px;" />

            </div> 
            <div  class ="col-lg-9">
                <h1><%=DC.getNickname()%></h1>
                <p> 
                    <b>Nombre:</b> <%=DC.getNombre()%></br> 
                    <b>Apellido:</b> <%=DC.getApellido()%></br> 
                    <b>Fecha de Nacimiento:</b> <%=(new DataTypes.Fecha(DC.getFechaNac())).toString()%></br>
                    <b>Direccion:</b> <%=DC.getDireccion()%></br>
                    <b>Email:</b> <%=DC.getEmail()%></br>
                </p>
            </div>
        </div>
        </br>
        <div class="tab-pane" id="Pedidos">            
            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                <%
                    Iterator it = port.getDataPedidos(nick).iterator();
                    while (it.hasNext()) {
                        Object entry = (Object) it.next();
                        DataPedido DP = (DataPedido) entry;
                        if (!DP.getEstado().equals(Estado.ACONFIRMAR)) {
                %>
                <div class="panel panel-pedido  panel-default">
                    <div class="panel-heading" role="tab" id="<%=DP.getNumero()%>">
                        <div class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse<%=DP.getNumero()%>" aria-expanded="true" aria-controls="collapseOne">
                                <b>Fecha:</b> <%=(new DataTypes.Fecha(DP.getFecha())).toString()%>  |  <b>Restaurante:</b> <%=port.buscarRestaurante(DP.getRestaurante()).getNombre()%> | <b>Total:</b> $<%=DP.getPrecio()%>
                            </a>
                            <%
                                DataCalificacion calificacion = port.obtenerCalificacionPedido(DP.getNumero());
                                if (calificacion.getPuntaje() == 0) {// <-- hay que poner esto porque solo deberian poder puntuarse pedidos recibidos
                                    if (DP.getEstado().equals(Estado.RECIBIDO)) {
                            %>
                            <a href="<%=DP.getNumero()%>" style="float: right;" class="calificarPedido"><span class="glyphicon glyphicon-pencil"></span></a>
                                <%
                                        }
                                    } else {
                                        out.print("<a href=\"#\" Style=\"Float:right;\" data-placement=\"left\" data-toggle=\"popover\" data-trigger=\"focus\" title=\"Comentario\" data-content=\"" + calificacion.getComentario() + "\" >");
                                        for (int i = 5; i > 0; i--) {
                                            if (i <= calificacion.getPuntaje()) {
                                                out.print("<span class=\"glyphicon glyphicon-star\" style=\"color:orange;\"></span>");
                                            } else {
                                                out.print("<span class=\"glyphicon glyphicon-star\" style=\"color:gray;\"></span>");
                                            }
                                        }
                                        out.print("</a>");
                                    }
                                %>
                        </div>
                    </div>
                    <div id="collapse<%=DP.getNumero()%>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="<%=DP.getNumero()%>">
                        <div class="row" style="padding: 10px; " >
                            <ul class="media-list col-lg-12" style="padding-left: 10px; ">
                                <%
                                    Iterator it2 = port.pedidoGetProdPedidos(DP.getNumero()).iterator();
                                    while (it2.hasNext()) {
                                        Object entry2 = it2.next();
                                        DataProdPedido DPP = (DataProdPedido) entry2;
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
                        <span  onclick="seleccionarArchivo();" class="spanCambio"><span>Click para <br/>cambiar imagen<b style=" font-size: 10px;"><br/>Max: 1Mb</b></span></span>
                    </div>
                    </p>
                    <input id="selectorArchivos" name="selectorArchivos" type="file" accept="image/*" style="visibility: hidden;" />
                </div>
                <div class="col-lg-6 " >
                    <form id ="formCambiarDatos" method="post" class="form-signin" onsubmit="return false;">
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
                        <div class="form-group">
                            <input type="password" name="re-passwd" id="re-passwd" value="<%=DC.getPwd()%>" class="form-control" placeholder="Confirmar Contraseña*" required/>
                        </div> 
                        <button value="Send" class="btn btn-primary" type="submit"  id="confirmarCambios" >Confirmar</button>                        
                        <a class="btn btn-primary" onclick="resetCampos()" >Restaurar Campos</a>
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
<script>
    $(document).ready(function () {
        cambiarTitulo('<%="Datos " + session.getAttribute("nombre")%>');
        $('[data-toggle="popover"]').popover();
        $('[data-toggle="popover"').click(function () {
            return false;
        });
    });
</script>
<script type="text/javascript">
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
                    $('#cambioImagen').attr('value', '1');
                };
            })(f);
            reader.readAsDataURL(f);
        }
    }
</script> 
<script type="text/javascript">
    $(function () {
        $("#confirmarCambios").click(function (event) {
            if ($('#formCambiarDatos')[0].checkValidity())
              //  var datos = $('#formCambiarDatos').serialize() + "&img=" + $('#imagenPerfilNueva').attr('src');
            
             var datos = {
             nombre: document.getElementById('nombre').value,
             apellido: document.getElementById('apellido').value,
             cambioImagen: document.getElementById('cambioImagen').value,
             email: document.getElementById('email').value,
             passwd: document.getElementById('passwd').value,
             direccion: document.getElementById('direccion').value,
             img: document.getElementById('imagenPerfilNueva').src
             }; 
             
            $.ajax({
                type: "POST",
                url: "cambiarDatosCliente",
                data: datos,
                success: function (data) {
                    mostrarRespuesta(data, true);
                    $("#frameContainer").load("infoUsuario.jsp");
                },
                error: function(data){
                    mostrarRespuesta(data, false);
                }
            });
        });
    });
</script>
<script type="text/javascript">
    resetCampos = function () {
        document.getElementById('imagenPerfilNueva').src = '<%=urlImg%>';
        document.getElementById('cambioImagen').value = '0';
        document.getElementById('nombre').value = '<%=DC.getNombre()%>';
        document.getElementById('apellido').value = '<%=DC.getApellido()%>';
        document.getElementById('direccion').value = '<%=DC.getDireccion()%>';
        document.getElementById('email').value = '<%=DC.getEmail()%>';
        document.getElementById('passwd').value = '<%=DC.getPwd()%>';
    };
</script>

