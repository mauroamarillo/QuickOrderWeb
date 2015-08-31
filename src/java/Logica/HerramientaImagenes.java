/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica;

import java.awt.Image;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URL;
import javax.imageio.ImageIO;
import javax.swing.ImageIcon;

/**
 *
 * @author Jean
 */
public abstract class HerramientaImagenes {


    public static ImageIcon obtenerImagenEscalada(String path, int w, int h) {
        Image img = new ImageIcon(path).getImage();
        Image newImg;
        newImg = img.getScaledInstance(w, h, java.awt.Image.SCALE_AREA_AVERAGING);
        return new ImageIcon(newImg);
    }

    public static ImageIcon escalarIcono(ImageIcon ico, int w, int h) {
        Image img = ico.getImage();
        Image newImg;
        newImg = img.getScaledInstance(w, h, java.awt.Image.SCALE_FAST);
        return new ImageIcon(newImg);
    }

    /**
     *
     * @param path
     * @return
     */
    public static ImageIcon cargarImagen(String path) {
        if (path.equals("sin_imagen")) {
            return new ImageIcon("src/img/sin_img.jpg");
        }
        try {
            URL intlLogoURL = new URL(path);
            InputStream in = intlLogoURL.openStream();
            return new ImageIcon(ImageIO.read(in));
        } catch (Exception e) {
            try {
                InputStream in = new FileInputStream(new File(path)); // こころ　
                return new ImageIcon(ImageIO.read(in));
            } catch (Exception ee) {
                return new ImageIcon("src/img/NoImgDisp.png");
            }
        }
    }

    public static ImageIcon cargarYescalar(String path, int w, int h) {
        return escalarIcono(cargarImagen(path), w, h);
    }
}
