/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica;

/**
 *
 * @author usuario
 */
import Logica.DataTypes.DataCliente;
import Logica.DataTypes.DataPedido;
import java.sql.Date;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class Cliente extends Usuario {

    private String apellido;
    private Date fechaNac;
    private String imagen;
    private HashMap pedidos;

    public Cliente(String nickname, String nombre, String email, String direccion, String apellido, Date fechaNac, String imagen, HashMap pedidos, String pwd) {
        super(nickname, nombre, email, direccion, pwd);
        this.apellido = apellido;
        this.fechaNac = fechaNac;
        this.imagen = imagen;
        this.pedidos = pedidos;
    }

    public DataCliente getDataType() throws SQLException, ClassNotFoundException {
        HashMap DataPedidos = new HashMap();
        if (pedidos != null) {
            Iterator it = pedidos.entrySet().iterator();
            while (it.hasNext()) {
                Map.Entry entry = (Map.Entry) it.next();
                Pedido p = (Pedido) entry.getValue();
                DataPedidos.put(p.getNumero(), new DataPedido(p));
            }
        }
        return new DataCliente(nickname, nombre, email, direccion, apellido, fechaNac, imagen, DataPedidos, pwd);
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

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public void setFechaNac(Date fechaNac) {
        this.fechaNac = fechaNac;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public void setPedidos(HashMap pedidos) {
        this.pedidos = pedidos;
    }

}