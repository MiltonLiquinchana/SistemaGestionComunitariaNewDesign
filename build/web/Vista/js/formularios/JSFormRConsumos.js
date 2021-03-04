/* global fetch, swal */
var ref_form, ref_input, ref_select, datos;
function inicioJsFormRConsumos() {
    var btn_search = document.getElementById("btnRC_buscarConsumo");
    btn_search.addEventListener("click", search_frmRconsumos);
    ref_form = document.getElementById("frmREConsumo");//obtenemos referencia del formulario
    ref_form.addEventListener("submit", guardarConsumo);
    //agregamos un evento al select de medidor para que detecte si sucede algun cambio en su valor
    ref_select = ref_form.querySelectorAll('select');//seleccionamos todos los select del formulario
    ref_input = ref_form.querySelectorAll('input');//seleccionamos todos los input del formulario
    //asignamos un evento al select para que detecte cuando haya un cambio en su valor
    ref_select[0].addEventListener("change", buscarUltimoConsumo);
    // ref_input[4].addEventListener("change", calcular);
    ref_input[4].addEventListener("blur", calcular);
    ref_input[4].addEventListener("blur", listarTipoConsumo);
    ref_input[10].addEventListener("click", limpiarFormRConsumos);
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
    ref_input[6].value = anio + "-" + mes + "-" + dia;
    cargarlimiteDias();
}
function search_frmRconsumos() {
    //creamos un objeto para alacenar la accion y el dato a enviar al servlet
    datos = new FormData();
    datos.append("accion", "buscarSocioConsumo");
    datos.append("dato", ref_input[0].value);
    //obtenemos una referencia del formulario
    fetch(controlador, {
        method: 'POST',
        body: datos
    }).then(res => res.json())
            .catch(error => {
                swal("¡Error!", "Ocurrió un error mientras se procesaba la solicitud. Vuelve a intentarlo más tarde", {
                    icon: "error",
                    dangerMode: true,
                    timer: 5000,
                    button: {
                        text: "Cerrar"
                    }
                });
                console.error('Error:', error);
            })
            .then(response => {
                console.log(response);
                if (response[0].error) {
                    swal("¡Registro no encontrado!", "1.-Intente por el numero de cedula\n\
                            2.-Verifique el criterio de busqueda\n\
                            3.-Verifique que la persona se encuentre registrada\n\
                            4.-Verifique que la persona tenga minimo un medidor", {
                        icon: "info",
                        dangerMode: true,
                        timer: 10000,
                        button: {
                            text: "Cerrar"
                        }
                    });
                } else if (!response[0].error) {
                    
                    //primero agregamos lo obtenido en la posicion 0 a el formulario
                    ref_input[1].value = response[0].cedula;
                    ref_input[2].value = response[0].primer_nombre + " " + response[0].segundo_nombre + " " + response[0].primer_apellido + " " + response[0].segundo_apellido;
                    response.splice(0, 1);//eliminamos un elemento comensando desde la posicion 0(posicion, numero de elementos)
                    ref_select[0].innerHTML = '';
                    ref_select[0].innerHTML = `<option selected disabled>Seleccione un medidor</option>`;
                    for (let item of response) {
                        ref_select[0].innerHTML += `<option value="${item.pk_medidor}">${item.numero_medidor}</option>`;
                    }
                }
                //
            });
}
function buscarUltimoConsumo() {
    datos = new FormData();
    datos.append("accion", "buscarUltimoConsumo");
    datos.append("pk_medidor", ref_select[0].value);
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
        if (response.error) {
            ref_input[3].value = "0";
            ref_input[4].removeAttribute("disabled");
        } else if (!response.error) {
            ref_input[3].value = response.lectura_anterior;
            ref_input[4].removeAttribute("disabled");
        }
    });
}
function calcular() {
    if (ref_input[4].value === "") {
        swal("¡Advertenia!", "El valor ingresado no es valido", {
            icon: "warning",
            dangerMode: true,
            timer: 5000,
            button: {
                text: "Cerrar"
            }
        });
    } else {
        const  valor4 = parseInt(ref_input[4].value);
        const  valor3 = parseInt(ref_input[3].value);
        if (ref_input[4].value < 10) {
            //valor = "0" + ref_input[4].value;
        }
        if (valor4 < valor3) {
            swal("¡Aviso!", "La lectura actual no puede ser menor a la lectura anterior", {
                icon: "warning",
                dangerMode: true,
                timer: 5000,
                button: {
                    text: "Cerrar"
                }
            });
            ref_input[5].value = "";
            ref_input[8].value = "";
            ref_select[1].innerHTML = '';
            ref_select[1].innerHTML = `<option selected disabled>Selecione un tipo de consumo</option>  `;
        } else if (valor4 === valor3) {
            swal("¡Aviso!", "La lectura y la lectura anterior son iguales", {
                icon: "warning",
                dangerMode: true,
                closeOnClickOutside: false,
                buttons: {
                    cancel: {
                        text: "Cancel",
                        value: "Cancelar",
                        visible: true,
                        className: "",
                        closeModal: true
                    },
                    confirm: {
                        text: "Continuar",
                        value: "Continuar",
                        visible: true,
                        className: "",
                        closeModal: true
                    }
                }
            }).then((value) => {
                switch (value) {

                    case "Cancelar":
                        ref_input[5].value = "";
                        ref_input[8].value = "";
                        ref_select[1].innerHTML = '';
                        ref_select[1].innerHTML = `<option selected disabled>Selecione un tipo de consumo</option>`;
                        break;
                    case "Continuar":
                        ref_input[5].value = ref_input[4].value - ref_input[3].value;
                        listarTipoConsumo();
                        break;
                }
            });
        } else if (valor4 > valor3) {
            ref_input[5].value = ref_input[4].value - ref_input[3].value;
        }
    }

}
function listarTipoConsumo() {
    if (ref_input[5].value !== "") {
        datos = new FormData();
        datos.append("accion", "ListarTipoConsumo");
        datos.append("valor", ref_input[5].value);
        fetch(controlador, {
            method: "POST",
            body: datos
        }).then(res => res.json()).catch(error => {
            swal("¡Advertencia!", "Ocurrió un problema mientras se procesaba la peticion, Vuelva a intentarlo", {
                icon: "warning",
                dangerMode: true,
                timer: 10000,
                button: {
                    text: "Cerrar"
                }
            });
            console.error('Error:', error);
        }).then(response => {
            if (response.error) {
                swal("¡No se a encontrado un tipo de consumo el cual establecer!", "Configure minimo un tipo de consumo en su registro", {
                    icon: "info",
                    dangerMode: true,
                    timer: 10000,
                    button: {
                        text: "Cerrar"
                    }
                });
            } else if (!response.error) {
                ref_select[1].innerHTML = '';
                ref_select[1].innerHTML = `<option disabled>Selecione un tipo de consumo</option>  `;
                //recorremos el json para rellenar la lista de opcione
                ref_select[1].innerHTML += `<option selected value="${response.pk_tipoconsumo}">${response.tipoConsumo}</option>`;
                ref_input[8].value = (response.totalPagar).toFixed(2);
            }
        });
    }
}
function cargarlimiteDias() {
    datos = new FormData();
    datos.append("accion", "buscarFechaLimite");
    fetch(controlador, {
        method: "POST",
        body: datos
    }).then(res => res.json()).catch(error => {
        console.error('Error:', error);
    }).then(response => {
        var fecha = new Date();
        var fechalimite = sumarDias(fecha, response.LimiteDias);
        var anio = fechalimite.getFullYear();
        var mes = fechalimite.getMonth() + 1;
        var dia = fechalimite.getDate();
        if (dia < 10) {
            dia = '0' + dia;
        } //agrega cero si el menor de 10
        if (mes < 10) {
            mes = '0' + mes;
        } //agrega cero si el menor de 10
        ref_input[7].value = anio + "-" + mes + "-" + dia;

    });
}
function sumarDias(fecha, dias) {
    fecha.setDate(fecha.getDate() + dias);
    return fecha;
}
function guardarConsumo(e) {
    e.preventDefault();
    datos = new FormData(ref_form);
    datos.append("accion", "guardarConsumo");
    fetch(controlador, {
        method: "POST",
        body: datos
    }).then(res => res.json())
            .catch(error => {
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
function limpiarFormRConsumos() {
    ref_input[0].value = "";
    ref_input[1].value = "";
    ref_input[2].value = "";
    ref_input[3].value = "";
    ref_input[4].value = "";
    ref_input[4].setAttribute("disabled", "");
    ref_input[5].value = "";
    ref_input[8].value = "";
    ref_select[0].innerHTML = '';
    ref_select[0].innerHTML = `<option selected disabled>Seleccione un medidor</option>`;
    ref_select[1].innerHTML = '';
    ref_select[1].innerHTML = `<option selected disabled>Selecione un tipo de consumo</option>`;
}