/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica;

import Logica.DataTypes.DataProdPedido;

/**
 *
 * @author usuario
 */
public class ProdPedido {

    private int cantidad;
    private Producto producto;

    public ProdPedido(int cantidad, Producto producto) {
        this.cantidad = cantidad;
        this.producto = producto;
    }

    public DataProdPedido getDataType() {
        return new DataProdPedido(cantidad, producto.getDataType());
    }

    public int getCantidad() {
        return cantidad;
    }

    public float getPrecio(){
        return cantidad * producto.getPrecio();
    }
    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }

}
