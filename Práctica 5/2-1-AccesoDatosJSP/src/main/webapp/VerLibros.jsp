<!DOCTYPE HTML PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN">
<!-- jsp0501.jsp Esta es la p�gina que permite visualizar la informaci�n de los registros quecontiene la base de datos "Libros", 
y que presenta al lector una forma sencilla deconexi�n con bases de datos. En este caso se utiliza el
puente Jdbc-Odbc para acceder a la tabla almacenada en una base de datos
Microsoft Access.CREATE TABLE LIBROS (TITULO VARCHAR(50) NOT NULL,AUTOR VARCHAR(30) NOT NULL,PRECIO INTEGER NOT NULL)-->
<html>

<head>
    <title>Tutorial JSP, Base de Datos</title>
</head>

<body>
    <%@ page import="java.sql.*"%>
    <%!
    // Declaraciones de las variables utilizadas para la
    // conexi�n a la base de datos y para la recuperaci�n de
    // datos de las tablas
    Connection c;
    Statement s;
    ResultSet rs;
    ResultSetMetaData rsmd;
    %>

    <%
    // Inicializaci�n de las variables necesarias para la
    // conexi�n a la base de datos y realizaci�n de consultas
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    c = DriverManager.getConnection("jdbc:derby://localhost:1527/tutorialJsp");
    s = c.createStatement();
    rs = s.executeQuery("SELECT * FROM LIBROS");
    rsmd = rs.getMetaData();%>

    <table width="100%" border="1">
        <tr>
            <% for( int i=1; i <= rsmd.getColumnCount(); i++ ) { %>
            <%--   Obtenemos los nombres de las columnas y los colocamoscomo cabecera de la tabla --%>

            <th>
                <%= rsmd.getColumnLabel( i ) %>
            </th><% } %>
        </tr><% while( rs.next() ) { %>
        <tr>
            <% for( int i=1; i <= rsmd.getColumnCount(); i++ ) { %>
            <%--   Recuperamos los valores de las columnas que corresponden a cada uno de los registros de latabla.
                 Hay que recoger correctamente el tipo de dato que contiene la columna --%>
            <% if( i == 3 ) { %>
            <td>
                <%= rs.getInt( i ) %></td>
            <% } else { %>
            <td>
                <%= rs.getString( i ) %>
            </td><% } } %>
        </tr><% } %>
    </table>
</body>

</html>