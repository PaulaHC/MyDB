<%-- 
    Document   : admin
    Created on : 25 apr 2022, 16:55:47
    Author     : daniele
--%>

<%@page import="java.io.File"%>
<%@page import="Modelo.register"%>
<%@page import="Datos.UserDB"%>
<%@page language="java" import="java.util.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <jsp:include page="/AdminServlet" flush="true"/>
    
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <meta http-equiv="X-UA-Compatible" content="ie=edge" />

    <meta name="copyright" content="MACode ID, https://macodeid.com/" />

    <title>MyDB - Custom database creator</title>

    <link rel="stylesheet" type="text/css" href="./assets/css/maicons.css" />

    <link rel="stylesheet" type="text/css" href="./assets/css/bootstrap.css" />

    <link rel="stylesheet" type="text/css" href="./assets/vendor/animate/animate.css" />

    <link rel="stylesheet" type="text/css" href="./assets/css/theme.css" />

    <link rel="stylesheet" type="text/css" href="./assets/css/style.css" />

    <!-- MyDB icon -->
    <link rel="icon" href="./assets/images/cloud-data-300.png">
    
    
  </head>
  <body>
   
    
    <!-- Back to top button -->
    <div class="back-to-top"></div>

    <header>
      <!-- NAVBAR -->
      <nav class="navbar navbar-toggleable-md navbar-light bg-faded">
        <div class="container">
          <a href="index.jsp" class="navbar-brand">My<span class="text-primary">DB</span></a>

          <button
            class="navbar-toggler navbar-toggler-right"
            data-toggle="collapse"
            type="button" 
            data-target="#navbarNav" 
            aria-controls="navbarNav"
            aria-expanded="false"
            aria-label="Toggle navigation"
          >
            <span class="mai-person" id="nav-usr-icon"></span>
          </button>

          <div class="collapsed navbar-collapse collapse" id="navbarNav">
            <ul class="navbar-nav">
              <li class="nav-item" id="nav-item-tr">
                <a class="nav-link" href="index.jsp">Home</a>
              </li>
              <li class="nav-item active" id="nav-item-tr">
                <a class="nav-link" href="admin.jsp" >Admin Mode</a>
              </li>
              <!-- Already logged-in user (admin), so "Register" and "Login" are useless -->
              <!-- <li class="nav-item">
                <a class="nav-link" href="register.jsp">Register</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="login.jsp">Login</a>
              </li> -->
              <li class="nav-item" id="nav-item-tr">
                <a class="nav-link" href="create-log.jsp">Manage table</a>
              </li>
              <li class="nav-item" id="nav-item-tr">
                <a class="nav-link" href="index.jsp" >Logout</a>
              </li>
            </ul>
          </div>
        </div>
      </nav>

      <div class="container">
        <div class="page-banner">
          <div class="row justify-content-center align-items-center h-100">
            <div class="col-md-6">
              <nav aria-label="Breadcrumb">
                <ul class="breadcrumb justify-content-center py-0 bg-transparent">
                  <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                  <li class="breadcrumb-item active">Admin</li>
                </ul>
              </nav>
              <h1 class="text-center">Act with care administrator.</h1>
            </div>
          </div>
        </div>
      </div>
      
    </header>

    <div class="page-section">
      <div class="container">
        <div class="row align-items-center">
          <div class="col-lg-12 py-3">
            <h2 class="title-section">MyDB, admin our data.</h2>
            <div class="divider"></div>
            <form action="AdminServlet" method="post" name="formulation">

                <div class="row align-items-start">
                  <div class="col-lg-8">
                    <!-- Table admin -->
                    <table class="table text-center">
                      <thead>
                        <tr>
                          <th scope="col" id="table-admin-index">#</th>
                          <th scope="col" id="table-admin-index">User name</th>
                          <th scope="col" id="table-admin-index">User surname</th>
                          <th scope="col" id="table-admin-index">User email</th>
                          <th scope="col" id="table-admin-index">User password</th>
                          <th scope="col" id="table-admin-index">Select user</th>
                        </tr>
                      </thead>

                      <tbody>
                           <% ArrayList<register> dataListUser= (ArrayList<register>)request.getAttribute("users");
                            int indice=1;
                            for(int i=0; i<dataListUser.size(); i++){
                                register r = dataListUser.get(i);
                                if(!r.getEmail().equals("admin@admin.com")){
                        %>
                      
                                    <tr>
                                        <td scope="row"><%= indice %></td>
                                        <td scope="row"><%= r.getName() %></td>
                                        <td scope="row"><%= r.getSubname() %></td>
                                        <td scope="row"><%= r.getEmail() %></td> 
                                        <td scope="row"><%= r.getPassword() %></td>
                                        <td class="align-middle">
                                            <label
                                              class="form-check-label"
                                              id="table-admin-select" >
                                                <input class="form-check-input" id="chx" type="checkbox" name="selectUserToDelete" value="<%= r.getEmail() %>"> Select
                                            </label>
                                        </td>
                                    </tr>
                                    <%indice++;
                                }
                            }%>
                      </tbody>
                    </table>
                    <!-- END table user -->

                    <!-- Buttons below the table -->
                    <div
                      class="btn-toolbar mb-2"
                      role="toolbar"
                      aria-label="Toolbar with button groups"
                    >
                      <div
                        class="btn-group mr-2"
                        role="group"
                        aria-label="Third group"
                      >
                          <form action="AdminServlet" method="post">
                          <button id="delete_user_db" name="selectUserToDeleteButton" type="submit" class="btn btn-accent">Delete selected user</button>
                          </form>
                          
                      </div>
                      <div
                        class="btn-group mr-2"
                        role="group"
                        aria-label="Third group"
                      >
                          <button type="submit" class="btn btn-accent">View Tables</button>
                      </div>
                    </div>
                    
                    <!-- END buttons below the table -->
                  </div>

                  <div class="col-lg-4">

                    <!-- Table select user's tables -->
                    <table class="table">

                      <thead>
                        <tr>
                          <th scope="col">Selected user tables</th>
                        </tr>
                      </thead>
                      <tbody>
                        <% Map<String,ArrayList<File>> dataNameFile= (Map<String,ArrayList<File>>)request.getAttribute("dataFileName");
                           String [] userSelected= (String [])request.getAttribute("userSelected");
                        if(dataNameFile!=null){
                            if(dataNameFile.size()<1){%>
                                <tr><td scope="row">No tables available.</td> </tr>
                            <%}else{
                                    for(int i=0;i<userSelected.length;i++){%>
                                         <tr><td scope="row">SELECTED USER:  <%= userSelected[i]%></td></tr>
                                         <%for(int j=0;j<dataNameFile.get(userSelected[i]).size();j++) { %>
                                            <tr>
                                                <td scope="row"><%= dataNameFile.get(userSelected[i]).get(j).getName()%></td>
                                            </tr>
                                        <%}
                                    }
                                }%>
                        <%}else{%>
                            <tr> 
                                <td scope="row">No user selected.</td>  
                            </tr>
                        <%}%>
                      </tbody>
                    </table>
                    <!-- END select user's tables -->

                    <!-- Buttons below the table -->
                    <div
                      class="btn-toolbar mb-2"
                      role="toolbar"
                      aria-label="Toolbar with button groups"
                    >
                      <div
                        class="btn-group mr-2"
                        role="group"
                        aria-label="First group"
                      >
                        <button type="submit" name="DeleteAll" class="btn btn-warning" value="true">Delete all user tables</button>
                      </div>
                    </div>
                    <!-- END buttons below the table -->
                  </div>
                </div>
                      </form>
          </div>
        </div>
      </div>
    </div>

    <!-- FOOTER -->
    <footer
      class="page-footer bg-image"
      style="background-image: url(../assets/images/world_pattern.svg)"
    >
      <div class="container">
        <div class="row mb-5">
          <div class="col-lg-6 py-3">
            <h3>MyDB</h3>
            <p>
              Follow us on our social channels.
            </p>

            <div class="social-media-button">
              <a href="https://www.facebook.com/"><span class="mai-logo-facebook-f"></span></a>
              <a href="https://twitter.com/"><span class="mai-logo-twitter"></span></a>
              <a href="https://www.instagram.com/"><span class="mai-logo-instagram"></span></a>
              <a href="https://www.youtube.com/"><span class="mai-logo-youtube"></span></a>
            </div>
          </div>
          
          <div class="col-lg-6 py-3">
            <h5>Contact Us</h5>
            <p><a href="https://goo.gl/maps/Kr9kD6ZVdLPDxUTy8" class="footer-link">Inf-UVa, P.º de Belén, 15, 47011, Valladolid, Spain</a></p>
            <p><a href="tel:+34 123 45 67 89" class="footer-link">+34 123 45 67 89</a></p>
            <p><a href="mailto:mydb@fake.email.com" class="footer-link">mydb@fake.email.com</a></p>
          </div>
          
        </div>
      </div>
    </footer>
    <!-- END FOOTER -->

    <script src="./assets/js/jquery-3.5.1.min.js"></script>

    <script src="./assets/js/bootstrap.bundle.min.js"></script>

    <script src="./assets/vendor/wow/wow.min.js"></script>

    <script src="./assets/js/theme.js"></script>
  </body>
</html>
