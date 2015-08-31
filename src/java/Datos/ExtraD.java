/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Datos;

import java.io.IOException;
import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Mauro
 */
public class ExtraD {

    private final Estructura es = new Estructura();
    private Statement st;

    public ExtraD() {// throws SQLException, ClassNotFoundException {
        //  this.st = es.generarSt();
    }

    public void restaurarSchema() throws IOException {/*
         Runtime r;
         Process p;
         //ProcessBuilder pb;
         r = Runtime.getRuntime();
         String[] cmd = {
         "C:\\Program Files\\PostgreSQL\\9.4\\bin\\pg_restore.exe",
         "--host", "localhost",
         "--port", "5433",
         "--username", "postgres",
         "--dbname", "quickorderDB",
         "--password", "1234",
         "--verbose",
         "C:\\quickorderDB.backup"
         };
         p = r.exec(cmd);*/


        String path = "src/sql/quickorderDB.backup";
        Runtime r = Runtime.getRuntime();

        String user = "postgres";
        String dbase = "jdbc:postgresql://localhost:5432/quickorderDB";
        String password = "1234";

        Process p;
        ProcessBuilder pb;

        r = Runtime.getRuntime();
        pb = new ProcessBuilder("pg_dump", "-v", "-D", "-f", path, "-U", user, dbase);
        pb.environment().put("PGPASSWORD", password);
        pb.redirectErrorStream(true);
        p = pb.start();

    }

    public void cargarDatosDePrueba() throws IOException, SQLException, ClassNotFoundException {
        BufferedReader br = new BufferedReader(new FileReader("src/sql/datosPrueba.sql"));
        StringBuilder sb = new StringBuilder();
        String line = br.readLine();
        if (line != null) {
            line = line.substring(1);
        }

        while (line != null) {
            sb.append(line);
            sb.append("\n");
            line = br.readLine();
        }
        // JOptionPane.showMessageDialog(null, sb.toString(), "A ver", JOptionPane.INFORMATION_MESSAGE);
        this.st = es.generarSt();
        st.execute(sb.toString());
        st.getConnection().close();
    }
}
