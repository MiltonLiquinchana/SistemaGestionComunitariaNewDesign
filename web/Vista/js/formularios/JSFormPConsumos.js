/* global fetch */
var ref_form, ref_input, ref_select, datos;
function inicioJsFormPConsumos() {
    var btn_search = document.getElementById("btnPC_buscarConsumo");
    btn_search.addEventListener("click", search_frmRconsumos);
    ref_form = document.getElementById("frmRPConsumo");//obtenemos referencia del formulario
    ref_form.addEventListener("submit", guardarPagoConsumo);
    //agregamos un evento al select de medidor para que detecte si sucede algun cambio en su valor
    ref_select = ref_form.querySelectorAll('select');//seleccionamos todos los select del formulario
    ref_input = ref_form.querySelectorAll('input');//seleccionamos todos los input del formulario
    //asignamos un evento al select para que detecte cuando haya un cambio en su valor
    ref_select[0].addEventListener("change", listarConsumosInpaga);
    ref_select[1].addEventListener("change", buscarDatosConsumoImpaga);
    ref_input[16].addEventListener("input", calcularCambio);
    ref_input[19].addEventListener("click", imprimirFactura);
    ref_input[20].addEventListener("click", limpiarFormPConsumo);
    var fecha = new Date();
    var anio = fecha.getFullYear();
    var mes = fecha.getMonth() + 1;
    var dia = fecha.getDate();
    if (dia < 10) {
        dia = '0' + dia;
    } //agrega cero si el menor de 10
    if (mes < 10) {
        mes = '0' + mes;
    } //agrega cero si el menor de 10
    ref_input[7].value = anio + "-" + mes + "-" + dia;
}
function listarConsumosInpaga() {
    datos = new FormData();
    datos.append("accion", "ListConsumoImpaga");
    datos.append("fk_medidor", ref_select[0].value);
    fetch(controlador, {
        method: "POST",
        body: datos
    }).then(res => res.json()).catch(error => {
        swal("¡Error!", "Ocurrió un error mientras se procesaba la solicitud. Vuelve a intentarlo más tarde", {
            icon: "error",
            dangerMode: true,
            timer: 5000,
            button: {
                text: "Cerrar"
            }
        });
        console.error('Error:', error);
    }).then(response => {
        ref_select[1].innerHTML = '';
        ref_select[1].innerHTML = `<option selected disabled value="">Seleccione un consumo</option>`;
        for (let item of response) {
            if (item.error) {
                swal("¡Registros no encontrados!", "A la actualidad no tiene deudas", {
                    icon: "success",
                    timer: 10000,
                    button: {
                        text: "Aceptar"
                    }
                });
                break;
            } else {
                const event = new Date(item.fecha_lectura);
                const options = {month: 'long'};
                var anio = event.getFullYear();
                var mes = event.getMonth() + 1;
                var dia = event.getDate();
                if (dia < 10) {
                    dia = '0' + dia;
                } //agrega cero si el menor de 10
                if (mes < 10) {
                    mes = '0' + mes;
                } //agrega cero si el menor de 10
                ref_select[1].innerHTML += `<option  value="${item.pk_consumo}">${convfirstLetterMayus(event.toLocaleDateString(undefined, options).toLowerCase()) + " " + anio}</option>`;
            }
        }
    });
}
function convfirstLetterMayus(string) {
    /*extrams la primera letra de la cadena y la convertimos a mayuscula, seguido
     * con slice tomamos el valor de la cadena empezando desde el indece  1*/
    return string.charAt(0).toUpperCase() + string.slice(1);
}
function buscarDatosConsumoImpaga() {
    datos = new FormData();
    datos.append("accion", "buscarDatosConsumoImpaga");
    datos.append("fkconsumo", ref_select[1].value);
    fetch(controlador, {
        method: "POST",
        body: datos
    }).then(res => res.json()).catch(error => {
        swal("¡Error!", "No se pudo conectar al servidor", {
            icon: "error",
            dangerMode: true,
            timer: 10000,
            button: {
                text: "Cerrar"
            }
        });
        console.error("Error:", error);
    }).then(response => {
        if (response.error) {
            swal("¡No se a encontrado registros!", "Ocurrio un problema mientras se procesaba la peticion", {
                icon: "warning",
                dangerMode: true,
                timer: 10000,
                button: {
                    text: "Cerrar"
                }
            });
        } else {
            ref_input[3].value = response.consumo_mcubico;
            ref_input[4].value = response.tipo_consumo;
            ref_input[5].value = response.fecha_lectura;
            ref_input[6].value = response.fecha_limite_pago;
            ref_input[8].value = response.subtotal;
            ref_input[9].value = response.tipo_multa;
            ref_input[10].value = response.valor_multa;
            ref_input[11].value = calculardiasRetraso(response.fecha_limite_pago);/*hay que calcular*/
            ref_input[12].value = response.valor_multa * calculardiasRetraso(response.fecha_limite_pago);/*hay que calcular*/
            ref_input[13].value = response.tarifa_ambiente;
            ref_input[14].value = response.alcantarillado;
            ref_input[15].value = (parseFloat(response.subtotal) + parseFloat(ref_input[12].value) + parseFloat(ref_input[13].value) + parseFloat(ref_input[14].value)).toFixed(2);/*calculamos el total a pagar*/
        }
    });
}
function calculardiasRetraso(fechainicial) {
    var fechaini = new Date(fechainicial);
    var fechaactual = new Date();
    var dias;
    if (fechaactual > fechaini) {
        var transcurso = fechaactual.getTime() - fechaini.getTime();
        dias = parseInt(transcurso / (1000 * 60 * 60 * 24));
//        console.log(parseInt(transcurso / (1000 * 60 * 60 * 24)));//es lo mismo que hacer abajo por separado
    } else if (fechaactual <= fechaini) {
        dias = 0;
//        console.log("no hay dias de retraso");
    }
    return dias;
}
function calcularCambio() {
    var cambio = (parseFloat(ref_input[16].value) - parseFloat(ref_input[15].value)).toFixed(2);
    ref_input[17].value = cambio;
}
function guardarPagoConsumo(e) {
    e.preventDefault();
    datos = new FormData(ref_form);
    datos.append("accion", "guardarDatosPagoConsumo");
    fetch(controlador, {
        method: "POST",
        body: datos
    }).then(res => res.json()).catch(error => {
        swal("¡Error!", "Ocurrio un problema mientras se procesaba la peticion", {
            icon: "error",
            dangerMode: true,
            timer: 5000,
            button: {
                text: "Cerrar"
            }
        });
        console.error('Error:', error);
    }).then(response => {
        if (response.message === "Completado") {
            document.cookie = "consumo=" + ref_select[1].value+";path=/SistemaGestionComunitariNEW;";
            swal("¡Accion completada con exito!", {
                icon: "success",
                timer: 2000,
                button: {
                    text: "Aceptar"
                }
            });
        } else if (response.message === "Error") {
            swal("¡Accion no completada!", "No se a podido guardar los datos correctamente", {
                icon: "error",
                dangerMode: true,
                timer: 5000,
                button: {
                    text: "Cerrar"
                }
            });
        }
    });
}
function limpiarFormPConsumo() {
    ref_input[0].value = "";
    ref_input[1].value = "";
    ref_input[2].value = "";
    ref_input[3].value = "";
    ref_input[4].value = "";
    ref_input[5].value = "";
    ref_input[6].value = "";
    ref_input[8].value = "";
    ref_input[9].value = "";
    ref_input[10].value = "";
    ref_input[11].value = "";
    ref_input[12].value = "";
    ref_input[13].value = "";
    ref_input[14].value = "";
    ref_input[15].value = "";
    ref_input[16].value = "";
    ref_input[17].value = "";
    ref_select[0].innerHTML = '';
    ref_select[0].innerHTML = `<option selected disabled >Seleccione un medidor</option>`;
    ref_select[1].innerHTML = '';
    ref_select[1].innerHTML = `<option selected disabled >Selecione un consumo</option>`;
}
function imprimirFactura() {
    
    window.open(dir_facfactura);

}
//    console.log("Tiempo transcuros: " + transcurso);
//    var segundos = transcurso / 1000;    // var diff = fechaactual - fechali;
//    console.log("segundos: " + segundos);
//    var minutos = segundos / 60;
//    console.log("minutos: " + minutos);
//    var hora = minutos / 60;
//    console.log("hora: " + hora);
//    var dia = hora / 24;
//    console.log("dia: " + parseInt(dia));