package Dao;

import Modelo.Comunero;
import java.sql.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DAOComuneroImpl {

    private Connection conec;
    Comunero comunero;

    public boolean registrarEditarEliminar(String accion, int pk_comuner, String cedula, String primer_nombre, String segundo_nombre, String primer_apellido, String segundo_Apellido, String telefono, String fecha_nacimiento, int edad, int fk_comuna, String direccion_vivienda, String referencia_geografica, String usuario, String Contrasenia, int fk_tipousuario) throws SQLException {
        CallableStatement ps = null;
        boolean registrocomunero = true;
        try {
            conec = Conexion.getInstace().getConnection();
            //ya echa la conecion hacemos una consulta
            //declaramos variables que necesitamos para hacer transacciones entre mysql
            //para usar esra se agrego la libreria
            //tambien agregamos libreria
            //aqui mandamos la consulta sql
            ps = conec.prepareCall("{call GuardarActualizarEliminar(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            ps.setString(1, accion);
            ps.setInt(2, pk_comuner);
            ps.setString(3, cedula);
            ps.setString(4, primer_nombre);
            ps.setString(5, segundo_nombre);
            ps.setString(6, primer_apellido);
            ps.setString(7, segundo_Apellido);
            ps.setString(8, telefono);
            ps.setString(9, fecha_nacimiento);
            ps.setInt(10, edad);
            ps.setInt(11, fk_comuna);
            ps.setString(12, direccion_vivienda);
            ps.setString(13, referencia_geografica);
            ps.setString(14, usuario);
            ps.setString(15, Contrasenia);
            ps.setInt(16, fk_tipousuario);
            registrocomunero = ps.execute();
            System.out.println(ps);
            ps.close();
            Conexion.getInstace().closeConnection(conec);
        } catch (SQLException e) {
            //solo un mensaje en consola
            System.out.println("No se a podido guardar los datos " + e.getMessage());
            ps.close();
            Conexion.getInstace().closeConnection(conec);
            registrocomunero = true;
        }
        return registrocomunero;
    }

    public List listar(int id_comuna) throws SQLException {
        List<Comunero> lista = new ArrayList();
        CallableStatement ps = null; //para usar esra se agrego la libreria
        try {
            conec = Conexion.getInstace().getConnection();
            //ya echa la conecion hacemos una consulta
            //declaramos variables que necesitamos para hacer transacciones entre mysql
            ResultSet res; //tambien agregamos libreria
            //aqui mandamos la consulta sql
            ps = conec.prepareCall("{call consulta_comunero(?)}");
            ps.setInt(1, id_comuna);
            res = ps.executeQuery();
            //con esto ejecutamos la consulta
            //con un if evaluamos si la consulta tiene resultados
            //con if solo estamos dando por echo que la consulta va a devolver una sola linea
            while (res.next()) { // si esto sale verdadero significa que esta consulta tiene resultados
                //con sun joptionpanel imprimimos los resultados
                //aqui definimos el tipo de dato que vamos a traer de la bd y dentro la etiqueta de la columna
                comunero = new Comunero();
                comunero.setPk_comunero(res.getInt("pk_comunero"));
                comunero.setCedula(res.getString("cedula"));
                comunero.setPrimer_nombre(res.getString("primer_nombre"));
                comunero.setSegundo_nombre(res.getString("segundo_nombre"));
                comunero.setPrimer_apellido(res.getString("primer_apellido"));
                comunero.setSegundo_apellido(res.getString("segundo_apellido"));
                comunero.setTelefono(res.getString("telefono"));
                comunero.setEdad(res.getInt("edad"));
                lista.add(comunero);
            }
            ps.close();
            Conexion.getInstace().closeConnection(conec);
        } catch (SQLException e) {
            System.out.println("No se a podido realizar la consulta " + e.getMessage());
            ps.close();
            Conexion.getInstace().closeConnection(conec);
        }
        return lista;
    }


    /*metodo para listar los datos del comunero por el numero de cedula o nombres completos*/
    public Comunero consultaComuneroCedula(String dato) throws SQLException {
        
        CallableStatement ps = null; //para usar esra se agrego la libreria
        try {
            conec = Conexion.getInstace().getConnection();
            //ya echa la conecion hacemos una consulta
            //declaramos variables que necesitamos para hacer transacciones entre mysql       
            ResultSet res; //tambien agregamos libreria
            //aqui mandamos la consulta sql
            ps = conec.prepareCall("{call consultaDatosComunero(?)}");
            ps.setString(1, dato);
            res = ps.executeQuery();
            //con esto ejecutamos la consulta
            //con un if evaluamos si la consulta tiene resultados
            //con if solo estamos dando por echo que la consulta va a devolver una sola linea
            if (res.next()) { // si esto sale verdadero significa que esta consulta tiene resultados
                comunero = new Comunero();
                //aqui definimos el tipo de dato que vamos a traer de la bd y dentro la etiqueta de la columna
                comunero.setPk_comunero(res.getInt("pk_comunero"));
                comunero.setCedula(res.getString("cedula"));
                comunero.setPrimer_nombre(res.getString("primer_nombre"));
                comunero.setSegundo_nombre(res.getString("segundo_nombre"));
                comunero.setPrimer_apellido(res.getString("primer_apellido"));
                comunero.setSegundo_apellido(res.getString("segundo_apellido"));
            }
            ps.close();
            Conexion.getInstace().closeConnection(conec);
        } catch (SQLException e) {
            //solo un mensaje en consola
            System.out.println("No se a podido realizar la consulta " + e.getMessage());
            ps.close();
            Conexion.getInstace().closeConnection(conec);
        }
        return comunero;
    }
}
