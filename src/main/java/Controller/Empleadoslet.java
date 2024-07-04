/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Contrato;
import Model.EmailUtil;
import Model.Empleado;
import Model.EmpleadoDAO;
import Model.Usuario;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.ParseException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
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
            String dist = request.getParameter("selectDist");
            Date fecNac = formateador.parse(request.getParameter("empFecNac"));
            String nac = request.getParameter("empNacionalidad");
            String dir = request.getParameter("empDir");
            String eCivil = request.getParameter("empEstCivil");
            String suc = request.getParameter("empSucursal");
            String estadoEmp = request.getParameter("empEstado");
                    
            int numEstadoEmp = 0;
            if(estadoEmp.equals("Activo")){
                numEstadoEmp = 1;
            }
            
            int nroHijos = Integer.parseInt(request.getParameter("empNroHijos"));
            /*Intentar Foto Usuario **/
            
            Part fotoPart = request.getPart("nuevaFoto");
            System.out.println("Foto Empleado: "  + fotoPart);
            
            long filesize = fotoPart.getSize();
            System.out.println("Tamaño de Foto : "  + filesize);

            if(filesize > 2* 1024 * 1024){
                System.out.print("error archivo demasiado grande");
                return;
            }
            byte[] fotoBytes = new byte[(int)filesize];
            
            System.out.println("arreglo Foto en Bytes: "  + Arrays.toString(fotoBytes));

            try (InputStream inputStream = fotoPart.getInputStream()){
                inputStream.read(fotoBytes);
                System.out.print("Conversion completada satisfactoriamente");
            } catch (IOException e) {
                System.out.println("error al leer la foto archivo dañado, " + e.getMessage());
            }
         
            System.out.println("arreglo foto en Bytes bytes agregados al arreglo: "  + Arrays.toString(fotoBytes));
            
            Empleado emp = new Empleado(ape,nom,genero,tipoDoc,numDoc,tel,email,dist,fecNac,nac,dir,eCivil,suc,numEstadoEmp,nroHijos,fotoBytes);
            
            boolean res = empDao.insertEmp(emp);
            System.out.println("Estado de insercion de empleado = " + res);
            
            
            Date fecInicioContrato = formateador.parse(request.getParameter("fecIncContrato"));
            Date fecTemContrato = formateador.parse(request.getParameter("fecTermContrato"));
            String cargo = request.getParameter("empCargo");
            int sueldo = Integer.parseInt(request.getParameter("empSueldo"));
            String moneda = request.getParameter("monedaContrato");
            String estadoContrato = request.getParameter("empEstadoContrato");
            String obs = request.getParameter("obsCotrato");
            
            Contrato cnt = new Contrato();
            Contrato contrato = new Contrato(fecInicioContrato,fecTemContrato,numDoc, suc ,cargo, sueldo, moneda, estadoContrato, obs);
            boolean resCont = cnt.insertarCont(contrato);
            System.out.println("estado de insercion de contrato = " + resCont);
            
            
            //Comprobar si se ha seleccionado crear cuenta de usuario
            String chekCrearCuenta = request.getParameter("checkNuevaCuenta");
            
            if ("on".equals(chekCrearCuenta)) {
                //Desactivacion temporal de la generacion de contraseñas para hacer mas facil de acceder
                //String contrasenia= EmailUtil.generarContraseña();
                String perfil;
                
                
                if(cargo.equals("Administrador")){
                    perfil = "Administrador";
                }else{
                    perfil = "Empleado";
                }
                Usuario usuario = new Usuario();
                Usuario usr = new Usuario(numDoc,numDoc,numDoc , estadoEmp, perfil);
                boolean insUsr = usuario.insertarUsuario(usr);
                if(insUsr){
                    String destinatario = email; //Correo electronico del empleado
                    EmailUtil.enviarMail(destinatario, "NUEVA CUENTA DE USUARIO SLC", 
                            "Su cuenta a sido creada exitosamente con las siguientes credenciales:  "
                                    + "\nUsuario:  " + numDoc + 
                                    "\nContraseña: " + numDoc +
                                    "\n " +
                                    "\n " +
                                    "\n Recuerde cambiar su contraseñas para mayor seguridad."+
                                    "\n Atentamente el equipo de soporte SLC "
                    );
                }else{
                     System.out.println("No se ha podido enviar correo al usuario");
                }
                
            }else{
                System.out.println("No se ha creado cuenta de usuario");
            }
            
            response.sendRedirect("adm/index.jsp");
            
            
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
