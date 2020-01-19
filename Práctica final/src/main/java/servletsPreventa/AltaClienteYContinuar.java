package servletsPreventa;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import funcionalidadCompartida.BaseDatos;

public class AltaClienteYContinuar extends HttpServlet {

    private BaseDatos bbdd;

    public void init(ServletConfig cfg) throws ServletException {
        bbdd = new BaseDatos();
        bbdd.abrirConexion();
    }

    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession s = req.getSession(true);

        // Se comprueba primero si no existe
        String nombreCliente = new String(req.getParameter("nombreCliente").getBytes("ISO-8859-1"),"UTF-8");
        String apellidosCliente = new String(req.getParameter("apellidosCliente").getBytes("ISO-8859-1"),"UTF-8");
        String telefonoCliente = new String(req.getParameter("telefonoCliente").getBytes("ISO-8859-1"),"UTF-8");
        String correoCliente = new String(req.getParameter("correoCliente").getBytes("ISO-8859-1"),"UTF-8");
        String pwCliente = new String(req.getParameter("pwCliente").getBytes("ISO-8859-1"),"UTF-8");

        if (bbdd.existeCliente(correoCliente) || correoCliente.equals("admin")) {
            res.sendRedirect(res.encodeRedirectURL("errorYaExiste.html"));
        } else {
            // Si no existe, se inserta en la bbdd
            bbdd.insertarCliente(nombreCliente, apellidosCliente, telefonoCliente, correoCliente, pwCliente);

            if (bbdd.loginCliente(correoCliente, pwCliente)) {
                s.setAttribute("usuario", correoCliente);

                // REDIRECT A ENTRADAS
                res.sendRedirect(res.encodeRedirectURL("pagar.jsp"));


            }

        }
    }

    public void destroy() {
        bbdd.cerrarConexion();
        super.destroy();
    }
}
