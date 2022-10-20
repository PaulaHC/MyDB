<%-- 
    Document   : register
    Created on : 25 apr 2022, 16:57:43
    Author     : daniele
--%>
<%@page language="java" import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <meta http-equiv="X-UA-Compatible" content="ie=edge" />

    <title>MyDB - Custom database creator</title>

    <link rel="stylesheet" href="./assets/css/maicons.css" />

    <link rel="stylesheet" href="./assets/css/bootstrap.css" />

    <link rel="stylesheet" href="./assets/vendor/animate/animate.css" />

    <link rel="stylesheet" href="./assets/css/theme.css" />

    <link rel="stylesheet" href="./assets/css/style.css" />

    <script src="./assets/js/functionality.js"></script>
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
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
            <span class="mai-person-outline" id="nav-usr-icon"></span>
          </button>

          <div class="collapsed navbar-collapse collapse" id="navbarNav">
            <ul class="navbar-nav">
              <li class="nav-item" id="nav-item-tr">
                <a class="nav-link" href="index.jsp">Home</a>
              </li>
              <li class="nav-item active" id="nav-item-tr">
                <a class="nav-link" href="register.jsp" >Register</a>
              </li>
              <li class="nav-item" id="nav-item-tr">
                <a class="nav-link" href="login.jsp">Login</a>
              </li>
              <li class="nav-item" id="nav-item-tr">
                <a class="nav-link" href="create.jsp" >Create table</a>
              </li>
            </ul>
          </div>
        </div>
      </nav>
      <!-- END NAVBAR -->

      <div class="container">
        <div class="page-banner">
          <div class="row justify-content-center align-items-center h-100">
            <div class="col-md-6">
              <nav aria-label="Breadcrumb">
                <ul class="breadcrumb justify-content-center py-0 bg-transparent">
                  <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                  <li class="breadcrumb-item active">Register</li>
                </ul>
              </nav>
              <h1 class="text-center">Register here!</h1><br>
              <% String bol = (String)request.getAttribute("show"); 
                   if(bol!=null){%>
                        <%if("yes".equals(bol)){%>
                            <h2 id="textWrong" class="text-center">Your Email is also registered.</h2>
                       <%}else if("no".equals(bol)){%>
                            <h2 class="text-center" id="textWrong" >Some folds empty...</h2>
                       <%}else if("".equals(bol)){%>
                            <h2 id="textWrong" class="text-center">Your Email is also registered.</h2>
                       <%}%>
                   <%}else{%>
                        <h2></h2>
                   <%}%>
            </div>
          </div>
        </div>
      </div>
    </header>

    <div class="page-section">
      <div class="container">

        <div class="row align-items-center">
          <div class="col-lg-12 py-3">
            <h2 class="title-section">
              By registering you will have super powers
              <span class="mai-rocket-outline"></span>
            </h2>
            <div class="divider"></div>

            <!-- REGISTRATION FORM -->
            <form metod="post" action="RegistrerServlet">
              <div class="form-group row text-center">
                <label for="usr" class="col-sm-4 col-form-label">Name:</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    name="name"
                    class="form-control"
                    id="name"
                    placeholder="Enter name"
                  />
                </div>
              </div>
              <div class="form-group row text-center">
                <label for="usr" class="col-sm-4 col-form-label">Surname:</label>
                <div class="col-sm-8">
                  <input
                    type="text"
                    name="subname"
                    class="form-control"
                    id="usr"
                    placeholder="Enter surname"
                  />
                </div>
              </div>
              <div class="form-group row text-center">
                <label for="email" class="col-sm-4 col-form-label">Email address:</label>
                <div class="col-sm-8">
                  <input
                    type="email"
                    name="email"
                    class="form-control"
                    id="email"
                    placeholder="Enter email"
                  />
                </div>
              </div>
              <div class="form-group row text-center">
                <label for="pwd" class="col-sm-4 col-form-label">Password:</label>
                <div class="col-sm-8">
                  <input
                    type="password"
                    name="password"
                    class="form-control"
                    id="pwd"
                    placeholder="Enter password"
                  />
                </div>
              </div>

              <!-- Button converted to a link for demonstration purposes only, in order to show the step after the registration. -->
              <!-- <button type="submit" class="btn btn-primary">Submit</button> -->
              <div class="row">
                <div class="col-sm-12 text-center">
                  <input type="submit" class="btn btn-primary" value="submit" name="registr">
                </div>
              </div>
            </form>
            <!-- END REGISTRATION FORM -->
          </div>
          <!-- .col -->
        </div>
        <!-- .row -->
      </div>
    </div>

    <!-- FOOTER-->
    <footer
      class="page-footer bg-image"
      style="background-image: url(./assets/images/world_pattern.svg)"
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
