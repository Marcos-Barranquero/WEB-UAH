/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author marco
 */
public class CalcularGanancia extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // Recojo nombre de coche y circuito:
        String cocheSeleccionado = request.getParameter("listaCoches");
        String circuitoSeleccionado = request.getParameter("listaCircuitos");

        // Extraigo kw del coche:
        Integer kwCoche = -1;
        try {

            Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/Practica6");
            ResultSet queryCoche = c.createStatement().executeQuery("SELECT COCHE.KWCURVA FROM COCHE WHERE COCHE.NOMBRE = '" + cocheSeleccionado + "'");
            queryCoche.next();
            kwCoche = queryCoche.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // Extraigo numero de vueltas y curvas del circuito:
        Integer vueltas = -1;
        Integer curvas = -1;
        try {

            Connection c = DriverManager.getConnection("jdbc:derby://localhost:1527/Practica6");
            ResultSet queryCircuito = c.createStatement().executeQuery("SELECT CIRCUITO.VUELTAS, CIRCUITO.CURVAS FROM CIRCUITO WHERE CIRCUITO.NOMBRE = '" + circuitoSeleccionado + "'");
            queryCircuito.next();
            vueltas = queryCircuito.getInt(1);
            curvas = queryCircuito.getInt(2);
        } catch (Exception e) {
            e.printStackTrace();
        }
        // calculo ganancia chunga
        Integer resultado = kwCoche * vueltas * curvas;


        // Instancia impresora para dar formato a la página 
        PrintWriter out = new PrintWriter(response.getOutputStream());

        // Se crea una pequeña página HTML
        out.println("<html>");
        
        out.println("<head>");
        out.println("<link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css\" crossorigin=\"anonymous\">");
        out.println("<script src=\"https://code.jquery.com/jquery-3.4.1.slim.min.js\" crossorigin=\"anonymous\"></script>");
        out.println("<script src=\"https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js\" crossorigin=\"anonymous\"></script>");
        out.println("<script src=\"https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js\" crossorigin=\"anonymous\"></script>");
        out.println("<meta charset=\"UTF-8\"><title>Resultado</title></head>");
        
        out.println("<body><br><br><br><div class=\"container\">");
        out.println("<h1>El resultado de la ganancia es de " + resultado + " kW</h1>");
        out.println("<br><br>");
        out.println("<h2>Calculado a partir de los siguientes datos</h2><br>");
        out.println("<p>El coche ahorra " + kwCoche + " kW en cada curva.</p>");
        out.println("<p>El circuito tiene " + curvas + " curvas</p>");
        out.println("<p>El circuito se completa en " + vueltas + " vueltas</p>");
        out.println("<br><br>");
        out.println("<button type=\"button\" class=\"btn btn-primary\" onclick=\"window.location.href = 'calculador.jsp';\">Calcular de nuevo</button>");
        out.println("<button type=\"button\" class=\"btn btn-secondary\" onclick=\"window.location.href = 'index.html';\">Volver a inicio</button>");
        out.println("</div>");
        out.println("<br><br><br><footer class=\"footer\">");
        out.println("<div class=\"container text-center\">");
        out.println("<p>Practica 6 - Marcos Barranquero y Daniel Manzano | Arquitectura y Diseno de Sistemas Web y C/S, 2019</p>");
        out.println("</div></footer></body></html>");
        out.close();
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
