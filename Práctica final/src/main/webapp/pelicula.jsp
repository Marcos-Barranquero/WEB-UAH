<%@page import="java.util.ArrayList"%>
<%@page import="funcionalidadCompartida.Pelicula"%>
<%@page import="funcionalidadCompartida.BaseDatos"%>
<%@page import="funcionalidadCompartida.Comentario"%>
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
            String nombrePelicula = "";
            String nombreCine = "";
            if (request.getParameter("cine") == null || request.getParameter("pelicula") == null) {
                // Si no han llegado los parámetros en el POST:
                if (session.getAttribute("cine") == null || session.getAttribute("pelicula") == null) {
                    // Si tampoco los hay en la sesión:
                    nombrePelicula = "error";
                    nombreCine = "error";
        %>
        <title>Error</title>
        <%
        } else {
            // Si se ha encontrado un parámetro en la sesión:
            nombrePelicula = session.getAttribute("pelicula").toString();
            nombreCine = session.getAttribute("cine").toString();
        %>        
        <title><%=nombrePelicula%></title>
        <%
            }
        } else {
            // Si han llegado los parámetros con el POST:
            nombrePelicula = new String(request.getParameter("pelicula").getBytes("ISO-8859-1"), "UTF-8");
            nombreCine = new String(request.getParameter("cine").getBytes("ISO-8859-1"), "UTF-8");
            session.setAttribute("pelicula", nombrePelicula);
            session.setAttribute("cine", nombreCine);
        %>
        <title><%=nombrePelicula%></title>
        <% } %>
    </head>

    <body>

        <br><br><br>

        <% if (nombrePelicula.equals("error") || nombreCine.equals("error")) { %>
        <div class="container">
            <h1>Error.</h1>
            <h2>No se ha seleccionado la película o el cine correctamente.</h2>
            <br><br>
            <button type="button" class="btn btn-primary" onclick="window.location.href = 'cartelera.jsp';">Volver a la cartelera</button>
        </div>
        <% } else { %>

        <%!
            Connection c;
            Statement s;
            ResultSet rs;
            ResultSetMetaData rsmd;
            BaseDatos bd;
        %>

        <%
            bd = new BaseDatos();
            bd.abrirConexion();

            System.out.println("Nombre pelicula: " + nombrePelicula);
            System.out.println("Nombre cine:  " + nombreCine);
            Pelicula pelicula = bd.recuperarPelicula(nombrePelicula);
            System.out.println(pelicula.toString());

            Class.forName("org.apache.derby.jdbc.ClientDriver");
            c = DriverManager.getConnection("jdbc:derby://localhost:1527/BBDDPECLF");
            s = c.createStatement();
            rs = s.executeQuery("SELECT fecha, hora, id_proyeccion FROM PROYECCION WHERE nombre_cine = '"
                    + nombreCine + "' AND nombre_pelicula = '" + nombrePelicula + "' ORDER BY fecha ASC");
            rsmd = rs.getMetaData();
            System.out.println("RS: " + rs);

        %>

        <div class="container">
            <%-- Se muestra la información de la película --%>
            <%-- Título y año --%><h1><%= pelicula.getTitulo()%> (<%=pelicula.getAnyo()%>)</h1>
            <%
                int edadMinima = pelicula.getEdadMinima();
                if (edadMinima == 0) {%>
            <h3>Apta para todos los públicos</h3>
            <% } else {%>
            <h3>No recomendada para menores de <%=edadMinima%> años</h3>
            <% }%>
            <br><br>
            <table class="table table-sm">
                <tbody>
                    <tr>
                        <th scope="row">Título original</th>
                        <td><%= pelicula.getTituloOriginal()%></td>
                        <th scope="row">País</th>
                        <td><%= pelicula.getNacionalidad()%></td>
                    </tr>
                    <tr>
                        <th scope="row">Género</th>
                        <td><%= pelicula.getGenero()%></td>
                        <th scope="row">Duración</th>
                        <td><%= pelicula.getDuracion()%> minutos</td>
                    </tr>
                    <tr>
                        <th scope="row">Director</th>
                        <td><%= pelicula.getDirector()%></td>
                        <th scope="row">Distribuidora</th>
                        <td><%= pelicula.getDistribuidora()%></td>
                    </tr>
                    <tr>
                        <th scope="row">Sitio web</th>
                        <td colspan="3"><a href="<%= pelicula.getWebOficial()%>" target="_blank"><%= pelicula.getWebOficial()%></a></td>
                    </tr>
                </tbody>
            </table>

            <h3>Sinopsis</h3>
            <p><%= pelicula.getSinopsis()%></p>
            <br>
            <h3>Actores</h3>
            <ul> 
                <% ArrayList<String> actores = pelicula.getActores();
                    for (String actor : actores) {%>
                <li><%=actor%></li>
                    <%}%>
            </ul>
            <br>
            <% if (pelicula.getOtrosDatos() != null) {%>
            <h3>Otra información de interés</h3>
            <p><%= pelicula.getOtrosDatos()%></p>
            <br>
            <% }%>

            <h2>Compra tus entradas</h2>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th scope="col"></th>
                        <th scope="col">Fecha</th>
                        <th scope="col">Hora</th>
                        <th scope="col">Comprar</th>
                    </tr>
                </thead>
                <tbody>
                    <% int i = 1; %>
                    <% while (rs.next()) {%>
                    <tr>
                        <th scope="row"><%= i%></th>
                        <td><%= rs.getString(1)%></td>
                        <td><%= rs.getString(2)%></td>
                        <td>                            
                            <form action="eligeButaca.jsp" method="POST">
                                <input name="id_proyeccion" type ="hidden" value="<%= rs.getString(3)%>">
                                <button type="submit" class="btn btn-primary"> Elegir butaca </button>
                            </form>
                    </tr>
                    <% i++; %>
                    <% }%>
                </tbody>
            </table>

            <br>

            <%-- Si el cliente no está identificado, no se muestran los comentarios de la película --%>

            <% if (session.getAttribute("usuario") == null || session.getAttribute("usuario").equals("admin")) { %>
            <%-- Si no hay una sesión de un cliente --%>
            <h2>No puedes ver ni publicar comentarios.</h2>
            <p>Debes iniciar sesión en la página principal.</p>
            <% } else { %>

            <%-- Si hay una sesión de un cliente, se muestran --%>

            <h2>Comentarios</h2>

            <% ArrayList<Comentario> comentarios = bd.getComentarios(nombrePelicula);%>
            <% if (comentarios.isEmpty()) { %>
            <p>No hay comentarios.</p>
            <% } else { %>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th scope="col">Puntuación</th>
                        <th scope="col">Comentario</th>
                    </tr>
                </thead>
                <tbody>
                    <% i = 1; %>
                    <% for (Comentario coment : comentarios) {%>
                    <tr>
                        <th scope="row"><%=coment.getPuntuacion()%></th>
                        <td>
                            <p><%= coment.getComentario()%></p>
                        </td>
                    </tr>
                    <% i++; %>
                    <% }%>
                </tbody>
            </table>
            <% }%>

            <br>

            <% if (!bd.haVisto(session.getAttribute("usuario").toString(), pelicula.getTitulo())) {%>
            
            <%-- Si no ha visto la película (no tiene entradas), no se permite comentar --%>
            
            <h3>No puedes publicar un comentario.</h3>
            <p>No has visto esta película.</p>
            
            <% } else if (!bd.existeComentario(session.getAttribute("usuario").toString(), pelicula.getTitulo())) {%>

            <%-- Si ha visto la película y no ha publicado un comentario ya, se permite insertar uno --%>

            <h3>Publica un comentario.</h3>

            <form action="CargarComentario" method="POST">
                <input type="hidden" name="correo" value="<%= session.getAttribute("usuario")%>">
                <input type="hidden" name="pelicula" value="<%= pelicula.getTitulo()%>">
                <input type="hidden" name="cine" value="<%= nombreCine%>">
                <table class="table table-borderless">
                    <thead>
                        <tr>
                            <th width="20%" scope="col"><p>Puntuación (1-5): </p></th>
                            <th width="70%" scope="col"><p>Comentario: </p></th>
                            <th width="10%" scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><input type="number" min="1" max="5" name="puntuacion" required></td>
                            <td><input type="text" pattern="[0-9a-zA-ZÀ-ÿ ñÑ-\.:,]{0,1000}" size="100%" name="comentario" required></td>
                            <td>
                                <input type="hidden" name="cine" value="<%= nombreCine%>">
                                <button type="submit" class="btn btn-primary">Publicar</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form>

            <% } else {%>

            <%-- Si ya ha comentado, se permite borrarlo --%>

            <h3>Ya has comentado.</h3>
            <br>
            <form action="BorrarComentarioCliente" method="POST">
                <input type="hidden" name="correo" value="<%= session.getAttribute("usuario")%>">
                <input type="hidden" name="pelicula" value="<%= pelicula.getTitulo()%>">
                <button type="submit" class="btn btn-primary">Borrar comentario</button>
            </form>
            <% } %>
            <% } %>

        </div>
        <% }%>

        <br><br>

        <div class="container">
            <br><br>
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