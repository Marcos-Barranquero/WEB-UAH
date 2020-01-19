<%@page import="funcionalidadCompartida.BaseDatos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<!DOCTYPE html>


<%
    BaseDatos bbdd = new BaseDatos();
    bbdd.abrirConexion();
            
    ArrayList<String> nombresCines;
    nombresCines = bbdd.getCines();
%>

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
        <% } else { %>


        <div class="container">
            <h1>Introduce los datos de la proyección.</h1>
            <br><br>

            <form action="crearProyeccionHorario.jsp" method="POST" onsubmit="cargar()">
                <table class="table table-borderless">
                    <tr>
                        <td width="500px"><p>Cine: </p></td>
                    </tr>
                    <tr>
                        <td>
                            <select id="nombreCine" class="custom-select" name="nombreCine" size="5" style="width: 500px" required>
                                <%for (String cine : nombresCines) {%>
                                <option><%= cine%></option>
                                <% }%>
                            </select>
                        </td>
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