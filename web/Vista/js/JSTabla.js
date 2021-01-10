/* global fetch, swal */

var languageSpanish = {
    "sProcessing": "Procesando...",
    "sLengthMenu": "Mostrar _MENU_ registros",
    "sZeroRecords": "No se encontraron resultados",
    "sEmptyTable": "Ningún dato disponible en esta tabla",
    "sInfo": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
    "sInfoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
    "sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
    "sInfoPostFix": "",
    "sSearch": "Buscar:",
    "sUrl": "",
    "sInfoThousands": ",",
    "sLoadingRecords": "Cargando...",
    "oPaginate": {
        "sFirst": "Primero",
        "sLast": "Último",
        "sNext": "Siguiente",
        "sPrevious": "Anterior"
    },
    "oAria": {
        "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
        "sSortDescending": ": Activar para ordenar la columna de manera descendente"
    },
    "buttons": {
        "copy": "Copiar",
        "colvis": "Visibilidad"
    }
}
var btnsstyleepi = [
    {
        extend: 'excelHtml5',
        text: '<img src="img/icon table/sobresalir.svg" alt="excel" width="17px" height="17px">',
        titleAttr: 'Exportar a Excel',
        className: 'btn btn-success'
    },
    {
        extend: 'pdfHtml5',
        text: ' <img src="img/icon table/documento.svg" alt="pdf" width="16px" height="16px">',
        titleAttr: 'Exportar a PDF',
        className: 'btn btn-danger'
    },
    {
        extend: 'print',
        text: ' <img src="img/icon table/impresion.svg" alt="print" width="16px" height="16px">',
        titleAttr: 'Imprimir',
        className: 'btn btn-info'
    }
];
var id_comunero;
var json_comunero;
function llenarDatatable() {

    fetch('../Controles?accion=cargarSocios', {
        method: 'POST'
    }).then(res => res.json())
            .then(data => {
                //ejecutamos la funcion para cargar el jquery datatable para que se aplique esta funcionalidad    
                var cuerportable = document.getElementById("cuerpo");
                cuerportable.innerHTML = '';
                for (let item of data) {
                    if (item.error === "error") {
                        console.log("verifique el dato enviado");
                        break;
                    }
                    cuerportable.innerHTML += `<tr>
                <td style="display: none;">${item.pk_comunero}</td>
                <td>
                    <div class="text-center">
                        <!--Boton editar-->
                        <a href="#" class="editar btn btn-warning" role="button" aria-pressed="true"
                           style="width: 30px; height: 30px; padding: 0px; border: 0px; margin: 0px;"> <img
                                src="./img/icon table/lapiz.svg" alt=""
                                style="width: 20px; height: 20px; padding: 0px; border: 0px; margin: 0px;" id="btn_editarR"> </a>
                        <!--boton eliminar-->
                        <a href="#" class="eliminar btn btn-danger" role="button" aria-pressed="true"
                           style="width: 30px; height: 30px; padding: 0px; border: 0px; margin: 0px;" id="btn_eliminarR"> <img
                                src="./img/icon table/basura.svg" alt=""
                                style="width: 20px; height: 20px; padding: 0px; border: 0px; margin: 0px;"> </a>
                    </div>
                </td>
                <td>${item.cedula}</td>
                <td>${item.primer_nombre} ${item.segundo_nombre} ${item.primer_apellido} ${item.segundo_apellido}</td>
                <td>${item.telefono}</td>
                <td>${item.edad}</td>
            </tr> `;
                }
                cargarDatatable();

            });

}
;

function cargarDatatable() {
    /*agregamos nuestra tabla(el id de la tabla) a una variable */
    var table = $('#example').DataTable({
        /*estas de info y padding en false tienen que estar por que si no me pone esa funcionalidad */
        "paging": false,
        "info": false,
        "language": languageSpanish,
        /*elementos filtrado etc */
        dom: 'fBrt',
        /*botones de impresion etc */
        buttons: btnsstyleepi
    });
    obtener_data("#example tbody", table);
    /*obtenemos los nuevos elementos para asignarle eventos*/
    var btn_Registrarnuevo = document.getElementById("btn_Registrarnuevo");//boton que se carga con la tabla Agregar Nuevo

    btn_Registrarnuevo.addEventListener("click", cargarmodal);//evento click del boton nuevo  de la tabla
}

var obtener_data = function (tbody, table) {
    $(tbody).on("click", "a.eliminar", function () {
        preguntarsino();
    });
    $(tbody).on("click", "a.editar", function () {
        var data = table.row($(this).parents("tr")).data();
        id_comunero = data[0];
        rellenarmodal();
    });
};
function cargarmodal() {
    $('#modales').load("TablaProyectoAguaJquery/modalRegistro.html", mostrarModal);
}
/*aqui le decimos que cuando aga click en el boton nuevo no agrege el 
 modal al div respectivo, que luego nos ejecute una funcion llamada mostrarModal*/
function rellenarmodal() {
    fetch('../Controles?accion=editarSocio&id_comunero=' + id_comunero, {
        method: 'POST'
    }).then(res => res.json())
            .then(data => {
                if (data.error === 'error') {
                    swal("Good job!", "You clicked the button!", "error");
                } else if (data.cedula.length > 0) {
                    //asiganmos los datos a una variable global para almacenar los datos objenidos del servidor y poder usarlos en todo el documento js
                    json_comunero = data;
                    cargarmodal();
                    //$('#modales').load("TablaProyectoAguaJquery/modalRegistro.html", mostrarModal);
                }
            });

}
;

/*Esta funcion se encarga de mostrar el modal y rellenar*/
function mostrarModal() {
    $('#staticBackdrop').modal();
    var btn_guardar = document.getElementById("btn_guardarSoc");
    var ref_input = document.getElementById("frmRESocios").querySelectorAll('input');
    if (!json_comunero) {
        /*obtenemos todos los selects que esten dentro del formulario con el id frmRESocios*/
        var ref_select = document.getElementById("frmRESocios").querySelectorAll('select');
        rellenarListaTipoUsuario(ref_select[0], "");
    } else if (json_comunero) {
        var ref_select = document.getElementById("frmRESocios").querySelectorAll('select');
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
        if (json_comunero.pk_tipousuario !== 0) {
            rellenarListaTipoUsuario(ref_select[0], json_comunero.pk_tipousuario);
        } else if (json_comunero.pk_tipousuario <= 0) {
            rellenarListaTipoUsuario(ref_select[0], "");
        }
        json_comunero = null;
    }
    btn_guardar.addEventListener("click", guardarSocio);
}
;

function rellenarListaTipoUsuario(HTMLSelectElement, pk_tipousuario) {
    //e.preventDefault();
    fetch('../Controles?accion=listarTipoUsuarios', {
        method: 'POST'
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

function guardarSocio() {
    swal("¡Accion completada con exito!", {
        icon: "success",
    });
}
;

function preguntarsino() {
    swal({
        title: "¿Estas Seguro?",
        text: "¡Esta opcion eliminara todo registro referente a esta persona!",
        icon: "warning",
        dangerMode: true,
        buttons: ["Cancelar", "Confirmar"],
    })
            .then((willDelete) => {
                if (willDelete) {
                    /*aqui se ejecuta cualquier cosa en caso de aber dado en aceptar */
                    swal("¡Accion completada con exito!", {
                        icon: "success",
                        timer: 2000,
                        buttons: false,
                    });
                } else {
                    swal("¡La accion se a cancelado!", {
                        icon: "info",
                        timer: 2000,
                        buttons: false,
                    });

                }
            });
}
;