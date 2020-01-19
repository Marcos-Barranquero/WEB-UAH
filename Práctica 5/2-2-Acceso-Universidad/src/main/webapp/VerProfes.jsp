<%-- 
    Document   : VerProfes
    Created on : 21-nov-2019, 17:35:33
    Author     : marco
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <title>Tutorial JSP, Base de Datos</title>
    </head>

    <body>
        <%@ page import="java.sql.*"%>
        <%!
            Connection c;
            Statement s;
            ResultSet rs;
            ResultSetMetaData rsmd;
        %>

        <%
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            c = DriverManager.getConnection("jdbc:derby://localhost:1527/Universidad");
            s = c.createStatement();
            String nombreProfesor = (String)request.getAttribute("profesor");
            rs = s.executeQuery("SELECT ALUMNO.DNI, ALUMNO.NOMBRE, ALUMNO.APELLIDO "
                    + "FROM ALUMNO INNER JOIN ASISTE ON ASISTE.DNI = ALUMNO.DNI "
                    + "INNER JOIN ASIGNATURA ON ASIGNATURA.IDASIGNATURA "
                    + " = ASISTE.IDASIGNATURA INNER JOIN PROFESOR "
                    + "ON PROFESOR.DNI=ASIGNATURA.DNI "
                    + "WHERE PROFESOR.NOMBRE='"+nombreProfesor+"'");
        rsmd = rs.getMetaData();%>

        <table width="100%" border="1">
            <tr>
                <% for (int i = 1; i <= rsmd.getColumnCount(); i++) {%>

                <th>
                    <%= rsmd.getColumnLabel(i)%>
                </th><% } %>
            </tr><% while (rs.next()) { %>
            <tr>
                <% for (int i = 1; i <= rsmd.getColumnCount(); i++) { %>
                <% if (i == 3) {%>
                <td>
                    <%= rs.getString(i)%></td>
                    <% } else {%>
                <td>
                    <%= rs.getString(i)%>
                </td><% }
                } %>
            </tr><% }%>
        </table>
    </body>

</html>