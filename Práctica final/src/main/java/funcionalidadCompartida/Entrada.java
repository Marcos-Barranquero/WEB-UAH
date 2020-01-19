package funcionalidadCompartida;

public class Entrada {
    private String idEntrada;
    private int idProyeccion, fila, columna;
    private float precio;

    public Entrada(String idEntrada, int idProyeccion, int fila, int columna, float precio) {
        this.idEntrada = idEntrada;
        this.idProyeccion = idProyeccion;
        this.fila = fila;
        this.columna = columna;
        this.precio = precio;
    }

    public String getIdEntrada() {
        return idEntrada;
    }

    public int getIdProyeccion() {
        return idProyeccion;
    }

    public int getFila() {
        return fila;
    }

    public int getColumna() {
        return columna;
    }

    public float getPrecio() {
        return precio;
    }

    @Override
    public String toString() {
        return "Entrada{" + "idEntrada=" + idEntrada + ", idProyeccion=" + idProyeccion + ", fila=" + fila + ", columna=" + columna + ", precio=" + precio + '}';
    }
    
    
    
    

}
