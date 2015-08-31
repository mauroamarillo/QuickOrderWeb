/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica;

import Logica.DataTypes.DataPromocion;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 *
 * @author usuario
 */
public class Promocion extends Producto {

    private boolean activa;
    private float descuento;
    private HashMap prodPromo;

    public Promocion(String nombre, String descripcion, String imagen, boolean activa, float descuento, Restaurante restaurante, HashMap subProductos) {
        super(nombre, descripcion, imagen, restaurante);
        this.activa = activa;
        this.descuento = descuento;
        this.prodPromo = subProductos;
    }

    @Override
    public DataPromocion getDataType() {
        HashMap dataProd = new HashMap();
        Iterator it = prodPromo.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            ProdPromo pp = (ProdPromo) entry.getValue();
            dataProd.put(pp.getIndividual().getRestaurante().getNickname() + "_" + pp.getIndividual().getNombre(), pp.getDataType());
        }
        return new DataPromocion(descuento, activa, dataProd, nombre, descripcion, this.getPrecio(), imagen, restaurante.getNickname());
    }

    @Override
    public float getPrecio() {
        float total = 0;
        Iterator it = prodPromo.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            ProdPromo PP = (ProdPromo) entry.getValue();
            total += (PP.getCantidad() * PP.getIndividual().getPrecio());
        }
        return (total - ((total * descuento) / 100));
    }

    public boolean getActiva() {
        return activa;
    }

    public void setActiva(boolean activa) {
        this.activa = activa;
    }

    public float getDescuento() {
        return descuento;
    }

    public void setDescuento(float descuento) {
        this.descuento = descuento;
    }

    public HashMap getProdPromos() {
        return prodPromo;
    }

    public void setProdPromos(HashMap prodPromos) {
        this.prodPromo = prodPromos;
    }
}
