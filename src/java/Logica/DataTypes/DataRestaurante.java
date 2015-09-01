/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica.DataTypes;

import Logica.Individual;
import Logica.Promocion;
import Logica.Restaurante;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 *
 * @author Jean
 */
public class DataRestaurante {

    private final String nickname;
    private final String pwd;
    private final String nombre;
    private final String email;
    private final String direccion;

    private final HashMap categorias;
    private final HashMap individuales;
    private final HashMap promociones;
    private final HashMap imagenes;

    public DataRestaurante(String nickname, String nombre, String email, String direccion, HashMap categorias, HashMap individuales, HashMap promociones, HashMap imagenes, String pwd) {
        this.nickname = nickname;
        this.pwd = pwd;
        this.nombre = nombre;
        this.email = email;
        this.direccion = direccion;
        this.categorias = categorias;
        this.individuales = individuales;
        this.promociones = promociones;
        this.imagenes = imagenes;
    }

    public DataRestaurante(Restaurante R) {
        this.nickname = R.getNickname();
        this.pwd = R.getPwd();
        this.nombre = R.getNombre();
        this.email = R.getEmail();
        this.direccion = R.getDireccion();

        Iterator it = R.getCategorias().entrySet().iterator();
        this.categorias = new HashMap();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            String C = (String) entry.getValue();
            this.categorias.put(C, C);
        }

        it = R.getIndividuales().entrySet().iterator();
        this.individuales = new HashMap();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            Individual I = (Individual) entry.getValue();
            this.individuales.put(I.getRestaurante().getNickname() + "_" + I.getNombre(), new DataIndividual(I));
        }
        it = R.getPromociones().entrySet().iterator();
        this.promociones = new HashMap();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            Promocion P = (Promocion) entry.getValue();
            this.promociones.put(P.getRestaurante().getNickname() + "_" + P.getNombre(), new DataPromocion(P));
        }
        it = R.getImagenes().entrySet().iterator();
        this.imagenes = new HashMap();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            String I = (String) entry.getValue();
            this.imagenes.put(entry.getKey(), I);
        }
    }

    public String getNickname() {
        return nickname;
    }

    public String getNombre() {
        return nombre;
    }

    public String getEmail() {
        return email;
    }

    public String getDireccion() {
        return direccion;
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

    public HashMap getImagenes() {
        return imagenes;
    }

}
