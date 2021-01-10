package Modelo;

public class Tipousuario {

    private int pk_tipousuario;
    private String tipo_usuario;

    /*contructores con y sin parametros*/
    public Tipousuario() {
    }

    public Tipousuario(int pk_tipousuario, String tipo_usuario) {
        this.pk_tipousuario = pk_tipousuario;
        this.tipo_usuario = tipo_usuario;
    }

    //metodos getters y seters
    public int getPk_tipousuario() {
        return pk_tipousuario;
    }

    public void setPk_tipousuario(int pk_tipousuario) {
        this.pk_tipousuario = pk_tipousuario;
    }

    public String getTipo_usuario() {
        return tipo_usuario;
    }

    public void setTipo_usuario(String tipo_usuario) {
        this.tipo_usuario = tipo_usuario;
    }

}
