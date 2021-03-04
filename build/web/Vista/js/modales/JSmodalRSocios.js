/* global fetch */

function rellenarmodal() {
    datos = new FormData();
    datos.append("accion", "editarSocio");
    datos.append("id_comunero", id_comunero);
    fetch(controlador, {
        method: 'POST',
        body: datos
    }).then(res => res.json())
            .then(data => {
                if (data.error === 'error') {
                    swal("¡Error!", "No se a podido cargar lo datos", "error");
                } else if (data.cedula.length > 0) {
                    //asiganmos los datos a una variable global para almacenar los datos obtenidos del servidor y poder usarlos en todo el documento js
                    json_comunero = data;
                    cargarmodal();

                }
            });
}
;
/*Esta funcion se encarga de mostrar el modal y rellenar*/
function mostrarModal() {
    $('#staticBackdrop').modal("show");
    var refFRMRegEdit = document.getElementById("frmRESocios");
    var ref_input = refFRMRegEdit.querySelectorAll('input');
    /*obtenemos todos los selects que esten dentro del formulario con el id frmRESocios*/
    var ref_select = document.getElementById("frmRESocios").querySelectorAll('select');
    if (!json_comunero) {
        //con esto obtenemos el valor de la cookie comunidad
        var cookieValor = document.cookie.replace(/(?:(?:^|.*;\s*)comunidad\s*\=\s*([^;]*).*$)|^.*$/, "$1");
        ref_input[8].value = cookieValor;
        rellenarListaTipoUsuario(ref_select[0], "");
        accion = "Guardar";
    } else if (json_comunero) {
        ref_input[0].value = json_comunero.cedula;
        ref_input[1].value = json_comunero.primer_nombre;
        ref_input[2].value = json_comunero.segundo_nombre;
        ref_input[3].value = json_comunero.primer_apellido;
        ref_input[4].value = json_comunero.segundo_apellido;
        ref_input[5].value = json_comunero.telefono;
        ref_input[6].value = json_comunero.direccion_vivienda;
        ref_input[7].value = json_comunero.referencia_geografica;
        ref_input[8].value = json_comunero.nombre_comuna;
        ref_input[9].value = json_comunero.fecha_nacimiento;
        ref_input[10].value = json_comunero.edad;
        ref_input[11].value = json_comunero.usuario;
        ref_input[12].value = json_comunero.contrasenia;

        if (json_comunero.contrasenia) {
            ref_input[12].value = json_comunero.contrasenia;

        } else {
            ref_input[12].value = "";
        }
        if (json_comunero.usuario) {

            ref_input[11].value = json_comunero.usuario;

        } else {
            ref_input[11].value = "";
        }

        if (json_comunero.pk_tipousuario !== 0) {
            rellenarListaTipoUsuario(ref_select[0], json_comunero.pk_tipousuario);
        } else if (json_comunero.pk_tipousuario <= 0) {
            rellenarListaTipoUsuario(ref_select[0], "");
        }
        json_comunero = null;
        accion = "Actualizar";
    }
    refFRMRegEdit.addEventListener("submit", GuardarActualizarEliminarSocio);
}
;

function rellenarListaTipoUsuario(HTMLSelectElement, pk_tipousuario) {
    datos = new FormData();
    datos.append("accion", "listarTipoUsuarios");
    fetch(controlador, {
        method: 'POST',
        body: datos
    }).then(res => res.json())
            .then(data => {
                HTMLSelectElement.innerHTML = '';
                HTMLSelectElement.innerHTML = `<option selected disabled value="">Seleccione una opcion</option>`;
                //recorremos el json para rellenar la lista de opciones
                for (let item of data) {
                    if (item.error === "error") {
                        swal("Good job!", "You clicked the button!", "error");
                        break;
                    } else if (item.tipo_usuario.length > 0) {
                        HTMLSelectElement.innerHTML += `<option value="${item.pk_tipousuario}">${item.tipo_usuario}</option>`;
                    }
                }
                HTMLSelectElement.value = pk_tipousuario;
            });

}
;

function GuardarActualizarEliminarSocio(e) {
    var refFRMRegEdit = document.getElementById("frmRESocios");
    var datos;
    if (accion !== "Eliminar") {
        e.preventDefault();
        datos = new FormData(refFRMRegEdit);
    } else {
        datos = new FormData();
    }
    datos.append("accion", accion);
    datos.append("pk_comuner", id_comunero);

    fetch(controlador, {
        method: 'POST',
        body: datos
    }).then(response => response.json())
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
            })
            .then(response => {
                if (response.message === "Completado") {

                    swal("¡Accion completada con exito!", {
                        icon: "success",
                        timer: 2000,
                        button: {
                            text: "Aceptar"
                        }
                    });
                    $('#contenido').load(dir_tbltabla, llenarDatatable());
                } else if (response.message === "Error") {
                    if (accion === "Guardar") {
                        swal("¡Accion no completada!", "No se a podido guardar los datos correctamente", {
                            icon: "error",
                            dangerMode: true,
                            timer: 5000,
                            button: {
                                text: "Cerrar"
                            }
                        });

                    } else if (accion === "Actualizar") {
                        swal("¡Accion no completada!", "No se a podido actualizar los datos correctamente", {
                            icon: "error",
                            dangerMode: true,
                            timer: 5000,
                            button: {
                                text: "Cerrar"
                            }
                        });
                    } else if (accion === "Eliminar") {
                        /*aqui se ejecuta cualquier cosa en caso de aber dado en aceptar */
                        swal("¡Accion no completada!", "No se ha podido eliminar los registros", {
                            dangerMode: true,
                            icon: "error",
                            timer: 5000,
                            button: {
                                text: "Aceptar"
                            }
                        });

                    }

                }
            });
}
;
