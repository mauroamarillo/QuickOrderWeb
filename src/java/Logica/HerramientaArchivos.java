package Logica;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;

public abstract class HerramientaArchivos {

    public static void copiarArchivo(File source, File dest) throws IOException {
        Files.copy(source.toPath(), dest.toPath());
    }
    
    /*
     Encontre otras 3 formas mas de copiar archivos
     por lo que lei capas la siguiente sirve 
     mas al momento de implementar el servidor
     por eso lo dejo aca tambien
     */

    public static void copyFileUsingFileStreams(File source, File dest) throws IOException {
        InputStream input = null;
        OutputStream output = null;
        try {
            input = new FileInputStream(source);
            output = new FileOutputStream(dest);
            byte[] buf = new byte[1024];
            int bytesRead;
            while ((bytesRead = input.read(buf)) > 0) {
                output.write(buf, 0, bytesRead);
            }
        } finally {
            input.close();
            output.close();
        }
    }

}
