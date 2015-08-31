/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Datos;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class UsuarioD {

    private final Estructura es = new Estructura();
    private Statement st;

    public UsuarioD() {// throws SQLException, ClassNotFoundException {
        // this.st = es.generarSt();
    }

    public boolean nickOcupado(String nick) throws SQLException, ClassNotFoundException {
        this.st = es.generarSt();
        String query = "SELECT nickname FROM usuarios WHERE nickname = '" + nick + "';";
        ResultSet rs = st.executeQuery(query);
        st.getConnection().close();
        return rs.next();
    }

    public boolean emailOcupado(String email) throws SQLException, ClassNotFoundException {
        this.st = es.generarSt();
        String query = "SELECT email FROM usuarios WHERE email = '" + email + "';";
        ResultSet rs = st.executeQuery(query);
        st.getConnection().close();
        return rs.next();
    }

    private void agregarUsuario(String nick, String nombre, String email, String direccion) throws SQLException, ClassNotFoundException {
        this.st = es.generarSt();
        String Usuario = "INSERT INTO usuarios(nickname,nombre,email,direccion) "
                + " VALUES('" + nick + "','" + nombre + "','" + email + "','" + direccion + "');";
        st.execute(Usuario);
        st.getConnection().close();
    }

    public void agregarCliente(String nick, String nombre, String email, String direccion, String apellido, Date fechaN, String imagen) throws SQLException, ClassNotFoundException {
        agregarUsuario(nick, nombre, email, direccion);
        this.st = es.generarSt();
        /*Registro al Usuario como cliente*/
        String Cliente = "INSERT INTO clientes(\"nicknameC\",\"apellido\",\"fechaN\") "
                + " VALUES('" + nick + "','" + apellido + "','" + fechaN + "');";

        st.execute(Cliente);
        /*Si no se le asigno una imagen retorno*/
        if (imagen.equals("sin_imagen")) {
            return;
        }
        /*si hay imagen guarda la ruta y la asocia con el cliente*/
        String Img = " INSERT INTO clientes_imagenes(cliente,imagen)"
                + " VALUES('" + nick + "','" + imagen + "')";
        st.execute(Img);
        st.getConnection().close();
    }

    public void agregarRestaurante(String nick, String nombre, String email, String direccion) throws SQLException, ClassNotFoundException {
        agregarUsuario(nick, nombre, email, direccion);
        this.st = es.generarSt();
        String Restaurante = "INSERT INTO restaurantes(\"nicknameR\") "
                + " VALUES('" + nick + "');";
        st.execute(Restaurante);
        st.getConnection().close();
    }

    public void agregarImgRestaurante(String nick, String path) throws SQLException, ClassNotFoundException {
        this.st = es.generarSt();
        String Imagen = " INSERT INTO restaurantes_imagenes(restaurante,imagen)"
                + " VALUES('" + nick + "','" + path + "');";
        st.execute(Imagen);
        st.getConnection().close();
    }

    public void agregarCategoriaARestaurante(String nick, int cat) throws SQLException, ClassNotFoundException {
        this.st = es.generarSt();
        String categoria = "INSERT INTO restaurantes_categorias(restaurante,categoria) "
                + "VALUES('" + nick + "','" + cat + "');";
        st.execute(categoria);
        st.getConnection().close();
    }

    public ResultSet listarRestaurantes() throws SQLException, ClassNotFoundException {
        this.st = es.generarSt();
        String query = " SELECT * "
                + " FROM usuarios u, restaurantes r"
                + " WHERE u.nickname = r.\"nicknameR\";";
        ResultSet rs = st.executeQuery(query);
        st.getConnection().close();
        return rs;
    }

    public ResultSet listarIMGsRestaurante(String nick) throws SQLException, ClassNotFoundException {
        this.st = es.generarSt();
        String query = "SELECT imagen "
                + " FROM restaurantes_imagenes"
                + " WHERE restaurante = '" + nick + "';";
        ResultSet rs = st.executeQuery(query);
        st.getConnection().close();
        return rs;
    }

    public ResultSet listarClientes() throws SQLException, ClassNotFoundException {
        this.st = es.generarSt();
        String query = " SELECT * "
                + " FROM usuarios u, clientes c"
                + " WHERE u.nickname = c.\"nicknameC\";";
        ResultSet rs = st.executeQuery(query);
        st.getConnection().close();
        return rs;
    }

    public String obtenerIMGCliente(String nick) throws SQLException, ClassNotFoundException {
        this.st = es.generarSt();
        String query = "SELECT imagen"
                + " FROM clientes_imagenes"
                + " WHERE cliente = '" + nick + "';";
        ResultSet rs = st.executeQuery(query);
        st.getConnection().close();
        if (rs.next()) {
            return rs.getString("imagen");
        }
        return "sin_imagen";
    }
}
