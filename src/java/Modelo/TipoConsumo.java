/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

/**
 *
 * @author MiltonLQ
 */
public class TipoConsumo {

    private int pk_tipoconsumo;
    private String tipo_consumo;
    private int limitem_cubico;
    private double valor;
    private double tarifa_basica;
    private double tarifa_ambiente;
    private double alcantarillado;
    private Comuna comuna;

    /*contrucrores*/
    //contructor vacio
    public TipoConsumo() {
    }

    //constructor con parametros
    public TipoConsumo(int pk_tipoconsumo, String tipo_consumo, int limitem_cubico, double valor, double tarifa_basica, double tarifa_ambiente, double alcantarillado, Comuna comuna) {
        this.pk_tipoconsumo = pk_tipoconsumo;
        this.tipo_consumo = tipo_consumo;
        this.limitem_cubico = limitem_cubico;
        this.valor = valor;
        this.tarifa_basica = tarifa_basica;
        this.tarifa_ambiente = tarifa_ambiente;
        this.alcantarillado = alcantarillado;
        this.comuna = comuna;
    }

    /*metodos getters y setters*/
    public int getPk_tipoconsumo() {
        return pk_tipoconsumo;
    }

    public void setPk_tipoconsumo(int pk_tipoconsumo) {
        this.pk_tipoconsumo = pk_tipoconsumo;
    }

    public String getTipo_consumo() {
        return tipo_consumo;
    }

    public void setTipo_consumo(String tipo_consumo) {
        this.tipo_consumo = tipo_consumo;
    }

    public int getLimitem_cubico() {
        return limitem_cubico;
    }

    public void setLimitem_cubico(int limitem_cubico) {
        this.limitem_cubico = limitem_cubico;
    }

    public double getValor() {
        return valor;
    }

    public void setValor(double valor) {
        this.valor = valor;
    }

    public double getTarifa_basica() {
        return tarifa_basica;
    }

    public void setTarifa_basica(double tarifa_basica) {
        this.tarifa_basica = tarifa_basica;
    }

    public double getTarifa_ambiente() {
        return tarifa_ambiente;
    }

    public void setTarifa_ambiente(double tarifa_ambiente) {
        this.tarifa_ambiente = tarifa_ambiente;
    }

    public double getAlcantarillado() {
        return alcantarillado;
    }

    public void setAlcantarillado(double alcantarillado) {
        this.alcantarillado = alcantarillado;
    }

    public Comuna getComuna() {
        return comuna;
    }

    public void setComuna(Comuna comuna) {
        this.comuna = comuna;
    }
}
