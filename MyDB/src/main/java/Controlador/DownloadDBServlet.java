/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import Datos.FileDB;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author paula
 */
@WebServlet(name = "DownloadDBServlet", urlPatterns = {"/DownloadDBServlet"})
public class DownloadDBServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            //Identificador de la cuenta abierta
            String  emailAddress= (String) request.getSession().getAttribute("user");
            //Nombre del fichero elegido para su carga en pantalla
            String fich=  request.getParameter("selectDatabase");
            String stringFile="";
            if(fich!=null){
                 //Variable con donde ira el contenido del fichero
                 stringFile="\"";

                 //Descarga de la base de datos el fichero elegido
                 File chooseFile=FileDB.getFileFromUser(fich,emailAddress);

                 //Paso su contenido a cadena
                 FileReader fr =new FileReader(chooseFile); 
                 BufferedReader entrada = new BufferedReader(fr);
                 String readFile = entrada.readLine();    //se lee la primera línea del fichero
                 while (readFile != null) {               //mientras no se llegue al final del fichero      
                    stringFile+=readFile;            //añado la linea del fichero al string
                     readFile = entrada.readLine();       //se lee la siguiente línea del fichero  
                 }
                 stringFile+="\"";
                 request.setAttribute("chosenfile", stringFile);
                
            }
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/create-log.jsp");
            dispatcher.forward(request, response);
            
        }catch(IOException | ServletException e){
             System.out.println(e);
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
        processRequest(request, response);
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
        processRequest(request, response);
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
