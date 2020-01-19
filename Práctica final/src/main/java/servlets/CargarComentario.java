package servlets;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import funcionalidadCompartida.BaseDatos;
import funcionalidadCompartida.Comentario;

public class CargarComentario extends HttpServlet {

    private BaseDatos bbdd;

    public void init(ServletConfig cfg) throws ServletException {
        bbdd = new BaseDatos();
        bbdd.abrirConexion();
    }

    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession s = req.getSession(true);

        // Se comprueba primero si no existe
        String correo = new String(req.getParameter("correo").getBytes("ISO-8859-1"),"UTF-8");
        String pelicula = new String(req.getParameter("pelicula").getBytes("ISO-8859-1"),"UTF-8");
        String puntuacionTxt = new String(req.getParameter("puntuacion").getBytes("ISO-8859-1"),"UTF-8");
        String comentario = new String(req.getParameter("comentario").getBytes("ISO-8859-1"),"UTF-8");

        if (bbdd.existeComentario(correo, pelicula)) {
            res.sendRedirect(res.encodeRedirectURL("errorYaExiste.html"));
        } else {
            // Si no existe, se realizan otras comprobaciones
            if (correo.isEmpty() || pelicula.isEmpty() || puntuacionTxt.isEmpty() || comentario.isEmpty()) {
                System.out.println("Algún campo está vacío.");
                res.sendRedirect(res.encodeRedirectURL("errorDatosMal.html"));
            } else if (correo.length() > 100 || pelicula.length() > 50 || comentario.length() > 1000) {
                System.out.println("La longitud de algún texto excede el máximo permitido.");
                res.sendRedirect(res.encodeRedirectURL("errorDatosMal.html"));
            } else {
                try {
                    Integer puntuacion = Integer.parseInt(puntuacionTxt);
                    if (puntuacion < 1 || puntuacion > 5) {
                        System.out.println("El número está fuera de rango.");
                        res.sendRedirect(res.encodeRedirectURL("errorDatosMal.html"));
                    } else {
                        // Si ha pasado los filtros, se inserta
                        Comentario c = new Comentario(correo, pelicula, puntuacion, comentario);
                        System.out.println(correo + pelicula + puntuacionTxt + comentario);
                        bbdd.insertarComentario(c);
                        res.sendRedirect(res.encodeRedirectURL("pelicula.jsp"));
                    }
                } catch (Exception e) {
                    System.out.println("No se ha introducido un número en el campo numérico.");
                    res.sendRedirect(res.encodeRedirectURL("errorDatosMal.html"));
                }
            }
        }
    }

    public void destroy() {
        bbdd.cerrarConexion();
        super.destroy();
    }
}
