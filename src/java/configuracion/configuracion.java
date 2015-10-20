/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package configuracion;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.net.URL;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Shean
 */
public abstract class configuracion {

    private final static String RUTA = System.getProperty("user.home") + "\\QuickOrderWeb\\propiedades.properties";

    private static boolean existe() {
        return (new java.io.File(RUTA)).exists();
    }

    private static String configurar() {
        try {
            File archivo = new File(RUTA);
            BufferedWriter bw;
            bw = new BufferedWriter(new FileWriter(archivo));
            bw.write("rutaWS=\"http://localhost:8080/WSUsuario/WSQuickOrder?wsdl\"");
            bw.close();
            return "http://localhost:8080/WSUsuario/WSQuickOrder?wsdl";
        } catch (IOException ex) {
            Logger.getLogger(configuracion.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public static String URLWS() {
        if(!existe()){
            return configurar();
        }        
        try {
            Properties propiedades = new Properties();
            propiedades.load(new FileInputStream(RUTA));
            String rutaWS = propiedades.getProperty("rutaWS");
            return rutaWS;
        } catch (IOException ex) {
            Logger.getLogger(configuracion.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
}
