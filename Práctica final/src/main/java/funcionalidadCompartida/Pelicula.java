package funcionalidadCompartida;

import java.util.ArrayList;

public class Pelicula {
    private String titulo, sinopsis, webOficial, tituloOriginal, genero,
            nacionalidad, distribuidora, director, otrosDatos;
            
    private Integer duracion, anyo, edadMinima;

    private ArrayList<String> actores;
    
    public Pelicula(String titulo, String sinopsis, String webOficial, String tituloOriginal, String genero, String nacionalidad, Integer duracion, Integer anyo, String distribuidora, String director, Integer edadMinima, String otrosDatos, ArrayList<String> actores) {
        this.titulo = titulo;
        this.sinopsis = sinopsis;
        this.webOficial = webOficial;
        this.tituloOriginal = tituloOriginal;
        this.genero = genero;
        this.nacionalidad = nacionalidad;
        this.duracion = duracion;
        this.anyo = anyo;
        this.distribuidora = distribuidora;
        this.director = director;
        this.edadMinima = edadMinima;
        this.otrosDatos = otrosDatos;
        this.actores = actores;
    }
    
    public String getTitulo() {
        return titulo;
    }

    public String getSinopsis() {
        return sinopsis;
    }

    public String getWebOficial() {
        return webOficial;
    }

    public String getTituloOriginal() {
        return tituloOriginal;
    }

    public String getGenero() {
        return genero;
    }

    public String getNacionalidad() {
        return nacionalidad;
    }

    public Integer getDuracion() {
        return duracion;
    }

    public Integer getAnyo() {
        return anyo;
    }

    public String getDistribuidora() {
        return distribuidora;
    }

    public String getDirector() {
        return director;
    }

    public Integer getEdadMinima() {
        return edadMinima;
    }
    
    public String getOtrosDatos() {
        return otrosDatos;
    }

    public ArrayList<String> getActores() {
        return actores;
    }

    @Override
    public String toString() {
        return "Pelicula{" + "titulo=" + titulo + ", sinopsis=" + sinopsis + ", webOficial=" + webOficial + ", tituloOriginal=" + tituloOriginal + ", genero=" + genero + ", nacionalidad=" + nacionalidad + ", distribuidora=" + distribuidora + ", director=" + director + ", otrosDatos=" + otrosDatos + ", duracion=" + duracion + ", anyo=" + anyo + ", edadMinima=" + edadMinima + ", actores=" + actores + '}';
    }
    
    
}


