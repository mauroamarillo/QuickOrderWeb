package servlets;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import Logica.ControladorUsuario;
import Logica.DataTypes.DataCliente;
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
        ControladorUsuario CU = new ControladorUsuario();
        String user = request.getParameter("nick");
        String pass = request.getParameter("passwd");
        HttpSession session = request.getSession();
        if (CU.nickOcupado(user)) {
            DataCliente DC = CU.buscarCliente(user);
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
            if (CU.emailOcupado(user)) {
                DataCliente DC = CU.buscarClientePorEmail(user);
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
