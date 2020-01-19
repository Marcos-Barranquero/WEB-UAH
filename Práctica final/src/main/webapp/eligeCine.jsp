<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>

    <head>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" crossorigin="anonymous"></script>
        <meta charset="UTF-8">
        <title>Cartelera</title>
    </head>

    <body>

        <%!
            Connection c;
            Statement s;
            ResultSet rs;
            ResultSetMetaData rsmd;
        %>

        <%
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            c = DriverManager.getConnection("jdbc:derby://localhost:1527/BBDDPECLF");
            s = c.createStatement();
            rs = s.executeQuery("SELECT nombre_cine, count(ID_SALA) AS cantidad_salas FROM SALA GROUP BY NOMBRE_CINE");
            rsmd = rs.getMetaData();
        %>

        <br><br><br>

        <div class="container">

            <h1>Nuestros cines.</h1>
            <br><br>

            <table class="table table-striped">
                <thead>
                    <tr>
                        <th width="10%" scope="col"></th>
                        <th width="65%" scope="col">Nombre</th>
                        <th width="10%" scope="col">Nº salas</th>
                        <th width="15%" scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <% int i = 1; %>
                    <% while (rs.next()) {%>
                    <tr>
                        <th scope="row"><%= i%></th>
                        <td><h3><%= rs.getString(1)%></h3></td>
                        <td><%= rs.getInt(2)%></td>
                        <td>
                            <form action="cartelera.jsp" method="POST">
                                <input type="hidden" name="nombre_cine" value="<%= rs.getString(1)%>">
                                <button type="submit" class="btn btn-primary">Ver cartelera</button>
                            </form>
                        </td>
                    </tr>
                    <% i++; %>
                    <% }%>
                </tbody>
            </table>

            <button type="button" class="btn btn-primary" onclick="window.location.href = 'inicio.jsp';">Ir a la página de inicio</button>

        </div>

        <br><br><br>

        <footer class="footer">
            <div class="container text-center">
                <p>Práctica final - Marcos Barranquero y Daniel Manzano | Arquitectura y Diseño de Sistemas Web y C/S, 2020</p>
            </div>
        </footer>

    </body>
</html>