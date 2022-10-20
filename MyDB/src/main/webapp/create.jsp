<%-- 
    Document   : create
    Created on : 25 apr 2022, 16:56:51
    Author     : daniele
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <meta http-equiv="X-UA-Compatible" content="ie=edge" />

    <meta name="copyright" content="MACode ID, https://macodeid.com/" />

    <title>MyDB - Custom database creator</title>

    <link rel="stylesheet" href="./assets/css/maicons.css" />

    <link rel="stylesheet" href="./assets/css/bootstrap.css" />

    <link rel="stylesheet" href="./assets/vendor/animate/animate.css" />

    <link rel="stylesheet" href="./assets/css/theme.css" />

    <link rel="stylesheet" href="./assets/css/style.css" />
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
              <li class="nav-item" id="nav-item-tr">
                <a class="nav-link" href="register.jsp">Register</a>
              </li>
              <li class="nav-item" id="nav-item-tr">
                <a class="nav-link" href="login.jsp">Login</a>
              </li>
              <li class="nav-item active" id="nav-item-tr">
                <a class="nav-link" href="create.jsp">Create table</a>
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
                  <li class="breadcrumb-item active">Create Table</li>
                </ul>
              </nav>
              <h1 class="text-center">Have fun creating your own table!</h1>
            </div>
          </div>
        </div>
      </div>
    </header>

    <div class="page-section">
      <div class="container">
        <div class="row align-items-center">
          <div class="col-lg-12 py-3">
            <h2 class="title-section">MyDB, create your table.</h2>
            <div class="divider"></div>

            <div class="row align-items-start">
              <div class="col-lg-8">
                <!-- Buttons above the table -->
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
                    <button id= "addButton" type="button" class="btn btn-primary" onclick="Fill_table()">Add</button>
                  </div>
                  <div
                    class="btn-group mr-2"
                    role="group"
                    aria-label="Second group"
                  >
                    <form class="form-inline">
                      <input
                        type="text"
                        class="form-control"
                        placeholder="Table name"
                        id="table-create-input-name"
                      />
                    </form>
                  </div>
                </div>
                <!-- END buttons above the table -->

                <!-- Table create -->
                <table id="tableBD"class="table text-center">
                  <thead>
                    <tr>
                      <th scope="col" id="table-create-index">#</th>
                      <th scope="col">
                        <input
                          type="text"
                          class="form-control border-0"
                          id="table-create-input-cell"
                          placeholder="Insert key"
                        />
                        <label
                          class="form-check-label"
                          id="table-create-primary-key"
                        >
                          <input class="form-check-input" id="Primary_Key" type="checkbox"/>Primary
                        </label>
                      </th>
                      <th scope="col">
                        <input
                          type="text"
                          class="form-control border-0"
                          id="table-create-input-cell"
                          placeholder="Insert key"
                        />
                        <label
                          class="form-check-label"
                          id="table-create-primary-key"
                        >
                          <input class="form-check-input" id="Primary_Key" type="checkbox"/>Primary
                        </label>
                      </th>
                      <th scope="col">
                        <input
                          type="text"
                          class="form-control border-0"
                          id="table-create-input-cell"
                          placeholder="Insert key"
                        />
                        <label
                          class="form-check-label"
                          id="table-create-primary-key"
                        >
                          <input class="form-check-input" id="Primary_Key" type="checkbox"/>Primary
                        </label>
                      </th>
                    </tr>
                  </thead>

                  <tbody>
                    <tr>
                      <th scope="row" class='iden' id="table-create-index">1</th>
                      <td>
                        <input
                          type="text"
                          class="form-control border-0"
                          name="cell"
                          id="table-create-input-cell"
                          placeholder="Insert value"
                        />
                      </td>
                      <td>
                        <input
                          type="text"
                          class="form-control border-0"
                          id="table-create-input-cell"
                          name="cell"
                          placeholder="Insert value"
                        />
                      </td>
                      <td>
                        <input
                          type="text"
                          class="form-control border-0"
                          id="table-create-input-cell"
                          name="cell"
                          placeholder="Insert value"
                        />
                      </td>
                    </tr>
                    <tr>
                      <th scope="row" class='iden' id="table-create-index">2</th>
                      <td>
                        <input
                          type="text"
                          class="form-control border-0"
                          id="table-create-input-cell"
                          name="cell"
                          placeholder="Insert value"
                        />
                      </td>
                      <td>
                        <input
                          type="text"
                          class="form-control border-0"
                          id="table-create-input-cell"
                          name="cell"
                          placeholder="Insert value"
                        />
                      </td>
                      <td>
                        <input
                          type="text"
                          class="form-control border-0"
                          id="table-create-input-cell"
                          name="cell"
                          placeholder="Insert value"
                        />
                      </td>
                    </tr>
                    <tr>
                      <th scope="row" class='iden' id="table-create-index">3</th>
                      <td>
                        <input
                          type="text"
                          class="form-control border-0"
                          id="table-create-input-cell"
                          name="cell"
                          placeholder="Insert value"
                        />
                      </td>
                      <td>
                        <input
                          type="text"
                          class="form-control border-0"
                          id="table-create-input-cell"
                          name="cell"
                          placeholder="Insert value"
                        />
                      </td>
                      <td>
                        <input
                          type="text"
                          class="form-control border-0"
                          id="table-create-input-cell"
                          name="cell"
                          placeholder="Insert value"
                        />
                      </td>
                    </tr>
                  </tbody>
                </table>
                <!-- END table create -->

                <!-- Buttons below the table -->
                <div class="row mb-4 text-center">
                
                  <div class="col-sm-6">
                    <button type="button" class="btn btn-primary" id="btn-add-below-create-table-log" onclick="Add_row()" >Add row</button>
                    <button type="button" class="btn btn-primary" id="btn-add-below-create-table-log" onclick="Add_column()">Add column</button>
                  </div>

                  <div class="col-sm-6">
                    <div class="col-sm-12">
                      <input
                        type="text"
                        class="rounded-top rounded-bottom border border-accent"
                        id="input-delete-row-col"
                        placeholder="Enter row/column to delete:"
                      />
                    </div>
                    <div class="col-sm-12">
                      <button type="button" class="btn btn-accent" id="btn-del-below-create-table-log" onclick="Delete_row()">Delete row</button>
                      <button type="button" class="btn btn-accent" id="btn-del-below-create-table-log" onclick="Delete_column()">Delete column</button>
                    </div>
                  </div>
                </div>
                <!-- END buttons below the table -->
              </div>
              
              <div class="col-lg-4">
                <!-- Buttons above the table -->
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
                    <button type="button" class="btn btn-warning" onclick="Delete_table(true,null)">Delete</button>
                  </div>
                  <div
                    class="btn-group mr-2"
                    role="group"
                    aria-label="Second group"
                  >
                    <button type="button" class="btn btn-primary" onclick="Export()">Export</button>
                  </div>
                </div>
                <!-- END buttons above the table -->

                <!-- Table tables -->
                <table class="table" id="table">

                  <thead>
                    <tr>
                      <th scope="col">Your tables</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td scope="row" id="go_to_login">
                        <a href="login.jsp"> Login</a> for more powers
                        <span class="mai-bulb-outline"></span>
                      </td>
                    </tr>
                  </tbody>
                </table>
                <!-- END table tables -->
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- FOOTER -->
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

    <script src="./assets/js/functionality.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>



  </body>
</html>
