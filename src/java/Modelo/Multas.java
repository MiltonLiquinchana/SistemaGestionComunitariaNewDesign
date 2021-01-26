
package Modelo;

public class Multas {
    private int pk_multas;
    private String tipo_multa;
    private Double valor;
    private Comuna comuna;//este sirve en ves de el fk de comuna es decir que si se ase una consulta este se hace mediante el fk

    public Multas() {
    }

    public Multas(int pk_multas, String tipo_multa, Double valor, Comuna comuna) {
        this.pk_multas = pk_multas;
        this.tipo_multa = tipo_multa;
        this.valor = valor;
        this.comuna = comuna;
    }

    public int getPk_multas() {
        return pk_multas;
    }

    public void setPk_multas(int pk_multas) {
        this.pk_multas = pk_multas;
    }

    public String getTipo_multa() {
        return tipo_multa;
    }

    public void setTipo_multa(String tipo_multa) {
        this.tipo_multa = tipo_multa;
    }

    public Double getValor() {
        return valor;
    }

    public void setValor(Double valor) {
        this.valor = valor;
    }

    public Comuna getComuna() {
        return comuna;
    }

    public void setComuna(Comuna comuna) {
        this.comuna = comuna;
    }
}
