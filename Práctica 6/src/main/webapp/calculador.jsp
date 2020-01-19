<html>

    <head>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" crossorigin="anonymous"></script>
        <meta charset="UTF-8">
        <title>Práctica 6</title>
    </head>

    <body>
        <br><br><br>
        <div class="container">

            <%@ page import="java.sql.*"%>
            <%@ page pageEncoding="UTF-8"%>
            <%@page contentType="text/html"%>
            <%!
                // Instancio conexiones y resultados de base de datos
                Connection c;
                Statement s;
                ResultSet nombresCircuitos;
                ResultSet nombresCoches;
            %>

            <%
                // Esto no sé que hace jeje
                Class.forName("org.apache.derby.jdbc.ClientDriver");

                // Me conecto a la base de datos
                Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/Practica6");

                // Está muy feo lo de tener que lanzar las querys en statements distintos.
                // pero muy feo. 
                // Ejecuto querys
                nombresCoches = c.createStatement().executeQuery("SELECT COCHE.NOMBRE FROM COCHE");
                nombresCircuitos = c.createStatement().executeQuery("SELECT CIRCUITO.NOMBRE FROM CIRCUITO");
            %>



            <h1>Calculadora de ahorro</h1>
            <h2>Elige un coche y un circuito. Nosotros nos encargamos del resto.</h2>
            <br><br><br>
            <form action="CalcularGanancia" method="POST">
                <table>
                    <tr>
                        <td width="250px">
                            <h3>Coches</h3>
                            <!-- Iterando sobre los resultados de la query de coches, cargo los nombres de coches. -->
                            <select id="listaCoches" name="listaCoches" style="width: 200px">
                                <%while (nombresCoches.next()) {%>
                                <option><%= nombresCoches.getString(1)%></option>
                                <% }%>
                            </select>
                        </td>
                        <td width="250px">
                            <h3> Circuitos </h3>
                            <!-- Iterando sobre los resultados de la query de circuitos, cargo los nombres de coches. -->
                            <select id="listaCircuitos" name="listaCircuitos" style="width: 200px">
                                <%while (nombresCircuitos.next()) {%>
                                <option><%= nombresCircuitos.getString(1)%></option>
                                <% }%>
                            </select>
                        </td>
                    </tr>
                </table>

                <br><br>
                <p><input type="submit" name="BotonSubmit" value="Calcular"></p>
            </form>
        </div>

        <br><br><br>

        <footer class="footer">
            <div class="container text-center">
                <p>Práctica 6 - Marcos Barranquero y Daniel Manzano | Arquitectura y Diseño de Sistemas Web y C/S, 2019</p>
            </div>
        </footer>

    </body>

</html>