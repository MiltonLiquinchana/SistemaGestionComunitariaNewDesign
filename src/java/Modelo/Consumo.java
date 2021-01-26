
package Modelo;

public class Consumo {

    private int pk_consumo;
    private String lectura_anterior;
    private String lectura_actual;
    private String fecha_lectura;
    private String fecha_limite_pago;/*Hasta que fecha tiene que pagar sin cargo extra*/
    private int consumo_mcubico;
    private double total_pagar;
    private Medidor medidor;
    private TipoConsumo tipoconsumo;

    //constructores vacios y llenos
    public Consumo() {
    }

    public Consumo(int pk_consumo, String lectura_anterior, String lectura_actual, String fecha_lectura, String fecha_limite_pago, int consumo_mcubico, double total_pagar, Medidor medidor, TipoConsumo tipoconsumo, EstadoPagos estadopagos) {
        this.pk_consumo = pk_consumo;
        this.lectura_anterior = lectura_anterior;
        this.lectura_actual = lectura_actual;
        this.fecha_lectura = fecha_lectura;
        this.fecha_limite_pago = fecha_limite_pago;
        this.consumo_mcubico = consumo_mcubico;
        this.total_pagar = total_pagar;
        this.medidor = medidor;
        this.tipoconsumo = tipoconsumo;
    }

    //metodos getters y setters

    public int getPk_consumo() {
        return pk_consumo;
    }

    public void setPk_consumo(int pk_consumo) {
        this.pk_consumo = pk_consumo;
    }

    public String getLectura_anterior() {
        return lectura_anterior;
    }

    public void setLectura_anterior(String lectura_anterior) {
        this.lectura_anterior = lectura_anterior;
    }

    public String getLectura_actual() {
        return lectura_actual;
    }

    public void setLectura_actual(String lectura_actual) {
        this.lectura_actual = lectura_actual;
    }

    public String getFecha_lectura() {
        return fecha_lectura;
    }

    public void setFecha_lectura(String fecha_lectura) {
        this.fecha_lectura = fecha_lectura;
    }

    public String getFecha_limite_pago() {
        return fecha_limite_pago;
    }

    public void setFecha_limite_pago(String fecha_limite_pago) {
        this.fecha_limite_pago = fecha_limite_pago;
    }

    public int getConsumo_mcubico() {
        return consumo_mcubico;
    }

    public void setConsumo_mcubico(int consumo_mcubico) {
        this.consumo_mcubico = consumo_mcubico;
    }

    public double getTotal_pagar() {
        return total_pagar;
    }

    public void setTotal_pagar(double total_pagar) {
        this.total_pagar = total_pagar;
    }

    public Medidor getMedidor() {
        return medidor;
    }

    public void setMedidor(Medidor medidor) {
        this.medidor = medidor;
    }

    public TipoConsumo getTipoconsumo() {
        return tipoconsumo;
    }

    public void setTipoconsumo(TipoConsumo tipoconsumo) {
        this.tipoconsumo = tipoconsumo;
    }

}
