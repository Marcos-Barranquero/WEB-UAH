<%@page import="funcionalidadCompartida.Butaca"%>
<%@page import="java.util.ArrayList"%>
<%@page import="funcionalidadCompartida.BaseDatos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" crossorigin="anonymous"></script>
        <meta charset="UTF-8">

        <title>Pago</title>
    </head>

    <body>
        <%
            String butacas[] = (String[]) session.getAttribute("butacas");
            int idProyeccion = Integer.valueOf((String) session.getAttribute("id_proyeccion"));

            BaseDatos bbdd = new BaseDatos();
            bbdd.abrirConexion();

            ArrayList<Butaca> butacasRecuperadas = new ArrayList();

            for (String butaca : butacas) {
                // Quito parentesis
                butaca = butaca.replace("(", "").replace(")", "");
                String[] butacaSpliteada = butaca.split(",");
                int fila = Integer.valueOf(butacaSpliteada[0]);
                int columna = Integer.valueOf(butacaSpliteada[1]);
                Butaca recuperada = bbdd.recuperarButaca(fila, columna, idProyeccion);
                recuperada.toString();
                butacasRecuperadas.add(recuperada);
            }

            float precioProyeccion = bbdd.getPrecioProyeccion(idProyeccion);
            String nombrePelicula = bbdd.getNombrePelicula(idProyeccion);
        %>

        <br><br><br>

        <div class="container">

            <h1>Entradas para <%=nombrePelicula%>.</h1>

            <table class="table table-striped">
                <thead>
                    <tr>
                        <th width="20%" scope="col">Fila</th>
                        <th width="20%" scope="col">Columna</th>
                        <th width="20%" scope="col">Precio</th>
                    </tr>
                </thead>
                <tbody>
                    <%for (Butaca butaca : butacasRecuperadas) {%>
                    <tr>
                        <td> <%=butaca.getFila()%> </td>
                        <td> <%=butaca.getColumna()%> </td>
                        <td> <%=precioProyeccion%></td>
                    </tr>
                    <%}%>
                </tbody>
            </table>

            <br><br>

            <h2>Método de pago</h2>
            <br>

            <form action="exitoPagando.jsp" method="POST">
                <div class="form-group">
                    <label>Número de tarjeta</label>
                    <input type="text" class="form-control" pattern="[0-9]{16}" required>
                </div>
                <div class="form-group">
                    <label>Fecha de caducidad (MM-AA)</label>
                    <input type="text" class="form-control" pattern="(0[1-9]|^(11)|^(12))-[0-9][0-9]$" required>
                </div>
                <div class="form-group">
                    <label>CVV</label>
                    <input type="text" class="form-control" pattern="[0-9]{3}" required>
                </div>
                <button type="submit" class="btn btn-primary">Pagar</button>
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