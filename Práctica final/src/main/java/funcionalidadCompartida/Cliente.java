package funcionalidadCompartida;

public class Cliente {
    
    /**
     * Encapsula todos los datos que tienen los clientes.
     */

    private String nombre, apellidos,telefono, correo, contrasenya;

    public Cliente(String nombre, String apellidos, String telefono, String correo, String contrasenya) {
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.telefono = telefono;
        this.correo = correo;
        this.contrasenya = contrasenya;
    }

    public String getNombre() {
        return nombre;
    }

    public String getApellidos() {
        return apellidos;
    }

    public String getTelefono() {
        return telefono;
    }

    public String getCorreo() {
        return correo;
    }

    public String getContrasenya() {
        return contrasenya;
    }
}
