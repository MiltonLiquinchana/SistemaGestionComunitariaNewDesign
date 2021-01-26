
package Modelo;

public class Comunero {
    private int pk_comunero;
    private String cedula;
    private String primer_nombre;
    private String segundo_nombre;
    private String primer_apellido;
    private String segundo_apellido;
    private String telefono;
    private String fecha_nacimiento;
    private int edad;
    private Comuna comuna;
    private String direccion_vivienda;
    private String referencia_geografica;
    
    //contructores
    //vacio
    public Comunero() {
    }

    //contructor con parametros
    public Comunero(int pk_comunero, String cedula, String primer_nombre, String segundo_nombre, String primer_apellido, String segundo_apellido, String telefono, String fecha_nacimiento, int edad, Comuna comuna, String direccion_vivienda, String referencia_geografica) {
        this.pk_comunero = pk_comunero;
        this.cedula = cedula;
        this.primer_nombre = primer_nombre;
        this.segundo_nombre = segundo_nombre;
        this.primer_apellido = primer_apellido;
        this.segundo_apellido = segundo_apellido;
        this.telefono = telefono;
        this.fecha_nacimiento = fecha_nacimiento;
        this.edad = edad;
        this.comuna = comuna;
        this.direccion_vivienda = direccion_vivienda;
        this.referencia_geografica = referencia_geografica;
    }
    
    //metodos getters y setters
    public int getPk_comunero() {
        return pk_comunero;
    }

    public void setPk_comunero(int pk_comunero) {
        this.pk_comunero = pk_comunero;
    }

    public String getCedula() {
        return cedula;
    }

    public void setCedula(String cedula) {
        this.cedula = cedula;
    }

    public String getPrimer_nombre() {
        return primer_nombre;
    }

    public void setPrimer_nombre(String primer_nombre) {
        this.primer_nombre = primer_nombre;
    }

    public String getSegundo_nombre() {
        return segundo_nombre;
    }

    public void setSegundo_nombre(String segundo_nombre) {
        this.segundo_nombre = segundo_nombre;
    }

    public String getPrimer_apellido() {
        return primer_apellido;
    }

    public void setPrimer_apellido(String primer_apellido) {
        this.primer_apellido = primer_apellido;
    }

    public String getSegundo_apellido() {
        return segundo_apellido;
    }

    public void setSegundo_apellido(String segundo_apellido) {
        this.segundo_apellido = segundo_apellido;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getFecha_nacimiento() {
        return fecha_nacimiento;
    }

    public void setFecha_nacimiento(String fecha_nacimiento) {
        this.fecha_nacimiento = fecha_nacimiento;
    }

    public int getEdad() {
        return edad;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    public Comuna getComuna() {
        return comuna;
    }

    public void setComuna(Comuna comuna) {
        this.comuna = comuna;
    }

    public String getDireccion_vivienda() {
        return direccion_vivienda;
    }

    public void setDireccion_vivienda(String direccion_vivienda) {
        this.direccion_vivienda = direccion_vivienda;
    }

    public String getReferencia_geografica() {
        return referencia_geografica;
    }

    public void setReferencia_geografica(String referencia_geografica) {
        this.referencia_geografica = referencia_geografica;
    }
    

}
