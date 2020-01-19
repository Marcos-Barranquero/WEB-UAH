/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package funcionalidadCompartida;

import java.sql.Time;

/**
 *
 * @author marco
 */
public class Butaca {

    private int fila, columna;
    private int idProyeccion;
    private boolean reservada;
    private boolean ocupada;
    private Time horaReserva;

    public Butaca(int fila, int columna, int idProyeccion, boolean reservada, boolean ocupada, String x,String y) {
        this.fila = fila;
        this.columna = columna;
        this.idProyeccion = idProyeccion;
        this.reservada = reservada;
        this.ocupada = ocupada;
        this.horaReserva = null;
        
    }

    public Butaca(int fila, int columna, int idProyeccion, boolean reservada, boolean ocupada, Time horaReserva) {
        this.fila = fila;
        this.columna = columna;
        this.idProyeccion = idProyeccion;
        this.reservada = reservada;
        this.ocupada = ocupada;
        this.horaReserva = horaReserva;
    }

    public int getFila() {
        return fila;
    }

    public int getColumna() {
        return columna;
    }

    public int getIdProyeccion() {
        return idProyeccion;
    }

    public boolean isReservada() {
        return reservada;
    }

    public boolean isOcupada() {
        return ocupada;
    }

    @Override
    public String toString() {
        String hora = "null";
        if(horaReserva!= null)
        {
            hora = horaReserva.toString();
        }
        return "Butaca{" + "fila=" + fila + ", columna=" + columna + ", idProyeccion=" + idProyeccion + ", reservada=" + reservada + ", ocupada=" + ocupada + ", horaReserva=" + hora + '}';
    }


    

    public Time getHoraReserva() {
        return horaReserva;
    }

    public void setFila(int fila) {
        this.fila = fila;
    }

    public void setColumna(int columna) {
        this.columna = columna;
    }

    public void setIdProyeccion(int idProyeccion) {
        this.idProyeccion = idProyeccion;
    }

    public void setReservada(boolean reservada) {
        this.reservada = reservada;
    }

    public void setOcupada(boolean ocupada) {
        this.ocupada = ocupada;
    }

    public void setHoraReserva(Time horaReserva) {
        this.horaReserva = horaReserva;
    }
    
    
    
    

}
