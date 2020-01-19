<%@page import="funcionalidadCompartida.Butaca"%>
<%@page import="java.util.ArrayList"%>
<%@page import="funcionalidadCompartida.Pelicula"%>
<%@page import="funcionalidadCompartida.BaseDatos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>

    <head>

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" type="text/css" href="./image-picker.css" crossorigin="anonymous">
        <meta charset="UTF-8">
        <script src="./image-picker.min.js" crossorigin="anonymous" type="text/javascript"></script>
        <script>
            function cargaPicker()
            {
                $("select").imagepicker(
                        {
                            hide_select: false,
                            show_label: true
                        }
                );
            }
        </script>

        <% String idProyeccion = ""; %>
        <% if (request.getParameter("id_proyeccion") == null) {%>
        <title>Error</title>
        <% } else {%>
        <% idProyeccion = new String(request.getParameter("id_proyeccion").getBytes("ISO-8859-1"), "UTF-8");%>
        <title>Elige butacas</title>
        <% }%>
    </head>

    <body onload="cargaPicker()">


        <%!
            BaseDatos bbdd;
            Connection conexion;
            Statement consulta;
            ResultSet resultado;
            ResultSetMetaData rsmd;
            String butacaVacia;
            String butacaOcupada;
        %>

        <%
            String usuario = (String) session.getAttribute("usuario");
            System.out.println("Usuario en butacas: " + usuario);
            butacaVacia = "'./media/vacia.png'";
            butacaOcupada = "'./media/ocupada.png'";
            bbdd = new BaseDatos();
            bbdd.abrirConexion();
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conexion = DriverManager.getConnection("jdbc:derby://localhost:1527/BBDDPECLF");

            // recupero filas y columnas
            int filas = -1;
            int columnas = -1;
            String query = "select filas, columnas from sala inner join proyeccion on"
                    + " proyeccion.ID_SALA = sala.ID_SALA where proyeccion.ID_PROYECCION = " + idProyeccion + "";

            try {
                consulta = conexion.createStatement();
                resultado = consulta.executeQuery(query);
                resultado.next();
                filas = resultado.getInt("filas");
                columnas = resultado.getInt("columnas");

                resultado.close();
                consulta.close();
            } catch (Exception e) {
                System.out.println("Error recuperando filas y columnas al crear sitios: ");
                e.printStackTrace();
            }

            int idProyeccionInt = Integer.valueOf(idProyeccion);
            String estadoButaca = "";
        %>

        <br><br><br>

        <div class="container">

            <h1>Elige butaca para la sesión.</h1>

            <form action="CargarEntrada" method="POST">

                <div class="picker" style="width: 800px;margin-left: auto;  margin-right: auto;">
                    <select multiple="multiple" id="butacas" name="butacas" class="image-picker" style="display: none; " required>

                        <% for (int fila = 1; fila <= filas; fila++) {%>
                        <% for (int columna = 1; columna <= columnas; columna++) {%>

                        <%
                            String elegible = "";
                            Butaca recuperada = bbdd.recuperarButaca(fila, columna, idProyeccionInt);
                            if (recuperada.isOcupada() || recuperada.isReservada()) {
                                estadoButaca = butacaOcupada;
                                elegible = "disabled";
                            } else {
                                estadoButaca = butacaVacia;
                                elegible = "";
                            }
                        %>

                        <option <%=elegible%> data-img-src=<%=estadoButaca%> value="(<%=fila%>,<%=columna%>)" 
                                              name="(<%=fila%>,<%=columna%>)"></option>

                        <%}%>
                        <%}%>
                    </select>
                </div>

                <input name="id_proyeccion" type ="hidden" value="<%=idProyeccionInt%>">
                <button type="submit" class="btn btn-primary" style="display: flex;
                        justify-content: center;"> Elegir butaca </button>
            </form>

        </div>

        <br><br><br>

        <footer class="footer">
            <div class="container text-center">
                <p>Práctica final - Marcos Barranquero y Daniel Manzano | Arquitectura y Diseño de Sistemas Web y C/S, 2020</p>
            </div>
        </footer>

    </body>
</html>