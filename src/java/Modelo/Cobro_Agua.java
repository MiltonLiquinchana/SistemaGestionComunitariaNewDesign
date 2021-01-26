package Modelo;

import java.util.Date;

public class Cobro_Agua {

    private int pk_cobro_agua;
    private Consumo consumo;
    private Date fecha_cacelacion;
    private String dias_retraso;
    private Multas multas;
    private Double valor_multa;
    private Double totalpagar;
    private EstadoPagos estadopagos;

    public Cobro_Agua() {
    }

    public Cobro_Agua(int pk_cobro_agua, Consumo consumo, Date fecha_cacelacion, String dias_retraso, Multas multas, Double valor_multa, Double totalpagar, EstadoPagos estadopagos) {
        this.pk_cobro_agua = pk_cobro_agua;
        this.consumo = consumo;
        this.fecha_cacelacion = fecha_cacelacion;
        this.dias_retraso = dias_retraso;
        this.multas = multas;
        this.valor_multa = valor_multa;
        this.totalpagar = totalpagar;
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

    public String getDias_retraso() {
        return dias_retraso;
    }

    public void setDias_retraso(String dias_retraso) {
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

    public EstadoPagos getEstadopagos() {
        return estadopagos;
    }

    public void setEstadopagos(EstadoPagos estadopagos) {
        this.estadopagos = estadopagos;
    }

}
