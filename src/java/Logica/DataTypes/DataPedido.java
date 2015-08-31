/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica.DataTypes;

import Logica.Estado;
import Logica.Pedido;
import Logica.ProdPedido;
import java.sql.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 *
 * @author Jean
 */
public class DataPedido {

    private final int numero;
    private final Date fecha;
    private final Estado estado;
    private final HashMap prodPedidos;
    private final String cliente;
    private final String restaurante;
    private final float precio;

    public DataPedido(int numero, Date fecha, Estado estado, HashMap prodPedidos, String cliente, String restaurante, float precio) {
        this.numero = numero;
        this.fecha = fecha;
        this.estado = estado;
        this.prodPedidos = prodPedidos;
        this.cliente = cliente;
        this.restaurante = restaurante;
        this.precio = precio;
    }

    public DataPedido(Pedido P) {
        this.numero = P.getNumero();
        this.fecha = P.getFecha();
        this.estado = P.getEstado();
        this.cliente = P.getCliente().getNickname();
        this.restaurante = P.getRestaurante().getNickname();
        this.precio = P.getPrecio();
        /*por cada objeto producto de pedido se  crea un datatype*/
        Iterator it = P.getProdPedidos().entrySet().iterator();
        this.prodPedidos = new HashMap();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            ProdPedido p = (ProdPedido) entry.getValue();
            prodPedidos.put(p.getProducto().getNombre(), new DataProdPedido(p));
        }

    }

    public float getPrecio() {
        return precio;
    }

    public int getNumero() {
        return numero;
    }

    public Date getFecha() {
        return fecha;
    }

    public Estado getEstado() {
        return estado;
    }

    public HashMap getProdPedidos() {
        return prodPedidos;
    }

    public String getCliente() {
        return cliente;
    }

    public String getRestaurante() {
        return restaurante;
    }

}
