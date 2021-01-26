package Dao;

import Modelo.Comuna;
import Modelo.Comunero;
import Modelo.Login;
import Modelo.Tipousuario;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DAOLoginImpl {/*con esto podemos usar la conexion sin crear objetos*/
    private Connection conec;
    Comunero comunero;
    Comuna comuna;
    Login login;
    Tipousuario tipoUsuario;

  
    public Login listar(String username, String password) throws SQLException {
        CallableStatement ps = null; //creamos una instancia para preparar el call
        try {
            conec = Conexion.getInstace().getConnection();
            //ya echa la conecion hacemos una consulta
            ResultSet res; //tambien agregamos libreria, con esto traeremos los datos de la bd
            //aqui mandamos la consulta sql
            ps = conec.prepareCall("{call listarloginuserpass(?,?)}");
            ps.setString(1, username);
            ps.setString(2, password);
            res = ps.executeQuery();
            //con esto ejecutamos la consulta
            //con un if evaluamos si la consulta tiene resultados
            //con if solo estamos dando por echo que la consulta va a devolver una sola linea
            if (res.next()) { // si esto sale verdadero significa que esta consulta tiene resultados
                //con sun joptionpanel imprimimos los resultados
                //aqui definimos el tipo de dato que vamos a traer de la bd y dentro la etiqueta de la columna
                /*creamos los objetos necesarios para cada clase*/
                login = new Login();
                tipoUsuario = new Tipousuario();
                comunero = new Comunero();
                comuna = new Comuna();
                login.setPk_login(res.getInt("pk_login"));
                login.setUsuario(res.getString("usuario"));
                login.setContrasenia(res.getString("contraseña"));
                tipoUsuario.setPk_tipousuario(res.getInt("pk_tipousuario"));
                tipoUsuario.setTipo_usuario(res.getString("tipo_usuario"));
                comunero.setPk_comunero(res.getInt("pk_comunero"));
                comunero.setPrimer_nombre(res.getString("primer_nombre"));
                comunero.setSegundo_nombre(res.getString("segundo_nombre"));
                comunero.setPrimer_apellido(res.getString("primer_apellido"));
                comunero.setSegundo_apellido(res.getString("segundo_apellido"));
                comuna.setPk_comuna(res.getInt("pk_comuna"));
                comuna.setNombre_comuna(res.getString("nombre_comuna"));
                //aqui le mandamos los datos al objeto login
                login.setTipoUsuario(tipoUsuario);
                comunero.setComuna(comuna);
                login.setComunero(comunero);
            }
            ps.close();
            Conexion.getInstace().closeConnection(conec);

        } catch (SQLException e) {
            //solo un mensaje en consola
            System.out.println("No se a podido realizar la consulta " + e.getMessage());
            ps.close();
            Conexion.getInstace().closeConnection(conec);
        }
        return login;
    }

    /*consultamos los datos del comunero a editar desde esta clase por que el login es el que alverga
    al objeto comunero y tipo de usuario
     */
    public Login listarID(int id_comunero) throws SQLException {
        CallableStatement ps = null; //para usar esra se agrego la libreria
        try {
            conec = Conexion.getInstace().getConnection();
            //ya echa la conecion hacemos una consulta
            //declaramos variables que necesitamos para hacer transacciones entre mysql
            ResultSet res; //tambien agregamos libreria
            //aqui mandamos la consulta sql
            ps = conec.prepareCall("{call consulta_comuneroID(?)}");
            ps.setInt(1, id_comunero);
            res = ps.executeQuery();
            //con esto ejecutamos la consulta
            //con un if evaluamos si la consulta tiene resultados
            //con if solo estamos dando por echo que la consulta va a devolver una sola linea
            if (res.next()) { // si esto sale verdadero significa que esta consulta tiene resultados
                //con sun joptionpanel imprimimos los resultados
                //aqui definimos el tipo de dato que vamos a traer de la bd y dentro la etiqueta de la columna
                comunero = new Comunero();
                comuna = new Comuna();
                login = new Login();
                tipoUsuario = new Tipousuario();
                comunero.setCedula(res.getString("cedula"));
                comunero.setPrimer_nombre(res.getString("primer_nombre"));
                comunero.setSegundo_nombre(res.getString("segundo_nombre"));
                comunero.setPrimer_apellido(res.getString("primer_apellido"));
                comunero.setSegundo_apellido(res.getString("segundo_apellido"));
                comunero.setTelefono(res.getString("telefono"));
                comunero.setDireccion_vivienda(res.getString("direccion_vivienda"));
                comunero.setReferencia_geografica(res.getString("referencia_geografica"));
                comuna.setNombre_comuna(res.getString("nombre_comuna"));
                comunero.setFecha_nacimiento(res.getString("fecha_nacimiento"));
                comunero.setEdad(res.getInt("edad"));
                login.setUsuario(res.getString("usuario"));
                login.setContrasenia(res.getString("contraseña"));
                tipoUsuario.setPk_tipousuario(res.getInt("pk_tipousuario"));
                comunero.setComuna(comuna);
                login.setComunero(comunero);
                login.setTipoUsuario(tipoUsuario);
            }
            ps.close();
            Conexion.getInstace().closeConnection(conec);
        } catch (SQLException e) {
            System.out.println("No se a podido realizar la consulta " + e.getMessage());
            ps.close();
            Conexion.getInstace().closeConnection(conec);
        }
        return login;
    }
    /*public Login listarID(Login login) throws Exception {
        try {
            conec = con.getConectionn();
            //ya echa la conecion hacemos una consulta
            //declaramos variables que necesitamos para hacer transacciones entre mysql
            CallableStatement ps; //para usar esra se agrego la libreria
            ResultSet res; //tambien agregamos libreria
            //aqui mandamos la consulta sql
            ps = conec.prepareCall("{call listar_usuarioID(?)}");
            ps.setInt(1, login.getFk_comunero());
            res = ps.executeQuery();
            //con esto ejecutamos la consulta
            //con un if evaluamos si la consulta tiene resultados
            //con if solo estamos dando por echo que la consulta va a devolver una sola linea
            while (res.next()) { // si esto sale verdadero significa que esta consulta tiene resultados
                //con sun joptionpanel imprimimos los resultados
                //aqui definimos el tipo de dato que vamos a traer de la bd y dentro la etiqueta de la columna
                login.setPk_login(res.getInt("pk_login"));
                login.setUsuario(res.getString("usuario"));
                login.setContrasenia(res.getString("contraseña"));
                login.setFk_tipousuario(res.getInt("fk_tipousuario"));
                login.setFk_comunero(res.getInt("fk_comunero"));
            }
            res.close();
        } catch (Exception e) {
            //solo un mensaje en consola
            JOptionPane.showMessageDialog(null, e);
        }
        return login;
    }*/
 /*metodo para consultar la fecha limite a colocar en el campo fecha limite del formulario registro de consumos*/
 /*public String FechaLimite(String fk_comunero) throws Exception {
        String fechalimite = "";
        try {
            conec = con.getConectionn();
            //ya echa la conecion hacemos una consulta
            //declaramos variables que necesitamos para hacer transacciones entre mysql
            CallableStatement ps; //para usar esra se agrego la libreria
            ResultSet res; //tambien agregamos libreria
            //aqui mandamos la consulta sql
            ps = conec.prepareCall("{call consultaFechaLimitePago(?)}");
            ps.setString(1, fk_comunero);
            res = ps.executeQuery();
            //con esto ejecutamos la consulta
            //con un if evaluamos si la consulta tiene resultados
            //con if solo estamos dando por echo que la consulta va a devolver una sola linea
            if (res.next()) { // si esto sale verdadero significa que esta consulta tiene resultados
                //con sun joptionpanel imprimimos los resultados
                //aqui definimos el tipo de dato que vamos a traer de la bd y dentro la etiqueta de la columna
               fechalimite=res.getString("fechaLimite");

            }
            res.close();
        } catch (Exception e) {
            //solo un mensaje en consola
            JOptionPane.showMessageDialog(null, e);
        }
        return fechalimite;
    }*/
}
