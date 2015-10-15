/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

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
public class verificar extends HttpServlet {

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
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String dato = null;
            if (request.getParameter("nick") != null) {
                dato = request.getParameter("nick");
                if (dato == null) {
                    out.print("<span style='font-weight:bold;color:white;'>Ingrese un nickname</span>");
                    return;
                }
                if (!dato.isEmpty()) {
                    if (nickOcupado(dato)) {
                        out.print("<span style='font-weight:bold;color:green;'>Disponible.</span>");
                    } else {
                        out.print("<span style='font-weight:bold;color:red;'>El nombre de usuario ya existe.</span>");
                    }
                } else {
                    out.print("<span style='font-weight:bold;color:white;'>Ingrese un nickname</span>");
                }
            }
            if (request.getParameter("email") != null) {
                dato = request.getParameter("email");
                if (dato == null) {
                    out.print("<span style='font-weight:bold;color:white;'>Ingrese Email</span>");
                    return;
                }
                if (!dato.isEmpty()) {
                    if (emailOcupado(dato)) {
                        out.print("<span style='font-weight:bold;color:green;'>Disponible.</span>");
                    } else {
                        out.print("<span style='font-weight:bold;color:red;'>Ya existe este email en la base de datos.</span>");
                    }
                } else {
                    out.print("<span style='font-weight:bold;color:white;'>Ingrese su email</span>");
                }
            }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(verificar.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(verificar.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(verificar.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(verificar.class.getName()).log(Level.SEVERE, null, ex);
        }
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

    private static Boolean emailOcupado(java.lang.String arg0) {
        ClienteWS.WSQuickOrder_Service service = new ClienteWS.WSQuickOrder_Service();
        ClienteWS.WSQuickOrder port = service.getWSQuickOrderPort();
        return port.emailOcupado(arg0);
    }

    private static Boolean nickOcupado(java.lang.String arg0) {
        ClienteWS.WSQuickOrder_Service service = new ClienteWS.WSQuickOrder_Service();
        ClienteWS.WSQuickOrder port = service.getWSQuickOrderPort();
        return port.nickOcupado(arg0);
    }

}
