package servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class CargarCircuito extends HttpServlet {

    private ModeloDatos bd;

    public void init(ServletConfig cfg) throws ServletException {
        bd = new ModeloDatos();
        bd.abrirConexion();
    }

    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession s = req.getSession(true);

        // Se comprueba primero si no existe el circuito
        String nombre = req.getParameter("txtNombre");

        if (bd.existeCircuito(nombre)) {
            res.sendRedirect(res.encodeRedirectURL("errorCircuito.html"));
        } else {
            // Si no existe, se pasa a recoger y comprobar el resto de datos
            String ciudad = req.getParameter("txtCiudad");
            String pais = req.getParameter("txtPais");
            String vueltasTxt = req.getParameter("txtVueltas");
            String longitudTxt = req.getParameter("txtLongitud");
            String curvasTxt = req.getParameter("txtCurvas");

            // Se comprueban que no estén vacíos
            if (nombre.isEmpty() || ciudad.isEmpty() || pais.isEmpty() || vueltasTxt.isEmpty() || longitudTxt.isEmpty() || curvasTxt.isEmpty()) {
                System.out.println("Algún campo está vacío.");
                res.sendRedirect(res.encodeRedirectURL("datosMalCircuito.html"));
            } else if (nombre.length() > 20 || ciudad.length() > 20 || pais.length() > 20) {
                // Si alguno ocupa más de lo permitido
                System.out.println("La longitud de algún texto excede el máximo permitido.");
                res.sendRedirect(res.encodeRedirectURL("datosMalCircuito.html"));
            } else {
                try {
                    // Se comprueba que los datos sean números
                    Integer vueltas = Integer.parseInt(vueltasTxt);
                    Integer longitud = Integer.parseInt(longitudTxt);
                    Integer curvas = Integer.parseInt(curvasTxt);

                    if ((vueltas < 40 || vueltas > 80)
                            || (longitud < 3000 || longitud > 9000)
                            || (curvas < 6 || curvas > 20)) {
                        // Y que están dentro de los rangos correctos
                        System.out.println("Algún número está fuera de rango.");
                        res.sendRedirect(res.encodeRedirectURL("datosMalCircuito.html"));
                    } else {
                        // Si ha pasado todos los filtros, se inserta
                        bd.insertarCircuito(nombre, ciudad, pais, vueltas, longitud, curvas);
                        res.sendRedirect(res.encodeRedirectURL("exitoInsertado.html"));
                    }
                } catch (Exception e) {
                    System.out.println("No se ha introducido un número en algún campo numérico.");
                    res.sendRedirect(res.encodeRedirectURL("datosMalCircuito.html"));
                }
            }
        }
    }

    public void destroy() {
        bd.cerrarConexion();
        super.destroy();
    }
}
