/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Empleado;
import Model.EmpleadoDAO;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.ParseException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import jakarta.servlet.http.Part;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author ROBOT
 */
@MultipartConfig
public class Empleadoslet extends HttpServlet {
    EmpleadoDAO empDao = new EmpleadoDAO();
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
            throws ServletException, IOException, ParseException, MessagingException, java.text.ParseException {
        String tipoTransac = request.getParameter("tipoTransac");
        if(tipoTransac.equals("INS")){
            System.out.println("Esta funcionando la llamada a la transaccion.");
            
            DateFormat formateador = new SimpleDateFormat("dd/MM/yyy");
            String ape = request.getParameter("empApellidos");
            String nom = request.getParameter("empNombres");
            String genero = request.getParameter("empGenero");
            String tipoDoc = request.getParameter("empTipoDoc");
            String numDoc = request.getParameter("empNumDoc");
            String tel = request.getParameter("empTelefono");
            String email = request.getParameter("empEmail");
            String dist = request.getParameter("empDist");
            Date fecNac = formateador.parse(request.getParameter("empFecNac"));
            String nac = request.getParameter("empNacionalidad");
            String dir = request.getParameter("empDir");
            String eCivil = request.getParameter("empEstCivil");
            String suc = request.getParameter("empSucursal");
            int estadoEmp = Integer.parseInt(request.getParameter("empEstado"));
            int nroHijos = Integer.parseInt(request.getParameter("empNroHijos"));
            /*
            Part foto;
            foto = request.getPart('empFoto');
            String fotoName = Paths.get(foto.getSubmittedFileName()).getFileName().toString();
            byte[] bufferImage = new byte[1024];
            String rutaAlmc = "/adm/config/users/usersImages";
            OutputStream salida = null ;
            InputStream entrada = null;
            try {
                salida = new FileOutputStream(new File( rutaAlmc+ File.separator + fotoName));
                entrada = foto.getInputStream();
                int i;
                while((i = entrada.read(bufferImage)) != -1){
                    salida.write(bufferImage, 0 , i);
                }
            } catch (FileNotFoundException e) {
                System.out.println("Error garrafal en convertir la foto:");
                
            }finally{
                 if (salida != null) salida.close();
                 if (entrada != null) entrada.close();
            }
            */
            Empleado emp = new Empleado(ape,nom,genero,tipoDoc,numDoc,tel,email,dist,fecNac,nac,dir,eCivil,suc,estadoEmp,nroHijos,null);
            empDao.insertEmp(emp);
            response.sendRedirect("index.jsp");
        }else if(tipoTransac.equals("UPD")){
            
        }else if(tipoTransac.equals("DEL")){
            
        }else{
            
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
        } catch (MessagingException ex) {
            Logger.getLogger(Empleadoslet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (java.text.ParseException ex) {
            Logger.getLogger(Empleadoslet.class.getName()).log(Level.SEVERE, null, ex);
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
