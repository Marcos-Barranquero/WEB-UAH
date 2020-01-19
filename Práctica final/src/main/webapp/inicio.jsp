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
        <title>Cines Marcdan</title>
    </head>
    
    <body>
        <br><br><br>
        <div class="container">
            <h1>Cines Marcdan</h1>
            <h2>Bienvenido. ¿Qué quieres hacer?</h2>
            <br><br>
            <table class="table table-borderless">
                <tr>
                    <td>
                        <h3>Ver nuestros cines</h3>
                        <br><br>
                        <button type="button" class="btn btn-primary" onclick="window.location.href = 'eligeCine.jsp';">Ir a la cartelera</button>
                    </td>
                    <td>
                        <% if (session.getAttribute("usuario") == null) { %>
                        <h3>¿Has comprado una entrada?</h3>
                        <form action="iniciandoSesion.jsp" method="POST">
                            <div class="form-group">
                                <label>Correo electrónico</label>
                                <input type="text" class="form-control" name="correo" aria-describedby="emailHelp" placeholder="Correo" size="20">
                                <small id="emailHelp" class="form-text text-muted">Es el que utilizaste al comprar las entradas.</small>
                            </div>
                            <div class="form-group">
                                <label>Contraseña</label>
                                <input type="password" class="form-control" name="contrasenya" placeholder="Contraseña" size="20">
                            </div>
                            <button type="submit" class="btn btn-primary">Iniciar sesión</button>
                            <button type="button" class="btn btn-primary" onclick="window.location.href = 'registro.jsp';">Registrarse</button>

                        </form>
                        <% } else if (session.getAttribute("usuario").equals("admin")) { %>
                        <h3>Has iniciado sesión como administrador.</h3>
                        <br><br>
                        <button type="button" class="btn btn-primary" onclick="window.location.href = 'administracion.jsp';">Ir a la página de administración</button>
                        <button type="button" class="btn btn-secondary" onclick="window.location.href = 'cerrarSesion.jsp';">Finalizar la sesión</button>
                        <% } else {%>
                        <%!BaseDatos bd;%>
                        <%
                            bd = new BaseDatos();
                            bd.abrirConexion();
                        %>
                        <h3>Has iniciado sesión como <%=bd.getNombreCliente(session.getAttribute("usuario").toString())%></h3>
                        <br><br>
                        <button type="button" class="btn btn-primary" onclick="window.location.href = 'cerrarSesion.jsp';">Cerrar sesión</button>
                        <% }%>
                    </td>
                </tr>
            </table>
        </div>

        <br><br><br>

        <footer class="footer">
            <div class="container text-center">
                <p>Práctica Final - Marcos Barranquero y Daniel Manzano | Arquitectura y Diseño de Sistemas Web y C/S, 2019</p>
            </div>
        </footer>

    </body>
</html>