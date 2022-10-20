/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Datos.FileDB;
import Modelo.Fich;
import java.io.*;
import java.util.Date;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.rowset.serial.SerialBlob;

/**
 *
 * @author franc
 */
@WebServlet(name = "SaveDBServlet", urlPatterns = {"/SaveDBServlet"})
public class SaveDBSevlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        
        // take in String format the text of the file that create the database
        String texto = (String)request.getParameter("id");
        String filename = (String) request.getParameter("name");
        
        try (PrintWriter out = response.getWriter()) {
            // recover the email from the person who just registered
            HttpSession sesion = request.getSession();
            String email = (String) sesion.getAttribute("user");
            
            if(!FileDB.fileExist(email, filename)){
                // create the file that save in the Database
                File f = null;
                try{
                    f = new File("creation");
                    FileWriter fw = new FileWriter (f);
                    BufferedWriter bw=new BufferedWriter(fw);
                    bw.write(texto);
                    bw.flush();
                }catch(IOException e){
                    System.out.println(e);
                }

                // the current date of the database creation
                Date date = new Date();
                long timeInMilliSeconds = date.getTime();
                java.sql.Date date1 = new java.sql.Date(timeInMilliSeconds);

                // create the object Fich to insert into the database
                Fich fich = new Fich();
                fich.setEmail(email);
                fich.setModificationDate(null);
                fich.setCreationDate(date1);
                fich.setName(filename);
                fich.setFichero(f);

                byte[] byteData = texto.getBytes();
                Blob docInBlob = new SerialBlob(byteData);

                // insert the file into the database
                FileDB.insert(fich, docInBlob);
                
                
            }else{
                //out.print("enterNewNameFile(\""+filename+"\")");
                File f = null;
                try{
                    f = new File(filename);
                    FileWriter fw = new FileWriter (f);
                    BufferedWriter bw=new BufferedWriter(fw);
                    bw.write(texto);
                    bw.flush();
                }catch(IOException e){
                    System.out.println(e);
                }
                
                Date date = new Date();
                long timeInMilliSeconds = date.getTime();
                java.sql.Date date1 = new java.sql.Date(timeInMilliSeconds);

                // create the object Fich to insert into the database
                Fich fich = new Fich();
                fich.setEmail(email);
                fich.setModificationDate(null);
                fich.setCreationDate(date1);
                fich.setName(filename);
                fich.setFichero(f);

                byte[] byteData = texto.getBytes();
                Blob docInBlob = new SerialBlob(byteData);
                
               FileDB.UpdateDateFile(date1, docInBlob, email, filename);
            }
            
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(SaveDBSevlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(SaveDBSevlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
