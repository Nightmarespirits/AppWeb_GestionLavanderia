package Controller;

import Model.Cliente;
import Model.DetalleServicio;
import Model.Orden;
import Model.Usuario;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Time;
import java.sql.Date;
import java.text.ParseException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author Clider Fernando Tutaya Rivera
 */
public class OrdenesLet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.text.ParseException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        
        // Configurar el tipo de contenido de la respuesta
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Parsear el cuerpo de la solicitud como JSON
        JsonObject ordenData = new Gson().fromJson(request.getReader(), JsonObject.class);
        
        //Tomar Parametros para la Orden de Servicio
        LocalTime horaActual = LocalTime.now();
        DateTimeFormatter fecFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        DateTimeFormatter timeFormattter = DateTimeFormatter.ofPattern("HH:mm:ss");

        String nroOrden = ordenData.get("nroOrden").getAsString();
        String docIdUsuario = ordenData.get("docIdUsuario").getAsString();
        String docIdCliente = ordenData.get("docIdCliente").getAsString();

        LocalDate localFecRecep = LocalDate.parse(ordenData.get("fecRecep").getAsString(),fecFormatter);
        Date fecRecep = Date.valueOf(localFecRecep);

        Time horaRecep = Time.valueOf(horaActual);

        LocalDate localFecEntrega = LocalDate.parse(ordenData.get("fecEntrega").getAsString(), fecFormatter);
        Date fecEntrega = Date.valueOf(localFecEntrega);

        Time horaEntrega;
        horaEntrega = Time.valueOf(LocalTime.parse(ordenData.get("horaEntrega").getAsString() , timeFormattter));
        int aCuenta = Integer.parseInt(ordenData.get("aCuenta").getAsString() );
        
        //Crear Objetos e insertar  Datos en la BD
        Usuario usuario = new Usuario();
        Cliente cliente = new Cliente();
        Usuario usr = usuario.buscarUsrDoc(docIdUsuario); 
        Cliente cli = cliente.buscarCliente(docIdCliente);
        
        //Crear ojeto Orden
        Orden orden = new Orden(nroOrden, usr, cliente, fecRecep,horaRecep, fecEntrega, horaEntrega, "En Proceso ", aCuenta);
        boolean insertarOrden = orden.insertarOrden(orden, usr, cli);

        System.out.println("Estadod e la insecion de orden de servicio " + insertarOrden);
        
        
        //Crear objeto array detalles a partir del json del objet ordenData
        JsonArray detalles = ordenData.getAsJsonArray("detalles");
        System.out.println(detalles);
        //Crear objeto DetalleServicio sin propiedades aun
        DetalleServicio dtl = new DetalleServicio();
        
        //Iterar el jsonArray para agregar propiedades al objeto DetalleServicio
        for(JsonElement detal : detalles){
            
            JsonObject detalle = detal.getAsJsonObject();
            
            
            int cantidad = Integer.parseInt(detalle.get("cantidad").getAsString());
            String servicio = detalle.get("servicio").getAsString();
            String prenda = detalle.get("prenda").getAsString();
            Double precio = Double.valueOf(detalle.get("precio").getAsString());
            Double subtotal = Double.valueOf(detalle.get("subtotal").getAsString());
            String observaciones = detalle.get("observaciones").getAsString();
            
            //Crear un nuevo detalle servicio objeto con propiedades
            DetalleServicio detalleServicio = new DetalleServicio(nroOrden, cantidad, servicio , prenda, precio,subtotal, observaciones);
            System.out.println("prenda de detalle:" + detalleServicio.getPrenda());
            //Agregar detalle servicio a la lista de detalles de el objeto orden:
            orden.addDetalle(detalleServicio);
            
            //Subir a la BD dicho detalle servicio
            boolean resultInsDtlServ = dtl.insertarDetalle(detalleServicio);
            System.out.println("Estado de insercion de detalles a la BD" + resultInsDtlServ);
            
            
        }
        
        //Reenviar al servlet factura (para imprimir la factura)
        
        
        request.setAttribute("orden", orden);
        
        try (PrintWriter out = response.getWriter()) {
            out.println("Respuesta del servidor");
        }catch(Exception e){
            System.out.println("Erro al intentar enviar respuesta" + e.getMessage());
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
            Logger.getLogger(OrdenesLet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(OrdenesLet.class.getName()).log(Level.SEVERE, null, ex);
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
