/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica;

/**
 *
 * @author usuario
 */
import Logica.DataTypes.DataPedido;
import java.sql.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import Datos.PedidoD;
import Logica.DataTypes.DataCalificacion;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Pedido {
    
    private int numero;
    private Date fecha;
    private Estado estado;
    private HashMap prodPedidos;
    private Cliente cliente;

    private Restaurante restaurante;
    
    private PedidoD PedidoDatos = new PedidoD();

    public Pedido(int numero, Date fecha, Estado estado, Cliente cliente, Restaurante restaurante, HashMap prodPedidos) {
        this.numero = numero;
        this.cliente = cliente;
        this.restaurante = restaurante;
        this.fecha = fecha;
        this.estado = estado;
        this.prodPedidos = prodPedidos;
    }

    public DataPedido getDataType() throws SQLException, ClassNotFoundException {
        HashMap dataProdPedidos;
        dataProdPedidos = new HashMap();
        Iterator it = prodPedidos.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            ProdPedido pp = (ProdPedido) entry.getValue();
            dataProdPedidos.put(pp.getProducto().getNombre(), pp.getDataType());
        }
        return new DataPedido(numero, fecha, estado, dataProdPedidos, cliente.getNickname(), restaurante.getNickname(), getPrecio(), getCalificacion());
    }

    public Cliente getCliente() {
        return cliente;
    }

    public Restaurante getRestaurante() {
        return restaurante;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public void setRestaurante(Restaurante restaurante) {
        this.restaurante = restaurante;
    }

    public int getNumero() {
        return numero;
    }

    public void setNumero(int numero) {
        this.numero = numero;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public float getPrecio() {
        float precio = 0;
        Iterator it = prodPedidos.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            ProdPedido pp = (ProdPedido) entry.getValue();
            precio += pp.getPrecio();
        }
        return precio;
    }
    
    public DataCalificacion getCalificacion() throws SQLException, ClassNotFoundException{
        ResultSet rs = PedidoDatos.obtenerCalificacion(this.numero);
        if(rs.next()){
            return new DataCalificacion(rs.getInt("puntaje"), rs.getString("comentario"));
        }else{
            return new DataCalificacion();
        }
    }

    public Estado getEstado() {
        return estado;
    }

    public void setEstado(Estado estado) {
        this.estado = estado;
    }

    public HashMap getProdPedidos() {
        return prodPedidos;
    }

    public void setProdPedidos(HashMap prodPedidos) {
        this.prodPedidos = prodPedidos;
    }
}
