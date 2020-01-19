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
        <meta charset="UTF-8">
        <title>Insertar película</title>
    </head>

    <body>

        <%
            BaseDatos bd = new BaseDatos();
            bd.abrirConexion();
        %>

        <br><br><br>

        <div class="container">

            <h1>Registro.</h1>
            <p>Introduce tus datos.</p>
            <br><br>

            <form action="AltaCliente" method="POST">
                <div class="form-group">
                    <label for="exampleInputEmail1">Nombre</label>
                    <input type="text" pattern="[a-zA-ZÀ-ÿ ñÑ-\.,]{0,50}" size="40" name="nombreCliente" required class="form-control">
                </div>
                <div class="form-group">
                    <label for="exampleInputEmail1">Apellidos</label>
                    <input type="text" pattern="[a-zA-ZÀ-ÿ ñÑ-\.,]{0,50}" size="40" name="apellidosCliente" required class="form-control">
                </div>
                <div class="form-group">
                    <label for="exampleInputEmail1">Teléfono</label>
                    <input type="text" pattern="[0-9]{9}" size="40" name="telefonoCliente" required class="form-control">
                </div>
                <div class="form-group">
                    <label for="exampleInputEmail1">Correo electrónico</label>
                    <input type="email" size="40" name="correoCliente" required class="form-control">
                </div>
                <div class="form-group">
                    <label for="exampleInputPassword1">Contraseña</label>
                    <input type="password" name="pwCliente" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Debe contener al menos un número, una mayúscula y una minúscula, y 8 o más caracteres." class="form-control">
                </div>
                <input type="submit" class="btn btn-primary" name="BotonSubmit" value="Registrarse" id="Insertar">
                <input type="reset" class="btn btn-secondary" name="BotonReset" value="Reestablecer el formulario">
            </form>

            <br>

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