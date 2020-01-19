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
        <title>Compra de entradas</title>
    </head>

    <body>

        <%!
            BaseDatos bd;
            ArrayList<String> nombresActores;
        %>

        <%
            bd = new BaseDatos();
            bd.abrirConexion();
        %>

        <br><br><br>

        <div class="container">

            <h1>Antes de continuar... </h1>
            <br><br>

            <table class="table table-sm">
                <tr>
                    <td width="45%">
                        <br>
                        <h2>Regístrate.</h2>
                        <form action="AltaClienteYContinuar" method="POST">
                            <div class="form-group">
                                <label>Nombre</label>
                                <input type="text" pattern="[a-zA-ZÀ-ÿ ñÑ-\.,]{0,50}" size="30" name="nombreCliente" required class="form-control" placeholder="Nombre">
                            </div>
                            <div class="form-group">
                                <label>Apellidos</label>
                                <input type="text" pattern="[a-zA-ZÀ-ÿ ñÑ-\.,]{0,50}" size="30" name="apellidosCliente" required class="form-control" placeholder="Apellidos">
                            </div>
                            <div class="form-group">
                                <label>Teléfono</label>
                                <input type="text" pattern="[0-9]{9}" size="30" name="telefonoCliente" required class="form-control" placeholder="Teléfono">
                            </div>
                            <div class="form-group">
                                <label>Correo</label>
                                <input type="email" name="correoCliente" size="30" required class="form-control" placeholder="Correo">
                            </div>
                            <div class="form-group">
                                <label>Contraseña</label>
                                <input type="password" size="30" name="pwCliente" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Debe contener al menos un número, una mayúscula y una minúscula, y 8 o más caracteres." class="form-control" placeholder="Contraseña">
                            </div>
                            <button type="submit" class="btn btn-primary">Registrarse y continuar</button>
                        </form>
                    </td>
                    <td width="10%">
                    </td>
                    <td width="45%">
                        <br>
                        <h2>Inicia sesión.</h2>
                        <form action="LoginYContinuar" method="POST">
                            <div class="form-group">
                                <label>Correo electrónico</label>
                                <input type="text" class="form-control" name="correoLogin" aria-describedby="emailHelp" placeholder="Correo" size="30">
                            </div>
                            <div class="form-group">
                                <label>Contraseña</label>
                                <input type="password" class="form-control" name="passLogin" placeholder="Contraseña" size="30">
                            </div>
                            <button type="submit" class="btn btn-primary">Iniciar sesión</button>
                        </form>
                        
                        <br><br><br><br>
                        
                        <h2>O bien, continua sin registrarte.</h2>
                        <p>No podrás dejar comentarios en las películas que veas.</p>
                        <form action="pagar.jsp" method="POST">
                            <button type="submit" class="btn btn-primary">Continuar sin registrarse</button>
                        </form>
                        
                    </td>
                </tr>
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