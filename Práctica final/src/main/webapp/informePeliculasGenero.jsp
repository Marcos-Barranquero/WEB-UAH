<%@page import="funcionalidadCompartida.BaseDatos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<%@page import="funcionalidadCompartida.Pelicula"%>
<!DOCTYPE html>

<html>
    <head>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" crossorigin="anonymous"></script>
        <meta charset="UTF-8">
        <title>Películas por género</title>
    </head>

    <body>
        <%!
            BaseDatos bd;
            ArrayList<Pelicula> peliculas;
        %>

        <%
            bd = new BaseDatos();
            bd.abrirConexion();
            peliculas = bd.getPeliculasPorGenero();
        %>

        <br><br><br>

        <% if (session.getAttribute("usuario") == null || !session.getAttribute("usuario").equals("admin")) { %>
        <%-- Si no está iniciada la sesión como administrador, se deniega el acceso --%>
        <div class="container">
            <h1>Acceso denegado.</h1>
            <h2>No eres un administrador.</h2>
            <br><br>
            <button type="button" class="btn btn-primary" onclick="window.location.href = 'inicio.jsp';">Volver a inicio</button>
        </div>
        <% } else { %>

        <div class="container">

            <h1>Películas ordenadas por género.</h1>
            <br><br>

            <table class="table table-striped">
                <thead>
                    <tr>
                        <th width="10%" scope="col"></th>
                        <th width="10%" scope="col">Género</th>
                        <th width="40%" scope="col">Título</th>
                        <th width="20%" scope="col">Director</th>
                        <th width="10%" scope="col">Duración</th>
                        <th width="10%" scope="col">Año</th>
                    </tr>
                </thead>
                <tbody>
                    <% int i = 1; %>
                    <% for (Pelicula pelicula : peliculas) {%>
                    <tr>
                        <th scope="row"><%= i%></th>
                        <td><p><%= pelicula.getGenero()%></p></td>
                        <td><p><%= pelicula.getTitulo()%></p></td>
                        <td><p><%= pelicula.getDirector()%></p></td>
                        <td><p><%= pelicula.getDuracion()%> mins</p></td>
                        <td><p><%= pelicula.getAnyo()%></p></td>
                        </td>
                    </tr>
                    <% i++; %>
                    <% }%>
                </tbody>
            </table>

            <button type="submit" class="btn btn-primary" onclick="window.location.href = 'administracion.jsp';">Volver</button>

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