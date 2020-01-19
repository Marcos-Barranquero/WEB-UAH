package funcionalidadCompartida;

public class InformeEntradas {
    private String id, cine, sala, fila, columna, fecha, hora, precio, pelicula;

    public InformeEntradas(String id, String cine, String sala, String fila, String columna, String fecha, String hora, String precio, String pelicula) {
        this.id = id;
        this.cine = cine;
        this.sala = sala;
        this.fila = fila;
        this.columna = columna;
        this.fecha = fecha;
        this.hora = hora;
        this.precio = precio;
        this.pelicula = pelicula;
    }

    public String getId() {
        return id;
    }

    public String getCine() {
        return cine;
    }

    public String getSala() {
        return sala;
    }

    public String getFila() {
        return fila;
    }

    public String getColumna() {
        return columna;
    }

    public String getFecha() {
        return fecha;
    }

    public String getHora() {
        return hora;
    }

    public String getPrecio() {
        return precio;
    }

    public String getPelicula() {
        return pelicula;
    }
}
