var ref_input = document.querySelectorAll('input');
window.addEventListener("load", inicioJsFactura);
function inicioJsFactura() {
    var cookieValor = document.cookie.replace(/(?:(?:^|.*;\s*)consumo\s*\=\s*([^;]*).*$)|^.*$/, "$1");
    var data = new FormData();
    data.append("accion", "buscarDatosFactura");
    data.append("pk_consumo", cookieValor);
    fetch(controlador, {
        method: "POST",
        body: data
    })
            .then((res) => res.json())
            .catch((error) => {
                console.error("Error:", error);
            })
            .then((response) => {
                console.log(response);
                var numeracion = "0000000";/*1000000 */
                var acumulador = "";
                var contador = 0;
                var lengnumeracion = numeracion.length;
                var lengpk = response.num_factura.toString().length;
                var resta = lengnumeracion - lengpk;
                while (resta !== contador) {
                    acumulador = acumulador + "0";
                    contador++;
                }
                ref_input[0].value = acumulador + response.num_factura;
                ref_input[2].value = response.primer_apellido + " " + response.segundo_apellido + " " + response.primer_nombre + " " + response.segundo_nombre;
                var fecha = new Date();
                var anio, mes, dia;
                anio = fecha.getFullYear();
                mes = fecha.getMonth() + 1;
                dia = fecha.getDate();
                if (dia < 10) {
                    dia = '0' + dia;
                } //agrega cero si el menor de 10
                if (mes < 10) {
                    mes = '0' + mes;
                } //agrega cero si el menor de 10
                ref_input[3].value = anio + "-" + mes + "-" + dia;
                ref_input[4].value = response.cedula;
                ref_input[5].value = response.direccion_vivienda;
                ref_input[6].value = response.telefono;
                ref_input[7].value = response.numero_medidor;
                ref_input[8].value = response.fecha_lectura;
                ref_input[9].value = response.fecha_limite_pago;
                ref_input[10].value = response.lectura_anterior;
                ref_input[11].value = response.lectura_actual;
                ref_input[12].value = response.tipo_consumo;
                ref_input[13].value = response.consumo_mcubico;
                ref_input[14].value = response.tarifa_basicaC;
                ref_input[15].value = response.subtotal;
                ref_input[16].value = response.tarifa_ambienteC;
                ref_input[17].value = response.alcantarilladoC;
                ref_input[18].value = response.tipo_multa;
                ref_input[19].value = response.dias_retraso;
                ref_input[20].value = response.total_multa;
                ref_input[21].value = response.totalpagar;
                ref_input[22].value = response.totalpagar;
                ref_input[23].value = response.deposito;
                ref_input[24].value = response.cambio;
                window.print();
            });
}
