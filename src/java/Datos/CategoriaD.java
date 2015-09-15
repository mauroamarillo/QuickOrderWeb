/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Datos;

/**
 *
 * @author Mauro
 */
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class CategoriaD {

    private final Estructura es;
    private Statement st;

    public CategoriaD() throws SQLException, ClassNotFoundException {
        es = new Estructura();
        // st = es.generarSt();
    }

    public ResultSet consultarCategorias() throws SQLException, ClassNotFoundException {
        this.st = es.generarSt();
        String seleccion = "SELECT * FROM categorias";
        ResultSet rs = st.executeQuery(seleccion);
        st.getConnection().close();
        return rs;
    }

    public void agregarCategoria(String nombre) throws SQLException, ClassNotFoundException {
        this.st = es.generarSt();
        String insert = "INSERT INTO categorias(nombre) VALUES('" + nombre + "');";
        st.execute(insert);
        st.getConnection().close();
    }

    public ResultSet listarCatsRestaurante(String nick) throws SQLException, ClassNotFoundException {
        this.st = es.generarSt();
        String query = "SELECT c.nombre "
                + " FROM categorias c, restaurantes_categorias rc"
                + " WHERE c.\"idCat\" = rc.categoria"
                + " AND rc.restaurante = '" + nick + "';";
        ResultSet rs = st.executeQuery(query);
        st.getConnection().close();
        return rs;
    }
}
