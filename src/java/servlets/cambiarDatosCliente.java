/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
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

            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String cambioImagen = request.getParameter("cambioImagen");
            String email = request.getParameter("email");
            String passwd = request.getParameter("passwd");
            String nick = (String) session.getAttribute("nick");
            String direccion = request.getParameter("direccion");
            String imagen = "NO";
            if (cambioImagen.equals("1")) {
                imagen = request.getParameter("img");
               // out.print("<img src='" + imagen + "' width='190px' height='190px' >");
            }

            modificarCliente(nick, nombre, email, direccion, apellido, imagen, passwd);
            out.print("<p>Cambios Aplicados</p>");
            session.removeAttribute("nombre");
            session.removeAttribute("apellido");
            session.setAttribute("nombre", nombre);
            session.setAttribute("apellido", apellido);

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

    private static void modificarCliente(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2, java.lang.String arg3, java.lang.String arg4, java.lang.String arg5, java.lang.String arg6) {
        ClienteWS.WSQuickOrder_Service service = new ClienteWS.WSQuickOrder_Service();
        ClienteWS.WSQuickOrder port = service.getWSQuickOrderPort();
        port.modificarCliente(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

}
