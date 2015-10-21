/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataTypes;


/**
 *
 * @author Shean
 */
public class Fecha {

    private static final String[] meses = {"enero", "febrero", "marzo", "abril", "mayo",
        "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"};

    private int dia;
    private int mes;
    private int anio;

    public Fecha(ClienteWS.Fecha fecha) {
        dia = fecha.getDia();
        mes = fecha.getMes();
        anio = fecha.getAgno();
    }

    public String toString() {
        return (dia + " de " + meses[mes - 1] + " de " + anio);
    }

}
