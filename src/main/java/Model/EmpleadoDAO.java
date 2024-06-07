/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import config.Conexion;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.util.Date;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ROBOT
 */
public class EmpleadoDAO {
    Conexion cnx = new Conexion();
    Connection cn = cnx.getCn();
    
    public List listarEmp(){
        List lista = new ArrayList();
        try {
            String sql = "SELECT        dbo.tb_Empleado.CodEmp,  CONCAT(dbo.tb_Empleado.Apellidos, ' ' , dbo.tb_Empleado.Nombres) AS Nombres, dbo.tb_Empleado.NumDocIdentidad, dbo.tb_Cargo.Cargo, dbo.tb_Empleado.Telefono, dbo.tb_Empleado.Email, \n" +
"                         dbo.tb_Distrito.NombreDist\n" +
"FROM            dbo.tb_Empleado INNER JOIN\n" +
"                         dbo.tb_Distrito ON dbo.tb_Empleado.CodDist = dbo.tb_Distrito.CodDist INNER JOIN\n" +
"                         dbo.tb_ContratoEmp ON dbo.tb_Empleado.CodEmp = dbo.tb_ContratoEmp.CodEmp INNER JOIN\n" +
"                         dbo.tb_Cargo ON dbo.tb_ContratoEmp.CodCargo = dbo.tb_Cargo.CodCargo";
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
                    rs.getString(7)
                };
                
                lista.add(data);
            }
        } catch (Exception e) {
            System.out.println("Error en crear lista empleados");
        }
        return lista;
    }
    
    public boolean insertEmp(Empleado emp){
        boolean band = false;
        try {
            CallableStatement cs = cn.prepareCall("{call usp_InsertarEmp(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            cs.setString(1, emp.getApellidos());
            cs.setString(2, emp.getNombres());
            cs.setString(3, emp.getGenero());
            cs.setString(4, emp.getTipoDoc());
            cs.setString(5, emp.getNumDoc());
            cs.setString(6, emp.getTel());
            cs.setString(7, emp.getEmail());
            cs.setString(8, emp.getDist());
            Date fecNac = emp.getFecNac();
            java.sql.Date sqlFecNac = new java.sql.Date(fecNac.getTime());
            cs.setDate(9,sqlFecNac );
            cs.setString(10, emp.getNacionalidad());
            cs.setString(11, emp.getDireccion());
            cs.setString(12, emp.geteCivil());
            cs.setString(13, emp.getSucursal());
            cs.setInt(14, emp.getEstadoEmp());
            cs.setInt(15, emp.getNroHijos());
            cs.setBytes(16, emp.getImagen());
            
            if(cs.executeUpdate()>= 0){
                band = true;
                System.out.println("SE HA INSERTADO CORRECTAMENTE AL EMPLEADO EN LA TB_EMPLEADOS");
            }
        } catch (Exception e) {
            System.out.println("Error en empleado dao agregar empleado function");
            e.getCause();
            e.getMessage();
            e.printStackTrace();
            
        }
        return band;
    }
    /*
    void cargarFoto(byte[] bytesArr) {
        try {

            if (bytesArr != null) {

                InputStream is = new ByteArrayInputStream(bytesArr);
                BufferedImage img = ImageIO.read(is);
                File archivo = new File("img.jpg");

                ImageIO.write(img, "jpg", archivo);

                ImageIcon imagen = new ImageIcon(archivo.getAbsolutePath());
                Icon icoImg = new ImageIcon(imagen.getImage().getScaledInstance(lblFoto.getWidth(), lblFoto.getHeight(), Image.SCALE_SMOOTH));
                lblFoto.setIcon(icoImg);
            } else {
                lblRuta.setText("No se ha encontrado una imagen en la base de datos del usuario");
            }

        } catch (IOException e) {
            System.out.println("Ha ocurrido un error garrafal " + e.getMessage() + e.getStackTrace());
        }
    }*/
    
}
