<%@page import="funcionalidadCompartida.BaseDatos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<!DOCTYPE html>


        <%
            BaseDatos bd;
            ArrayList<String> peliculas;

            bd = new BaseDatos();
            bd.abrirConexion();
            peliculas = bd.getTodasLasPeliculas();
        %>

<html>

    <head>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" crossorigin="anonymous"></script>
        <meta charset="UTF-8">
        <title>Borrar película</title>
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
        <% } else { %>

        <div class="container">

            <h1>Elimina una película.</h1>
            <p>También se eliminarán sus sesiones y comentarios.</p>
            <br><br>

            <table class="table table-striped">
                <thead>
                    <tr>
                        <th width="10%" scope="col"></th>
                        <th width="75%" scope="col">Título</th>
                        <th width="15%" scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <% int i = 1; %>
                    <% for (String titulo : peliculas) {%>
                    <tr>
                        <th scope="row"><%= i%></th>
                        <td><h3><%= titulo%></h3></td>
                        <td>
                            <form action="BorrarPelicula" method="POST">
                                <input type="hidden" name="pelicula" value="<%= titulo%>">
                                <button type="submit" class="btn btn-danger">Borrar</button>
                            </form>
                        </td>
                    </tr>
                    <% i++; %>
                    <% }%>
                </tbody>
            </table>

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