/* global fetch */
var ref_form, ref_input, ref_select, datos;
function inicioJsFormPConsumos() {
    var btn_search = document.getElementById("btnPC_buscarConsumo");
    btn_search.addEventListener("click", search_frmRconsumos);
    ref_form = document.getElementById("frmRPConsumo");//obtenemos referencia del formulario
    //agregamos un evento al select de medidor para que detecte si sucede algun cambio en su valor
    ref_select = ref_form.querySelectorAll('select');//seleccionamos todos los select del formulario
    ref_input = ref_form.querySelectorAll('input');//seleccionamos todos los input del formulario
    //asignamos un evento al select para que detecte cuando haya un cambio en su valor
    ref_select[0].addEventListener("change", listarConsumosInpaga);

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
    fetch("../Controles", {
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
        ref_select[1].innerHTML = `<option selected disabled value="">Seleccione el consumo</option>`;
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
