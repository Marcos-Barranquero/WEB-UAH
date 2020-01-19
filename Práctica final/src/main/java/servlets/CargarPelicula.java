package servlets;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import funcionalidadCompartida.BaseDatos;
import funcionalidadCompartida.Pelicula;
import java.util.ArrayList;

public class CargarPelicula extends HttpServlet {

    private BaseDatos bd;

    public void init(ServletConfig cfg) throws ServletException {
        bd = new BaseDatos();
        bd.abrirConexion();
    }

    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession s = req.getSession(true);

        // Se comprueba primero si no existe
        String nombrePelicula = new String(req.getParameter("nombrePelicula").getBytes("ISO-8859-1"),"UTF-8");
        Pelicula pelicula = null;

        String sinopsis = new String(req.getParameter("sinopsis").getBytes("ISO-8859-1"),"UTF-8");
        String pagina_oficial = new String(req.getParameter("pagina_oficial").getBytes("ISO-8859-1"),"UTF-8");
        String titulo_original = new String(req.getParameter("titulo_original").getBytes("ISO-8859-1"),"UTF-8");
        String genero = new String(req.getParameter("genero").getBytes("ISO-8859-1"),"UTF-8");
        String nacionalidad = new String(req.getParameter("nacionalidad").getBytes("ISO-8859-1"),"UTF-8");
        String duracionTxt = new String(req.getParameter("duracion").getBytes("ISO-8859-1"),"UTF-8");
        String anyoTxt = new String(req.getParameter("anyo").getBytes("ISO-8859-1"),"UTF-8");
        String distribuidora = new String(req.getParameter("distribuidora").getBytes("ISO-8859-1"),"UTF-8");
        String director = new String(req.getParameter("director").getBytes("ISO-8859-1"),"UTF-8");
        String clasificacion_edadTxt = new String(req.getParameter("clasificacion_edad").getBytes("ISO-8859-1"),"UTF-8");
        String otros_datos = new String(req.getParameter("otros_datos").getBytes("ISO-8859-1"),"UTF-8");
        String[] actores = req.getParameterValues("listaActoresSeleccionados");

        if (yaExiste(bd, nombrePelicula)) {
            // Si existe el cine, error
            res.sendRedirect(res.encodeRedirectURL("errorYaExiste.html"));
        } else if (peliculaIncorrecta(nombrePelicula, sinopsis, pagina_oficial, titulo_original,
                genero, nacionalidad, duracionTxt, anyoTxt, distribuidora, director,
                clasificacion_edadTxt, otros_datos, actores)) {
            // Si los datos están mal, error
            res.sendRedirect(res.encodeRedirectURL("errorDatosMal.html"));
        } else {
            // Si todo está correcto, se inserta
            ArrayList<String> actoresArray = arrayToArrayList(actores);
            int duracion = Integer.valueOf(duracionTxt);
            int anyo = Integer.valueOf(anyoTxt);
            int edad_minima = Integer.valueOf(clasificacion_edadTxt);

            pelicula = new Pelicula(nombrePelicula, sinopsis, pagina_oficial,
                    titulo_original, genero, nacionalidad, duracion, anyo, distribuidora,
                    director, edad_minima, otros_datos, actoresArray);

            bd.insertarPelicula(pelicula);
            res.sendRedirect(res.encodeRedirectURL("exitoInsertado.html"));
        }
    }

    public boolean yaExiste(BaseDatos bd, String nombrePelicula) {
        return bd.existePelicula(nombrePelicula);
    }

    public boolean peliculaIncorrecta(String nombrePelicula, String sinopsis, String pagina_oficial,
            String titulo_original, String genero,
            String nacionalidad, String duracionTxt, String anyoTxt, String distribuidora,
            String director, String clasificacion_edadTxt,
            String otros_datos, String[] actores) {

        boolean estaMal = false;

        // Si no existe, se pasa a comprobar parámetros
        // Se comprueban que no estén vacíos (salvo otros_datos)
        if (nombrePelicula.isEmpty() || pagina_oficial.isEmpty()
                || titulo_original.isEmpty() || genero.isEmpty()
                || nacionalidad.isEmpty() || duracionTxt.isEmpty()
                || anyoTxt.isEmpty() || distribuidora.isEmpty()
                || director.isEmpty() || clasificacion_edadTxt.isEmpty()) {
            System.out.println("Algún campo está vacío.");
            estaMal = true;
        } else if (nombrePelicula.length() > 50 || sinopsis.length() > 1000
                || pagina_oficial.length() > 100 || titulo_original.length() > 50
                || genero.length() > 50 || nacionalidad.length() > 50
                || distribuidora.length() > 50 || director.length() > 50
                || otros_datos.length() > 1000) {
            // Si alguno ocupa más de lo permitido
            System.out.println("La longitud de algún texto excede el máximo permitido.");
            estaMal = true;
        } else {
            try {
                // Se comprueba que los datos sean números
                Integer duracion = Integer.parseInt(duracionTxt);
                Integer anyo = Integer.parseInt(anyoTxt);
                Integer clasificacion_edad = Integer.parseInt(clasificacion_edadTxt);

                if (duracion < 0 || anyo > 2020 || clasificacion_edad < 0 || clasificacion_edad > 18) {
                    // Y que estén dentro de los rangos correctos
                    System.out.println("Algún número está fuera de rango.");
                    estaMal = true;
                }
            } catch (Exception e) {
                System.out.println("No se ha introducido un número en algún campo numérico.");
                estaMal = true;
            }
        }
        return estaMal;
    }

    public ArrayList<String> arrayToArrayList(String[] actores) {
        ArrayList<String> salida = new ArrayList<>();
        for (String string : actores) {
            salida.add(string);
        }
        return salida;
    }

    public void destroy() {
        bd.cerrarConexion();
        super.destroy();
    }
}
