/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class SegundoServlet extends HttpServlet {
    String nombre;

    public void service(HttpServletRequest peticion, HttpServletResponse respuesta)
            throws ServletException, IOException {
        // Recogemos parámetro nombre del formulario y lo guardamos en una string
        nombre = peticion.getParameter("NOMBRE");

        // Escribimos html mostrando el nombre:
        ServletOutputStream out = respuesta.getOutputStream();
        out.println("<html>");
        out.println("<head><title>HolaTalServlet</title></head>");
        out.println("<body>");
        out.println("<p><h1><center>Su nombre es: <B>" + nombre + "</B></center></h1></p>");
        out.println("</body></html>");
        out.close();
    }
}