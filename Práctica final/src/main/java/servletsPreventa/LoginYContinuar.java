package servletsPreventa;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import funcionalidadCompartida.BaseDatos;

public class LoginYContinuar extends HttpServlet {

    private BaseDatos bbdd;

    public void init(ServletConfig cfg) throws ServletException {
        bbdd = new BaseDatos();
        bbdd.abrirConexion();
    }

    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession s = req.getSession(true);

        // Se comprueba primero si no existe
        String correoLogin = new String(req.getParameter("correoLogin").getBytes("ISO-8859-1"),"UTF-8");
        String passLogin = new String(req.getParameter("passLogin").getBytes("ISO-8859-1"),"UTF-8");

        // si loguin correcto, logueo y envio a pagar
        if (bbdd.loginCliente(correoLogin, passLogin)) {
            s.setAttribute("usuario", correoLogin);
            res.sendRedirect(res.encodeRedirectURL("pagar.jsp"));
        }
        //si no redirect a pag. anterior
        else
        {
            // TODO CAMBIAR A REDIRECCION ERROR REDIRECCION QUIERESREGISTRARTE
            res.sendRedirect(res.encodeRedirectURL("quieresRegistrarte.jsp"));
        }
    }

    public void destroy() {
        bbdd.cerrarConexion();
        super.destroy();
    }
}
