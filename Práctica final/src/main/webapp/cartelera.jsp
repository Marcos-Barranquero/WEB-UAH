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

        <%
            String nombreCine = "";
            if (request.getParameter("nombre_cine") == null) {
                // Si no ha llegado un parámetro en el POST:
                if (session.getAttribute("cine") == null) {
                    // Si tampoco lo hay en la sesión:
                    nombreCine = "error";
        %>
        <title>Error</title>
        <%
        } else {
            // Si se ha encontrado un parámetro en la sesión:
            nombreCine = new String(request.getParameter("cine").getBytes("ISO-8859-1"), "UTF-8");
        %>
        <title><%=nombreCine%></title>
        <%
            }
        } else {
            // Si ha llegado el parámetro con el POST:
            nombreCine = new String(request.getParameter("nombre_cine").getBytes("ISO-8859-1"), "UTF-8");
            session.setAttribute("cine", nombreCine);
        %>        
        <title><%=nombreCine%></title>
        <%  } %>

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
            rs = s.executeQuery("SELECT DISTINCT nombre_pelicula FROM PROYECCION WHERE nombre_cine = '" + nombreCine + "'");
            rsmd = rs.getMetaData();
        %>


        <br><br><br>

        <% if (nombreCine.equals("error")) {%>
        <div class="container">
            <h1>Error.</h1>
            <h2>No has seleccionado correctamente un cine.</h2>
            <br><br>
        </div>
        <% } else {%>


        <div class="container">

            <h1>Nuestras películas en <%=nombreCine%></h1>

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
                    <% while (rs.next()) {%>
                    <tr>
                        <th scope="row"><%= i%></th>
                        <td><h3><%= rs.getString(1)%></h3></td>
                        <td>
                            <form action="pelicula.jsp" method="POST">
                                <input type="hidden" name="pelicula" value="<%= rs.getString(1)%>">
                                <input type="hidden" name="cine" value="<%= nombreCine%>">
                                <button type="submit" class="btn btn-primary">+ Info</button>
                            </form>

                        </td>
                    </tr>
                    <% i++; %>
                    <% }%>
                </tbody>
            </table>

        </div>
        <% }%>

        <div class="container">
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