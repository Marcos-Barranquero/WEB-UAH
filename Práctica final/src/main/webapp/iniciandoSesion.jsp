<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="funcionalidadCompartida.BaseDatos"%>
<!DOCTYPE html>
<html>

    <head>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" crossorigin="anonymous"></script>
        <meta charset="UTF-8">
        <title>Iniciando sesión...</title>
    </head>

    <body>
        
        <br><br><br>

        <div class="container">
            <h1>Iniciando sesión...</h1>
        </div>

        <% String correo = new String(request.getParameter("correo").getBytes("ISO-8859-1"),"UTF-8"); %>
        <% String contrasenya = new String(request.getParameter("contrasenya").getBytes("ISO-8859-1"),"UTF-8"); %>

        <% if (correo == null || contrasenya == null) {%>
        <meta http-equiv="refresh" content="0; url=inicio.jsp" />
        <% } else { %>

        <% if (correo.equals("admin") && contrasenya.equals("admin")) { %>
        <%-- Si es un administrador, se establece la sesión para él --%>
        <% session.setAttribute("usuario", "admin"); %>
        <meta http-equiv="refresh" content="0; url=administracion.jsp" />
        <% } else { %>
        <%-- Si no lo es, se comprueba si existe en la base de datos --%>
        <%!BaseDatos bd;%>
        <%
            bd = new BaseDatos();
            bd.abrirConexion();
        %>

        <% if (bd.loginCliente(correo, contrasenya)) { %>
        <%-- Datos correctos --%>
        <% session.setAttribute("usuario", correo); %>
        <meta http-equiv="refresh" content="0; url=inicio.jsp" />
        <% } else { %>
        <%-- Datos incorrectos --%>
        <div class="container">
            <h1>Error.</h1>
            <h2>Los datos introducidos no son correctos.</h2>
            <br><br>
            <button type="button" class="btn btn-primary" onclick="window.location.href = 'inicio.jsp';">Ir a la página de inicio</button>
        </div>
        <% }%>
        <% }%>
        <% }%>

        <br><br><br>

        <footer class="footer">
            <div class="container text-center">
                <p>Práctica final - Marcos Barranquero y Daniel Manzano | Arquitectura y Diseño de Sistemas Web y C/S, 2020</p>
            </div>
        </footer>

    </body>
</html>