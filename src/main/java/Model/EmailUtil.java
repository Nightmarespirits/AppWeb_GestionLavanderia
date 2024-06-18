/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;
import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.security.SecureRandom;


/**
 *
 * @author Clider Fernando Tutaya Rivera
 */
public class EmailUtil {
    private static final String REMITENTE = "soporteslc309@gmail.com"; 
    private static final String CLAVE = "izib bntd dqpw uxzc"; 
    
    public static void enviarMail(String dest, String asunto, String cuerpo){
        Properties props = new Properties();
        
        /*props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");*/
        

        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.ssl.trust", "*");
        
        Session session = Session.getInstance(props, new Authenticator(){
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(REMITENTE, CLAVE);
            }
        });
        
        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(REMITENTE));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(dest));
            msg.setSubject(asunto);
            msg.setText(cuerpo);
            
            Transport.send(msg);
            System.out.println("Correo enviado a: " + dest);
        } catch (MessagingException e) {
             throw new RuntimeException(e);
        }
    }
    
    public static String generarContraseña() {
        String caracteres = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        SecureRandom random = new SecureRandom();
        StringBuilder sb = new StringBuilder(10);
        for (int i = 0; i < 10; i++) {
            sb.append(caracteres.charAt(random.nextInt(caracteres.length())));
        }
        return sb.toString();
    }
}
