package Dao;

/*librerias usadas para realizar la conexion*/
import org.apache.commons.dbcp2.BasicDataSource;
import java.sql.Connection;
import java.sql.SQLException;

/*en esta clase utilizamos el patron singleton,
buscamos limitar la creacion de objetos no poner new a cada rato*/
public class Conexion {

    /*Constantes necesarias para la conexion, final por que son unicos y no van a cambiar en todo el programa*/
    private final String URL = "jdbc:mysql://localhost:3306/ProyectoSistemaAgua?serverTimezone=EST5EDT";
    private final String USERNAME = "root";
    private final String PASSWORD = "1754429361f";
    
    //creamos un objeto de la clase conecion de esta misma clase
    private static Conexion dataSource;
    //objeto que permite crear un pool de conexiones
    private BasicDataSource basicDataSource = null;

    //colocamos private para que no se puedan crear instancias en otras clases
    private Conexion() {
        //inicializamos la configuracion de BasicDataSource
        basicDataSource = new BasicDataSource();
        basicDataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
        basicDataSource.setUsername(USERNAME);
        basicDataSource.setPassword(PASSWORD);
        basicDataSource.setUrl(URL);
        
        //esto es obsoinal administra dependiendo de los recursos
        /*basicDataSource.setMinIdle(5);//el minimo de conexion inactivas
        basicDataSource.setMaxIdle(20);//el maximo
        basicDataSource.setMaxTotal(50);//cuantas conexiones activa o se permiten
        basicDataSource.setMaxWaitMillis(10000);//en caso de que ya no aya una conexion
        */
    }

    /*para inicializar o crear una instancia de esta clase*/
    public static Conexion getInstace() {
        //verificamos si es igual a null
        if (dataSource == null) {
            //se crea una nueva instancia
            dataSource = new Conexion();
            return dataSource;
        } else {
            //si ya hay solo devuelve
            return dataSource;
        }
    }

    //metodo para estalecer la conexion a la base de datos
    public Connection getConnection() throws SQLException {
            return this.basicDataSource.getConnection();

    }
    
    public void closeConnection(Connection connection) throws SQLException{
    connection.close();
    }

}
