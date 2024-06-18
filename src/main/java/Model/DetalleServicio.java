/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import com.google.gson.annotations.Expose;
import config.PoolConexion;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author ROBOT
 */
public class DetalleServicio {
    @Expose
    private String nroOrden;
    @Expose
    private int Cantidad;
    @Expose
    private String tipoServ;
    @Expose
    private String tipoPrenda;
    @Expose
    private String prenda;
    @Expose
    private Double precio;
    @Expose
    private Double subtotal;
    @Expose
    private String obs;
    
    public DetalleServicio() {
    }

    public DetalleServicio(String nroOrden, int Cantidad, String tipoServ, String prenda, Double precio, Double subtotal, String obs) {
        this.nroOrden = nroOrden;
        this.Cantidad = Cantidad;
        this.tipoServ = tipoServ;
        this.prenda = prenda;
        this.precio = precio;
        this.subtotal = subtotal;
        this.obs = obs;
    }
    
    public boolean insertarDetalle(DetalleServicio detalle) {
        boolean band = false;
        Connection conn = null;
        CallableStatement cs = null;
        try {
            conn = PoolConexion.getDs().getConnection();
            cs = conn.prepareCall("{call usp_addDetalleServicio(?,?,?,?)}");

            cs.setString(1, detalle.getNroOrden());
            cs.setString(2, detalle.getTipoServ());
            cs.setString(3, detalle.getPrenda());
            cs.setInt(4, detalle.getCantidad());

            if (cs.executeUpdate() > 0) {
                band = true;
                System.out.println("Se ha insertado correctamente nuevo registro detalle de orden nro: " + detalle.getNroOrden());
            } else {
                System.out.println("No se insertaron a la orden: " + detalle.getNroOrden());
            }

        } catch (SQLException e) {
            System.out.println("Error en insertar detalle: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (cs != null) cs.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return band;
    }

    
    public int getCantidad() {
        return Cantidad;
    }

    public void setCantidad(int Cantidad) {
        this.Cantidad = Cantidad;
    }

    public String getTipoServ() {
        return tipoServ;
    }

    public void setTipoServ(String tipoServ) {
        this.tipoServ = tipoServ;
    }

    public String getTipoPrenda() {
        return tipoPrenda;
    }

    public void setTipoPrenda(String tipoPrenda) {
        this.tipoPrenda = tipoPrenda;
    }

    public String getPrenda() {
        return prenda;
    }

    public void setPrenda(String prenda) {
        this.prenda = prenda;
    }

    public Double getPrecio() {
        return precio;
    }

    public void setPrecio(Double precio) {
        this.precio = precio;
    }

    public Double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(Double subtotal) {
        this.subtotal = subtotal;
    }

    public String getObs() {
        return obs;
    }

    public void setObs(String obs) {
        this.obs = obs;
    }

    public String getNroOrden() {
        return nroOrden;
    }

    public void setNroOrden(String nroOrden) {
        this.nroOrden = nroOrden;
    }
    
    
    
    
}


