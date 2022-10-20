<%-- 
    Document   : index
    Created on : 25 apr 2022, 16:49:23
    Author     : daniele
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <meta http-equiv="X-UA-Compatible" content="ie=edge" />

    <title>MyDB - Custom database creator</title>

    <link rel="stylesheet" href="../assets/css/maicons.css" />

    <link rel="stylesheet" href="../assets/css/bootstrap.css" />

    <link rel="stylesheet" href="../assets/vendor/animate/animate.css" />

    <link rel="stylesheet" href="../assets/css/theme.css" />

    <link rel="stylesheet" href="../assets/css/style.css" />

    <!-- MyDB icon -->
    <link rel="icon" href="../assets/images/cloud-data-300.png">
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
              <li class="nav-item active" id="nav-item-tr">
                <a class="nav-link" href="index.jsp">Home</a>
              </li>
              <li class="nav-item" id="nav-item-tr">
                <a class="nav-link" href="register.jsp">Register</a>
              </li>
              <li class="nav-item" id="nav-item-tr">
                <a class="nav-link" href="login.jsp">Login</a>
              </li>
              <li class="nav-item" id="nav-item-tr">
                <a class="nav-link" href="create.jsp">Create table</a>
              </li>
            </ul>
          </div>
        </div>
      </nav>
      <!-- NAVBAR -->

      <div class="container">
        <div class="page-banner home-banner">
          <div class="row align-items-center flex-wrap-reverse h-100">
            <div class="col-md-6 py-5 wow fadeInLeft">
              <h1 class="mb-4">
                An easy, fast and efficient way to create your own database.
              </h1>
              <p class="text-lg text-grey mb-5">
                Get started by creating your first table!
              </p>
              <a href="create.jsp" class="btn btn-primary btn-split"
                >Create table
                <div class="fab"><span class="mai-code"></span></div
              ></a>
            </div>
            <div class="col-md-6 py-5 wow zoomIn">
              <div class="img-fluid text-center">
                <img src="../assets/images/cloud-data-300.png" alt="cloud-data image"/>
              </div>
            </div>
          </div>
          <a href="#about" class="btn-scroll" data-role="smoothscroll"
            ><span class="mai-arrow-down"></span
          ></a>
        </div>
      </div>
      <!-- .container -->
    </header>
    <!-- .page-section -->

    <!-- Our service section -->
    <div class="page-section" id="about">
      <div class="container">
        <div class="row align-items-center">
          <div class="col-lg-6 py-3 wow fadeInUp">
            <span class="subhead">Our Service</span>
            <h2 class="title-section">The #1 creator of database tables</h2>
            <div class="divider"></div>

            <p>Expert or novice, we know how tedious it is to create a table using SQL code.</p>
            <p>That's why we invented My DataBase.</p>
            <p>MyDB is a completely free service to create and manage tables for your database.</p>
            <p>All without having to write a line of code!</p>
            <p>You only need to insert in a table the values you need and select the primary key, and you're done.</p>
            <p>Obviously you can customize the table with the number of rows and columns you need.</p>
            <p>Awesome, isn't it?</p>

          </div>
          <div class="col-lg-6 py-3 wow fadeInRight">
            <div class="img-fluid py-3 text-center">
              <img src="../assets/images/team-1-450.jpg" alt="team-1 image" />
            </div>
          </div>
        </div>
      </div>
      <!-- .container -->
    </div>
    <!-- .page-section -->

    <!-- Our features section -->
    <div class="page-section bg-light">
      <div class="container">
        <div class="text-center wow fadeInUp">
          <div class="subhead">Our Features</div>
          <h2 class="title-section">
            You can work without having an account, but registering provides you
            much more!
          </h2>
          <div class="divider mx-auto"></div>
        </div>

        <div class="row">
          <div class="col-sm-6 col-lg-4 col-xl-3 py-3 wow zoomIn">
            <div class="features">
              <div class="header mb-3">
                <span class="mai-brush"></span>
              </div>
              <h5>Create tables</h5>
              <p>Non-registered and Registered user</p>
            </div>
          </div>
          <div class="col-sm-6 col-lg-4 col-xl-3 py-3 wow zoomIn">
            <div class="features">
              <div class="header mb-3">
                <span class="mai-cloud-download"></span>
              </div>
              <h5>Export tables</h5>
              <p>Non-registered and Registered user</p>
            </div>
          </div>
          <div class="col-sm-6 col-lg-4 col-xl-3 py-3 wow zoomIn">
            <div class="features">
              <div class="header mb-3">
                <span class="mai-cloud-done"></span>
              </div>
              <h5>Save tables</h5>
              <p>Registered user only</p>
            </div>
          </div>
          <div class="col-sm-6 col-lg-4 col-xl-3 py-3 wow zoomIn">
            <div class="features">
              <div class="header mb-3">
                <span class="mai-construct"></span>
              </div>
              <h5>Manage tables</h5>
              <p>Registered user only</p>
            </div>
          </div>
        </div>
      </div>
      <!-- .container -->
    </div>
    <!-- .page-section -->

    <!-- Banner info -->
    <div class="page-section banner-info">
      <div
        class="wrap bg-image"
        style="background-image: url(../assets/images/bg_pattern.svg)"
      >
        <div class="container">
          <div class="row align-items-center">
            <div class="col-lg-6 py-3 pr-lg-5 wow fadeInUp">
              <h2 class="title-section">
                MyDB improves your experience with databases tables<br />
              </h2>
              <div class="divider"></div>
              <p>
                MyDB was designed and created by GROUP 21 for the Servicios y Systemas Web course project in the year 2022. The course is provided by the Universidad de Valladolid.
              </p>

              <ul class="theme-list theme-list-light text-white">
                <li>
                  <div class="h5">MyDB is a free service</div>
                  <p>
                    Why free? Because we are engineering students and we like to make our knowledge available to others, hoping that someone will find our work useful.
                  </p>
                </li>
                <li>
                  <div class="h5">MyDB is developed by</div>
                  <p>
                    David Fernández García, Daniele Giorgianni, Paula Higuera Consuegra, Francisco Manzanas Mogrovejo
                  </p>
                </li>
              </ul>
            </div>
            <div class="col-lg-6 py-3 wow fadeInRight">
              <div class="img-fluid text-center">
                <img src="../assets/images/banner_image_2.svg" alt="banner image" />
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- .wrap -->
    </div>
    <!-- .page-section -->

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

    <script src="../assets/js/jquery-3.5.1.min.js"></script>

    <script src="../assets/js/bootstrap.bundle.min.js"></script>

    <script src="../assets/vendor/wow/wow.min.js"></script>

    <script src="../assets/js/theme.js"></script>
  </body>
</html>
