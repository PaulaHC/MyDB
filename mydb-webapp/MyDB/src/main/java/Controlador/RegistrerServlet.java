/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import Datos.UserDB;
import Modelo.register;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author paula
 */
@WebServlet(name = "RegistrerServlet", urlPatterns = {"/RegistrerServlet"})
public class RegistrerServlet extends HttpServlet {

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
        /*Creo un nuevo usuario para el registro, y saco los datos proporcionados por el usuario*/
        register usuario = new register();
        String name=request.getParameter("name");
        String subname=request.getParameter("subname");
        String email=request.getParameter("email");
        String password=request.getParameter("password");
        String bol = "";
        try {
            
            if(name!="" && subname!="" && email!="" && password!=""){
                usuario.setName(name);
                usuario.setEmail(email);
                usuario.setSubname(subname);
                usuario.setPassword(password);
                /*Comprobamos si el usuario ya existe*/
                if (!UserDB.emailExists(email)){
                    UserDB.insert(usuario);
                    bol="new";
                }else{
                    bol = "yes";
                }
            }else{
                    bol = "no";
                }
        }catch(Exception e){
            System.out.println(e);
        }
        
        try{
            String nextStep = "";
            if("new".equals(bol)){
                request.setAttribute("show", "new");
                HttpSession session = request.getSession();
                session.setAttribute("user", email);
                nextStep = "/create-log.jsp";
            }else{
                nextStep = "/register.jsp";
            }
            RequestDispatcher dispatcher =
                    getServletContext().getRequestDispatcher(nextStep);
            if(!"new".equals(bol)) request.setAttribute("show", bol);
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
