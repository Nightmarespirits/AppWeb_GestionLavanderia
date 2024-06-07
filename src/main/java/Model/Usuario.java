/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import com.google.gson.annotations.Expose;
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
public class Usuario {
    Conexion cnx = new Conexion();
    Connection cn = cnx.getCn();
    @Expose
    private String codEmp;
    @Expose
    private String apellidos;
    @Expose
    private String nombres;
    @Expose
    private String numDoc;
    @Expose
    private String codUser;
    @Expose
    private String username;
    @Expose
    private String password;
    @Expose
    private String rol;
    @Expose
    private String area;
    @Expose
    private String cargo;
    @Expose
    private Date fecReg;
    @Expose
    private String estadoUsuario;
    
    private byte[] foto;
    public String session;

    public Usuario() {
    }
    public Usuario(String codEmp, String apellidos, String nombres, String numDoc, String codUser, String username,String password, String rol, String area, String cargo, Date fecReg, String estadoUsuario, byte[] foto) {
        this.codEmp = codEmp;
        this.apellidos = apellidos;
        this.nombres = nombres;
        this.numDoc = numDoc;
        this.codUser = codUser;
        this.username = username;
        this.password = password;
        this.rol = rol;
        this.area = area;
        this.cargo = cargo;
        this.fecReg = fecReg;
        this.estadoUsuario = estadoUsuario;
        this.foto = foto;
    }
    
    //DAO
    public Usuario buscarUsrDoc(String docIdent){
        Usuario usr = null;
        try {
            String sql = "SELECT  dbo.tb_Empleado.CodEmp, dbo.tb_Empleado.Apellidos, dbo.tb_Empleado.Nombres, dbo.tb_Empleado.NumDocIdentidad, dbo.tb_Usuario.CodUsuario, dbo.tb_Usuario.NombreUsuario, dbo.tb_Usuario.Contrasenia, \n" +
                    "    dbo.tb_Perfil.Perfil, dbo.tb_Area.Area, dbo.tb_Cargo.Cargo, dbo.tb_Usuario.FecRegistro, dbo.tb_Usuario.EstadoUsuario, dbo.tb_Empleado.Foto\n" +
                    "FROM dbo.tb_Usuario INNER JOIN\n" +
                    "    dbo.tb_Empleado ON dbo.tb_Usuario.CodEmp = dbo.tb_Empleado.CodEmp INNER JOIN\n" +
                    "    dbo.tb_Perfil ON dbo.tb_Usuario.CodPerfil = dbo.tb_Perfil.CodPerfil INNER JOIN\n" +
                    "    dbo.tb_ContratoEmp ON dbo.tb_Empleado.CodEmp = dbo.tb_ContratoEmp.CodEmp INNER JOIN\n" +
                    "    dbo.tb_Area INNER JOIN\n" +
                    "    dbo.tb_Cargo ON dbo.tb_Area.CodArea = dbo.tb_Cargo.CodArea ON dbo.tb_ContratoEmp.CodCargo = dbo.tb_Cargo.CodCargo\n" +
                    "WHERE dbo.tb_Empleado.NumDocIdentidad = '" + docIdent + "'";
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            
            while(rs.next()){
                usr = new Usuario(
                    rs.getString(1),
                    rs.getString(2),
                    rs.getString(3),
                    rs.getString(4),
                    rs.getString(5),
                    rs.getString(6),
                    rs.getString(7),
                    rs.getString(8),
                    rs.getString(9),
                    rs.getString(10),
                    rs.getDate(11),
                    rs.getString(12),
                    rs.getBytes(13)
                );
            }
            
        } catch (Exception e) {
            System.out.println("Error en buscarUsuarioMetodo UsuarioClase" + e.getMessage() + e.getCause());
        }
        return usr;
    }    
    
