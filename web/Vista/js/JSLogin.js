/* global fetch */

window.addEventListener("load", incioLogin);
function incioLogin(e) {
    e.preventDefault();
    fetch('Controles').then(res => res.json())
            .then(data =>
            {
                if (data.error === 'error') {
                    var formulario = document.getElementById("formularie");
                    formulario.addEventListener('submit', mostrar);
                    console.log(data);
                } else if (data.usuario.length > 0) {
                    //document.cookie="username="+data.usuario;
                    window.location.href = "Vista/PaginaPrincipal.html";
                   console.log(data);
                }
            }
            );
}

function mostrar(e) {
    var formularioo = document.getElementById("formularie");
    e.preventDefault();
    var datos = new FormData(formularioo);
    fetch('Controles?accion=IniciarSesion&user=' + datos.get('user') + "&passw=" + datos.get('passw'), {
        method: 'POST'
    }).then(res => res.json())
            .then(data => {
                //document.cookie="username="+data.usuario;
                window.location.href = "Vista/PaginaPrincipal.html";
               console.log(data);
            });
            
}


