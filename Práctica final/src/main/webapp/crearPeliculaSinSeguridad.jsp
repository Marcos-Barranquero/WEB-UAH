<%@page import="funcionalidadCompartida.BaseDatos"%>
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

        <script>
            $(document).ready(function () {
                $("#listaActoresBBDD").dblclick(function (ev) {

                    // Extraigo valoes del elemento seleccionado
                    var valor = $("#listaActoresBBDD").children("option:selected").val();
                    var texto = $("#listaActoresBBDD").children("option:selected").text();
                    var name = $("#listaActoresBBDD").children("option:selected").name;

                    // Añado nuevo plato a pedidos
                    $("#listaActoresSeleccionados").append(new Option(texto, valor));

                    // Elimino de la lista de actores
                    $("#listaActoresBBDD").children("option:selected").remove();
                });
            });
        </script>
        
        <script>
            $(document).ready(function () {
                $("#listaActoresSeleccionados").dblclick(function (ev) {

                    // Extraigo valoes del elemento seleccionado
                    var valor = $("#listaActoresSeleccionados").children("option:selected").val();
                    var texto = $("#listaActoresSeleccionados").children("option:selected").text();
                    var name = $("#listaActoresSeleccionados").children("option:selected").name;

                    // Añado nuevo plato a pedidos
                    $("#listaActoresBBDD").append(new Option(texto, valor));

                    // Elimino de la lista de actores
                    $("#listaActoresSeleccionados").children("option:selected").remove();
                });
            });
        </script>
        <script>
            function cargar() {
                var listaOpciones = document.getElementById('listaActoresSeleccionados');
                for (var i = 0; i < listaOpciones.length; i++) {
                    opt = listaOpciones[i];
                    opt.selected = true;
                }
            }
        </script>

        <meta charset="UTF-8">
        <title>Insertar película</title>
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
        
        <%!
            BaseDatos bd;
            ArrayList<String> nombresActores;
        %>

        <%
            bd = new BaseDatos();
            bd.abrirConexion();
            nombresActores = bd.recuperarTodosLosActores();
        %>

        <div class="container">
            <h1>Introduce los datos de la película.</h1>
            <br><br>
            
            <form action="CargarPelicula" method="POST" onsubmit="cargar()">
                <table>
                    <tr>
                        <td width="500px"><p>Nombre de la película:</p></td>
                        <td><input type="text" size="40" name="nombrePelicula"></td>
                    </tr>
                    <tr>
                        <td width="500px"><p>Sinopsis:</p></td>
                        <td><input type="text" size="40" name="sinopsis"></td>
                    </tr>
                    <tr>
                        <td width="500px"><p>Página web oficial:</p></td>
                        <td><input type="text" size="40" name="pagina_oficial"></td>
                    </tr>
                    <tr>
                        <td width="500px"><p>Título original:</p></td>
                        <td><input type="text" size="40" name="titulo_original"></td>
                    </tr>
                    <tr>
                        <td width="500px"><p>Género:</p></td>
                        <td><input type="text" size="40" name="genero"></td>
                    </tr>
                    <tr>
                        <td width="500px"><p>Nacionalidad:</p></td>
                        <td><input type="text" size="40" name="nacionalidad"></td>
                    </tr>
                    <tr>
                        <td width="500px"><p>Duración:</p></td>
                        <td><input type="text" name="duracion"> minutos</td>
                    </tr>
                    <tr>
                        <td width="500px"><p>Año:</p></td>
                        <td><input type="text" name="anyo"></td>
                    </tr>
                    <tr>
                        <td width="500px"><p>Distribuidora:</p></td>
                        <td><input type="text" size="40" name="distribuidora"></td>
                    </tr>
                    <tr>
                        <td width="500px"><p>Director:</p></td>
                        <td><input type="text" size="40" name="director"></td>
                    </tr>
                    <tr>
                        <td width="500px"><p>Clasificación por edad: (0 = todos los públicos)</p></td>
                        <td>No recomendada para menores de <input type="text" name="clasificacion_edad"> años</td>
                    </tr>
                    <tr>
                        <td width="500px"><p>Otros datos:</p></td>
                        <td><input type="text" size="40" name="otros_datos"></td>
                    </tr>
                    <tr>
                        <td width="500px">
                            <p>Actores de la película:</p>
                            <p> Elija, de los actores de la base de datos, aquellos que participen en la película. </p>
                            <p><b>Nota</b>: debe haberlos insertado en la BBDD previamente. </p>
                        </td>
                        <td>
                            <h4>Actores de la BBDD</h4>
                            <!-- Cargo actores de la BBDD en la select box. -->
                            <select id="listaActoresBBDD" name="listaActoresBBDD" size="4" style="width: 200px">
                                <%for (String actor : nombresActores) {%>
                                <option><%= actor%></option>
                                <% }%>
                            </select>
                        </td>
                        <td>
                            <h4>Actores seleccionados</h4>
                            <!-- Cargo actores de la BBDD en la select box. -->
                            <select id="listaActoresSeleccionados" name="listaActoresSeleccionados" multiple="multiple" size="4" style="width: 200px">
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