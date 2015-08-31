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
import java.sql.SQLException;
import java.sql.Statement;

public class Estructura {

    private Statement st;

    public Statement generarSt() throws SQLException, ClassNotFoundException {
        Configuracion config = new Configuracion();
        config.conectarBD();
        st = config.getConexion().createStatement();
        return st;
    }

    public void cerrarSt() throws SQLException {
        st.getConnection().close();
    }
}
