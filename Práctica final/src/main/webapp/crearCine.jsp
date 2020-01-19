<%@page import="funcionalidadCompartida.BaseDatos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>

    <head>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" crossorigin="anonymous"></script>
        <meta charset="UTF-8">
        <title>Insertar cine</title>
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

            <h1>Introduce los datos del cine.</h1>
            <br><br>
            <form action="CargarCine" method="POST">
                <table>
                    <tr>
                        <td width="500px"><p>Nombre del cine: </p></td>
                        <td><input type="text" pattern="[0-9a-zA-ZÀ-ÿ ñÑ-\.,]{0,50}" size="50" name="nombreCine" required></td>
                    </tr>
                    <tr>
                        <td width="500px"><p>Nº de salas: </p></td>
                        <td><input type="number" min="1" max="20" name="cantidadSalas" required></td>
                    </tr>
                </table>

                <input type="submit" class="btn btn-primary" name="BotonSubmit" value="Insertar" id="Insertar">
                <input type="reset" class="btn btn-secondary" name="BotonReset" value="Reestablecer el formulario">
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