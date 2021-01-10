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

    /*public void registrar(Comunero comunero) throws Exception {

        try {
            conec = con.getConectionn();
            //ya echa la conecion hacemos una consulta
            //declaramos variables que necesitamos para hacer transacciones entre mysql
            CallableStatement ps; //para usar esra se agrego la libreria
            //tambien agregamos libreria
            //aqui mandamos la consulta sql
            ps = conec.prepareCall("{call guardar_comunero(?,?,?,?,?,?,?,?,?,?,?)}");
            ps.setString(1, comunero.getCedula());
            ps.setString(2, comunero.getPrimer_nombre());
            ps.setString(3, comunero.getSegundo_nombre());
            ps.setString(4, comunero.getPrimer_apellido());
            ps.setString(5, comunero.getSegundo_apellido());
            ps.setString(6, comunero.getTelefono());
            ps.setString(7, comunero.getFecha_nacimiento());
            ps.setInt(8, comunero.getEdad());
            ps.setInt(9, comunero.getFk_comuna());
            ps.setString(10, comunero.getDireccion_vivienda());
            ps.setString(11, comunero.getReferencia_geografica());
            ps.execute();
            JOptionPane.showMessageDialog(null, "Se guardo exitosamente");
        } catch (Exception e) {
            //solo un mensaje en consola
            JOptionPane.showMessageDialog(null, e);
        }

    }

    public void modificar(Comunero comunero) throws SQLException {
        try {
            conec = con.getConectionn();
            //ya echa la conecion hacemos una consulta
            //declaramos variables que necesitamos para hacer transacciones entre mysql
            CallableStatement ps; //para usar esra se agrego la libreria
            //tambien agregamos libreria
            //aqui mandamos la consulta sql
            ps = conec.prepareCall("{call actualizar_comunero(?,?,?,?,?,?,?,?,?,?,?,?)}");
            ps.setInt(1, comunero.getPk_comunero());
            ps.setString(2, comunero.getCedula());
            ps.setString(3, comunero.getPrimer_nombre());
            ps.setString(4, comunero.getSegundo_nombre());
            ps.setString(5, comunero.getPrimer_apellido());
            ps.setString(5, comunero.getSegundo_apellido());
            ps.setString(7, comunero.getTelefono());
            ps.setString(8, comunero.getFecha_nacimiento());
            ps.setInt(9, comunero.getEdad());
            ps.setInt(10, comunero.getFk_comuna());
            ps.setString(11, comunero.getDireccion_vivienda());
            ps.setString(12, comunero.getReferencia_geografica());
            ps.execute();
            JOptionPane.showMessageDialog(null, "Acutalizacion excitosa");
        } catch (Exception e) {
            //solo un mensaje en consola
            JOptionPane.showMessageDialog(null, e);
        }
    }*/

 /*public void eliminar(Comunero comunero) throws Exception {
        try {
            conec = con.getConectionn();
            //ya echa la conecion hacemos una consulta
            //declaramos variables que necesitamos para hacer transacciones entre mysql
            CallableStatement ps; //para usar esra se agrego la libreria
            //tambien agregamos libreria
            //aqui mandamos la consulta sql
            ps = conec.prepareCall("{call eliminar_comunero(?)}");
            ps.setInt(1, comunero.getPk_comunero());
            ps.execute();
            JOptionPane.showMessageDialog(null, "Se elimino comunero exitosamente");
        } catch (Exception e) {
            //solo un mensaje en consola
            JOptionPane.showMessageDialog(null, e);
        }
    }*/
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

    

    /* public Comunero listarID(Comunero comunero) throws Exception {
        try {
            conec = con.getConectionn();
            //ya echa la conecion hacemos una consulta
            //declaramos variables que necesitamos para hacer transacciones entre mysql
            CallableStatement ps; //para usar esra se agrego la libreria
            ResultSet res; //tambien agregamos libreria
            //aqui mandamos la consulta sql
            ps = conec.prepareCall("{call consulta_comuneroID(?)}");
            ps.setInt(1, comunero.getPk_comunero());
            res = ps.executeQuery();
            //con esto ejecutamos la consulta
            //con un if evaluamos si la consulta tiene resultados
            //con if solo estamos dando por echo que la consulta va a devolver una sola linea
            while (res.next()) { // si esto sale verdadero significa que esta consulta tiene resultados
                //con sun joptionpanel imprimimos los resultados
                //aqui definimos el tipo de dato que vamos a traer de la bd y dentro la etiqueta de la columna
                comunero.setPk_comunero(res.getInt("pk_comunero"));
                comunero.setCedula(res.getString("cedula"));
                comunero.setPrimer_nombre(res.getString("primer_nombre"));
                comunero.setSegundo_nombre(res.getString("segundo_nombre"));
                comunero.setPrimer_apellido(res.getString("primer_apellido"));
                comunero.setSegundo_apellido(res.getString("segundo_apellido"));
                comunero.setTelefono(res.getString("telefono"));
                comunero.setFecha_nacimiento(String.valueOf(res.getDate("fecha_nacimiento")));
                comunero.setEdad(res.getInt("edad"));
                comunero.setFk_comuna(res.getInt("fk_comuna"));
                comunero.setDireccion_vivienda(res.getString("direccion_vivienda"));
                comunero.setReferencia_geografica(res.getString("referencia_geografica"));
            }
            res.close();
        } catch (Exception e) {
            //solo un mensaje en consola
            JOptionPane.showMessageDialog(null, e);
        }
        return comunero;
    }*/

 /*metodo para listar los datos del comunero por el numero de cedula*/
 /* public Comunero listarCCedula(String dato) throws Exception {
        Comunero comunero = new Comunero();
        try {
            conec = con.getConectionn();
            //ya echa la conecion hacemos una consulta
            //declaramos variables que necesitamos para hacer transacciones entre mysql
            CallableStatement ps; //para usar esra se agrego la libreria
            ResultSet res; //tambien agregamos libreria
            //aqui mandamos la consulta sql
            ps = conec.prepareCall("{call listar_datos_comunero_ced_nom(?)}");
            ps.setString(1, dato);
            res = ps.executeQuery();
            //con esto ejecutamos la consulta
            //con un if evaluamos si la consulta tiene resultados
            //con if solo estamos dando por echo que la consulta va a devolver una sola linea
            while (res.next()) { // si esto sale verdadero significa que esta consulta tiene resultados
                //con sun joptionpanel imprimimos los resultados
                //aqui definimos el tipo de dato que vamos a traer de la bd y dentro la etiqueta de la columna
                comunero.setPk_comunero(res.getInt("pk_comunero"));
                comunero.setCedula(res.getString("cedula"));
                comunero.setPrimer_nombre(res.getString("primer_nombre"));
                comunero.setSegundo_nombre(res.getString("segundo_nombre"));
                comunero.setPrimer_apellido(res.getString("primer_apellido"));
                comunero.setSegundo_apellido(res.getString("segundo_apellido"));

            }
            res.close();
        } catch (Exception e) {
            //solo un mensaje en consola
            JOptionPane.showMessageDialog(null, e);
        }
        return comunero;
    }*/
}
