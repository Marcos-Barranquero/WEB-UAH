<%@page import="funcionalidadCompartida.BaseDatos"%>
<%@page import="funcionalidadCompartida.InformeEntradas"%>
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
        <title>Entradas vendidas</title>
    </head>

    <body>
        <%!
            BaseDatos bd;
            ArrayList<InformeEntradas> informe;
        %>

        <%
            bd = new BaseDatos();
            bd.abrirConexion();
            informe = bd.getEntradasVendidas();
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

            <h1>Entradas vendidas.</h1>
            <br><br>

            <table class="table table-striped">
                <thead>
                    <tr>
                        <th width="5%" scope="col"></th>
                        <th width="5%" scope="col">ID</th>
                        <th width="15%" scope="col">Cine</th>
                        <th width="5%" scope="col">Sala</th>
                        <th width="5%" scope="col">Fila</th>
                        <th width="5%" scope="col">Columna</th>
                        <th width="10%" scope="col">Fecha</th>
                        <th width="10%" scope="col">Hora</th>
                        <th width="10%" scope="col">Precio</th>
                        <th width="30%" scope="col">Película</th>
                    </tr>
                </thead>
                <tbody>
                    <% int i = 1; %>
                    <% for (InformeEntradas cliente : informe) {%>
                    <tr>
                        <th scope="row"><%= i%></th>
                        <td><p><%= cliente.getId()%></p></td>
                        <td><p><%= cliente.getCine()%></p></td>
                        <td><p><%= cliente.getSala()%></p></td>
                        <td><p><%= cliente.getFila()%></p></td>
                        <td><p><%= cliente.getColumna()%></p></td>
                        <td><p><%= cliente.getFecha()%></p></td>
                        <td><p><%= cliente.getHora()%></p></td>
                        <td><p><%= cliente.getPrecio()%></p></td>
                        <td><p><%= cliente.getPelicula()%></p></td>
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