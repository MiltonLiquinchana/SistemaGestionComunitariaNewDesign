/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Modelo.Comunero;
import Modelo.Medidor;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author MiltonLQ
 */
public class DAOMedidorImpl {

    private Connection conec;
    Medidor medidor;
    //realizamos las operaciones
    Comunero comunero;

    public void registrar(Medidor medi) throws SQLException {

    }

    public void modificar(Medidor comuni) throws SQLException {
    }

    public void eliminar(Medidor comuni) throws SQLException {

    }

    public List listar(String dato) throws SQLException {
        List<Medidor> lista = new ArrayList();
        CallableStatement ps = null; //para usar esra se agrego la libreria
        try {
            conec = Conexion.getInstace().getConnection();
            //ya echa la conecion hacemos una consulta
            //declaramos variables que necesitamos para hacer transacciones entre mysql
            ResultSet res; //tambien agregamos libreria
            //aqui mandamos la consulta sql
            ps = conec.prepareCall("{call consultaMedidoresComunero(?)}");
            ps.setString(1, dato);
            res = ps.executeQuery();
            //con esto ejecutamos la consulta
            //con un if evaluamos si la consulta tiene resultados
            //con if solo estamos dando por echo que la consulta va a devolver una sola linea
            while (res.next()) { // si esto sale verdadero significa que esta consulta tiene resultados
                //con sun joptionpanel imprimimos los resultados
                //aqui definimos el tipo de dato que vamos a traer de la bd y dentro la etiqueta de la columna
                medidor = new Medidor();
                medidor.setPk_medidor(res.getInt("pk_medidor"));
                medidor.setNumero_medidor(res.getString("numero_medidor"));
                lista.add(medidor);
            }
            ps.close();
            Conexion.getInstace().closeConnection(conec);
        } catch (SQLException e) {
            //solo un mensaje en consola
            System.out.println("No se a podido realizar la consulta " + e.getMessage());
            ps.close();
            Conexion.getInstace().closeConnection(conec);
        }
        return lista;
    }

    public List<Medidor> listarAbonados(String dato) throws SQLException {
        List<Medidor> lista = new ArrayList();
        CallableStatement ps = null; //para usar esra se agrego la libreria
        try {
            conec = Conexion.getInstace().getConnection();
            //ya echa la conecion hacemos una consulta
            //declaramos variables que necesitamos para hacer transacciones entre mysql
            ResultSet res; //tambien agregamos libreria
            //aqui mandamos la consulta sql
            ps = conec.prepareCall("{call listarAbonados(?)}");
            ps.setString(1, dato);
            res = ps.executeQuery();
            //con esto ejecutamos la consulta
            //con un if evaluamos si la consulta tiene resultados
            //con if solo estamos dando por echo que la consulta va a devolver una sola linea
            while (res.next()) { // si esto sale verdadero significa que esta consulta tiene resultados
                //con sun joptionpanel imprimimos los resultados
                //aqui definimos el tipo de dato que vamos a traer de la bd y dentro la etiqueta de la columna
                medidor = new Medidor();
                comunero = new Comunero();
                //aqui definimos el tipo de dato que vamos a traer de la bd y dentro la etiqueta de la columna
                comunero.setCedula(res.getString("cedula"));
                comunero.setPrimer_nombre(res.getString("primer_nombre"));
                comunero.setSegundo_nombre(res.getString("segundo_nombre"));
                comunero.setPrimer_apellido(res.getString("primer_apellido"));
                comunero.setSegundo_apellido(res.getString("segundo_apellido"));
                medidor.setPk_medidor(res.getInt("pk_medidor"));
                medidor.setNumero_medidor(res.getString("numero_medidor"));
                medidor.setComunero(comunero);
                lista.add(medidor);
            }
            ps.close();
            Conexion.getInstace().closeConnection(conec);
        } catch (SQLException e) {
            //solo un mensaje en consola
            System.out.println("No se a podido realizar la consulta " + e.getMessage());
            ps.close();
            Conexion.getInstace().closeConnection(conec);
        }
        return lista;
    }

}
