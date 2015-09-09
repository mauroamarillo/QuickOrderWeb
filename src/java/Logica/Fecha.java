package Logica;

/**
 * @Fuente http://www.it.uc3m.es/tsps/lab/2/soluciones/Fecha.java
 * @author Jean
 */
import java.sql.Date;
import java.util.Calendar;

public class Fecha {

    /**
     * Meses del año, ordenados, para facilitar la conversión de formato cadena
     * a número y viceversa
     *
     * El número de mes coincidirá con la posición de su nombre en el array más
     * 1 (porque las posiciones del array se numeran a partir de 0 pero los
     * meses a partir de 1)
     */
    private static final String[] meses = {"enero", "febrero", "marzo", "abril", "mayo",
        "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"};

    // ATRIBUTOS
    private int dia;
    private int mes;
    private int agno;

    // CONSTRUCTORES
    public Fecha() {
        this.dia = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
        this.mes = Calendar.getInstance().get(Calendar.MONTH) + 1;
        this.agno = Calendar.getInstance().get(Calendar.YEAR);
    }

    public Fecha(Date f) {
        
        Calendar cal = Calendar.getInstance();
        cal.setTime(f);
        
        this.dia = cal.get(Calendar.DAY_OF_MONTH);
        this.mes = cal.get(Calendar.MONTH) + 1;
        this.agno = cal.get(Calendar.YEAR);
    }

    public Fecha(int dia, int mes, int agno) throws Exception {

        comprobarFecha(dia, mes, agno);

        this.dia = dia;
        this.mes = mes;
        this.agno = agno;

    }

    public Fecha(String sDia, String sNombreMes, String sAgno) throws Exception {

        // Convertir las cadenas del dia y el año en numeros
        try {
            dia = Integer.parseInt(sDia);
            agno = Integer.parseInt(sAgno);

        } catch (NumberFormatException nfe) {
            // Error al convertir una cadena en numero
            throw new Exception("Fecha incorrecta");
        }

        mes = getMes(sNombreMes);

        // Comprobar ademas que los valores tienen sentido
        comprobarFecha(dia, mes, agno);

    }

    // ACCESORES
    public int getDia() {
        return dia;
    }

    public int getMes() {
        return mes;
    }

    public int getAgno() {
        return agno;
    }

    public void setDia(int dia) throws Exception {
        comprobarFecha(dia, this.mes, this.agno);
        this.dia = dia;
    }

    public void setMes(int mes) throws Exception {
        comprobarFecha(this.dia, mes, this.agno);
        this.mes = mes;
    }

    public void setAgno(int agno) throws Exception {
        comprobarFecha(dia, mes, agno);
        this.agno = agno;
    }

    // METODOS
    @Override
    public String toString() {
        return (dia + " de " + meses[mes - 1] + " de " + agno);
    }

    public int compareTo(Fecha fecha) {

        int resultado = 0;

        if (agno < fecha.getAgno()) {
            resultado = -1;
        } else if (agno > fecha.getAgno()) {
            resultado = 1;
        } else {		// los años son iguales => comparar los meses

            if (mes < fecha.getMes()) {
                resultado = -1;
            } else if (mes > fecha.getMes()) {
                resultado = 1;
            } else {		// los meses también son iguales => comparar los dias

                if (dia < fecha.getDia()) {
                    resultado = -1;
                } else if (dia > fecha.getDia()) {
                    resultado = 1;
                } else {		// los dias también son iguales => misma fecha
                    resultado = 0;
                }
            }
        }

        return resultado;
    }

    // METODOS AUXILIARES
    /**
     * Devuelve el numero de dias de un mes dado
     */
    private int getDiasMes(int mes) throws Exception {

        int diasMes = 0;

        switch (mes) {

            case 1:
            case 3:
            case 5:
            case 7:
            case 8:
            case 10:
            case 12:		// meses de 31 dias
                diasMes = 31;
                break;

            case 4:
            case 6:
            case 9:
            case 11:		// meses de 30 dias
                diasMes = 30;
                break;

            case 2:		// febrero
                if (esBisiesto(agno)) {
                    diasMes = 29;
                } else {
                    diasMes = 28;
                }
                break;

            default:			// mes incorrecto
                throw new Exception("Mes incorrecto");
        }

        return diasMes;

    }

    /**
     * Devuelve el número de días de un mes dado
     */
    private int getDiasMes(String mes) throws Exception {
        return getDiasMes(getMes(mes));
    }

    /**
     * Método auxiliar para calcular el número de mes, dado su nombre. Devuelve
     * -1 si el texto introducido no se corresponde con un mes.
     */
    private static int getMes(String sNombreMes) throws Exception {

        // Hallar el numero de mes
        int mes = -1;
        for (int i = 0; i < meses.length; i++) {
            if (meses[i].equals(sNombreMes)) {
                // El mes coincide con el elemento actual del array
                mes = i + 1;
                break;
            }
        }
        return mes;
    }

    /**
     * Método auxiliar para comprobar que una fecha es correcta
     */
    private void comprobarFecha(int dia, int mes, int agno) throws Exception {

        // Comprobar que el dia es correcto
        // (El método getDiasMes ya comprueba que el mes sea correcto)
        if ((dia <= 0) || (dia > getDiasMes(mes))) {
            throw new Exception("Dia incorrecto");
        }

    }

    /**
     * Comprueba si un año es bisiesto Son bisiestos los años múltiplos de 4 que
     * no sean múltiplos de 100 y los múltiplos de 400
     */
    private boolean esBisiesto(int agno) {
        return ((((agno % 4) == 0) && ((agno % 100) != 0))
                || ((agno % 400) == 0));
    }

    public Fecha fechaMasReciente(Fecha[] fechas) {

        Fecha fecha = null;

        if ((fechas != null) && (fechas.length > 0)) {

            int max = 0;
            for (int i = 1; i < fechas.length; i++) {
                if (fechas[max].compareTo(fechas[i]) < 0) {
                    max = i;
                }
            }
            fecha = fechas[max];
        }

        return fecha;

    }

    /*Esta la agrego porque la necesito para insertar*/
    public Date getSQLDate() {
        java.sql.Date fecha = java.sql.Date.valueOf(agno + "-" + mes + "-" + dia);
        return fecha;
    }
}
