/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


/**
 *
 * @author ROBOT
 */
public class Controlador extends HttpServlet {

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
        String pagina = request.getParameter("pagina");
        System.out.println("llamada al serverlet controlador" );
        switch(pagina){
            case "inicio":
                request.getRequestDispatcher("/index.jsp").forward(request, response);
                break;
            case "ordenesServicio":
                System.out.println("Ordenes de Sevicio");
                request.getRequestDispatcher("/adm/ordenesServicio.jsp").forward(request, response);
                
                break;
            case "clientes":
                request.getRequestDispatcher("/adm/nuevo/cliente.jsp").forward(request, response);
                break;
            case "caja":
                request.getRequestDispatcher("/adm/caja.jsp").forward(request, response);
                break;
            case "delivery":
                request.getRequestDispatcher("/adm/delivery.jsp").forward(request, response);
                break;
            case"facturas":
                request.getRequestDispatcher("/adm/controlpuntos.jsp").forward(request,response);
                break;
            case"compras":
                request.getRequestDispatcher("/adm/controlpuntos.jsp").forward(request,response);
                break;
            case"controlpuntos":
                request.getRequestDispatcher("/adm/controlpuntos.jsp").forward(request,response);
                break;
            case"almacen":
                request.getRequestDispatcher("/adm/controlpuntos.jsp").forward(request,response);
                break;
            case"empleados":
                request.getRequestDispatcher("/adm/config/empleados.jsp").forward(request, response);
            default:
                response.setStatus(HttpServletResponse.SC_NOT_FOUND); // Devuelve un error 404 si la página solicitada no existe
                break;
                
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
