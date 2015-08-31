/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica;

import Logica.DataTypes.DataProdPromo;

/**
 *
 * @author usuario
 */
public class ProdPromo{
    private int cantidad;
    private Individual individual;
    
    public ProdPromo(int cantidad, Individual ind){
        this.cantidad = cantidad;
        this.individual = ind;
    }
    public DataProdPromo getDataType() {
        return new DataProdPromo(cantidad,individual.getDataType());
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public Individual getIndividual() {
        return individual;
    }

    public void setIndividual(Individual individual) {
        this.individual = individual;
    }
}
