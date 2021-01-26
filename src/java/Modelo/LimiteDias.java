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
public class LimiteDias {

    private int pk_LimiteDias;
    private int LimiteDias;
    private Comuna comuna;

    public LimiteDias() {
    }

    public LimiteDias(int pk_LimiteDias, int LimiteDias, Comuna comuna) {
        this.pk_LimiteDias = pk_LimiteDias;
        this.LimiteDias = LimiteDias;
        this.comuna = comuna;
    }

    public int getPk_LimiteDias() {
        return pk_LimiteDias;
    }

    public void setPk_LimiteDias(int pk_LimiteDias) {
        this.pk_LimiteDias = pk_LimiteDias;
    }

    public int getLimiteDias() {
        return LimiteDias;
    }

    public void setLimiteDias(int LimiteDias) {
        this.LimiteDias = LimiteDias;
    }

    public Comuna getComuna() {
        return comuna;
    }

    public void setComuna(Comuna comuna) {
        this.comuna = comuna;
    }

}