    public Usuario buscarUsuarioUsername(String username){
        Usuario usr = null;
        try {
            String sql = "SELECT        dbo.tb_Empleado.CodEmp, dbo.tb_Empleado.Apellidos, dbo.tb_Empleado.Nombres, dbo.tb_Empleado.NumDocIdentidad, dbo.tb_Usuario.CodUsuario, dbo.tb_Usuario.NombreUsuario, dbo.tb_Usuario.Contrasenia, \n" +
            " dbo.tb_Perfil.Perfil, dbo.tb_Area.Area, dbo.tb_Cargo.Cargo, dbo.tb_Usuario.FecRegistro, dbo.tb_Usuario.EstadoUsuario, dbo.tb_Empleado.Foto\n" +
            "FROM     dbo.tb_Area INNER JOIN\n" +
            " dbo.tb_Cargo ON dbo.tb_Area.CodArea = dbo.tb_Cargo.CodArea INNER JOIN\n" +
            " dbo.tb_ContratoEmp ON dbo.tb_Cargo.CodCargo = dbo.tb_ContratoEmp.CodCargo INNER JOIN\n" +
            " dbo.tb_Empleado ON dbo.tb_ContratoEmp.CodEmp = dbo.tb_Empleado.CodEmp INNER JOIN\n" +
            " dbo.tb_Distrito ON dbo.tb_Empleado.CodDist = dbo.tb_Distrito.CodDist INNER JOIN\n" +
            " dbo.tb_Sucursal ON dbo.tb_ContratoEmp.CodSucursal = dbo.tb_Sucursal.CodSucursal AND dbo.tb_Distrito.CodDist = dbo.tb_Sucursal.CodDist INNER JOIN\n" +
            " dbo.tb_Usuario ON dbo.tb_Empleado.CodEmp = dbo.tb_Usuario.CodEmp INNER JOIN\n" +
            " dbo.tb_Perfil ON dbo.tb_Usuario.CodPerfil = dbo.tb_Perfil.CodPerfil\n" +
            " where dbo.tb_Usuario.NombreUsuario='"+ username+"'";
            Statement st = cn.createStatement();

            ResultSet rs = st.executeQuery(sql);    

            while(rs.next()){
                usr = new Usuario(
                    rs.getString(1),
                    rs.getString(2),
                    rs.getString(3),
                    rs.getString(4),
                    rs.getString(5),
                    rs.getString(6),
                    rs.getString(7),
                    rs.getString(8),
                    rs.getString(9),
                    rs.getString(10),
                    rs.getDate(11),
                    rs.getString(12),
                    rs.getBytes(13)


                );
            }

        } catch (SQLException e) {
            System.out.println("Error el metodo crear usuario de usuarioDao" + e.getMessage() + e.getCause());
        }
        return usr;
    }

    public String validarLogin(String usu, String pas){
        String msg = "";
        try {
            CallableStatement cs = cn.prepareCall("{ call usp_ValidarLogin( ?, ?, ?) }");
            cs.setString(1,usu);
            cs.setString(2,pas);
            cs.setString(3, "tigo");
            
            ResultSet rs = cs.executeQuery();
            if(rs.next()){
                msg =  rs.getString(1);
            }
        } catch (SQLException e) {
            
            System.out.println("Error: en validar login " + e.getMessage());
            
        }
        
        return msg;
    }
    
    public List listaUsuario(){
    List lista = new ArrayList();
    try {
        String sql = "select * from usuario";
        Statement st = cn.createStatement();
        ResultSet rs = st.executeQuery(sql);

        while(rs.next()){
            Object data[] = {
              rs.getInt(1),
              rs.getString(2),
              rs.getString(3),
              rs.getString(4),
              rs.getString(5),
              rs.getInt(6),
              rs.getString(7),
            };
            lista.add(data);
            }
        } catch (Exception e) {
            System.out.println("Error");
        }
        return lista;
    }

    public boolean insertarUsuario(Usuario usu){
        boolean band = false;
        try {
            CallableStatement cs =cn.prepareCall("{call usp_insertarUsuario(?,?,?,?,?)}");    
            cs.setString(1,usu.getNombres());
            cs.setString(2,usu.getUsername());
            cs.setString(3,usu.getRol());
            cs.setString(4,usu.getEstadoUsuario());
            cs.setString(5,usu.getPassword());
            
            
            if(cs.executeUpdate() > 0){
                band = true;
            }          
        } catch (Exception e) {
            System.out.println("Error al insertar usuario" + e.getMessage());
        }
        return band;
    }
    
    //Getters and Setters
    public String getCodUser() {
        return codUser;
    }

    public void setCodUser(String codUser) {
        this.codUser = codUser;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getCargo() {
        return cargo;
    }

    public void setCargo(String cargo) {
        this.cargo = cargo;
    }

    public String getSession() {
        return session;
    }

    public void setSession(String session) {
        this.session = session;
    }
   public String getCodEmp() {
        return codEmp;
    }

    public void setCodEmp(String codEmp) {
        this.codEmp = codEmp;
    }

    public Date getFecReg() {
        return fecReg;
    }

    public void setFecReg(Date fecReg) {
        this.fecReg = fecReg;
    }

    public String getEstadoUsuario() {
        return estadoUsuario;
    }

    public void setEstadoUsuario(String estadoUsuario) {
        this.estadoUsuario = estadoUsuario;
    }

    public byte[] getFoto() {
        return foto;
    }

    public void setFoto(byte[] foto) {
        this.foto = foto;
    }

    public String getNumDoc() {
        return numDoc;
    }

    public void setNumDoc(String numDoc) {
        this.numDoc = numDoc;
    }
    
    
}
