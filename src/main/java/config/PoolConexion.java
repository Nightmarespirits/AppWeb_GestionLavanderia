/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package config;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
/**-
 *
 * @author Clider Fernando Tutaya Rivera
 */
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import java.io.PrintWriter;

public class PoolConexion {
    private static HikariDataSource dataSource;

    static {
        try {
            HikariConfig config = new HikariConfig();
            config.setJdbcUrl("jdbc:sqlserver://DESKTOP-43498UB\\SQLEXPRESS;databaseName=DB_Sistema_Lavanderia_Control;encrypt=true;trustServerCertificate=true;hostNameInCertificate=*.database.windows.net;loginTimeout=30;");
            config.setUsername("sa");
            config.setPassword("masterdatabase31");
            config.setMaximumPoolSize(20);
            config.setMinimumIdle(5);
            config.setConnectionTimeout(30000);
            config.setIdleTimeout(600000);
            config.setMaxLifetime(1800000);
            dataSource = new HikariDataSource(config);
            // Habilitar logging de HikariCP
            config.addDataSourceProperty("logger", "slf4j");
            config.addDataSourceProperty("logWriter", new PrintWriter(System.out));
            dataSource = new HikariDataSource(config);
            System.out.println("Pool Conexion DB CORRECTA");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ExceptionInInitializerError("Error initializing DataSource: " + e.getMessage());
        }
    }

    public static HikariDataSource getDs() {
        return dataSource;
    }
}
