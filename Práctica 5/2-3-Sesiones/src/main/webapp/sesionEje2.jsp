<%-- 
    Document   : sesionEje2
    Created on : 21-nov-2019, 11:23:58
    Author     : danim
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title> Ejemplo de Sesión </title>
    </head>
    <body>
    <center> <h1>Ejemplo de Sesión</h1>
        Hola, <%=session.getAttribute("Nombre")%>
        <p>Bienvenido a la página 2</p>
    </body>
</html>
