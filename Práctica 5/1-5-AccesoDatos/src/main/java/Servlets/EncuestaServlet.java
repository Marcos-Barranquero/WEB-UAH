package Servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

public class EncuestaServlet extends HttpServlet {
    Statement mandato = null;
    Connection conexion = null;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        // Compruebo que el driver funciona.
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
        } catch (Exception e) {
            System.out.println("Error al cargar el driver JDBC/ODBC.");
            return;
        }

        // Intento conectarme a la base de datos.
        try {
            conexion = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");
            mandato = conexion.createStatement();
        } catch (SQLException e) {
            System.out.println("Problemas al conectar con la base de datos");
        }
    }

    public void service(HttpServletRequest peticion, HttpServletResponse respuesta)
            throws ServletException, IOException {
        /* creación del flujo de salida hacia el cliente */
        ServletOutputStream out = respuesta.getOutputStream();
        respuesta.setContentType("text/html");

        /* recuperamos los valores que nos manda el cliente */
        String strNombre = peticion.getParameter("NOMBRE");
        String strEmail = peticion.getParameter("EMAIL");
        String strRespuesta = peticion.getParameter("RESPUESTA");

        /* insertamos los datos en la base de datos */
        try {
            mandato.executeUpdate("INSERT  INTO  ENCUESTA  VALUES(  '" + strNombre + "',  '" + strEmail + "', '"
                    + strRespuesta + "')");
        } catch (SQLException e) {
            System.out.println("ERROR PORQUE LA TABLA NO ESTÁ CREADA. ");
            System.out.println(e);
            return;
        }
        /* leemos todos los registros para crear la estadística */try {
            int intSI = 0;
            int intNO = 0;
            ResultSet resultado = mandato.executeQuery("SELECT RESPUESTA FROM ENCUESTA");
            while (resultado.next()) {
                String resp = resultado.getString("RESPUESTA");
                if (resp.compareTo("SI") == 0)
                    intSI++;
                else
                    intNO++;
            }

            // Imprimo página HTML mostrando los resultados de la encuesta
            out.println("<h2><center>Encuesta Servlet</center></h2>");
            out.println("<BR>Gracias por participar en esta encuesta.");
            out.println("<BR>Los resultados hasta este momento son :");
            out.println("<BR>              SI : " + intSI);
            out.println("<BR>              NO : " + intNO);
            out.println("<a >");
        } catch (IOException e) {
            System.out.println(e);
            return;
        } catch (SQLException e) {
            System.out.println(e);
            return;
        }
    }

    public void destroy() {
        try {
            conexion.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}
