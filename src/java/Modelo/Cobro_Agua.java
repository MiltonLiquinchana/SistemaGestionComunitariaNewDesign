package Modelo;

import java.util.Date;

public class Cobro_Agua {

    private int pk_cobro_agua;
    private Consumo consumo;
    private Date fecha_cacelacion;
    private int dias_retraso;
    private Multas multas;
    private Double valor_multa;
    private Double totalpagar;
    private Double tarifa_basicaC;
    private Double tarifa_ambienteC;
    private Double alcantarilladoC;
    private Double deposito;
    private Double cambio;
    private EstadoPagos estadopagos;

    public Cobro_Agua() {
    }

    public Cobro_Agua(int pk_cobro_agua, Consumo consumo, Date fecha_cacelacion, int dias_retraso, Multas multas, Double valor_multa, Double totalpagar, Double tarifa_basicaC, Double tarifa_ambienteC, Double alcantarilladoC, Double deposito, Double cambio, EstadoPagos estadopagos) {
        this.pk_cobro_agua = pk_cobro_agua;
        this.consumo = consumo;
        this.fecha_cacelacion = fecha_cacelacion;
        this.dias_retraso = dias_retraso;
        this.multas = multas;
        this.valor_multa = valor_multa;
        this.totalpagar = totalpagar;
        this.tarifa_basicaC = tarifa_basicaC;
        this.tarifa_ambienteC = tarifa_ambienteC;
        this.alcantarilladoC = alcantarilladoC;
        this.deposito = deposito;
        this.cambio = cambio;
        this.estadopagos = estadopagos;
    }

    public int getPk_cobro_agua() {
        return pk_cobro_agua;
    }

    public void setPk_cobro_agua(int pk_cobro_agua) {
        this.pk_cobro_agua = pk_cobro_agua;
    }

    public Consumo getConsumo() {
        return consumo;
    }

    public void setConsumo(Consumo consumo) {
        this.consumo = consumo;
    }

    public Date getFecha_cacelacion() {
        return fecha_cacelacion;
    }

    public void setFecha_cacelacion(Date fecha_cacelacion) {
        this.fecha_cacelacion = fecha_cacelacion;
    }

    public int getDias_retraso() {
        return dias_retraso;
    }

    public void setDias_retraso(int dias_retraso) {
        this.dias_retraso = dias_retraso;
    }

    public Multas getMultas() {
        return multas;
    }

    public void setMultas(Multas multas) {
        this.multas = multas;
    }

    public Double getValor_multa() {
        return valor_multa;
    }

    public void setValor_multa(Double valor_multa) {
        this.valor_multa = valor_multa;
    }

    public Double getTotalpagar() {
        return totalpagar;
    }

    public void setTotalpagar(Double totalpagar) {
        this.totalpagar = totalpagar;
    }

    public Double getTarifa_basicaC() {
        return tarifa_basicaC;
    }

    public void setTarifa_basicaC(Double tarifa_basicaC) {
        this.tarifa_basicaC = tarifa_basicaC;
    }

    public Double getTarifa_ambienteC() {
        return tarifa_ambienteC;
    }

    public void setTarifa_ambienteC(Double tarifa_ambienteC) {
        this.tarifa_ambienteC = tarifa_ambienteC;
    }

    public Double getAlcantarilladoC() {
        return alcantarilladoC;
    }

    public void setAlcantarilladoC(Double alcantarilladoC) {
        this.alcantarilladoC = alcantarilladoC;
    }

    public Double getDeposito() {
        return deposito;
    }

    public void setDeposito(Double deposito) {
        this.deposito = deposito;
    }

    public Double getCambio() {
        return cambio;
    }

    public void setCambio(Double cambio) {
        this.cambio = cambio;
    }

    public EstadoPagos getEstadopagos() {
        return estadopagos;
    }

    public void setEstadopagos(EstadoPagos estadopagos) {
        this.estadopagos = estadopagos;
    }

}
