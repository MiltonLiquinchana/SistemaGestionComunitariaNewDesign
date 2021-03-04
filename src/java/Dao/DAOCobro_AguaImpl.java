package Dao;

import Modelo.Cobro_Agua;
import Modelo.Comunero;
import Modelo.Consumo;
import Modelo.Medidor;
import Modelo.Multas;
import Modelo.TipoConsumo;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DAOCobro_AguaImpl {

    private Connection conec;
    Cobro_Agua cobro_Agua;
    Consumo consumo;
    Multas multa;
    TipoConsumo tipoConsumo;
    Medidor medidor;
    Comunero comunero;
    boolean registroCobroagua = true;

    /*metodo para listar los datos del consumo sin pagar por el numero de medidor*/
    public Cobro_Agua buscarDatosConsumoImpaga(int fkconsumo, int fk_comun) throws SQLException {
        CallableStatement ps = null; //para usar esra se agrego la libreria
        try {
            conec = Conexion.getInstace().getConnection();
            //ya echa la conecion hacemos una consulta
            //declaramos variables que necesitamos para hacer transacciones entre mysql
            ResultSet res; //tambien agregamos libreria
            //aqui mandamos la consulta sql
            ps = conec.prepareCall("{call buscarDatosConsumoImpaga(?,?)}");
            ps.setInt(1, fkconsumo);
            ps.setInt(2, fk_comun);
            res = ps.executeQuery();
            //con esto ejecutamos la consulta
            //con un if evaluamos si la consulta tiene resultados
            //con if solo estamos dando por echo que la consulta va a devolver una sola linea
            if (res.next()) { // si esto sale verdadero significa que esta consulta tiene resultados
                //con sun joptionpanel imprimimos los resultados
                //aqui definimos el tipo de dato que vamos a traer de la bd y dentro la etiqueta de la columna
                cobro_Agua = new Cobro_Agua();
                consumo = new Consumo();
                multa = new Multas();
                tipoConsumo = new TipoConsumo();

                //Asignamos los valores obtenidos de la base de datos a sus respectivas entidades(clases) y atributos
                consumo.setConsumo_mcubico(res.getInt("consumo_mcubico"));
                tipoConsumo.setTipo_consumo(res.getString("tipo_consumo"));
                consumo.setFecha_lectura(res.getString("fecha_lectura"));
                consumo.setFecha_limite_pago(res.getString("fecha_limite_pago"));
                consumo.setTotal_pagar(res.getDouble("subtotal"));
                multa.setTipo_multa(res.getString("tipo_multa"));
                multa.setValor(res.getDouble("valor_multa"));
                tipoConsumo.setTarifa_ambiente(res.getDouble("tarifa_ambiente"));
                tipoConsumo.setAlcantarillado(res.getDouble("alcantarillado"));

                //asignamos los objetos con sus atributos ya definidos a la clase principal que maneja todo
                consumo.setTipoconsumo(tipoConsumo);
                cobro_Agua.setConsumo(consumo);
                cobro_Agua.setMultas(multa);
            }
            ps.close();
            Conexion.getInstace().closeConnection(conec);
        } catch (SQLException e) {
            //solo un mensaje en consola
            System.out.println("No se a podido realizar la consulta " + e.getMessage());
            ps.close();
            Conexion.getInstace().closeConnection(conec);
        }
        return cobro_Agua;
    }

    public boolean registrar(int dias_retras, double valor_totalmulta, double total_pagado, int fk_consum, int fk_comun, double deposito,double cambio) throws SQLException {
        CallableStatement ps = null; //para usar esra se agrego la libreria
        try {
            conec = Conexion.getInstace().getConnection();
            //ya echa la conecion hacemos una consulta
            //declaramos variables que necesitamos para hacer transacciones entre mysql
            //tambien agregamos libreria
            //aqui mandamos la consulta sql
            ps = conec.prepareCall("{call guardarPagoConsumo(?,?,?,?,?,?,?)}");
            ps.setInt(1, dias_retras);
            ps.setDouble(2, valor_totalmulta);
            ps.setDouble(3, total_pagado);
            ps.setInt(4, fk_consum);
            ps.setInt(5, fk_comun);
            ps.setDouble(6, deposito);
            ps.setDouble(7, cambio);
            registroCobroagua = ps.execute();
            ps.close();
            Conexion.getInstace().closeConnection(conec);
        } catch (SQLException e) {
            //solo un mensaje en consola
            System.out.println("No se a podido guardar los datos " + e.getMessage());
            ps.close();
            Conexion.getInstace().closeConnection(conec);
            registroCobroagua = true;
        }
        return registroCobroagua;
    }

    /*metodo para listar los datos del consumo sin pagar por el numero de medidor*/
    public Cobro_Agua buscarDatosFactura(int fkconsumo) throws SQLException {
        CallableStatement ps = null; //para usar esra se agrego la libreria
        try {
            conec = Conexion.getInstace().getConnection();
            //ya echa la conecion hacemos una consulta
            //declaramos variables que necesitamos para hacer transacciones entre mysql
            ResultSet res; //tambien agregamos libreria
            //aqui mandamos la consulta sql
            ps = conec.prepareCall("{call consultaDatosFactura(?)}");
            ps.setInt(1, fkconsumo);
            res = ps.executeQuery();
            //con esto ejecutamos la consulta
            //con un if evaluamos si la consulta tiene resultados
            //con if solo estamos dando por echo que la consulta va a devolver una sola linea
            if (res.next()) { // si esto sale verdadero significa que esta consulta tiene resultados
                //con sun joptionpanel imprimimos los resultados
                //aqui definimos el tipo de dato que vamos a traer de la bd y dentro la etiqueta de la columna
                cobro_Agua = new Cobro_Agua();
                consumo = new Consumo();
                multa = new Multas();
                tipoConsumo = new TipoConsumo();
                medidor = new Medidor();
                comunero = new Comunero();
                comunero.setPrimer_apellido(res.getString("primer_apellido"));
                comunero.setSegundo_apellido(res.getString("segundo_apellido"));
                comunero.setPrimer_nombre(res.getString("primer_nombre"));
                comunero.setSegundo_nombre(res.getString("segundo_nombre"));
                comunero.setCedula(res.getString("cedula"));
                comunero.setTelefono(res.getString("telefono"));
                comunero.setDireccion_vivienda(res.getString("direccion_vivienda"));
                medidor.setNumero_medidor(res.getString("numero_medidor"));
                medidor.setComunero(comunero);//seteamos el comunero a el medidor
                consumo.setFecha_lectura(res.getString("fecha_lectura"));
                consumo.setFecha_limite_pago(res.getString("fecha_limite_pago"));
                consumo.setLectura_anterior(res.getString("lectura_anterior"));
                consumo.setLectura_actual(res.getString("lectura_actual"));
                tipoConsumo.setTipo_consumo(res.getString("tipo_consumo"));
                consumo.setConsumo_mcubico(res.getInt("consumo_mcubico"));
                cobro_Agua.setTarifa_basicaC(res.getDouble("tarifa_basicaC"));
                consumo.setTotal_pagar(res.getDouble("subtotal"));
                cobro_Agua.setTarifa_ambienteC(res.getDouble("tarifa_ambienteC"));
                cobro_Agua.setAlcantarilladoC(res.getDouble("alcantarilladoC"));
                consumo.setTipoconsumo(tipoConsumo);//para poder acceder al tipo de consumo
                consumo.setMedidor(medidor);
                multa.setTipo_multa(res.getString("tipo_multa"));
                cobro_Agua.setDias_retraso(res.getInt("dias_retraso"));
                cobro_Agua.setValor_multa(res.getDouble("total_multa"));
                cobro_Agua.setTotalpagar(res.getDouble("totalpagar"));
                cobro_Agua.setDeposito(res.getDouble("deposito"));
                cobro_Agua.setCambio(res.getDouble("cambio"));
                cobro_Agua.setMultas(multa);
                cobro_Agua.setConsumo(consumo);

            }
            ps.close();
            Conexion.getInstace().closeConnection(conec);
        } catch (SQLException e) {
            //solo un mensaje en consola
            System.out.println("No se a podido realizar la consulta " + e.getMessage());
            ps.close();
            Conexion.getInstace().closeConnection(conec);
        }
        return cobro_Agua;
    }
}
