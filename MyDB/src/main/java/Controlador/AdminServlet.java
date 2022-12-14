/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Datos.FileDB;
import Datos.UserDB;
import Modelo.register;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author franc
 */
@WebServlet(name = "AdminServlet", urlPatterns = {"/AdminServlet"})
public class AdminServlet extends HttpServlet {

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

        ArrayList<register> dataListUser = new ArrayList();
        Map<String,ArrayList<File>> dataListFile = new HashMap<String,ArrayList<File>>();
        String button = request.getParameter("selectUserToDeleteButton");
        String buttonDeleteAll = request.getParameter("DeleteAll");
        String [] select = request.getParameterValues("selectUserToDelete");

        try{
            if(select !=null){
                if(button!=null){
                    for (String select1 : select) {
                        FileDB.removeAllFromUser(select1);
                        UserDB.removeUser(select1);
                    }
                }
                if(buttonDeleteAll!=null){
                    for (String select1 : select) {
                        FileDB.removeAllFromUser(select1);
                    }
                }

                for (String select1 : select) {
                     dataListFile.put(select1, FileDB.getAllFileFromUser(select1));
                   }
            }
                dataListUser = UserDB.selectAllUser();

                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/admin.jsp");
                request.setAttribute("users", dataListUser);
                request.setAttribute("dataFileName", dataListFile);
                request.setAttribute("userSelected", select);
                dispatcher.forward(request, response);
            

            
        }catch(Exception e){
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
