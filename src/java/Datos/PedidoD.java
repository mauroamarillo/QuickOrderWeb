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

public class PedidoD {

    private final Estructura es = new Estructura();
    private Statement st;

    public PedidoD(){// throws SQLException, ClassNotFoundException {
       // this.st = es.generarSt();
    }

    public int agregarPedido(Date fecha, int estado, String cliente, String restaurante) throws SQLException, ClassNotFoundException {
       this.st = es.generarSt();
        String query = "INSERT INTO pedidos(fecha,estado,cliente,restaurante)"
                + " VALUES('" + fecha + "','" + estado + "','" + cliente + "','" + restaurante + "') RETURNING numero";
        ResultSet rs = st.executeQuery(query);
        rs.next();
        st.getConnection().close();
        return rs.getInt("numero");
    }

    public void agregarLineaDePedido(int numero, String restaurante, String producto, int cantidad) throws SQLException, ClassNotFoundException {
        this.st = es.generarSt();
        String query = "INSERT INTO pedidos_producto(pedido,restaurante,producto,cantidad)"
                + " VALUES(" + numero + ",'" + restaurante + "','" + producto + "'," + cantidad + ")";
        st.execute(query);
        st.getConnection().close();
    }

    public ResultSet listarPedidos() throws SQLException, ClassNotFoundException {
        this.st = es.generarSt();
        String query = " SELECT * "
                + " FROM pedidos";
       ResultSet rs = st.executeQuery(query);
        st.getConnection().close();
        return rs;
    }

    public ResultSet listarLineasDePedidos(int numero) throws SQLException, ClassNotFoundException {
       this.st = es.generarSt();
       String query = " SELECT * "
                + " FROM pedidos_producto "
                + " WHERE pedido = " + numero;
        ResultSet rs = st.executeQuery(query);
        st.getConnection().close();
        return rs;
    }

    public ResultSet listarPedidosDeCliente(String nick) throws SQLException, ClassNotFoundException {
        this.st = es.generarSt();
        String query = " SELECT * "
                + " FROM pedidos"
                + " WHERE cliente='" + nick + "'";
        ResultSet rs = st.executeQuery(query);
        st.getConnection().close();
        return rs;
    }

    public ResultSet listarLinasDePedidosDeCliente(String nick) throws SQLException, ClassNotFoundException {
       this.st = es.generarSt();
       String query = " SELECT pp.pedido, pp.restaurante,pp.producto,pp.cantidad "
                + " FROM pedidos p, pedidos_producto pp"
                + " WHERE p.numero = pp.pedido"
                + " AND p.cliente='" + nick + "'";
        ResultSet rs = st.executeQuery(query);
        st.getConnection().close();
        return rs;
    }

    public void eliminarPedido(int numero) throws SQLException, ClassNotFoundException {
       this.st = es.generarSt();
       String query = "DELETE FROM pedidos_producto "
                + "WHERE pedido = " + numero;
        st.execute(query);
        query = "DELETE FROM pedidos"
                + " WHERE numero = " + numero;
        st.execute(query);
        st.getConnection().close();
    }

    public void modificarEstado(int numero, int estado) throws SQLException, ClassNotFoundException {
        this.st = es.generarSt();
        String query = "UPDATE pedidos SET estado = " + estado
                + " WHERE numero = " + numero;
        st.execute(query);
        st.getConnection().close();
    }

    public void modificarCantidadProducto(int numero, String restaurante, String producto, int cantidad) throws SQLException, ClassNotFoundException{
        this.st = es.generarSt();
        String query = "UPDATE pedidos_producto SET cantidad = " + cantidad
                + "WHERE pedido=" + numero + " AND restaurante='" + restaurante + "' AND producto='" + producto + "';";
        st.execute(query);
        st.getConnection().close();
    }
    
    public ResultSet obtenerCalificacion(int pedido) throws SQLException, ClassNotFoundException{
        this.st = es.generarSt();
        String query = " SELECT * "
                + " FROM calificaciones"
                + " WHERE pedido=" + pedido + ";";
        ResultSet rs = st.executeQuery(query);
        st.getConnection().close();
        return rs;
    }
    
    public ResultSet obtenerPedidosRestaurante(String nick) throws SQLException, ClassNotFoundException{
        this.st = es.generarSt();
        String query = " SELECT * "
                + " FROM pedidos"
                + " WHERE restaurante='" + nick + "';";
        ResultSet rs = st.executeQuery(query);
        st.getConnection().close();
        return rs;
    }
    
    public void calificarPedido(int numero, Date fecha, int calificacion, String comentario) throws SQLException, ClassNotFoundException{
        this.st = es.generarSt();
        String query = "INSERT INTO calificaciones(fecha, pedido, puntaje, comentario)"
            + "VALUES ('" + fecha + "', " + numero + ", " + calificacion + ", '" + comentario + "');";
        st.execute(query);
        st.getConnection().close();
    }
    
    public void removerLineaDePedido(int pedido, String restaurante, String producto) throws SQLException, ClassNotFoundException{
        this.st = es.generarSt();
        String query = "DELETE FROM pedidos_producto"
            + " WHERE pedido = " + pedido + " AND restaurante = '" + restaurante + "' AND producto = '" + producto + "';";
        st.execute(query);
        st.getConnection().close();
    }
}