<%-- 
    Document   : sesionEje
    Created on : 21-nov-2019, 11:18:43
    Author     : danim
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Ejemplo de Sesión</title>
    </head>
    <body>
        <%
            String val = request.getParameter("nombre");
            if (val != null) {
                session.setAttribute("Nombre", val);
            }
        %>
    <center>
        <h1>Ejemplo de Sesión</h1>
        <p>¿Dónde quieres ir?</p>
        <a href="sesionEje1.jsp">Ir a Página 1</a>
        <a href="sesionEje2.jsp">Ir a Página 2</a>
    </body>
</html>
