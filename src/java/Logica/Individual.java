/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica;

import Logica.DataTypes.DataIndividual;

/**
 *
 * @author usuario
 */
public class Individual extends Producto {

    private float precio;

    public Individual(String nombre, String descripcion, float precio, String imagen, Restaurante restaurante) {
        super(nombre, descripcion, imagen, restaurante);
        this.precio = precio;
    }
    @Override
    public DataIndividual getDataType() {
        return new DataIndividual(nombre, descripcion, this.getPrecio(), imagen, restaurante.getNickname());
    }

    @Override
    public float getPrecio() {
        return precio;
    }

}
