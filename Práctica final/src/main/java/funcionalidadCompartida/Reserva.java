package funcionalidadCompartida;

public class Reserva {
    private Integer idReserva;
    private String correo;

    public Reserva(Integer idReserva, String correo) {
        this.idReserva = idReserva;
        this.correo = correo;
    }

    public Integer getIdReserva() {
        return idReserva;
    }

    public String getCorreo() {
        return correo;
    }
}
