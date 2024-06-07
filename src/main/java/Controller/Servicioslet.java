/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import com.google.gson.Gson;
import config.Conexion;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ROBOT
 */
public class Servicioslet extends HttpServlet {
    Conexion cnx = new Conexion();
    Connection cn = cnx.getCn();
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        System.out.println("llamada al servlet correcta servicioslet");
        Gson gson = new Gson();
        String sql = "SELECT dbo.tb_TipoServicio.NombreServicio, dbo.tb_TipoServicio.TiempoDias, dbo.tb_TipoPrenda.NombreTipoPrenda, dbo.tb_Prenda.Descripcion, dbo.tb_Prenda.PrecioNormal, dbo.tb_Prenda.PrecioDesc\n" +
        "FROM dbo.tb_Prenda INNER JOIN\n" +
        " dbo.tb_TipoPrenda ON dbo.tb_Prenda.CodTipoPrenda = dbo.tb_TipoPrenda.CodTipoPrenda INNER JOIN\n" +
        " dbo.tb_TipoServicio ON dbo.tb_Prenda.CodTipoServ = dbo.tb_TipoServicio.CodTipoServ";
        Statement st = cn.createStatement();
        ResultSet rs = st.executeQuery(sql);
        List listaServs = new ArrayList();
        while(rs.next()){
            Object data[] = {
                rs.getString(1),
                rs.getInt(2),
                rs.getString(3),
                rs.getString(4),
                rs.getString(5),
                rs.getString(6)
            };
            
            listaServs.add(data);
            
        }
        
        String jsonServs = gson.toJson(listaServs);
        PrintWriter pw = response.getWriter();
        pw.print(jsonServs);
        pw.flush();
        
        
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
            Logger.getLogger(Servicioslet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(Servicioslet.class.getName()).log(Level.SEVERE, null, ex);
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
