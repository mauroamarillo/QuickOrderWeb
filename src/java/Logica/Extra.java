/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica;

import Datos.ExtraD;
import java.io.IOException;
import java.sql.SQLException;
/*
 *
 * @author Mauro
 */

public class Extra {

    private final ControladorUsuario cu;
    private final ExtraD e;

    public Extra(ControladorUsuario CU) throws SQLException, ClassNotFoundException {
        cu = CU;
        e = new ExtraD();
    }

    public void cargarDatosPrueba() throws IOException, SQLException, ClassNotFoundException {
        e.cargarDatosDePrueba();
        cu.actualizarDatos();
    }

    public void restaurar() throws IOException {
        e.restaurarSchema();
    }
}
