/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import Logica.ControladorUsuario;
import Logica.HerramientaArchivos;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Jean
 */
public class cambiarDatosCliente extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            ControladorUsuario CU = null;
            if (session.getAttribute("CU") == null) {
                CU = new ControladorUsuario();
            } else {
                CU = (ControladorUsuario) session.getAttribute("CU");
            }
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String cambioImagen = request.getParameter("cambioImagen");
            String email = request.getParameter("email");
            String passwd = request.getParameter("passwd");
            String nick = (String) session.getAttribute("nick");
            String direccion = request.getParameter("direccion");
            String imagen = "";
            if (cambioImagen.equals("1")) {
                HerramientaArchivos.copyFile("C:\\imagenes\\__temp\\nuevo_" + nick + ".jpg", "C:\\imagenes\\" + nick + ".jpg");
            }
            try {
                CU.modificarCliente(nick, nombre, email, direccion, apellido, "ftp://127.0.0.1/" + nick + ".jpg", passwd);
                out.print("<p>Cambios Aplicados</p>");
                session.removeAttribute("nick");
                session.removeAttribute("nombre");
                session.removeAttribute("apellido");
                session.setAttribute("nick", nick);
                session.setAttribute("nombre", nombre);
                session.setAttribute("apellido", apellido);
            } catch (SQLException ex) {
                response.getWriter().print(ex);
            } catch (ClassNotFoundException ex) {
                response.getWriter().print(ex);
            }
        } catch (SQLException ex) {
            response.getWriter().print(ex);
        } catch (ClassNotFoundException ex) {
            response.getWriter().print(ex);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
