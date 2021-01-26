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
public class Medidor {

    //Estructura de la tabla
    private int pk_medidor;
    private String numero_medidor;
    private String fecha_conexion; 
    private Comunero comunero;
    
    /*constructores*/
    //vacio
    public Medidor() {
    }
    
    //con parametros
     public Medidor(int pk_medidor, String numero_medidor, String fecha_conexion, Comunero comunero) {
        this.pk_medidor = pk_medidor;
        this.numero_medidor = numero_medidor;
        this.fecha_conexion = fecha_conexion;
        this.comunero = comunero;
    }   
    
    /*getter y setters*/

    public int getPk_medidor() {
        return pk_medidor;
    }

    public void setPk_medidor(int pk_medidor) {
        this.pk_medidor = pk_medidor;
    }

    public String getNumero_medidor() {
        return numero_medidor;
    }

    public void setNumero_medidor(String numero_medidor) {
        this.numero_medidor = numero_medidor;
    }

    public String getFecha_conexion() {
        return fecha_conexion;
    }

    public void setFecha_conexion(String fecha_conexion) {
        this.fecha_conexion = fecha_conexion;
    }

    public Comunero getComunero() {
        return comunero;
    }

    public void setComunero(Comunero comunero) {
        this.comunero = comunero;
    }

   

   
    
}
