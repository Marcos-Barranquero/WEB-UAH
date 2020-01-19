package servlets;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import funcionalidadCompartida.BaseDatos;

public class CargarCine extends HttpServlet {

    private BaseDatos bbdd;

    public void init(ServletConfig cfg) throws ServletException {
        bbdd = new BaseDatos();
        bbdd.abrirConexion();
    }

    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession s = req.getSession(true);

        // Se comprueba primero si no existe
        String nombreCine = new String(req.getParameter("nombreCine").getBytes("ISO-8859-1"),"UTF-8");
        String cantidadSalas = new String(req.getParameter("cantidadSalas").getBytes("ISO-8859-1"),"UTF-8");;

        if (yaExiste(bbdd, nombreCine)) {
            // Si existe el cine, error
            res.sendRedirect(res.encodeRedirectURL("errorYaExiste.html"));
        } else if (cineIncorrecto(nombreCine, cantidadSalas)) {
            // Si los datos están mal, error
            res.sendRedirect(res.encodeRedirectURL("errorDatosMal.html"));
        } else {
            // Si todo está correcto, se inserta
            int salas = Integer.valueOf(cantidadSalas);
            bbdd.insertarCine(nombreCine, salas);
            res.sendRedirect(res.encodeRedirectURL("exitoInsertado.html"));
        }
    }

    public boolean yaExiste(BaseDatos bbdd, String nombreCine) {
        System.out.println("yaExiste: " + bbdd.existeCine(nombreCine));
        return bbdd.existeCine(nombreCine);
    }

    public boolean cineIncorrecto(String nombreCine, String numeroSalas) {
        boolean esIncorrecto = false;
        if (nombreCine.isEmpty() || numeroSalas.isEmpty()) {
            esIncorrecto = true;
        }

        if (nombreCine.length() > 50) {
            esIncorrecto = true;
        }

        int salas = -1;
        try {
            salas = Integer.valueOf(numeroSalas);
        } catch (Exception e) {
            esIncorrecto = true;
        }

        if (salas < 1 || salas > 20) {
            esIncorrecto = true;
        }
        return esIncorrecto;
    }

    public void destroy() {
        bbdd.cerrarConexion();
        super.destroy();
    }
}
