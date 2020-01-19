package servlets;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import funcionalidadCompartida.BaseDatos;

public class CargarActor extends HttpServlet {

    private BaseDatos bbdd;

    public void init(ServletConfig cfg) throws ServletException {
        bbdd = new BaseDatos();
        bbdd.abrirConexion();
    }

    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession s = req.getSession(true);

        // Se comprueba primero si no existe
        String nombreActor = new String(req.getParameter("nombreActor").getBytes("ISO-8859-1"),"UTF-8");

        if (bbdd.existeActor(nombreActor)) {
            res.sendRedirect(res.encodeRedirectURL("errorYaExiste.html"));
        } else {
            // Si no existe, se realizan otras comprobaciones
            if (nombreActor.isEmpty()) {
                System.out.println("El campo está vacío.");
                res.sendRedirect(res.encodeRedirectURL("errorDatosMal.html"));
            } else if (nombreActor.length() > 100) {
                System.out.println("La longitud del texto excede el máximo permitido.");
                res.sendRedirect(res.encodeRedirectURL("errorDatosMal.html"));
            } else {
                // Si ha pasado los filtros, se inserta
                bbdd.insertarActor(nombreActor);
                res.sendRedirect(res.encodeRedirectURL("exitoInsertado.html"));
            }
        }
    }

    public void destroy() {
        bbdd.cerrarConexion();
        super.destroy();
    }
}
