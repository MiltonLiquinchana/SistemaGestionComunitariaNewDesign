package Modelo;

public class Comuna {
    private int pk_comuna;
    private String nombre_comuna;
    private String direccion_comuna;
    private String fk_parroquia;

    public Comuna() {
    }

    public Comuna(int pk_comuna, String nombre_comuna, String direccion_comuna, String fk_parroquia) {
        this.pk_comuna = pk_comuna;
        this.nombre_comuna = nombre_comuna;
        this.direccion_comuna = direccion_comuna;
        this.fk_parroquia = fk_parroquia;
    }

    public int getPk_comuna() {
        return pk_comuna;
    }

    public void setPk_comuna(int pk_comuna) {
        this.pk_comuna = pk_comuna;
    }

    public String getNombre_comuna() {
        return nombre_comuna;
    }

    public void setNombre_comuna(String nombre_comuna) {
        this.nombre_comuna = nombre_comuna;
    }

    public String getDireccion_comuna() {
        return direccion_comuna;
    }

    public void setDireccion_comuna(String direccion_comuna) {
        this.direccion_comuna = direccion_comuna;
    }

    public String getFk_parroquia() {
        return fk_parroquia;
    }

    public void setFk_parroquia(String fk_parroquia) {
        this.fk_parroquia = fk_parroquia;
    }
    
}
