/* 
 * Todos los scripts en un solo archivito que se carga solo en el index.jsp cuando empieso a navegar por la pagina
 */

(cargarBienvenida = function () {
    $.ajax({
        url: "bienvenida.jsp",
        beforeSend: function () {
            cambioFrameIcono("refresh");
            $("#frameContainer").load("cargando.html");
            $("#frameTitulo").html(" CARGANDO");
        },
        error: function () {
            cambioFrameIcono("alert");
            $("#frameContainer").html(" Error al cargar restaurante");
            $("#frameTitulo").html(" ERROR");
            n();
        },
        success: function (data) {
            cambioFrameIcono("cutlery");
            $("#frameContainer").html(data);
            $("#frameTitulo").html(" Bienvenido");
            n();
        }
    });
});
(cargarBarraRestaurantes = function () {
    $.ajax({
        url: "restaurantesPorCategoria.jsp",
        beforeSend: function () {
            $("#barraRestauranes").load("cargando.html");
        },
        error: function () {
            $("#barraRestauranes").html("Error al cargar restaurante");
            n();
        },
        success: function (data) {
            $("#barraRestauranes").html(data);
            n();
        }
    });
});
(programarFrameLinks = function () {
    $(".frameLink").each(function () {
        var href = $(this).attr("href");
        var titulo = $(this).html();
        if (href !== "#") {
            $(this).attr({href: "#"});
            $(this).click(function () {
                $.ajax({
                    url: href,
                    beforeSend: function () {
                        cambioFrameIcono("refresh");
                        $("#frameContainer").load("cargando.html");
                        $("#frameTitulo").html(" CARGANDO");
                    },
                    error: function () {
                        cambioFrameIcono("alert");
                        $("#frameContainer").html(" Error al cargar informacion ");
                        $("#frameTitulo").html(" ERROR");
                        n();
                    },
                    success: function (data) {
                        if (href === 'infoUsuario.jsp')
                            cambioFrameIcono("user");
                        else if (href === 'carrito.jsp')
                            cambioFrameIcono("shopping-cart");
                        else
                            cambioFrameIcono('cutlery');
                        $("#frameContainer").html(data);
                        $("#frameTitulo").html(" " + titulo);
                        n();
                    }
                });
                return false;
            });
        }
    });
});

(cambiarTitulo = function (titulo) {
    document.title = titulo;
});
(mostrarRespuesta = function (mensaje, ok) {
    $("#respuesta").removeClass('alert alert-success').removeClass('alert alert-danger').html("<p style='text-align: center'>" + mensaje + "</p>");
    if (ok) {
        $("#respuesta").addClass('alert alert-success');
    } else {
        $("#respuesta").addClass('alert alert-danger');
    }
    $('#respuesta').show().delay(3000).fadeOut("slow");
});
(busquedaProducto = function (filtro) {
    $.ajax({
        type: "POST",
        url: "busquedaProducto.jsp",
        data: {filtro: filtro},
        beforeSend: function () {
            cambioFrameIcono("refresh");
            $("#frameContainer").load("cargando.html");
            $("#frameTitulo").html(" Buscando...");
        },
        error: function () {
            cambioFrameIcono("alert");
            $("#frameContainer").html(" Error al cargar restaurante");
            $("#frameTitulo").html(" ERROR");
            n();
        },
        success: function (data) {
            cambioFrameIcono("search");
            $("#frameContainer").html(data);
            $("#frameTitulo").html(" Resultado de busqueda por: " + filtro);
            n();
        }
    });
});
(cambioFrameIcono = function (icono) {
    $("#frameIcono").removeClass('glyphicon-asterisk');
    $("#frameIcono").removeClass('glyphicon-user');
    $("#frameIcono").removeClass('glyphicon-refresh');
    $("#frameIcono").removeClass('glyphicon-search');
    $("#frameIcono").removeClass('glyphicon-cutlery');
    $("#frameIcono").removeClass('glyphicon-alert');
    $("#frameIcono").removeClass('glyphicon-shopping-cart');
    $("#frameIcono").addClass('glyphicon-' + icono);
});
(window.alert = function (message) {
    mostrarRespuesta(message, false);
});
(cargarResaurante = function (r) {
    $.ajax({
        type: "POST",
        url: "infoRestaurante.jsp",
        data: "r=" + r,
        dataType: "html",
        beforeSend: function () {
            cambioFrameIcono("refresh");
            $("#frameContainer").load("cargando.html");
            $("#frameTitulo").html(" CARGANDO");
        },
        error: function () {
            cambioFrameIcono("alert");
            $("#frameContainer").html(" Error al cargar restaurante");
            $("#frameTitulo").html(" ERROR");
            n();
        },
        success: function (data) {
            cambioFrameIcono("cutlery");
            $("#frameContainer").html(data);
            $("#frameTitulo").html(" Restaurantes");
            n();
        }
    });
});

