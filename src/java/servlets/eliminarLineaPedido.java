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
public class eliminarLineaPedido extends HttpServlet {

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
            throws ServletException, IOException, SQLException, ClassNotFoundException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
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

                out.print("<link href =\"css/estilos.css\" rel=\"stylesheet\" />"
                        + "<div class=\"Exception\"> " + e.getMessage() + "</div>");
                return;
            }
            ClienteWS.WSQuickOrder port = service.getWSQuickOrderPort();
            /*aca termina*/
            int pedido = Integer.parseInt((String) request.getParameter("pedido"));
            String restaurante = (String) request.getParameter("restaurante");
            String producto = (String) request.getParameter("producto");
            try {
                port.quitarLineaPedido(pedido, restaurante, producto);
                out.println("<p>Producto removido</p>");
            } catch (Exception ex) {
                out.println("<p>" + ex + "</p>");
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
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(eliminarLineaPedido.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(eliminarLineaPedido.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(eliminarLineaPedido.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(eliminarLineaPedido.class.getName()).log(Level.SEVERE, null, ex);
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
