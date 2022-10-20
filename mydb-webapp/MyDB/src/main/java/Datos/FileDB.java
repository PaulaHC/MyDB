/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Datos;

import Modelo.Fich;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author paula
 */
public class FileDB {
    
    public static int insert(Fich file, Blob b) throws FileNotFoundException, IOException {
        Conexion pool = Conexion.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        String query="INSERT INTO basededatos (NOMBRE, FECHACREACION, FECHAMODIFICACION, FICHERO, EMAILUSUARIO) "+
                "VALUES (?, ?, ?, ?, ?);";
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, file.getName());
            ps.setDate(2, file.getCreationDate());
            ps.setDate(3, file.getModificationDate()); 
            
            //ps.setBlob(4, (Blob)file.getFichero());
            ps.setBlob(4, b);
            ps.setString(5, file.getEmail());
            
            int res = ps.executeUpdate();
            ps.close();
            pool.freeConnection(connection);
            
            return res;
        } catch (SQLException e) {
            System.out.println(e);
            return 0;
        }
    }
    
    public static boolean fileExist(String emailAddress, String name) {
        Conexion pool = Conexion.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT NOMBRE FROM BASEDEDATOS "
        + "WHERE EMAILUSUARIO = ? AND NOMBRE=?;";
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, emailAddress);
            ps.setString(2, name);
            rs = ps.executeQuery();
            boolean res = rs.next();
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return res;
        } catch (SQLException e) {
            return false;
        }
    }

    public static String getAllNameFileFromUser(String emailAddress){
        String lista = "";
        
        Conexion pool = Conexion.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT NOMBRE FROM BASEDEDATOS "
        + "WHERE EMAILUSUARIO = ? ;";
        
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, emailAddress);
            rs = ps.executeQuery();
            if(rs.next())
                lista=rs.getString("NOMBRE");
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            
            return lista;
        } catch (SQLException e) {
            return null;
        }
    }
    
    public static ArrayList<File> getAllFileFromUser(String emailAddress){    
        Conexion pool = Conexion.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT NOMBRE, FICHERO FROM BASEDEDATOS "
        + "WHERE EMAILUSUARIO = ?;";
        
        try {
            ArrayList<File>lista= new ArrayList<File>() ;
            ps = connection.prepareStatement(query);
            ps.setString(1, emailAddress);
            rs = ps.executeQuery();
            while(rs.next()){
                // read the Blob object that represent the File
                File f = new File(rs.getString("NOMBRE"));
                FileOutputStream fos = new FileOutputStream(f);

                byte[] buffer = new byte[1];
                InputStream is = rs.getBinaryStream(2);
                while (is.read(buffer) > 0) {
                    fos.write(buffer);
                }
                fos.close();
                lista.add(f);
            }
           
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            
            return lista;
        } catch (SQLException e) {
            return null;
        } catch (IOException ex) {
            Logger.getLogger(FileDB.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public static void removeAllFromUser(String email){
        Conexion pool = Conexion.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        //ResultSet rs = null;
        String query = "DELETE FROM BASEDEDATOS "
        + "WHERE EMAILUSUARIO = ?;";
        
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, email);
            ps.executeUpdate();

            ps.close();
            pool.freeConnection(connection);
            
        } catch (SQLException e) {
        }
    }
    
    public static File getFileFromUser(String name,String emailAddress){    
        Conexion pool = Conexion.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT FICHERO FROM BASEDEDATOS "
        + "WHERE EMAILUSUARIO = ? AND NOMBRE= ?";
        
        try {
            File f = null;
            ps = connection.prepareStatement(query);
            ps.setString(1, emailAddress);
            ps.setString(2, name);
            rs = ps.executeQuery();
            if(rs.next()){
                // read the Blob object that represent the File
                f = new File(name);
                FileOutputStream fos = new FileOutputStream(f);

                byte[] buffer = new byte[1];
                InputStream is = rs.getBinaryStream(1);
                while (is.read(buffer) > 0) {
                    fos.write(buffer);
                }
                fos.close();
            }
           
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            
            return f;
        } catch (SQLException e) {
            System.err.println(e);
            return null;
        } catch (IOException ex) {
            Logger.getLogger(FileDB.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
 
    public static void UpdateDateFile(Date d, Blob b, String email, String filename){
        Conexion pool = Conexion.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        //ResultSet rs = null;
        String query = "UPDATE basededatos SET FECHAMODIFICACION=?, FICHERO=? " 
                    + "WHERE EMAILUSUARIO=? AND NOMBRE=?;";
        try {
            ps = connection.prepareStatement(query);
            ps.setDate(1, d);
            ps.setBlob(2, b);
            ps.setString(3, email);
            ps.setString(4, filename);
            ps.executeUpdate();

            ps.close();
            pool.freeConnection(connection);
            
        } catch (SQLException e) {
        }
    }
}
