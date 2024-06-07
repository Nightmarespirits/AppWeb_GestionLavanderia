package Model;

import config.Conexion;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Date;
import java.util.List;
import java.sql.Time;
import java.sql.Types;
import java.util.ArrayList;

/**
 *
 * @author Tutaya Rivera Clider Fernando
 */
public class Orden {
    Conexion cnx = new Conexion();
    Connection cn = cnx.getCn();
    
    private String  nroOrden;
    private Usuario usr;
    private Cliente cliente;
    private Date fecOrden;
    private Time horaOrden;
    private Date fecEntrega;
    private Time horaEntrega;
    private String estadoOrden;
    private int aCuenta;
    //una misma orden puede tener una o mas detalles todo eso lo almacenamos en una lista detalles
    private List<DetalleServicio> listDetalles;
    private Factura factura;

    public Orden() {
        
    }

    public Orden(String nroOrden, Usuario usr, Cliente cliente, Date fecOrden, Time horaOrden, Date fecEntrega, Time horaEntrega, String estadoOrden, int aCuenta) {
        this.listDetalles = new ArrayList<>();
        this.nroOrden = nroOrden;
        this.usr = usr;
        this.cliente = cliente;
        this.fecOrden = fecOrden;
        this.horaOrden = horaOrden;
        this.fecEntrega = fecEntrega;
        this.horaEntrega = horaEntrega;
        this.estadoOrden = estadoOrden;
        this.aCuenta = aCuenta;
    }
    
    //DATA ACCESS OBJETS
    public boolean insertarOrden(Orden orden, Usuario usr, Cliente cli){
        boolean band = false;
        try {
            CallableStatement cs = cn.prepareCall("{call usp_addOrdenServicio(?,?,?,?,?,?,?,?)}");
            
            cs.setString(1, orden.getNroOrden());
            cs.setString(2, usr.getNumDoc());
            cs.setString(3, cli.getNumDoc());
            
            cs.setDate(4, orden.getFecOrden());
            cs.setTime(5, orden.getHoraOrden());
            cs.setDate(6,orden.getFecEntrega());
            cs.setTime(7, orden.getHoraEntrega());            
            cs.setInt(8, orden.getaCuenta());
            
            if(cs.executeUpdate() > 0){
                 band = true;
                System.out.println("SE HA INSERTADO CORRECTAMENTE A LA TABLA ORDEN DE SERVICIO");
            }
        } catch (SQLException e) {
            System.out.println("Error en insertar nueva orden function");
            e.getMessage();
        }
        
        return band;
    }
    /*
    public Orden(Usuario usr, Cliente cliente) {
        this.usr = usr;
        this.cliente = cliente;
        Date today = Date.from(Instant.EPOCH);
        this.fecOrden = today;
        this.horaOrden  = today;
        //bucar una forma de sumar dias a la hora
    }*/
    public String generarNroOrden() {
        String nroOrden = "";
        try {
            CallableStatement cs = cn.prepareCall("{call usp_GenerarNroOrden(?)}");
            cs.registerOutParameter(1, Types.VARCHAR); // Registrando el parámetro de salida
            cs.execute();
            nroOrden = cs.getString(1); // Obteniendo el valor de salida
            System.out.println("Número de orden generado: " + nroOrden);
        } catch (SQLException e) {
            System.out.println("Error en el generarNroOrdenMethod: " + e.getMessage());
            e.printStackTrace(); // Imprimir la traza completa del error
        }
        return nroOrden;
    }
    
    //Metodo para agregar un objeto DetalleServicio a la listDetalles
    public void addDetalle(DetalleServicio detalle){
        if (listDetalles == null) {
            System.out.println("Error: listDetalles es null");
            return;
        }
    
        if(factura == null){
            listDetalles.add(detalle);
        }else{
            System.out.println("Error, Ya se ha generado una factura para esta orden de servicio");
        }
        
    }

    //Guardamos una factura de esa orden en el objeto Orden
    public void generarFactura(){
        if(listDetalles  != null){
            Factura fact = new Factura();
            this.factura = fact.buscarFactura(this.getNroOrden());
        }else{
            System.out.println("Error, Aun no se ha agregado detalles a Esta Orden de Servicio");
        }
        
    }
    
    
    /*Getters*/
    public Factura getFactura(){
        return factura;
    }
    public List<DetalleServicio> getDetalles(){
        return listDetalles;
    }
    
    // Getter y Setters

    public String getNroOrden() {
        return nroOrden;
    }

    public void setNroOrden(String nroOrden) {
        this.nroOrden = nroOrden;
    }

    public Usuario getUsr() {
        return usr;
    }

    public void setUsr(Usuario usr) {
        this.usr = usr;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public Date getFecOrden() {
        return fecOrden;
    }

    public void setFecOrden(Date fecOrden) {
        this.fecOrden = fecOrden;
    }

    public Time getHoraOrden() {
        return horaOrden;
    }

    public void setHoraOrden(Time horaOrden) {
        this.horaOrden = horaOrden;
    }

    public Date getFecEntrega() {
        return fecEntrega;
    }

    public void setFecEntrega(Date fecEntrega) {
        this.fecEntrega = fecEntrega;
    }

    public Time getHoraEntrega() {
        return horaEntrega;
    }

    public void setHoraEntrega(Time horaEntrega) {
        this.horaEntrega = horaEntrega;
    }

    public String getEstadoOrden() {
        return estadoOrden;
    }

    public void setEstadoOrden(String estadoOrden) {
        this.estadoOrden = estadoOrden;
    }

    public int getaCuenta() {
        return aCuenta;
    }

    public void setaCuenta(int aCuenta) {
        this.aCuenta = aCuenta;
    }
    
}



