/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica.DataTypes;

import Logica.Cliente;
import Logica.Pedido;
import java.sql.Date;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 *
 * @author Jean
 */
public class DataCliente {

    private final String nickname;
    private final String pwd;
    private final String nombre;
    private final String email;
    private final String direccion;
    private final String apellido;
    private final Date fechaNac;
    private final String imagen;
    private final HashMap pedidos;

    public DataCliente(String nickname, String nombre, String email, String direccion, String apellido, Date fechaNac, String imagen, HashMap pedidos, String pwd) {
        this.nickname = nickname;
        this.pwd = pwd;
        this.nombre = nombre;
        this.email = email;
        this.direccion = direccion;
        this.apellido = apellido;
        this.fechaNac = fechaNac;
        this.imagen = imagen;
        this.pedidos = pedidos;
    }

    public DataCliente(Cliente C) throws SQLException, ClassNotFoundException {
        this.nickname = C.getNickname();
        this.pwd = C.getPwd();
        this.nombre = C.getNombre();
        this.email = C.getEmail();
        this.direccion = C.getDireccion();
        this.apellido = C.getApellido();
        this.fechaNac = C.getFechaNac();
        this.imagen = C.getImagen();
        this.pedidos = new HashMap();
        /*cambia los objetos pedido por datatypes DataPedido*/
        if (C.getPedidos() != null) {
            Iterator it = C.getPedidos().entrySet().iterator();
            while (it.hasNext()) {
                Map.Entry entry = (Map.Entry) it.next();
                Pedido p = (Pedido) entry.getValue();
                pedidos.put(p.getNumero(), p.getDataType());
            }
        }
    }

    public String getNickname() {
        return nickname;
    }
    
    public String getPwd() {
        return pwd;
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

    public String getApellido() {
        return apellido;
    }

    public Date getFechaNac() {
        return fechaNac;
    }

    public String getImagen() {
        return imagen;
    }

    public HashMap getPedidos() {
        return pedidos;
    }

}
