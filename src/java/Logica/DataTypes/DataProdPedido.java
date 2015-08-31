/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica.DataTypes;

import Logica.ProdPedido;

/**
 *
 * @author Jean
 */
public class DataProdPedido {
    private final int cantidad;
    private final DataProducto producto;

    public DataProdPedido(int cantidad, DataProducto producto) {
        this.cantidad = cantidad;
        this.producto = producto;
    }

    public DataProdPedido(ProdPedido pp) {
        this.cantidad = pp.getCantidad();
        this.producto = new DataProducto(pp.getProducto());
    }
    

    public int getCantidad() {
        return cantidad;
    }

    public DataProducto getProducto() {
        return producto;
    }   
    
}