(verificarEmail = function () {
    var consulta = $("#email").val();
    $.ajax({
        type: "POST",
        url: "verificar",
        data: "email=" + consulta,
        dataType: "html",
        beforeSend: function () {
            $("#resultadoEmail").html('<img src="img/confirmarCarrito.gif" /> verificando');
        },
        error: function () {
            $("#resultadoEmail").html("Error en la peticion ajax");
            n();
        },
        success: function (data) {
            $("#resultadoEmail").html(data);
            n();
        }
    });
});
(verificarNick = function () {
    var consulta = $("#nick").val();
    $.ajax({
        type: "POST",
        url: "verificar",
        data: "nick=" + consulta,
        dataType: "html",
        beforeSend: function () {
            $("#resultado").html('<img src="img/confirmarCarrito.gif" />');
        },
        error: function () {
            $("#resultado").html("Error en la peticion ajax");
            n();
        },
        success: function (data) {
            $("#resultado").html(data);
            n();
        }
    });
});
(compararPass = function () {
    var pass = $('#re-passwd').val();
    var pass2 = $('#passwd').val();
    if (pass === pass2) {
        $('#re-passwd-group').removeClass('has-success');
        $('#re-passwd-group').removeClass('has-error');
        $('#re-passwd-group').removeClass('has-warning');
        $('#re-passwd-icono').removeClass('glyphicon-remove');
        $('#re-passwd-icono').removeClass('glyphicon-ok');
        $('#re-passwd-icono').removeClass('glyphicon-warning-sign');
        $('#re-passwd-group').addClass('has-success');
        $('#re-passwd-icono').addClass('glyphicon-ok');
    } else {
        $('#re-passwd-group').removeClass('has-success');
        $('#re-passwd-group').removeClass('has-error');
        $('#re-passwd-group').removeClass('has-warning');
        $('#re-passwd-icono').removeClass('glyphicon-remove');
        $('#re-passwd-icono').removeClass('glyphicon-ok');
        $('#re-passwd-icono').removeClass('glyphicon-warning-sign');
        $('#re-passwd-group').addClass('has-error');
        $('#re-passwd-icono').addClass('glyphicon-remove');
    }
});
(evitarSubmit = function () {
    var pass = $('#re-passwd').val();
    var pass2 = $('#passwd').val();
    if (pass !== pass2) {
        alert('Las contraseñas no coinciden');
        return false;
    }
    return true;
});

/* Buscando y ordenando comida */

