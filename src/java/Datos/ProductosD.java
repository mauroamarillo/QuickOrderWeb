package Datos;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Jean
 */
public class ProductosD {

    private final Estructura es = new Estructura();
    private Statement st;

    public ProductosD() {//throws SQLException, ClassNotFoundException {
        // this.st = es.generarSt();
    }

    public boolean productoRegistrado(String nombre, String restaurante) throws SQLException, ClassNotFoundException {
        this.st = es.generarSt();
        String query = " SELECT * "
                + " FROM productos "
                + " WHERE nombre = '" + nombre + "' "
                + " AND restaurante ='" + restaurante + "';";
        ResultSet rs = st.executeQuery(query);
        st.getConnection().close();
        return rs.next();
    }

    private void agregarImagenProducto(String restaurante, String producto, String imagen) throws SQLException, ClassNotFoundException {
        this.st = es.generarSt();
        String query = " INSERT INTO productos_imagenes(restaurante,producto,imagen)"
                + " VALUES('" + restaurante + "','" + producto + "','" + imagen + "')";
        st.execute(query);
        st.getConnection().close();
    }

    private void agregarProducto(String restaurante, String producto, String descripcion, String imagen) throws SQLException, ClassNotFoundException {
        this.st = es.generarSt();
        String query = " INSERT INTO productos(restaurante,nombre,descripcion) "
                + " VALUES ('" + restaurante + "','" + producto + "','" + descripcion + "');";
        st.execute(query);
        agregarImagenProducto(restaurante, producto, imagen);
        st.getConnection().close();
    }

    public void agregarIndividual(String restaurante, String producto, float precio, String descripcion, String imagen) throws SQLException, ClassNotFoundException {
        this.st = es.generarSt();
        agregarProducto(restaurante, producto, descripcion, imagen);
        String query = " INSERT INTO individuales(restaurante,nombre,precio) "
                + " VALUES ('" + restaurante + "','" + producto + "'," + precio + ");";
        st.execute(query);
        st.getConnection().close();
    }

    public ResultSet listarIndividuales() throws SQLException, ClassNotFoundException {
        this.st = es.generarSt();
        String query = " SELECT p.restaurante, p.nombre, i.precio, p.descripcion "
                + " FROM productos p, individuales i"
                + " WHERE p.restaurante = i.restaurante"
                + " AND p.nombre = i.nombre";
        ResultSet rs = st.executeQuery(query);
        st.getConnection().close();
        return rs;
    }

    public void agregarPromocion(String restaurante, String producto, float descuento, String descripcion, String imagen, boolean act) throws SQLException, ClassNotFoundException {
        agregarProducto(restaurante, producto, descripcion, imagen);
        this.st = es.generarSt();
        String activa = "false";
        if (act) {
            activa = "true";
        }
        String query = " INSERT INTO promociones(restaurante,nombre,activa,descuento) "
                + " VALUES ('" + restaurante + "','" + producto + "'," + activa + "," + descuento + ");";
        st.execute(query);
        st.getConnection().close();
    }

    public void vincularPromocionProducto(String restaurante, String nombrePromo, String nombreProd, int cantidad) throws SQLException, ClassNotFoundException {
        this.st = es.generarSt();
        String query = " INSERT INTO promociones_productos(restaurante,nombrepromo,nombreprod,cantidad) "
                + " VALUES ('" + restaurante + "','" + nombrePromo + "','" + nombreProd + "'," + cantidad + ");";
        st.execute(query);
        st.getConnection().close();
    }

    public ResultSet listarPromociones() throws SQLException, ClassNotFoundException {
        this.st = es.generarSt();
        String query = " SELECT p.restaurante, p.nombre, p.descripcion, pp.descuento, pp.activa "
                + " FROM productos p,promociones pp"
                + " WHERE p.restaurante = pp.restaurante"
                + " AND p.nombre = pp.nombre";
        ResultSet rs = st.executeQuery(query);
        st.getConnection().close();
        return rs;
    }

    public ResultSet listarProductosDePromocion(String restaurante, String nombre) throws SQLException, ClassNotFoundException {
        this.st = es.generarSt();
        String query = " SELECT p.restaurante, p.nombre, p.descripcion, i.precio, pp.cantidad"
                + " FROM productos p,individuales i,promociones_productos pp "
                + " WHERE p.restaurante = i.restaurante"
                + " AND p.nombre = i.nombre"
                + " AND i.restaurante = pp.restaurante"
                + " AND i.nombre = pp.nombreprod"
                + " AND pp.restaurante = '" + restaurante + "'"
                + " AND pp.nombrepromo = '" + nombre + "'";
        ResultSet rs = st.executeQuery(query);
        st.getConnection().close();
        return rs;
    }

    public String obtenerIMGdeProducto(String restaurante, String nombre) throws SQLException, ClassNotFoundException {
        this.st = es.generarSt();
        String query = "SELECT imagen"
                + " FROM productos_imagenes"
                + " WHERE restaurante = '" + restaurante + "'"
                + " AND producto = '" + nombre + "'";
        ResultSet rs = st.executeQuery(query);
        st.getConnection().close();
        if (rs.next()) {
            return rs.getString("imagen");
        }

        return "sin_imagen";
    }
}
