package servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class CargarCoche extends HttpServlet {

    private ModeloDatos bd;

    public void init(ServletConfig cfg) throws ServletException {
        bd = new ModeloDatos();
        bd.abrirConexion();
    }

    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession s = req.getSession(true);

        // Se comprueba primero si no existe el coche
        String nombre = req.getParameter("txtNombre");

        if (bd.existeCoche(nombre)) {
            res.sendRedirect(res.encodeRedirectURL("errorCoche.html"));
        } else {
            // Si no existe, se pasa a comprobar el resto de datos
            String kwcurvaTxt = req.getParameter("txtPotencia");
            
            // Se comprueba que no estén vacíos
            if (nombre.isEmpty() || kwcurvaTxt.isEmpty()) {
                System.out.println("Algún campo está vacío.");
                res.sendRedirect(res.encodeRedirectURL("datosMalCoche.html"));
            } else if (nombre.length() > 20) {
                // Si el nombre ocupa más de lo permitido
                System.out.println("La longitud de algún texto excede el máximo permitido.");
                res.sendRedirect(res.encodeRedirectURL("datosMalCoche.html"));
            } else {
                try {
                    // Se comprueba que kwcurva sea un número
                    Integer kwcurva = Integer.parseInt(kwcurvaTxt);
                    
                    if (kwcurva < 4 || kwcurva > 10){
                        // Y que esté en el rango correcto
                        System.out.println("Algún número está fuera de rango.");
                        res.sendRedirect(res.encodeRedirectURL("datosMalCoche.html"));
                    } else {
                        // Si ha pasado todos los filtros, se inserta
                        bd.insertarCoche(nombre, kwcurva);
                        res.sendRedirect(res.encodeRedirectURL("exitoInsertado.html"));
                    }
                } catch (Exception e) {
                    System.out.println("No se ha introducido un número en algún campo numérico.");
                    res.sendRedirect(res.encodeRedirectURL("datosMalCoche.html"));
                }
            }
        }
    }

    public void destroy() {
        bd.cerrarConexion();
        super.destroy();
    }
}
