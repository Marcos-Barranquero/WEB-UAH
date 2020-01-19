package funcionalidadCompartida;

public class Comentario {
    private String correo, pelicula, comentario;
    private Integer puntuacion;

    public Comentario(String correo, String pelicula, Integer puntuacion, String comentario) {
        this.correo = correo;
        this.pelicula = pelicula;
        this.puntuacion = puntuacion;
        this.comentario = comentario;
    }

    public String getCorreo() {
        return correo;
    }

    public String getPelicula() {
        return pelicula;
    }

    public Integer getPuntuacion() {
        return puntuacion;
    }

    public String getComentario() {
        return comentario;
    }
}