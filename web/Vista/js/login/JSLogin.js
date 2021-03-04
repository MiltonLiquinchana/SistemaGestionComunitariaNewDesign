/* global fetch */
//agregamos un evento al cargar la pagina
window.addEventListener("load", incioLogin);
function incioLogin() {
    /*mediante fetch hacemos una peticion ajax al servidor
     para comprobar si hay un inicio de secion activo*/
    var datos = new FormData();
    datos.append("accion", "IniciarSesion");
    fetch('Controles',{
        method:"POST",
        body:datos
    }).then(res => res.json())
            .then(data =>
            {
                if (data.error === 'error') {
                    var formulario = document.getElementById("formularie");
                    formulario.addEventListener('submit', mostrar);
                    console.log(data);
                } else if (data.usuario.length > 0) {
                    window.location.href = dir_menuPaginaPrincipal;
                }
            }
            );
}

function mostrar(e) {
    var formularioo = document.getElementById("formularie");
    e.preventDefault();
    var datos = new FormData(formularioo);
    datos.append("accion", "IniciarSesion");
    fetch('Controles', {
        method: 'POST',
        body: datos
    }).then(res => res.json())
            .then(data => {
                window.location.href = dir_menuPaginaPrincipal;
                document.cookie = "comunidad=" + data.nombre_comuna;
                data=null;
            });
}


