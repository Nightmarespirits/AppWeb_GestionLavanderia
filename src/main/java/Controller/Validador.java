/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;


/**
 *
 * @author ROBOT
 */
public class Validador extends HttpServlet {
    Usuario usuario = new Usuario();
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
        Gson gson = new GsonBuilder()
                        .excludeFieldsWithoutExposeAnnotation() // Solo serializa campos anotados con @Expose
                        .create();
        
        String accion = request.getParameter("accion");
        if(accion.equals("login")){
            String username = request.getParameter("email");
            String clave = request.getParameter("password");
            
            String respuestaAcceso = usuario.validarLogin(username, clave);
            if(respuestaAcceso.equals("Ok")){
                Usuario usr = usuario.buscarUsuarioUsername(username);
                String usrstring  = gson.toJson(usr);
                
                request.setAttribute("usrstring",usrstring);
                if(usr.getRol().equals("Administrador")){
                    System.out.println("Redireccinando..");
                    request.getRequestDispatcher("/adm/index.jsp").forward(request,response);
                }else{
                    request.getRequestDispatcher("/emp/index.jsp").forward(request,response);
                }
                
                
            }else{
                   
                //Configurar texto mensaje respuesta del login
                request.setAttribute("respuestaAcceso",respuestaAcceso);
                request.getRequestDispatcher("/login.jsp").forward(request,response);
            }
            
        }else{
            request.setAttribute("respuestaAcceso","Operacion Fallida");
            request.getRequestDispatcher("/login.jsp").forward(request,response);
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
        processRequest(request,response);
        
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
