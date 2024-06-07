/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package config;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author ROBOT
 */
public class Conexion {
    /*Para establecer conexion es nescesario que sql browser este activo*/
    private String url = "jdbc:sqlserver://DESKTOP-43498UB\\SQLEXPRESS;" 
            + "database=DB_Sistema_Lavanderia_Control;" + "user=sa;" + "password=masterdatabase31;" +"trustServerCertificate=true;";
    private String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    
    public Connection getCn(){
        Connection cn = null;
        try {
            Class.forName(driver);
            cn = DriverManager.getConnection(url);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return cn;
    }
    
}
