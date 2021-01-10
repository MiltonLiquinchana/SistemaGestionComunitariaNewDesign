
function validarfomulario(){
    var radio_cedula=document.forms["mi_form"]["radio_cedula"].checked;
    var buscador= document.getElementsByName("buscador");
   if(radio_cedula==true){
        alert("El elemento a sido seleccionado");
   }
}