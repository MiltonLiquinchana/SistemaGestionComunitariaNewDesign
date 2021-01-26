package Dao;

import Dao.Conexion;
import Modelo.Consumo;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DAOConsumoImpl {
    
    private Connection conec;
    Consumo consumo;
    boolean registrocomunero = true;

    /*metodo para seleccionar el ultimo consumo de un medidor*/
    public Consumo consultarUltimoConsumoMedidor(int pk_medid) throws SQLException {
        CallableStatement ps = null; //para usar esra se agrego la libreria
        try {
            conec = Conexion.getInstace().getConnection();
            //ya echa la conecion hacemos una consulta
            //declaramos variables que necesitamos para hacer transacciones entre mysql
            ResultSet res; //tambien agregamos libreria
            //aqui mandamos la consulta sql
            ps = conec.prepareCall("{call consultarmaximoConsumo(?)}");
            ps.setInt(1, pk_medid);
            res = ps.executeQuery();
            //con esto ejecutamos la consulta
            //con un if evaluamos si la consulta tiene resultados
            //con if solo estamos dando por echo que la consulta va a devolver una sola linea
            if (res.next()) { // si esto sale verdadero significa que esta consulta tiene resultados
                //con sun joptionpanel imprimimos los resultados
                //aqui definimos el tipo de dato que vamos a traer de la bd y dentro la etiqueta de la columna
                consumo = new Consumo();
                consumo.setLectura_anterior(res.getString("lectura_actual"));
            }
            ps.close();
            Conexion.getInstace().closeConnection(conec);
        } catch (SQLException e) {
            //solo un mensaje en consola
            System.out.println("No se a podido realizar la consulta " + e.getMessage());
            ps.close();
            Conexion.getInstace().closeConnection(conec);
        }
        return consumo;
    }
    
    public boolean registrar(int lectura_ante, int lectura_actual, String fecha_lectu, String fecha_limit, int consumo_mcubic, double total_pag, int fk_medido, int fk_tipoconsumo) throws SQLException {
        //declaramos variables que necesitamos para hacer transacciones entre mysql
        CallableStatement ps = null; //para usar esra se agrego la libreria
        try {
            conec = Conexion.getInstace().getConnection();
            //ya echa la conecion hacemos una consulta
            //tambien agregamos libreria
            //aqui mandamos la consulta sql
            ps = conec.prepareCall("{call guardarConsumo(?,?,?,?,?,?,?,?)}");
            ps.setInt(1, lectura_ante);
            ps.setInt(2, lectura_actual);
            ps.setString(3, fecha_lectu);
            ps.setString(4, fecha_limit);
            ps.setInt(5, consumo_mcubic);
            ps.setDouble(6, total_pag);
            ps.setInt(7, fk_medido);
            ps.setInt(8, fk_tipoconsumo);
            registrocomunero = ps.execute();
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
    
    public List ListarConsumoImpaga(int pk_medid) throws SQLException {
        CallableStatement ps = null; //para usar esra se agrego la libreria
        List<Consumo> lista = new ArrayList();
        try {
            conec = Conexion.getInstace().getConnection();
            //ya echa la conecion hacemos una consulta
            //declaramos variables que necesitamos para hacer transacciones entre mysql
            ResultSet res; //tambien agregamos libreria
            //aqui mandamos la consulta sql
            ps = conec.prepareCall("{call buscarConsumoImpaga(?)}");
            ps.setInt(1, pk_medid);
            res = ps.executeQuery();
            //con esto ejecutamos la consulta
            //con un if evaluamos si la consulta tiene resultados
            //con if solo estamos dando por echo que la consulta va a devolver una sola linea
            while (res.next()) { // si esto sale verdadero significa que esta consulta tiene resultados
                //con sun joptionpanel imprimimos los resultados
                //aqui definimos el tipo de dato que vamos a traer de la bd y dentro la etiqueta de la columna
                consumo = new Consumo();
                consumo.setPk_consumo(res.getInt("pk_consumo"));
                consumo.setFecha_lectura(res.getString("fecha_lectura"));
                lista.add(consumo);
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
