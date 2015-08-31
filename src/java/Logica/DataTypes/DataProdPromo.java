/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica.DataTypes;

import Logica.ProdPromo;
/**
 *
 * @author Jean
 */
public class DataProdPromo {

    private final int cantidad;
    private final DataIndividual individual;

    public DataProdPromo(int cantidad, DataIndividual individual) {
        this.cantidad = cantidad;
        this.individual = individual;
    }

    public DataProdPromo(ProdPromo PP) {
        this.cantidad = PP.getCantidad();
        this.individual = new DataIndividual(PP.getIndividual());
    }

    public int getCantidad() {
        return cantidad;
    }

    public DataIndividual getIndividual() {
        return individual;
    }

}
