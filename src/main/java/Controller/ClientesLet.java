/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import Model.Cliente;
/**
 *
 * @author Clider Fernando Tutaya Rivera
 */
public class ClientesLet extends HttpServlet {

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
            throws ServletException, IOException, ParseException {
        String accion = request.getParameter("accion");
        
        if(accion.equals("INS")){
            DateFormat formateador = new SimpleDateFormat("dd/MM/yyy");
            String ape = request.getParameter("cliApellidos");
            String nom = request.getParameter("cliNombres");
            String genero = request.getParameter("cliGenero");
            String tipoDoc = request.getParameter("selectTipoDoc");
            String numDoc = request.getParameter("cliNumDoc");
            String tel = request.getParameter("cliTelef");
            String email = request.getParameter("cliEmail");
            String dist = request.getParameter("selectDist");
            Date fecNac = formateador.parse(request.getParameter("cliFecNac"));
            String nac = request.getParameter("selectNac");
            String dir = request.getParameter("cliDir");
            String eCivil = request.getParameter("cliEstCivil");
            Date fecReg = formateador.parse(request.getParameter("cliFecReg"));
            String fotoPath = null;
            
            Cliente cli = new Cliente(nom, ape, genero, tipoDoc,numDoc, tel, email, dist, dir, fecNac, nac, eCivil, fecReg, fotoPath);
            cli.insertCliente(cli);
            response.sendRedirect("adm/clientes.jsp");
        }else{
            System.out.println("Otro metodo distinto a insert");
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
        } catch (ParseException ex) {
            Logger.getLogger(Cliente.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (ParseException ex) {
            Logger.getLogger(Cliente.class.getName()).log(Level.SEVERE, null, ex);
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
