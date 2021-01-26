/*una variable para alacenar las traducciones al español*/
/* global fetch */
var submenuno = document.getElementById("subuno");
var submendos = document.getElementById("subdos");
var submentres = document.getElementById("subtres");
var submencuatro = document.getElementById("subcuatro");
var ref_a = document.querySelectorAll('a');//obtenemos todos los elementos a del formulario(solo los del menu)
window.addEventListener("load", inicio);//al terminar de cargar la pagina(La pagina principal)
function inicio() {
    fetch('../Controles').then(res => res.json())
            .then(data =>
            {
                if (data.error === 'error') {
                    window.location.href = "../index.html";
                } else if (data.usuario.length > 0) {
                    ref_a[1].addEventListener("click", mostrartabla);/*le asignamos un evento al boton y lo que tiene que hacer */
                    ref_a[2].addEventListener("click", desplegaruno);
                    ref_a[5].addEventListener("click", desplegardos);
                    ref_a[7].addEventListener("click", mostrarFormRconsumo);
                    ref_a[10].addEventListener("click", desplegartres);
                    ref_a[11].addEventListener("click", mostrarFormRPA);
                    ref_a[14].addEventListener("click", desplegarcuatro);
                    ref_a[18].addEventListener("click", cerrarSesion);
                }
            }
            );
}
;
/*Esta funcion carga la tabla */
function mostrartabla() {
    /*cargamos la tabla a la pagina principal */
    $('#contenido').load("TablaProyectoAguaJquery/tabla.html", llenarDatatable);/* con esto le decimos que al hacer click nos
     carge la tabla al formularo*/
    //en esta funcion tambien se asigna un evento llamado cargarDatatable el cuel se encuentra en otro archivo js, esto para hacerle mas dinamico 
    
}
;
function mostrarFormRconsumo() {
    $('#contenido').load("TablaProyectoAguaJquery/registroConsumo.html", inicioJsFormRConsumos);
}
;
function mostrarFormRPA() {
    $('#contenido').load("TablaProyectoAguaJquery/registroPagoAgua.html",inicioJsFormPConsumos);
}
;

function cerrarSesion(e) {
    e.preventDefault();
    var datos = new FormData();
    datos.append("accion", "CerrarSesion");
    fetch('../Controles', {
        method: 'POST',
        body: datos
    }).then(res => res.json())
            .then(data => {
                if (data.estateLogin === "LogOut") {
                    window.location.href = "../index.html";
                }
            });
}
;

/*estas funciones se encargan de desplegar los submenus */
function desplegaruno() {
    if (submenuno.style.display === "none") {
        submenuno.style.display = "block";
    } else {
        submenuno.style.display = "none";
    }
}
;
function desplegardos() {
    if (submendos.style.display === "none") {
        submendos.style.display = "block";
    } else {
        submendos.style.display = "none";
    }
}
;
function desplegartres() {
    if (submentres.style.display === "none") {
        submentres.style.display = "block";
    } else {
        submentres.style.display = "none";
    }
}
;
function desplegarcuatro() {
    if (submencuatro.style.display === "none") {
        submencuatro.style.display = "block";
    } else {
        submencuatro.style.display = "none";
    }
}
;
/*asi le decimos a javascript que queremos seleccionar un elemento html y lo 
 almacenamos en una constante btnToggle*/
/*const btnToggle= document.querySelector('.togle-btn');//seleccionamos la clase togle-btn del boton como en css
 btnToggle.addEventListener('click',function(){//agregamos lo que va a hacer dentro de una funcion cuando den click
 document.getElementById('sidebar').classList.toggle('active');//obtnemos el id y agregamos una clase con toogle, togle agrega si no tiene o quita si tiene una clase 
 
 })*//*agregamos un evento mejor dicho escuchamos los eventos, para ser especifico escuhamos
  el evento click */
const btnToggle = document.querySelector('.togle-btn');
btnToggle.addEventListener('click', function () {//agregamos lo que va a hacer dentro de una funcion cuando den click
    document.getElementById('contenedormenu').classList.toggle('active');
    document.getElementById('contenedorpaginas').classList.toggle('active');
    document.getElementById('togleBTN').classList.toggle('active');
});

