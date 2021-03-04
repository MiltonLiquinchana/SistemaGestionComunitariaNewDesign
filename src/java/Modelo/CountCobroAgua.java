/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

/*esta clase sirve para poder acceder a un conteo de los pago de agua que se han echo dependiendo de eso se colocara como numero de factura*/
public class CountCobroAgua {

    private int num_factura;

    public CountCobroAgua() {
    }

    public CountCobroAgua(int num_factura) {
        this.num_factura = num_factura;
    }

    public int getNum_factura() {
        return num_factura;
    }

    public void setNum_factura(int num_factura) {
        this.num_factura = num_factura;
    }


}
