package Logica;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.channels.FileChannel;
import java.nio.file.Files;

public abstract class HerramientaArchivos {

    public static void copiarArchivo(String source, String dest) throws IOException {
        Files.copy(new File(source).toPath(), new File(dest).toPath());
    }

    public static void copiarArchivo(File source, File dest) throws IOException {
        Files.copy(source.toPath(), dest.toPath());
    }

    /*
     Encontre otras 3 formas mas de copiar archivos
     por lo que lei capas la siguiente sirve 
     mas al momento de implementar el servidor
     por eso lo dejo aca tambien
     */
    
    public static void copyFile(String inicio, String fin) throws IOException {
        File sourceFile = new File(inicio);
        File destFile = new File(fin);
        if (!destFile.exists()) {
            destFile.createNewFile();
        }
        FileChannel origen = null;
        FileChannel destino = null;
        try {
            origen = new FileInputStream(sourceFile).getChannel();
            destino = new FileOutputStream(destFile).getChannel();

            long count = 0;
            long size = origen.size();
            while ((count += destino.transferFrom(origen, count, size - count)) < size);
            
        } finally {
            if (origen != null) {
                origen.close();
            }
            if (destino != null) {
                destino.close();
            }
        }
    }

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
