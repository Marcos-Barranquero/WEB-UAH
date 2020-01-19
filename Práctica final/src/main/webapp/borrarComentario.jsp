<%@page import="funcionalidadCompartida.BaseDatos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<%@page import="funcionalidadCompartida.Comentario"%>
<!DOCTYPE html>



<%
    BaseDatos bd = new BaseDatos();
    bd.abrirConexion();

    ArrayList<Comentario> comentarios;
    comentarios  = bd.getTodosLosComentarios();
%>

<html>

    <head>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" crossorigin="anonymous"></script>
        <meta charset="UTF-8">
        <title>Borrar comentario</title>
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

            <h1>Elimina un comentario.</h1>
            <br><br>

            <table class="table table-striped">
                <thead>
                    <tr>
                        <th width="5%" scope="col"></th>
                        <th width="20%" scope="col">Usuario</th>
                        <th width="20%" scope="col">Película</th>
                        <th width="10%" scope="col">Puntuación</th>
                        <th width="35%" scope="col">Comentario</th>
                        <th width="10%" scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    <% int i = 1; %>
                    <% for (Comentario comentario : comentarios) {%>
                    <tr>
                        <th scope="row"><%= i%></th>
                        <td><p><%= comentario.getCorreo()%></p></td>
                        <td><p><%= comentario.getPelicula()%></p></td>
                        <td><p><%= comentario.getPuntuacion()%></p></td>
                        <td><p><%= comentario.getComentario()%></p></td>
                        <td>
                            <form action="BorrarComentario" method="POST">
                                <input type="hidden" name="correo" value="<%= comentario.getCorreo()%>">
                                <input type="hidden" name="pelicula" value="<%= comentario.getPelicula()%>">
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