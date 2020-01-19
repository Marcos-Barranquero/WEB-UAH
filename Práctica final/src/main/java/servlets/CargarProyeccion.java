package servlets;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import funcionalidadCompartida.BaseDatos;
import funcionalidadCompartida.Proyeccion;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.Month;

public class CargarProyeccion extends HttpServlet {

    private BaseDatos bd;

    public void init(ServletConfig cfg) throws ServletException {
        bd = new BaseDatos();
        bd.abrirConexion();
    }

    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession s = req.getSession(true);

        // Se comprueba primero si no existe
        String nombreCine = new String(req.getParameter("nombreCine").getBytes("ISO-8859-1"),"UTF-8");
        String nombrePelicula = new String(req.getParameter("selectPeliculas").getBytes("ISO-8859-1"),"UTF-8");
        String fechaTxt = new String(req.getParameter("fechaTxt").getBytes("ISO-8859-1"),"UTF-8");
        String horaTxt = new String(req.getParameter("selectHora").getBytes("ISO-8859-1"),"UTF-8");
        String cuartoTxt = new String(req.getParameter("selectCuarto").getBytes("ISO-8859-1"),"UTF-8");
        String precioTxt = new String(req.getParameter("precioTxt").getBytes("ISO-8859-1"),"UTF-8");
        System.out.println("Fecha: " + fechaTxt);
        System.out.println("Hora: " + horaTxt);
        
        // si datos incorrectos, redireccion
        if (proyeccionIncorrecta(nombreCine, nombrePelicula, fechaTxt,
                horaTxt, cuartoTxt)) {
            res.sendRedirect(res.encodeRedirectURL("errorDatosMal.html"));
            // convierto fecha y hora
        } else {
            Date fecha = convertirFecha(fechaTxt);
            Time hora = convertirHora(horaTxt, cuartoTxt);

            // si ya existe, doy error 
            if (yaExiste(bd, fecha, hora)) {
                res.sendRedirect(res.encodeRedirectURL("errorYaExiste.html"));
            } else {
                int idProyeccion = bd.getMaxIdProyeccion() + 1;
                int idSala = bd.getidSala(nombreCine, idProyeccion);
                float precio = Float.valueOf(precioTxt);
                Proyeccion proyeccion = new Proyeccion(idProyeccion,
                        idSala, nombreCine, nombrePelicula, fecha, hora, precio);

                System.out.println("Mostrando proyeccion: ");
                System.out.println(proyeccion.toString());

                try {
                    bd.insertarProyeccion(proyeccion);
                    res.sendRedirect(res.encodeRedirectURL("exitoInsertado.html"));
                } catch (Exception e) {

                    res.sendRedirect(res.encodeRedirectURL("errorDatosMal.html"));
                    System.out.println("Error insertando: ");
                    e.printStackTrace();
                }
            }
        }
    }

    public Date convertirFecha(String fechaTxt) {
        //mes, día, año
        String[] fechaSeparada = fechaTxt.split("/");

        int ano = Integer.valueOf(fechaSeparada[2]);
        int mes = Integer.valueOf(fechaSeparada[0]);
        int dia = Integer.valueOf(fechaSeparada[1]);

        System.out.println("Fecha en convertir: " + "" + ano + "-" + mes + "-" + dia);
        
        LocalDate fecha = LocalDate.of(ano, mes, dia);

        // año, mes, día
        Date fechaOutput = Date.valueOf(fecha);
        System.out.println("Fecha tras convertir: " + fechaOutput.toString());
        return fechaOutput;
    }

    public Time convertirHora(String horaTxt, String cuartoTxt) {
        System.out.println("hora: " + horaTxt);
        System.out.println("cuartoTxt: " + cuartoTxt);
        int hora = Integer.valueOf(horaTxt);
        int minutos = Integer.valueOf(cuartoTxt);

        // hora, minutos, segundos
        Time horaOutput = new Time(hora, minutos, 00);

        return horaOutput;
    }

    public boolean yaExiste(BaseDatos bbdd, Date fecha, Time hora) {
        // TODO
        return false;
    }

    public boolean proyeccionIncorrecta(String nombreCine, String nombrePelicula,
            String fechaTxt, String horaTxt, String cuartoTxt) {
        // TODO PT2
        return false;
    }

    public void destroy() {
        bd.cerrarConexion();
        super.destroy();
    }

}
