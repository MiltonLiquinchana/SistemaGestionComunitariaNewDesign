package Modelo;

public class Login {

    /*los mismos parametros que en una tabla*/
    private int pk_login;
    private String usuario;
    private String contrasenia;
    private Tipousuario tipoUsuario;
    private Comunero comunero;
    
    //contructores
    //vacio
    public Login() {
    }
    //con parametros
     public Login(int pk_login, String usuario, String contrasenia, Tipousuario tipoUsuario, Comunero comunero) {
        this.pk_login = pk_login;
        this.usuario = usuario;
        this.contrasenia = contrasenia;
        this.tipoUsuario = tipoUsuario;
        this.comunero = comunero;
    }

    //metodos getters y setters

    public int getPk_login() {
        return pk_login;
    }

    public void setPk_login(int pk_login) {
        this.pk_login = pk_login;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getContrasenia() {
        return contrasenia;
    }

    public void setContrasenia(String contrasenia) {
        this.contrasenia = contrasenia;
    }

    public Tipousuario getTipoUsuario() {
        return tipoUsuario;
    }

    public void setTipoUsuario(Tipousuario tipoUsuario) {
        this.tipoUsuario = tipoUsuario;
    }

    public Comunero getComunero() {
        return comunero;
    }

    public void setComunero(Comunero comunero) {
        this.comunero = comunero;
    }

   
    
    
    
}
