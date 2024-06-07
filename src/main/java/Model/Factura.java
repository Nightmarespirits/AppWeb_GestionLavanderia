/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import config.Conexion;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author ROBOT
 * Con esta clase crearemos los objetos para la impresion de la factura ticket orden de trabajo
 */
public class Factura {
    Conexion cnx = new Conexion();
    Connection cn = cnx.getCn();
    
    private String nroFactura;
    private String nroOrden;
    private int costoTotal;
    private int saldo;

    public Factura() {
    }
    
    public Factura(String nroFactura, String nroOrden, int costoTotal, int saldo) {
        this.nroFactura = nroFactura;
        this.nroOrden = nroOrden;
        this.costoTotal = costoTotal;
        this.saldo = saldo;
    }
    
    //Solo usar cuando la orden de servicio y los detalles ya se hayan guardado en la BD
    public Factura buscarFactura(String nroOrden) {
        Factura fact = null;
        try {
            String sql = "select * from tb_Factura where NroOrden = '" + nroOrden + "'";
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while(rs.next()){
                fact = new Factura(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getInt(4)
                );
            }
            
        } catch (SQLException e) {
            System.out.println("Error en metodo buscar Factura Factura Class" + e.getMessage());
        }
        return fact;
    }

    /*Getters ***/

    public String getNroFactura() {
        return nroFactura;
    }

    public String getNroOrden() {
        return nroOrden;
    }

    public int getCostoTotal() {
        return costoTotal;
    }

    public int getSaldo() {
        return saldo;
    }

   
    
}
