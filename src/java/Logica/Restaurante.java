/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica;

import Logica.DataTypes.DataIndividual;
import Logica.DataTypes.DataPromocion;
import Logica.DataTypes.DataRestaurante;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 *
 * @author usuario
 */
public class Restaurante extends Usuario {

    private HashMap categorias;
    private HashMap individuales;
    private HashMap promociones;
    private HashMap imagenes;

    public Restaurante(String nickname, String nombre, String email, String direccion, HashMap categorias, HashMap individuales, HashMap promociones, HashMap imagenes, String pwd) {
        super(nickname, nombre, email, direccion, pwd);
        this.categorias = categorias;
        this.individuales = individuales;
        this.promociones = promociones;
        this.imagenes = imagenes;
    }

    public DataRestaurante getDataType() {

        HashMap dataCategorias = new HashMap();
        Iterator it = categorias.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            String c = (String) entry.getValue();
            dataCategorias.put(c, c);
        }
        HashMap dataIndividuales = new HashMap();
        it = individuales.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            Individual I = (Individual) entry.getValue();
            dataIndividuales.put(nickname + "_" + I.getNombre(), new DataIndividual(I));
        }
        HashMap dataPromociones = new HashMap();
        it = promociones.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            Promocion P = (Promocion) entry.getValue();
            dataPromociones.put(nickname + "_" + P.getNombre(), new DataPromocion(P));
        }
        HashMap imgs = new HashMap();
        it = imagenes.entrySet().iterator();
        int x = 1;
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            String I = (String) entry.getValue();
            imgs.put(x, I);
            x++;
        }
        return new DataRestaurante(nickname, nombre, email, direccion, dataCategorias, dataIndividuales, dataPromociones, imgs, pwd);
    }

    public HashMap getImagenes() {
        return imagenes;
    }

    public HashMap getCategorias() {
        return categorias;
    }

    public HashMap getIndividuales() {
        return individuales;
    }

    public HashMap getPromociones() {
        return promociones;
    }

    public void setCategorias(HashMap categorias) {
        this.categorias = categorias;
    }

    public void setIndividuales(HashMap individuales) {
        this.individuales = individuales;
    }

    public void setPromociones(HashMap promociones) {
        this.promociones = promociones;
    }

    public void setImagenes(HashMap imagenes) {
        this.imagenes = imagenes;
    }

}
