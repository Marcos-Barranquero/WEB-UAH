<%@page import="funcionalidadCompartida.BaseDatos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>



<!-- Lógica de la aplicación -->

<%
    BaseDatos bbdd;
    String nombreCine;
    ArrayList<String> nombresPeliculas;
    int numeroSalas;

    nombreCine = new String(request.getParameter("nombreCine").getBytes("ISO-8859-1"), "UTF-8");
    bbdd = new BaseDatos();
    bbdd.abrirConexion();
    nombresPeliculas = bbdd.getTodasLasPeliculas();
    numeroSalas = bbdd.getNumeroSalas(nombreCine);
%>

<!DOCTYPE html>
<html>

    <head>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" crossorigin="anonymous"></script>

        <!-- Jquery datapicker --> 
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <link rel="stylesheet" href="/resources/demos/style.css">
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script>
            $(function () {
                $("#datepicker").datepicker();
            });
        </script>

        <meta charset="UTF-8">
        <title>Insertar proyección</title>
    </head>

    <body>

        <br><br><br>

        <% if (session.getAttribute("usuario") == null || !session.getAttribute("usuario").equals("admin")) { %>
        <%-- Si no está iniciada la sesión como administrador, se deniega el acceso --%>
        <div class="container">
            <h1>Acceso denegado.</h1>
            <h2>No eres un administrador.</h2>
            <br><br>
            <button type="button" class="btn btn-primary" onclick="window.location.href = 'inicio.jsp';">Volver a inicio</button>
        </div>
        <% } else {%>



        <div class="container">
            <h1>Introduce los datos de la proyección.</h1>
            <br><br>

            <form action="CargarProyeccion" method="POST">
                <table class="table table-borderless">
                    <tr>
                        <td width="25%"><p>Cine:</p></td>
                        <td width="75%"><%=nombreCine%><input type="hidden" name="nombreCine" value="<%= nombreCine%>"></td>
                    </tr>
                    <tr>
                        <td><p>Película elegida:</p></td>
                        <td>
                            <select id="selectPeliculas" class="custom-select" name="selectPeliculas" size="3" style="width: 500px" required>
                                <%for (String pelicula : nombresPeliculas) {%>
                                <option><%= pelicula%></option>
                                <% }%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><p>Sala elegida:</p></td>
                        <td>
                            <select id="selectSala" class="custom-select" name="selectSala" size="1" style="width: 500px" required>
                                <%for (int i = 1; i <= numeroSalas; i++) {%>
                                <option><%= i%></option>
                                <% }%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><p>Fecha:</p></td>
                        <td><input type="text" id="datepicker" name="fechaTxt" style="width: 500px" required></td>
                    </tr>
                    <tr>
                        <td><p>Hora:</p></td>
                        <td>
                            <select id="selectHora" class="custom-select" name="selectHora" size="1" style="width: 500px" required>
                                <%for (int i = 0; i < 24; i++) {%>
                                <option><%= i%></option>
                                <% }%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><p>Cuarto de hora:</p></td>
                        <td>
                            <select id="selectCuarto" class="custom-select" name="selectCuarto" size="1" style="width: 500px" required>
                                <option>00</option>
                                <option>15</option>
                                <option>30</option>
                                <option>45</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><p>Precio:</p></td>
                        <td><input type="number" min="1" step="any" name="precioTxt"/></td>
                    </tr>
                </table>

                <input type="submit" class="btn btn-primary" name="BotonSubmit" value="Insertar" id="Insertar">
            </form>

        </div>
        <% }%>

        <br><br><br>

        <footer class="footer">
            <div class="container text-center">
                <p>Práctica final - Marcos Barranquero y Daniel Manzano | Arquitectura y Diseño de Sistemas Web y C/S, 2020</p>
            </div>
        </footer>

    </body>
</html>