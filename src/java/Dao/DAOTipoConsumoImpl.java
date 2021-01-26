package Dao;

import Modelo.TipoConsumo;
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
public class DAOTipoConsumoImpl {

    private Connection conec;
    TipoConsumo tipo;

    public TipoConsumo listarTipoConsumo(int fk_comuna, int valoringreso) throws SQLException {
        List<TipoConsumo> lista = new ArrayList();
        CallableStatement ps = null; //para usar esra se agrego la libreria
        try {
            conec = Conexion.getInstace().getConnection();
            //ya echa la conecion hacemos una consulta
            //declaramos variables que necesitamos para hacer transacciones entre mysql
            ResultSet res; //tambien agregamos libreria
            //aqui mandamos la consulta sql
            ps = conec.prepareCall("{call consultaTipoConsumo(?)}");
            ps.setInt(1, fk_comuna);
            res = ps.executeQuery();
            //con esto ejecutamos la consulta
            //con un if evaluamos si la consulta tiene resultados
            //con if solo estamos dando por echo que la consulta va a devolver una sola linea
            while (res.next()) { // si esto sale verdadero significa que esta consulta tiene resultados
                //con sun joptionpanel imprimimos los resultados
                //aqui definimos el tipo de dato que vamos a traer de la bd y dentro la etiqueta de la columna
                tipo = new TipoConsumo();
                tipo.setPk_tipoconsumo(res.getInt("pk_tipoconsumo"));
                tipo.setTipo_consumo(res.getString("tipo_consumo"));
                tipo.setLimitem_cubico(res.getInt("limitem_cubico"));
                tipo.setValor(res.getDouble("valor"));
                tipo.setTarifa_basica(res.getDouble("tarifa_basica"));
                tipo.setTarifa_ambiente(res.getDouble("tarifa_ambiente"));
                tipo.setAlcantarillado(res.getDouble("alcantarillado"));
                lista.add(tipo);
            }
            /*hacignamos el tipo de consumo,
            verificamos cual es el tipo de consumo segun el valor de consumo, y los limites de consumo*/
            int count = 0;
            int tamalista = lista.size();
            while (count < tamalista) {
                tipo = new TipoConsumo();
                if (tamalista == 1) {
                    tipo.setPk_tipoconsumo(lista.get(0).getPk_tipoconsumo());
                    tipo.setTipo_consumo(lista.get(0).getTipo_consumo());
                    tipo.setLimitem_cubico(lista.get(0).getLimitem_cubico());
                    tipo.setValor(lista.get(0).getValor());
                    tipo.setTarifa_basica(lista.get(0).getTarifa_basica());
                    tipo.setTarifa_ambiente(lista.get(0).getTarifa_ambiente());
                    tipo.setAlcantarillado(lista.get(0).getAlcantarillado());
                    break;
                } else if (tamalista > 1) {
                    int limite = lista.get(count).getLimitem_cubico();
                    if (valoringreso <= limite) {
                        tipo.setPk_tipoconsumo(lista.get(count).getPk_tipoconsumo());
                        tipo.setTipo_consumo(lista.get(count).getTipo_consumo());
                        tipo.setLimitem_cubico(lista.get(count).getLimitem_cubico());
                        tipo.setValor(lista.get(count).getValor());
                        tipo.setTarifa_basica(lista.get(count).getTarifa_basica());
                        tipo.setTarifa_ambiente(lista.get(count).getTarifa_ambiente());
                        tipo.setAlcantarillado(lista.get(count).getAlcantarillado());
                        break;
                    }
                    if (valoringreso > limite) {
                        if (count <= tamalista) {
                            int countd;
                            countd = 1 + count;
                            if (countd < tamalista) {
                                tipo.setPk_tipoconsumo(lista.get(countd).getPk_tipoconsumo());
                                tipo.setTipo_consumo(lista.get(countd).getTipo_consumo());
                                tipo.setLimitem_cubico(lista.get(countd).getLimitem_cubico());
                                tipo.setValor(lista.get(countd).getValor());
                                tipo.setTarifa_basica(lista.get(countd).getTarifa_basica());
                                tipo.setTarifa_ambiente(lista.get(countd).getTarifa_ambiente());
                                tipo.setAlcantarillado(lista.get(countd).getAlcantarillado());
                            } else if (countd >= tamalista) {
                                tipo.setPk_tipoconsumo(lista.get(count).getPk_tipoconsumo());
                                tipo.setTipo_consumo(lista.get(count).getTipo_consumo());
                                tipo.setLimitem_cubico(lista.get(count).getLimitem_cubico());
                                tipo.setValor(lista.get(count).getValor());
                                tipo.setTarifa_basica(lista.get(count).getTarifa_basica());
                                tipo.setTarifa_ambiente(lista.get(count).getTarifa_ambiente());
                                tipo.setAlcantarillado(lista.get(count).getAlcantarillado());
                                break;
                            }

                        } else if (count >= tamalista) {
                            tipo.setPk_tipoconsumo(lista.get(count).getPk_tipoconsumo());
                            tipo.setTipo_consumo(lista.get(count).getTipo_consumo());
                            tipo.setLimitem_cubico(lista.get(count).getLimitem_cubico());
                            tipo.setValor(lista.get(count).getValor());
                            tipo.setTarifa_basica(lista.get(count).getTarifa_basica());
                            tipo.setTarifa_ambiente(lista.get(count).getTarifa_ambiente());
                            tipo.setAlcantarillado(lista.get(count).getAlcantarillado());
                        }
                    }
                    count++;
                }
            }
            ps.close();
            Conexion.getInstace().closeConnection(conec);
        } catch (SQLException e) {
            //solo un mensaje en consola
            System.out.println("No se a podido realizar la consulta " + e.getMessage());
            ps.close();
            Conexion.getInstace().closeConnection(conec);
        }
        return tipo;
    }

}
