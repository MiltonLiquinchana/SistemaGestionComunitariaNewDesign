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
        text: '<img src="../icons/tablas/sobresalir.svg" alt="excel" width="17px" height="17px">',
        titleAttr: 'Exportar a Excel',
        className: 'btn btn-success'
    },
    {
        extend: 'pdfHtml5',
        text: ' <img src="../icons/tablas/documento.svg" alt="pdf" width="16px" height="16px">',
        titleAttr: 'Exportar a PDF',
        className: 'btn btn-danger'
    },
    {
        extend: 'print',
        text: ' <img src="../icons/tablas/impresion.svg" alt="print" width="16px" height="16px">',
        titleAttr: 'Imprimir',
        className: 'btn btn-info'
    }
];
var json_comunero;
var datos;
var accion;//esta variable nos sirve para asignar una accion de guardar o actualizar o eliminar
var id_comunero;
function llenarDatatable() {
    datos = new FormData();
    datos.append("accion", "cargarSocios");
    fetch(controlador, {
        method: 'POST',
        body: datos
    }).then(res => res.json())
            .then(data => {
                //ejecutamos la funcion para cargar el jquery datatable para que se aplique esta funcionalidad    
                var cuerportable = document.getElementById("cuerpo");
                cuerportable.innerHTML = '';
                for (let item of data) {
                    if (item.error === "error") {
                        swal("¡Registros no encontrados!", "Registre un nuevo usuario", {
                            icon: "info",
                            dangerMode: true,
                            timer: 5000,
                            button: {
                                text: "Cerrar"
                            }
                        });
                        break;
                    }
                    cuerportable.innerHTML += `<tr>
                <td style="display: none;">${item.pk_comunero}</td>
                <td>
                    <div class="text-center">
                        <!--Boton editar-->
                        <a href="#" class="editar btn btn-warning" role="button" aria-pressed="true"
                           style="width: 30px; height: 30px; padding: 0px; border: 0px; margin: 0px;"> <img
                                src="../icons/tablas/lapiz.svg" alt=""
                                style="width: 20px; height: 20px; padding: 0px; border: 0px; margin: 0px;" id="btn_editarR"> </a>
                        <!--boton eliminar-->
                        <a href="#" class="eliminar btn btn-danger" role="button" aria-pressed="true"
                           style="width: 30px; height: 30px; padding: 0px; border: 0px; margin: 0px;" id="btn_eliminarR"> <img
                                src="../icons/tablas/basura.svg" alt=""
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
    /*obtenemos los nuevos elementos para asignarle eventos*/
    var btn_Registrarnuevo = document.getElementById("btn_Registrarnuevo");//boton que se carga con la tabla Agregar Nuevo
    btn_Registrarnuevo.addEventListener("click", cargarmodal);//evento click del boton nuevo  de la tabla
}
;

function cargarDatatable() {
    /*agregamos nuestra tabla(el id de la tabla) a una variable */
    var table = $('#example').DataTable({
        destroy: true, //para que al editar o eliminar no me de problemas de inicializacion de tabla
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
}

var obtener_data = function (tbody, table) {
    $(tbody).on("click", "a.eliminar", function () {
        var data = table.row($(this).parents("tr")).data();
        id_comunero = data[0];
        preguntarsino();
    });
    $(tbody).on("click", "a.editar", function () {
        var data = table.row($(this).parents("tr")).data();
        id_comunero = data[0];
        rellenarmodal();
    });
};
function cargarmodal() {
    $('#modales').load(dir_mdmodalRegistro, mostrarModal);
}
/*aqui le decimos que cuando aga click en el boton nuevo no agrege el 
 modal al div respectivo, que luego nos ejecute una funcion llamada mostrarModal*/



function preguntarsino() {
    swal({
        title: "¿Estas Seguro?",
        text: "¡Esta persona ya no se tomara en cuenta para las demas actividades!",
        icon: "warning",
        dangerMode: true,
        buttons: ["Cancelar", "Confirmar"]
    })
            .then((willDelete) => {
                if (willDelete) {
                    accion = "Eliminar";
                    GuardarActualizarEliminarSocio();
                }
            });
}
;