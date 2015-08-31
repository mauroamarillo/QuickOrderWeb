/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica;

import Logica.DataTypes.DataProducto;

/**
 *
 * @author usuario
 */
public abstract class Producto {

    protected String nombre;
    protected String descripcion;
    protected Restaurante restaurante;
    protected String imagen;

    public Producto(String nombre, String descripcion, String imagen, Restaurante restaurante) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.imagen = imagen;
        this.restaurante = restaurante;
    }

    public DataProducto getDataType() {
        return new DataProducto(nombre, descripcion, this.getPrecio(), imagen, restaurante.getNickname());
    }

    public String getNombre() {
        return nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public float getPrecio() {
        return 0;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public Restaurante getRestaurante() {
        return restaurante;
    }

    public void setRestaurante(Restaurante restaurante) {
        this.restaurante = restaurante;
    }
}
