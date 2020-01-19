package servlets;

import java.sql.*;

public class ModeloDatos {

    private Connection con;
    private Statement set;
    private ResultSet rs;

    public void abrirConexion() {
        String sURL = "jdbc:odbc:mvc";
        try {
            // Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            // con = DriverManager.getConnection(sURL,"","");
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/Practica6");
            System.out.println("Se ha conectado");
        } catch (Exception e) {
            System.out.println("No se ha conectado");
        }
    }

    public boolean existeCoche(String nombre) {
        boolean existe = false;
        String cad;
        try {
            set = con.createStatement();
            rs = set.executeQuery("SELECT * FROM COCHE");
            while (rs.next()) {
                cad = rs.getString("nombre");
                cad = cad.trim();
                if (cad.compareTo(nombre.trim()) == 0)
                    existe = true;
            }
            rs.close();
            set.close();
        } catch (Exception e) {
            System.out.println("No lee de la tabla");
        }
        return (existe);
    }
    
    public boolean existeCircuito(String nombre) {
        boolean existe = false;
        String cad;
        try {
            set = con.createStatement();
            rs = set.executeQuery("SELECT * FROM CIRCUITO");
            while (rs.next()) {
                cad = rs.getString("nombre");
                cad = cad.trim();
                if (cad.compareTo(nombre.trim()) == 0)
                    existe = true;
            }
            rs.close();
            set.close();
        } catch (Exception e) {
            System.out.println("No lee de la tabla");
        }
        return (existe);
    }

    public void insertarCoche(String nombre, Integer kwcurva) {
        try {
            set = con.createStatement();
            set.executeUpdate("INSERT INTO COCHE " + " (nombre,kwcurva) VALUES ('" + nombre + "'," + kwcurva + ")");
            rs.close();
            set.close();
        } catch (Exception e) {
            System.out.println("No inserta en la tabla");
        }
    }
    
    public void insertarCircuito(String nombre, String ciudad, String pais, Integer vueltas, Integer longitud, Integer curvas) {
        try {
            set = con.createStatement();
            set.executeUpdate("INSERT INTO CIRCUITO " + " (nombre,ciudad,pais,vueltas,longitud,curvas)"
                    + " VALUES ('" + nombre + "','" + ciudad + "','" + pais + "'," + vueltas + "," + longitud + "," + curvas + ")");
            rs.close();
            set.close();
        } catch (Exception e) {
            System.out.println("No inserta en la tabla");
        }
    }
    
    public void cerrarConexion() {
        try {
            con.close();
        } catch (Exception e) {
        }
    }

}