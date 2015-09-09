<%-- 
    Document   : calificarPedido
    Created on : 06/09/2015, 01:46:59 AM
    Author     : Jean
--%>

<%@page import="Logica.DataTypes.DataPedido"%>
<%@page import="Logica.ControladorUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int pedido = Integer.parseInt((String) request.getParameter("pedido"));
%>

<!DOCTYPE html>
<style>

    input[type = "radio"]{ 
        display:none;
    }
    label{
        color:grey;
    }

    .clasificacion{
        direction: rtl;
        unicode-bidi: bidi-override;
        text-align:center; 
        font-size:20px;
    }

    label:hover,
    label:hover ~ label{
        color:orange;
    }
    input[type = "radio"]:checked ~ label{
        color:orange;
    }

</style>

<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
    <h3 class="form-signin-heading text-muted" style="color:white;">Calificar </h3>
</div>
<div class="modal-body"  style="color:black;">
    <form method="post" id="formulario">       
        <p class="clasificacion">
            <input id="radio1" type="radio" name="estrellas" value="5"> <label for="radio1"><span class="glyphicon glyphicon-star" aria-hidden="true"></span></label> 
            <input id="radio2" type="radio" name="estrellas" value="4"> <label for="radio2"><span class="glyphicon glyphicon-star" aria-hidden="true"></span></label>
            <input id="radio3" type="radio" name="estrellas" value="3"> <label for="radio3"><span class="glyphicon glyphicon-star" aria-hidden="true"></span></label>
            <input id="radio4" type="radio" name="estrellas" value="2"> <label for="radio4"><span class="glyphicon glyphicon-star" aria-hidden="true"></span></label>
            <input id="radio5" type="radio" name="estrellas" value="1"> <label for="radio5"><span class="glyphicon glyphicon-star" aria-hidden="true"></span></label>
        </p>
        <input name = "pedido" hidden=" true" value="<%=pedido%>" />
        <p>
            <textarea name="comentario" class="form-control" placeholder="Comentario" rows="3"></textarea>
        </p>
        <p>
            <input type="button" class="btn btn-primary" id="btn_enviar" value="calificar">
        </p>
    </form>

</div>
<div class="modal-footer">

</div>
<script>
    $(function () {
        $("#btn_enviar").click(function () {
            $.ajax({
                type: "POST",
                url: "calificarPedido",
                data: $("#formulario").serialize(),
                success: function (data) {
                    mostrarRespuesta(data, true);
                    $('#ModalPedido').modal('hide');
                    $("#frameContainer").load("infoUsuario.jsp");
                }
            });
            return false; // Evitar ejecutar el submit del formulario.
        });
    });
</script>
