package servlets;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import ClienteWS.DataCliente;
import java.io.IOException;
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
public class login extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     * @throws java.lang.ClassNotFoundException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
         /*Este codigo es igual siempre para crear los puertos a el WS*/
            ClienteWS.WSQuickOrder_Service service = null;
            String rutaWS = configuracion.configuracion.URLWS();
            try {
                if (rutaWS == null) {
                    service = new ClienteWS.WSQuickOrder_Service();
                } else {
                    service = new ClienteWS.WSQuickOrder_Service(new java.net.URL(rutaWS));
                }
            } catch (javax.xml.ws.WebServiceException e) {

                response.getOutputStream().print("<link href =\"css/estilos.css\" rel=\"stylesheet\" />"
                        + "<div class=\"Exception\"> " + e.getMessage() + "</div>");
                return;
            }
            ClienteWS.WSQuickOrder port = service.getWSQuickOrderPort();
            /*aca termina*/
        String user = request.getParameter("nick");
        String pass = request.getParameter("passwd");
        HttpSession session = request.getSession();
        if (port.nickOcupado(user)) {
            DataCliente DC = port.buscarCliente(user);
            if (DC != null) {
                String passCorrecta = DC.getPwd();
                if (passCorrecta != null && passCorrecta.equals(pass)) {
                    session.setAttribute("nick", DC.getNickname());
                    session.setAttribute("nombre", DC.getNombre());
                    session.setAttribute("apellido", DC.getApellido());
                    response.sendRedirect("index.jsp");
                } else {
                    response.sendRedirect("index.jsp?error=2"); //el pass no coincide
                }
            } else {
                response.sendRedirect("index.jsp?error=1"); // no se encontro el usuario
            }
        } else {
            if (port.emailOcupado(user)) {
                DataCliente DC = port.buscarClientePorEmail(user);
                if (DC != null) {
                    String passCorrecta = DC.getPwd();
                    if (passCorrecta != null && passCorrecta.equals(pass)) {
                        session.setAttribute("nick", DC.getNickname());
                        session.setAttribute("nombre", DC.getNombre());
                        session.setAttribute("apellido", DC.getApellido());
                        response.sendRedirect("index.jsp");
                    } else {
                        response.sendRedirect("index.jsp?error=2"); //el pass no coincide
                    }
                } else {
                    response.sendRedirect("index.jsp?error=1"); // no se encontro el usuario
                }
            } else {
                response.sendRedirect("index.jsp?error=1"); // no se encontro el usuario
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
            Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
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


}
