package funcionalidadCompartida;

public class Sala {
    private String nombre, cine;
    private Integer filas, columnas;

    public Sala(String nombre, String cine, int filas, int columnas) {
        this.nombre = nombre;
        this.filas = filas;
        this.columnas = columnas;
        this.cine = cine;
    }

    public String getNombre() {
        return nombre;
    }

    public Integer getFilas() {
        return filas;
    }

    public Integer getColumnas() {
        return columnas;
    }

    public String getCine() {
        return cine;
    }
}