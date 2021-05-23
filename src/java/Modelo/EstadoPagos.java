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
public class EstadoPagos {

    private int pk_esto_pagos;
    private String estado;

    public EstadoPagos() {
    }

    public EstadoPagos(int pk_esto_pagos, String estado) {
        this.pk_esto_pagos = pk_esto_pagos;
        this.estado = estado;
    }

    public int getPk_esto_pagos() {
        return pk_esto_pagos;
    }

    public void setPk_esto_pagos(int pk_esto_pagos) {
        this.pk_esto_pagos = pk_esto_pagos;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

}
