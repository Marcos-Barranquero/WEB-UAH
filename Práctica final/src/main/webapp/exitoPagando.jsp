<%@page import="funcionalidadCompartida.Entrada"%>
<%@page import="java.sql.Date"%>
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
            String correo = (String) session.getAttribute("usuario");

            BaseDatos bbdd = new BaseDatos();
            bbdd.abrirConexion();

            ArrayList<Butaca> butacasRecuperadas = new ArrayList<Butaca>();

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
            Date fecha = bbdd.getFechaProyeccion(idProyeccion);
            ArrayList<Entrada> entradas = new ArrayList<Entrada>();
            if (correo == null) {
                System.out.println("Como es un usuario no registrado, creo entradas no registradas");
                for (Butaca butaca : butacasRecuperadas) {
                    bbdd.crearEntradaNoRegistrada(butaca.getFila(), butaca.getColumna(), idProyeccion);
                    System.out.println("Entrada creada.");
                    Entrada recup = bbdd.recuperarEntrada(butaca.getFila(), butaca.getColumna(), idProyeccion);
                    entradas.add(recup);
                    System.out.println("Entrada recuperada: " + recup.toString());
                }
                session.setAttribute("butacas", null);
                session.setAttribute("id_proyeccion", null);
            } // para registrados
            else {
                System.out.println("Como es un usuario registrado, creo entradas registradas");
                for (Butaca butaca : butacasRecuperadas) {
                    bbdd.crearEntradaRegistrada(butaca.getFila(), butaca.getColumna(), idProyeccion, correo);
                    System.out.println("Entrada creada.");
                    Entrada recup = bbdd.recuperarEntrada(butaca.getFila(), butaca.getColumna(), idProyeccion);
                    entradas.add(recup);
                    System.out.println("Entrada recuperada: " + recup.toString());
                }
                session.setAttribute("butacas", null);
                session.setAttribute("id_proyeccion", null);
            }
        %>

        <br><br><br>

        <div class="container">

            <h1>Entradas compradas para <%=nombrePelicula%> el día <%=fecha.toString()%>.</h1>

            <table class="table table-striped">
                <thead>
                    <tr>
                        <th width="20%" scope="col">Fila</th>
                        <th width="20%" scope="col">Columna</th>
                        <th width="20%" scope="col">Precio</th>
                        <th width="20%" scope="col">Id</th>
                    </tr>
                </thead>
                <tbody>
                    <%for (Entrada entrada : entradas) {%>
                    <tr>
                        <td> <%= entrada.getFila()%> </td>
                        <td> <%=entrada.getColumna()%> </td>
                        <td> <%=precioProyeccion%></td>
                        <td> <%=entrada.getIdEntrada()%></td>
                    </tr>
                    <%}%>
                </tbody>
            </table>

            <br><br>

            <button type="button" class="btn btn-primary" onclick="window.location.href = 'inicio.jsp';">Volver al inicio</button>
        </div>

        <br><br><br>

        <footer class="footer">
            <div class="container text-center">
                <p>Práctica final - Marcos Barranquero y Daniel Manzano | Arquitectura y Diseño de Sistemas Web y C/S, 2020</p>
            </div>
        </footer>

    </body>
</html>