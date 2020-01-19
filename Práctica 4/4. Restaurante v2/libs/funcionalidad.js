var copa = false;
var cafe = false;

var dict_mesas = {
    "m1": {},
    "m2": {},
    "m3": {},
    "m4": {},
    "m5": {}
}

var dict_copas = {
    // mesa : [cafe, copa]
    "m1": [false, false],
    "m2": [false, false],
    "m3": [false, false],
    "m4": [false, false],
    "m5": [false, false]
}


// Mostrar p1 por defecto

$(document).ready(function () {
    $("#listap1").show();
    $("#listap2").hide();
    $("#listap3").hide();

})

// Mostrar p1 al clicar

$(document).ready(function () {
    $("#primeros").click(function () {
        $("#listap1").show();
        $("#listap2").hide();
        $("#listap3").hide();
    });
})

// Mostrar p2 al clicar

$(document).ready(function () {
    $("#segundos").click(function () {
        $("#listap1").hide();
        $("#listap2").show();
        $("#listap3").hide();
    });
})

// Mostrar p3 al clicar

$(document).ready(function () {
    $("#postres").click(function () {
        $("#listap1").hide();
        $("#listap2").hide();
        $("#listap3").show();
    });
})

// Add pedido listap1

$(document).ready(function () {
    $("#listap1").dblclick(function (ev) {

        // Precio de todos los platos anteriores
        var precioPlatos = parseFloat($("#precio").val());

        // Extraigo valoes del elemento seleccionado
        var valor = $("#listap1").children("option:selected").val();
        var texto = $("#listap1").children("option:selected").text();

        // Sumo el precio del plato seleccionado al que ya había
        var nuevoPrecio = precioPlatos + parseFloat(valor);

        // Actualizo campo de texto
        $("#precio").val(nuevoPrecio);

        // Añado nuevo plato a pedidos
        $("#pedidos").append(new Option(texto, valor));
    });
});

// Add pedido listap2

$(document).ready(function () {
    $("#listap2").dblclick(function (ev) {

        // Precio de todos los platos anteriores
        var precioPlatos = parseFloat($("#precio").val());

        // Extraigo valoes del elemento seleccionado
        var valor = $("#listap2").children("option:selected").val();
        var texto = $("#listap2").children("option:selected").text();

        // Sumo el precio del plato seleccionado al que ya había
        var nuevoPrecio = precioPlatos + parseFloat(valor);

        // Actualizo campo de texto
        $("#precio").val(nuevoPrecio);

        // Añado nuevo plato a pedidos
        $("#pedidos").append(new Option(texto, valor));
    });
});

// Add pedido listap3

$(document).ready(function () {
    $("#listap3").dblclick(function (ev) {

        // Precio de todos los platos anteriores
        var precioPlatos = parseFloat($("#precio").val());

        // Extraigo valoes del elemento seleccionado
        var valor = $("#listap3").children("option:selected").val();
        var texto = $("#listap3").children("option:selected").text();

        // Sumo el precio del plato seleccionado al que ya había
        var nuevoPrecio = precioPlatos + parseFloat(valor);
        var nuevoPrecio = Number((nuevoPrecio).toFixed(1));

        // Actualizo campo de texto
        $("#precio").val(nuevoPrecio);

        // Añado nuevo plato a pedidos
        $("#pedidos").append(new Option(texto, valor));
    });
});

// Eliminar pedido

$(document).ready(function () {
    $("#pedidos").dblclick(function (ev) {
        // Extraigo valor 
        var valor = $($("#pedidos").children("option:selected")).val();

        // Extraigo precio de platos anteriores
        var precioPlatos = parseFloat($("#precio").val());

        // Resto el precio del plato a quitar 
        var nuevoPrecio = precioPlatos - parseFloat(valor);

        // Actualizo campo de texto
        $("#precio").val(nuevoPrecio);

        $($("#pedidos").children("option:selected")).remove();

    });
});

// Guardar mesa

$(document).ready(function () {
    $("#mesas").click(function (ev) {
        var mesa_seleccionada = $("#mesas").val();
        mesa = dict_mesas[mesa_seleccionada];
        copa = dict_copas[mesa_seleccionada];

        $("#pedidos option").each(function () {
            mesa[$(this).text()] = $(this).val();
        });

        // café
        copa[0] = $("#cafe").is(':checked');
        // copa
        copa[1] = $("#copa").is(':checked');


    })
});

// Cargar mesa
$(document).ready(function () {
    $("#mesas").change(function (ev) {
        $('#pedidos')[0].options.length = 0;
        $("#cafe").prop("checked", false);
        $("#copa").prop("checked", false);

        var precio = 0;


        var mesa_seleccionada = $("#mesas").val();
        var mesa = dict_mesas[mesa_seleccionada]
        // pedidos
        $.each(mesa, function (texto, valor) {
            $('#pedidos')
                .append(new Option(texto, valor));
            precio += parseFloat(valor);
        });

        // copas
        copas = dict_copas[mesa_seleccionada];

        if (copas[0]) {
            $("#cafe").prop("checked", true);
            precio += parseFloat($("#cafe").val());
        }

        if (copas[1]) {
            $("#copa").prop("checked", true);
            precio += parseFloat($("#copa").val());
        }

        $("#precio").val(precio);
    });
});

// Boton pagar
$(document).ready(function () {
    $("#boton").click(function (ev) {
        window.alert("Has pagado")
        $("#precio").val(0);
        $("#cafe").prop("checked", false);
        $("#copa").prop("checked", false);
        $('#pedidos')[0].options.length = 0;
        var mesa_seleccionada = $("#mesas").val();
        dict_mesas[mesa_seleccionada] = {};
        dict_copas[mesa_seleccionada] = [false, false];


    })
});

// Actualizar precio al pulsar copa
$(document).ready(function () {
    $("#copa").click(function (ev) {
        var precioActual = parseFloat($("#precio").val());
        var precioCopa = parseFloat($("#copa").val());

        if ($("#copa").is(':checked')) {
            var precio = precioActual + precioCopa;
        }
        else {
            var precio = precioActual - precioCopa;
        }
        $("#precio").val(precio);


    })
});
// Actualizar precio al pulsar cafe

$(document).ready(function () {
    $("#cafe").click(function (ev) {
        var precioActual = parseFloat($("#precio").val());
        var precioCopa = parseFloat($("#cafe").val());

        if ($("#cafe").is(':checked')) {
            var precio = precioActual + precioCopa;
        }
        else {
            var precio = precioActual - precioCopa;
        }
        $("#precio").val(precio);


    })
});

