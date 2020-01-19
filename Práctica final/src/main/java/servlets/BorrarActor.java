package servlets;

import funcionalidadCompartida.BaseDatos;
import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BorrarActor extends HttpServlet {

    private BaseDatos bbdd;

    public void init(ServletConfig cfg) throws ServletException {
        bbdd = new BaseDatos();
        bbdd.abrirConexion();
    }

    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession s = req.getSession(true);

        // Se comprueba primero si existe
        String actor = new String(req.getParameter("actor").getBytes("ISO-8859-1"),"UTF-8");

        if (bbdd.existeActor(actor)) {
            bbdd.eliminarActor(actor);
        }
        res.sendRedirect(res.encodeRedirectURL("exitoBorrado.html"));
    }

    public void destroy() {
        bbdd.cerrarConexion();
        super.destroy();
    }
}