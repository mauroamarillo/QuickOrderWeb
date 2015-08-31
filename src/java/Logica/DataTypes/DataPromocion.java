/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica.DataTypes;

import Logica.ProdPromo;
import Logica.Promocion;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 *
 * @author Jean
 */
public class DataPromocion extends DataProducto {

    private final float descuento;
    private final boolean activo;
    private final HashMap dataProdPromo;

    public DataPromocion(float descuento, boolean activo, HashMap dataProdPromo, String nombre, String descripcion, float precio, String imagen, String restaurante) {
        super(nombre, descripcion, precio, imagen, restaurante);
        this.descuento = descuento;
        this.activo = activo;
        this.dataProdPromo = dataProdPromo;
    }

    public DataPromocion(Promocion P) {
        super(P);
        this.descuento = P.getDescuento();
        this.activo = P.getActiva();
        Iterator it = P.getProdPromos().entrySet().iterator();
        dataProdPromo = new HashMap();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            ProdPromo pp = (ProdPromo) entry.getValue();
            dataProdPromo.put(pp.getIndividual().getRestaurante().getNickname() + "_" + pp.getIndividual().getNombre(), new DataProdPromo(pp));
        }
    }

    public HashMap getDataProdPromo() {
        return dataProdPromo;
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

    public float getDescuento() {
        return descuento;
    }

    public boolean isActivo() {
        return activo;
    }

}
