package Dao;

import Modelo.CountCobroAgua;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DAOCountCobroAgua {

    private Connection conec;
    CountCobroAgua countCobroAgua;

    public CountCobroAgua buscarCount(int fk_comun) throws SQLException {
        CallableStatement ps = null;
        try {
            conec = Conexion.getInstace().getConnection();
            ResultSet res;
            ps = conec.prepareCall("{call numFac(?)}");
            ps.setInt(1, fk_comun);
            res = ps.executeQuery();
            if (res.next()) {
                countCobroAgua = new CountCobroAgua();
                countCobroAgua.setNum_factura(res.getInt("conteo"));
            }
            ps.close();
            Conexion.getInstace().closeConnection(conec);

        } catch (SQLException e) {
            //solo un mensaje en consola
            System.out.println("No se a podido realizar la consulta " + e.getMessage());
            ps.close();
            Conexion.getInstace().closeConnection(conec);
        }
        return countCobroAgua;
    }
}
