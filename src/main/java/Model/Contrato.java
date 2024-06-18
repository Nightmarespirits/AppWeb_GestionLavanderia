package Model;


import config.Conexion;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Clider Fernando Tutaya Rivera
 */
public class Contrato {
    Conexion cnx = new Conexion();
    Connection cn = cnx.getCn();
    
    private Date fecInicioContrato;
    private Date fecTerminoContrato;
    private String DocEmp;
    private String sucursal;
    private String cargo;
    private int sueldo;
    private String moneda;
    private String estadoCont;
    private String obs;

    public Contrato() {
    }
    
    
    public Contrato(Date fecInicioContrato, Date fecTerminoContrato, String DocEmp, String sucursal, String cargo, int sueldo, String moneda, String estadoCont, String obs) {
        this.fecInicioContrato = fecInicioContrato;
        this.fecTerminoContrato = fecTerminoContrato;
        this.DocEmp = DocEmp;
        this.sucursal = sucursal;
        this.cargo = cargo;
        this.sueldo = sueldo;
        this.moneda = moneda;
        this.estadoCont = estadoCont;
        this.obs = obs;
    }
    public boolean insertarCont(Contrato cntr){
        boolean band = false;
        try {
            CallableStatement cs = cn.prepareCall("{call usp_insertContrato(?,?,?,?,?,?,?,?,?)}");
            Date fecInicioCont =  cntr.getFecInicioContrato();
            java.sql.Date sqlFecInicioCont = new java.sql.Date(fecInicioCont.getTime());
            cs.setDate(1, sqlFecInicioCont );
            
            Date fecTerminoCont = cntr.getFecTerminoContrato();
            java.sql.Date sqlFecTerminoCont = new java.sql.Date(fecTerminoCont.getTime());
            cs.setDate(2, sqlFecTerminoCont);
            cs.setString(3,cntr.getDocEmp());
            cs.setString(4,cntr.getSucursal());
            cs.setString(5,cntr.getCargo());
            cs.setInt(6,cntr.getSueldo());
            cs.setString(7,cntr.getMoneda());
            cs.setString(8,cntr.getEstadoCont());
            cs.setString(9,cntr.getObs());
            
            if(cs.executeUpdate() >= 0){
                band = true;
                System.out.println("Contrato Agregado");
            }
        } catch (SQLException e) {
            System.out.println("Error en agregar contrato: " + e.getMessage());
            
        }
               
        return band;
        
    }
    
    public Date getFecInicioContrato() {
        return fecInicioContrato;
    }

    public void setFecInicioContrato(Date fecInicioContrato) {
        this.fecInicioContrato = fecInicioContrato;
    }

    public Date getFecTerminoContrato() {
        return fecTerminoContrato;
    }

    public void setFecTerminoContrato(Date fecTerminoContrato) {
        this.fecTerminoContrato = fecTerminoContrato;
    }

    public String getDocEmp() {
        return DocEmp;
    }

    public void setDocEmp(String DocEmp) {
        this.DocEmp = DocEmp;
    }

    public String getSucursal() {
        return sucursal;
    }

    public void setSucursal(String sucursal) {
        this.sucursal = sucursal;
    }

    public String getCargo() {
        return cargo;
    }

    public void setCargo(String cargo) {
        this.cargo = cargo;
    }

    public int getSueldo() {
        return sueldo;
    }

    public void setSueldo(int sueldo) {
        this.sueldo = sueldo;
    }

    public String getMoneda() {
        return moneda;
    }

    public void setMoneda(String moneda) {
        this.moneda = moneda;
    }

    public String getEstadoCont() {
        return estadoCont;
    }

    public void setEstadoCont(String estadoCont) {
        this.estadoCont = estadoCont;
    }

    public String getObs() {
        return obs;
    }

    public void setObs(String obs) {
        this.obs = obs;
    }
    
    
}
