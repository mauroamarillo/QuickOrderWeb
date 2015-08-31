/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica.DataTypes;

import Logica.Producto;

/**
 *
 * @author Jean
 */
public class DataProducto {

    protected final String nombre;
    protected final String descripcion;
    protected final float precio;
    protected final String imagen;
    protected final String restaurante;

    public DataProducto(String nombre, String descripcion, float precio, String imagen, String restaurante) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.precio = precio;
        this.imagen = imagen;
        this.restaurante = restaurante;
    }

    public DataProducto(Producto P) {
        this.nombre = P.getNombre();
        this.descripcion = P.getDescripcion();
        this.precio = P.getPrecio();
        this.imagen = P.getImagen();
        this.restaurante = P.getRestaurante().getNickname();
    }

    public String getNombre() {
        return nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public float getPrecio() {
        return precio;
    }

    public String getImagen() {
        return imagen;
    }

    public String getRestaurante() {
        return restaurante;
    }

}
