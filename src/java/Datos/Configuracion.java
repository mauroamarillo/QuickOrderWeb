/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Datos;

/**
 *
 * @author usuario
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Configuracion {

    private Connection conexion;

    public Connection getConexion() {
        return conexion;
    }

    public void conectarBD() throws ClassNotFoundException, SQLException {
        String url = "jdbc:postgresql://localhost:5433/quickorderDB";
        String usuario = "postgres";
        String contrasenia = "1234";
        if (conexion != null) {
            return;
        }
        Class.forName("org.postgresql.Driver");
        conexion = DriverManager.getConnection(url, usuario, contrasenia);
    }

    public void desconectarBD() throws SQLException {
        conexion.close();
    }

}
