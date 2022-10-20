/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Datos;

/**
 *
 * @author paula
 */
import Modelo.register;
import java.sql.*;
import java.util.ArrayList;

public class UserDB {
    
    public static int insert(register user) {
        Conexion pool = Conexion.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        String query="INSERT INTO USUARIOREGISTRADO (EMAIL, NOMBRE, APELLIDO, PASSWORD) VALUES (?, ?, ?, HEX(AES_ENCRYPT(?, 'claveparaencriptar')));";
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getName());
            ps.setString(3, user.getSubname());
            ps.setString(4, user.getPassword());
            int res = ps.executeUpdate();
            ps.close();
            pool.freeConnection(connection);
            return res;
        } catch (Exception e) {
            System.out.println("error22  " +e);
            return 0;
        }
    }
    
    public static boolean emailExists(String emailAddress) {
        Conexion pool = Conexion.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT EMAIL FROM USUARIOREGISTRADO "
        + "WHERE EMAIL = ?;";
        
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, emailAddress);
            rs = ps.executeQuery();
            boolean res = rs.next();
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            
            return res;
        } catch (Exception e) {
            return false;
        }
    }
    
    public static boolean userExists(String emailAddress, String password) {
        Conexion pool = Conexion.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT EMAIL FROM USUARIOREGISTRADO "
        + "WHERE EMAIL = ? AND PASSWORD = HEX(AES_ENCRYPT(?, 'claveparaencriptar'));";
        
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, emailAddress);
            ps.setString(2, password);
            rs = ps.executeQuery();
            boolean res = rs.next();
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return res;
        } catch (Exception e) {
            return false;
        }
    }
    
    public static register selectUser(String emailAddress) {
        Conexion pool = Conexion.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT NAME, SUBNAME, EMAIL, AES_DECRYPT(UNHEX(PASSWORD), 'claveparaencriptar') FROM USUARIOREGISTRADO WHERE EMAIL = ?;";
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, emailAddress);
            rs = ps.executeQuery();
            register user = null;
            if (rs.next()) {
                user = new register();
                user.setName(rs.getString("name"));
                user.setSubname(rs.getString("Subname"));
                user.setEmail(rs.getString("Email"));
                user.setPassword(rs.getString(4));
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return user;
        } catch (Exception e) {
            return null;
        } 
    } 
    
    public static String recoverPass(String name, String subname, String emailAddress) {
        Conexion pool = Conexion.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT AES_DECRYPT(UNHEX(PASSWORD), 'claveparaencriptar') FROM USUARIOREGISTRADO "
                + "WHERE EMAIL = ? AND NOMBRE = ? AND APELLIDO = ?;";

        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, emailAddress);
            ps.setString(2, name);
            ps.setString(3, subname);
            rs = ps.executeQuery();
            
            String res = "";
            if(rs.next()){
               res = rs.getString(1);
            }else{
                res = "";
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return res;
        } catch (Exception e) {
            System.out.println("error  " +e);
            return null;
        }
    }

    public static boolean proveEmailAndName(String name, String subname, String emailAddress){
        Conexion pool = Conexion.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT EMAIL FROM USUARIOREGISTRADO "
                + "WHERE NOMBRE = ? AND APELLIDO = ?;";

        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, subname);
            rs = ps.executeQuery();
            String res = "";
            boolean v = false; 
            if(rs.next()){
               res = rs.getString("EMAIL");
               if(res.equals(emailAddress)) v = true;
            }else{
                res = "";
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            if(v) return true;
            else return false;
        } catch (Exception e) {
            return false;
        }
    }

    public static ArrayList<register> selectAllUser(){
        Conexion pool = Conexion.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        ArrayList<register> lista = new ArrayList<register>();
           
        
        String query = "SELECT EMAIL, NOMBRE, APELLIDO, AES_DECRYPT(UNHEX(PASSWORD), 'claveparaencriptar') FROM usuarioregistrado";
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                register user = new register();
                user.setEmail(rs.getString("EMAIL"));
                user.setName(rs.getString("NOMBRE"));
                user.setSubname(rs.getString("APELLIDO"));
                user.setPassword(rs.getString(4));
                lista.add(user);
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return lista;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e);
            return null;
        } 
    }
    
     public static void removeUser(String email){
         Conexion pool = Conexion.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        //ResultSet rs = null;
        String query ="DELETE FROM USUARIOREGISTRADO \n" +
            "WHERE EMAIL = ?;";
        
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, email);
            ps.executeUpdate();

            ps.close();
            pool.freeConnection(connection);
            
        } catch (Exception e) {
        }
    }
}
