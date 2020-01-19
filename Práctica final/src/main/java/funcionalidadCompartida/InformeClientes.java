package funcionalidadCompartida;

public class InformeClientes {
    private String nombre, apellidos, correo, totalEntradas;

    public InformeClientes(String nombre, String apellidos, String correo, String totalEntradas) {
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.correo = correo;
        this.totalEntradas = totalEntradas;
    }

    public String getNombre() {
        return nombre;
    }

    public String getApellidos() {
        return apellidos;
    }

    public String getCorreo() {
        return correo;
    }

    public String getTotalEntradas() {
        return totalEntradas;
    }
    
}
