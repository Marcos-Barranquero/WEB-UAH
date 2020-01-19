package funcionalidadCompartida;

import java.sql.Date;
import java.sql.Time;

public class Proyeccion {
    private Integer idProyeccion, idSala;
    private String nombreCine, nombrePelicula;
    
    private float precio;
    
    
    private Date fechaProyeccion;
    
    private Time horaProyeccion;

    public Proyeccion(int idProyeccion, int id_sala, String nombreCine, String nombrePelicula, Date fechaProyeccion, Time horaProyeccion, float precio) {
        this.idProyeccion = idProyeccion;
        this.idSala = id_sala;
        this.nombreCine = nombreCine;
        this.nombrePelicula = nombrePelicula;
        this.fechaProyeccion = fechaProyeccion;
        this.horaProyeccion = horaProyeccion;
        this.precio = precio;
    }

    public Integer getIdProyeccion() {
        return idProyeccion;
    }

    public Integer getIdSala() {
        return idSala;
    }

    public String getNombreCine() {
        return nombreCine;
    }

    public String getNombrePelicula() {
        return nombrePelicula;
    }

    public String getFechaProyeccion() {
        return fechaProyeccion.toString();
    }

    public String getHoraProyeccion() {
        // HH:MM:SS
        return horaProyeccion.toString();
    }

    @Override
    public String toString() {
        return "Proyeccion{" + "idProyeccion=" + idProyeccion + ", idSala=" + idSala + ", nombreCine=" + nombreCine + ", nombrePelicula=" + nombrePelicula + ", fechaProyeccion=" + fechaProyeccion + ", horaProyeccion=" + horaProyeccion + '}';
    }

    public float getPrecio() {
        return precio;
    }
    
    
}