(linksAgregarProducto = function () {
    $(".agregarProducto").each(function () {
        var producto = $(this).attr("href");
        if (producto !== "#") {
            $(this).removeAttr("href");
            $(this).click(function () {
                var cantidad = document.getElementById("Cantidad_" + producto).value;
                var parametros = {
                    P: producto,
                    C: cantidad
                };
                $.post("agregarACarrito", parametros, function (result) {
                    mostrarRespuesta(result, true);
                });
            });
        }
    });
});
(linksVerPedidos = function () {
    $(".verPedidosProducto").each(function () {
        var producto = $(this).attr("href");    // esto tiene el key de producto con este formato: nombreRestaurante_nombreProducto
        var datos = producto.split("_");        // lo separo en  para guardarlos en variables diferentes
        $(this).click(function () {
            $(this).removeAttr("href");
            var parametros = {
                r: datos[0],
                p: datos[1]
            };
            $.ajax({
                type: "POST",
                url: "verPedidosProducto.jsp",
                data: parametros,
                beforeSend: function () {
                    $('#ModalProductosPedidos').removeData('bs.modal');
                    $('#ModalProductosPedidos').modal({remote: 'modalCarga.html'});
                    $('#ModalProductosPedidos').modal('show');
                },
                success: function (data) {
                    $('#ModalProductosPedidos').removeData('bs.modal');
                    $('#ModalProductosPedidos').find('h3').html(datos[1].toString());
                    $('#ModalProductosPedidos').find('.modal-body').html(data);
                }
            });
        });
    });
});
(verPromo = function (x) {
    $('#ModalPromocion').removeData('bs.modal');
    $('#ModalPromocion').modal({remote: 'modalCarga.html'});
    $('#ModalPromocion').modal('show');
    $('#ModalPromocion').removeData('bs.modal');
    $('#ModalPromocion').modal({remote: 'verPromo.jsp?x=' + x});
});

/* Acciones sobre el carrito */
(linksConfirmarPedido = function () {
    $(".confirmarPedido").each(function () {
        var pedido = $(this).attr("href");
        if (pedido !== "#") {
            $(this).removeAttr("href");
            $(this).click(function () {
                $(this).removeClass("confirmarPedido");
                var botonCancelar = document.getElementById("cancelar" + pedido);
                botonCancelar.parentNode.removeChild(botonCancelar);
                $(this).html("<p><img src=\"img/confirmarCarrito.gif\"/> Confirmando</p>");
                $.post("confirmarPedido",
                        {p: pedido},
                function (result) {
                    $("#frameContainer").load("carrito.jsp");
                    mostrarRespuesta(result, true);
                }
                );
            });
        }
    });
});
(linksCancelarPedido = function () {
    $(".cancelarPedido").each(function () {
        var pedido = $(this).attr("href");
        if (pedido !== "#") {
            $(this).removeAttr("href");
            $(this).click(function () {
                $(this).removeClass("confirmarPedido");
                $.post("cancelarPedido",
                        {p: pedido},
                function (result) {
                    var x = document.getElementById("Pedido" + pedido);
                    x.parentNode.removeChild(x);
                    //$("#frameContainer").load("carrito.jsp");
                    mostrarRespuesta(result, true);
                }
                );
            });
        }
    });
});
(linksConfirmarTodo = function () {
    $(".confirmarTodo").each(function () {
        $(this).click(function () {
            $.post("confirmarTodo",
                    function (result) {
                        $("#frameContainer").load("carrito.jsp");
                        mostrarRespuesta(result, true);
                    });
        });
    });
});
(linksEliminarLineaPedido = function () {
    $(".elimimarLineaPedido").each(function () {
        var href = $(this).attr("href");
        var datos = href.split("_");
        href = $(this).attr("href");
        if (href !== "#") {
            $(this).removeAttr("href");
            $(this).click(function () {
                $(this).removeClass("elimimarLineaPedido");
                var Lista = $("#Lista" + datos[0]);
                if (Lista.find("li").length === 1) {
                    var x = document.getElementById("Pedido" + datos[0]);
                    x.parentNode.removeChild(x);
                } else {
                    var x = document.getElementById(href);
                    var parent = x.parentNode;
                    parent.removeChild(x);
                }
                $.post("eliminarLineaPedido",
                        {pedido: datos[0],
                            restaurante: datos[1],
                            producto: datos[2]},
                function (result) {
                    // $("#frameContainer").load("carrito.jsp");
                    mostrarRespuesta(result, true);
                }
                );
            });
        }
    });
});


