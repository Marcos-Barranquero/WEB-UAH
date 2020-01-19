<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" crossorigin="anonymous"></script>
        <meta charset="UTF-8">
        <title>Administración</title>
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

            <h1>Página de administración</h1>

            <br><br>
            <p>Añadir información a la base de datos</p>
            <button type="button" class="btn btn-primary" onclick="window.location.href = 'crearActor.jsp';">Registrar un actor</button>
            <button type="button" class="btn btn-primary" onclick="window.location.href = 'crearPelicula.jsp';">Registrar una película</button>
            <button type="button" class="btn btn-primary" onclick="window.location.href = 'crearCine.jsp';">Registrar un cine</button>
            <button type="button" class="btn btn-primary" onclick="window.location.href = 'crearProyeccion.jsp';">Registrar una proyección</button>
            <br><br>
            <p>Eliminar información de la base de datos</p>
            <button type="button" class="btn btn-danger" onclick="window.location.href = 'borrarActor.jsp';">Borrar un actor</button>
            <button type="button" class="btn btn-danger" onclick="window.location.href = 'borrarPelicula.jsp';">Borrar una película</button>
            <button type="button" class="btn btn-danger" onclick="window.location.href = 'borrarCine.jsp';">Borrar un cine</button>
            <button type="button" class="btn btn-danger" onclick="window.location.href = 'borrarComentario.jsp';">Borrar un comentario</button>
            <button type="button" class="btn btn-danger" onclick="window.location.href = 'borrarCliente.jsp';">Borrar un cliente</button>
            <br><br>
            <p>Ver informes</p>
            <button type="button" class="btn btn-success" onclick="window.location.href = 'informeEntradasVendidas.jsp';">Entradas vendidas</button>
            <button type="button" class="btn btn-success" onclick="window.location.href = 'informePeliculasGenero.jsp';">Películas ordenadas por género</button>
            <button type="button" class="btn btn-success" onclick="window.location.href = 'informeClientesEntrada.jsp';">Clientes con entradas</button>
            <br><br>
            <p>Probar la seguridad de los servlets</p>
            <button type="button" class="btn btn-secondary" onclick="window.location.href = 'crearPeliculaSinSeguridad.jsp';">Probar la inserción de una película sin verificar los datos en el navegador</button>
            <br><br>
            <p>Salir</p>
            <button type="button" class="btn btn-primary" onclick="window.location.href = 'inicio.jsp';">Ir a la página de inicio</button>

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