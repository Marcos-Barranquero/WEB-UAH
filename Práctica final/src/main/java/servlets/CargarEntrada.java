package servlets;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import funcionalidadCompartida.BaseDatos;
import funcionalidadCompartida.Butaca;
import java.sql.Time;
import java.time.LocalTime;
import java.util.ArrayList;

public class CargarEntrada extends HttpServlet {

    private BaseDatos bd;

    public void init(ServletConfig cfg) throws ServletException {
        bd = new BaseDatos();
        bd.abrirConexion();
    }

    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession s = req.getSession(true);

        String[] butacas = req.getParameterValues("butacas");
        String idProyeccion = new String(req.getParameter("id_proyeccion").getBytes("ISO-8859-1"), "UTF-8");
        int idProyeccionInt = Integer.valueOf(idProyeccion);
        HttpSession session = (HttpSession) req.getSession();
        String usuario = (String) session.getAttribute("usuario");
        System.out.println("Butacas elegidas: " + butacas.toString());
        System.out.println("IdProyeccion elegida: " + idProyeccion);

        for (String butaca : butacas) {
            // Quito parentesis
            butaca = butaca.replace("(", "").replace(")", "");
            String[] butacaSpliteada = butaca.split(",");
            int fila = Integer.valueOf(butacaSpliteada[0]);
            int columna = Integer.valueOf(butacaSpliteada[1]);

            Butaca recuperada = bd.recuperarButaca(fila, columna, idProyeccionInt);

            // la pongo a reservada 
            recuperada.setReservada(true);
            recuperada.setHoraReserva(Time.valueOf(LocalTime.now()));
            bd.reescribirButaca(recuperada);
        }

        // Si no está registrado, guardo butacas en session y le invito a registrarse
        if (usuario == null) {
            session.setAttribute("butacas", butacas);
            session.setAttribute("id_proyeccion", idProyeccion);
            res.sendRedirect(res.encodeRedirectURL("quieresRegistrarte.jsp"));
        } else {
            session.setAttribute("butacas", butacas);
            session.setAttribute("id_proyeccion", idProyeccion);
            res.sendRedirect(res.encodeRedirectURL("pagar.jsp"));
        }
    }

    public void destroy() {
        bd.cerrarConexion();
        super.destroy();
    }
}
