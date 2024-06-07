/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import config.Conexion;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author ROBOT
 */
public class Cliente {
    Conexion cnx = new Conexion();
    Connection cn = cnx.getCn();
    private String nombres;
    private String apellidos;
    private String genero;
    private String tipoDoc;
    private String numDoc;
    private String tel;
    private String email;
    private String dist;
    private String direccion;
    private Date fecNac;
    private String nacionalidad;
    private String eCivil;
    private Date FecRegistro;
    private String fotoPath;

    public Cliente() {
    }

    public Cliente(String nombres, String apellidos, String genero, String tipoDoc, String numDoc, String tel, String email, String dist, String direccion, Date fecNac, String nacionalidad, String eCivil, Date FecRegistro ,String fotoPath) {
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.genero = genero;
        this.tipoDoc = tipoDoc;
        this.numDoc = numDoc;
        this.tel = tel;
        this.email = email;
        this.dist = dist;
        this.direccion = direccion;
        this.fecNac = fecNac;
        this.nacionalidad = nacionalidad;
        this.eCivil = eCivil;
        this.FecRegistro = FecRegistro;
        this.fotoPath = fotoPath;
    }
    

    /*Data Acces Object Methods*/
    
    public Boolean insertCliente(Cliente cli){
        Boolean band = false;
        try {
            CallableStatement cs = cn.prepareCall("{call usp_AddCliente(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            cs.setString(1, cli.getNombres());
            cs.setString(2, cli.getApellidos());
            cs.setString(3, cli.getGenero());
            cs.setString(4, cli.getTipoDoc());
            cs.setString(5, cli.getNumDoc());
            cs.setString(6, cli.getTel());
            cs.setString(7, cli.getEmail());
            cs.setString(8, cli.getDist());
            cs.setString(9, cli.getDireccion());
            Date fecNac = cli.getFecNac();
            java.sql.Date sqlFecNac = new java.sql.Date(fecNac.getTime());
            cs.setDate(10,sqlFecNac );
            cs.setString(11, cli.getNacionalidad());
            cs.setString(12, cli.geteCivil());
            Date fecReg = cli.getFecRegistro();
            java.sql.Date sqlFecReg= new java.sql.Date(fecReg.getTime());
            cs.setString(13, cli.getFotoPath());
            cs.setDate(14, sqlFecReg);
            
            if(cs.executeUpdate() > 0){
                band = true;
                System.out.println("SE HA INSERTADO CORRECTAMENTE AL cliente EN LA TB_CLIENTES");
            }
        } catch (SQLException e) {
            System.out.println("Error en cLIENTE mODEL INSERT METHOD");
            e.getCause();
            e.getMessage();
            e.printStackTrace();
        }
        return band;
    }
    
    public Cliente buscarCliente(String docIdent){
        Cliente cli = null;
        try {
            String sql = "SELECT dbo.tb_Cliente.Nombres, dbo.tb_Cliente.Apellidos, dbo.tb_Cliente.Genero, dbo.tb_TipoDoc.DocIdentidad, dbo.tb_Cliente.NumDocIdentidad, dbo.tb_Cliente.Telefono, dbo.tb_Cliente.Email, dbo.tb_Distrito.NombreDist, \n" +
                    "        dbo.tb_Cliente.Direccion, dbo.tb_Cliente.FecNac, dbo.tb_Nacionalidad.Nacionalidad, dbo.tb_Cliente.EstadoCivil, dbo.tb_Cliente.FecRegistro, dbo.tb_Cliente.foto\n" +
                    "FROM   dbo.tb_Cliente INNER JOIN\n" +
                    "        dbo.tb_Distrito ON dbo.tb_Cliente.CodDist = dbo.tb_Distrito.CodDist INNER JOIN\n" +
                    "        dbo.tb_Nacionalidad ON dbo.tb_Cliente.CodNac = dbo.tb_Nacionalidad.CodNac INNER JOIN\n" +
                    "        dbo.tb_TipoDoc ON dbo.tb_Cliente.CodTipoDoc = dbo.tb_TipoDoc.CodTipoDoc\n" +
                    "WHERE  dbo.tb_Cliente.NumDocIdentidad = '" + docIdent + "'";
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            
            while(rs.next()){
                cli = new Cliente(
                    rs.getString(1),
                    rs.getString(2),
                    rs.getString(3),
                    rs.getString(4),
                    rs.getString(5),
                    rs.getString(6),
                    rs.getString(7),
                    rs.getString(8),
                    rs.getString(9),
                    rs.getDate(10),
                    rs.getString(11),
                    rs.getString(12),
                    rs.getDate(13),
                    rs.getString(14)
                );
            }
            
        } catch (Exception e) {
            System.out.println("Error en buscarUsuarioMetodo UsuarioClase" + e.getMessage() + e.getCause());
        }
        return cli;
    }    
    
    public List listarClientes(){
        List lista = new ArrayList();
        try {
            String sql = "SELECT dbo.tb_Cliente.CodCliente, dbo.tb_Cliente.Nombres, dbo.tb_Cliente.Apellidos,\n" +
"dbo.tb_Cliente.Genero, dbo.tb_TipoDoc.DocIdentidad, dbo.tb_Cliente.NumDocIdentidad, \n" +
"dbo.tb_Cliente.Telefono, dbo.tb_Cliente.Email, dbo.tb_Distrito.NombreDist, \n" +
"dbo.tb_Nacionalidad.Nacionalidad, dbo.tb_Cliente.Direccion, \n" +
"dbo.tb_Cliente.FecNac, dbo.tb_Cliente.FecRegistro,\n" +
"dbo.tb_Cliente.EstadoCivil, dbo.tb_Cliente.foto\n" +
"FROM dbo.tb_Cliente INNER JOIN \n" +
"dbo.tb_Distrito ON dbo.tb_Cliente.CodDist = dbo.tb_Distrito.CodDist INNER JOIN\n" +
"dbo.tb_Nacionalidad ON dbo.tb_Cliente.CodNac = dbo.tb_Nacionalidad.CodNac INNER JOIN\n" +
"dbo.tb_TipoDoc ON dbo.tb_Cliente.CodTipoDoc = dbo.tb_TipoDoc.CodTipoDoc\n";
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            
            while(rs.next()){
                Object data[] ={
                    rs.getInt(1),
                    rs.getString(2),
                    rs.getString(3),
                    rs.getString(4),
                    rs.getString(5),
                    rs.getString(6),
                    rs.getString(7),
                    rs.getString(8),
                    rs.getString(9),
                    rs.getString(10),
                    rs.getString(11),
                    rs.getDate(12),
                    rs.getDate(13),
                    rs.getString(14),
                    rs.getString(15)

                };
                
                lista.add(data);
            }
        } catch (SQLException e) {
            System.out.println("Error en listar Clientes" + e.getMessage());
        }
        return lista;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public String getTipoDoc() {
        return tipoDoc;
    }

    public void setTipoDoc(String tipoDoc) {
        this.tipoDoc = tipoDoc;
    }

    public String getNumDoc() {
        return numDoc;
    }

    public void setNumDoc(String numDoc) {
        this.numDoc = numDoc;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDist() {
        return dist;
    }

    public void setDist(String dist) {
        this.dist = dist;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public Date getFecNac() {
        return fecNac;
    }

    public void setFecNac(Date fecNac) {
        this.fecNac = fecNac;
    }

    public String getNacionalidad() {
        return nacionalidad;
    }

    public void setNacionalidad(String nacionalidad) {
        this.nacionalidad = nacionalidad;
    }

    public String geteCivil() {
        return eCivil;
    }

    public void seteCivil(String eCivil) {
        this.eCivil = eCivil;
    }

    public Date getFecRegistro() {
        return FecRegistro;
    }

    public void setFecRegistro(Date FecRegistro) {
        this.FecRegistro = FecRegistro;
    }

    public String getFotoPath() {
        return fotoPath;
    }

    public void setFotoPath(String fotoPath) {
        this.fotoPath = fotoPath;
    }
    

}
