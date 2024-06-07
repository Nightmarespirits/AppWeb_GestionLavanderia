/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import config.Conexion;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Clider Fernando Tutaya Rivera
 */
public class servicios {
    Conexion cnx = new Conexion();
    Connection cn = cnx.getCn();
    
    String nomServ ;
    int tiempoDemora;
    String tipoPrenda;
    String prenda;
    int precNorm;
    int precDesc;

    public servicios() {
    }
    
    public servicios(String nomServ, int tiempoDemora, String tipoPrenda, String prenda, int precNorm, int precDesc) {
        this.nomServ = nomServ;
        this.tiempoDemora = tiempoDemora;
        this.tipoPrenda = tipoPrenda;
        this.prenda = prenda;
        this.precNorm = precNorm;
        this.precDesc = precDesc;
    }

    public List<servicios> crearListaServicios(){
        List<servicios> listaObjServicios = new ArrayList();
        
        try {
            String sql = "SELECT dbo.tb_TipoServicio.NombreServicio, dbo.tb_TipoServicio.TiempoDias, dbo.tb_TipoPrenda.NombreTipoPrenda, dbo.tb_Prenda.Descripcion, dbo.tb_Prenda.PrecioNormal, dbo.tb_Prenda.PrecioDesc\n" +
            "FROM dbo.tb_Prenda INNER JOIN\n" +
            " dbo.tb_TipoPrenda ON dbo.tb_Prenda.CodTipoPrenda = dbo.tb_TipoPrenda.CodTipoPrenda INNER JOIN\n" +
            " dbo.tb_TipoServicio ON dbo.tb_Prenda.CodTipoServ = dbo.tb_TipoServicio.CodTipoServ";
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery(sql);

            while(rs.next()){
                
            servicios serv = new servicios(
                    rs.getString(1),
                    rs.getInt(2),
                    rs.getString(3),
                    rs.getString(4),
                    rs.getInt(5),
                    rs.getInt(6)
                    );
            
            listaObjServicios.add(serv);
            }
        } catch (SQLException e) {
            System.out.println("Error en el listar servicios metodo " + e);
        }
        return listaObjServicios;
        
    }
    
    
    
    
    public String getNomServ() {
        return nomServ;
    }

    public void setNomServ(String nomServ) {
        this.nomServ = nomServ;
    }

    public int getTiempoDemora() {
        return tiempoDemora;
    }

    public void setTiempoDemora(int tiempoDemora) {
        this.tiempoDemora = tiempoDemora;
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

    public int getPrecNorm() {
        return precNorm;
    }

    public void setPrecNorm(int precNorm) {
        this.precNorm = precNorm;
    }

    public int getPrecDesc() {
        return precDesc;
    }

    public void setPrecDesc(int precDesc) {
        this.precDesc = precDesc;
    }
    
    
    
    
}
