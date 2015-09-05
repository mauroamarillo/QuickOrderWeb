/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import Logica.ControladorUsuario;
import Logica.DataTypes.DataIndividual;
import Logica.DataTypes.DataProdPedido;
import Logica.DataTypes.DataPromocion;
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
public class agregarACarrito extends HttpServlet {

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
            HttpSession session = request.getSession();
            ControladorUsuario CU = null;
            if (session.getAttribute("CU") == null) {
                CU = new ControladorUsuario();
            } else {
                CU = (ControladorUsuario) session.getAttribute("CU");
            }

            String prod = (String) request.getParameter("P");
            int cant = Integer.parseInt((String) request.getParameter("C"));
            String nick = (String) session.getAttribute("nick");
            if (CU.getCP().BuscarDataXRestaurante_Producto(prod) == null) {
                out.print("<p>Error al buscar producto</p>");
            } else {
                if (CU.getCP().BuscarDataXRestaurante_Producto(prod) instanceof DataIndividual) {
                    DataIndividual P = (DataIndividual) CU.getCP().BuscarDataXRestaurante_Producto(prod);
                    DataProdPedido DP = new DataProdPedido(cant, P);
                    CU.agregarACarrito(DP, nick);
                    out.print("<p>Exito</p>");
                    out.print("<p>" + cant + " " + DP.getProducto().getNombre() + "</p>");
                    out.print("<p>Agregado al carrito</p>");
                } else {
                    DataPromocion P = (DataPromocion) CU.getCP().BuscarDataXRestaurante_Producto(prod);
                    DataProdPedido DP = new DataProdPedido(cant, P);
                    CU.agregarACarrito(DP, nick);
                    out.print("<p>Exito</p>");
                    out.print("<p>" + cant + " " + DP.getProducto().getNombre() + "</p>");
                    out.print("<p>Agregado al carrito</p>");
                }

            }

            /* TODO output your page here. You may use following sample code. */
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
            Logger.getLogger(agregarACarrito.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(agregarACarrito.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(agregarACarrito.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(agregarACarrito.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(agregarACarrito.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(agregarACarrito.class.getName()).log(Level.SEVERE, null, ex);
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
