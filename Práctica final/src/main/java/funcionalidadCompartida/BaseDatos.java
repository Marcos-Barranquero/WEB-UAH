package funcionalidadCompartida;

import java.sql.*;
import java.time.Duration;
import java.time.LocalTime;
import java.util.ArrayList;

public class BaseDatos {

    private Connection conexion;
    private Statement consulta;
    private ResultSet resultado;

    /**
     * Abre la conexión con la base de datos.
     */
    public void abrirConexion() {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conexion = DriverManager.getConnection("jdbc:derby://localhost:1527/BBDDPECLF");
            System.out.println("Se ha conectado");
        } catch (Exception e) {
            System.out.println("No se ha conectado:" + e.toString());
        }
    }

    // INSERTS__________________________________________________________________
    /**
     * Inserta un CLIENTE.
     *
     * @param nombre - Nombre del cliente
     * @param apellidos - Apellidos
     * @param telefono - Nº de teléfono (es VARCHAR(9) en la BD)
     * @param correo - Correo electrónico
     * @param password - Contraseña
     */
    public void insertarCliente(String nombre, String apellidos, String telefono, String correo, String password) {
        String query = "INSERT INTO CLIENTE VALUES("
                + "'" + nombre + "', "
                + "'" + apellidos + "', "
                + "'" + telefono + "', "
                + "'" + correo + "', "
                + "'" + password + "')";
        try {
            consulta = conexion.createStatement();
            consulta.executeUpdate(query);
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error al insertar en CLIENTE: ");
            e.printStackTrace();
        }
    }

    /**
     * Inserta un ACTOR.
     *
     * @param actor - Nombre del actor.
     */
    public void insertarActor(String actor) {
        try {
            consulta = conexion.createStatement();
            consulta.executeUpdate("INSERT INTO ACTOR VALUES ('" + actor + "')");
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error al insertar en ACTOR: ");
            e.printStackTrace();
        }
    }

    /**
     * Inserta una PELICULA.
     *
     * @param pelicula - Objeto del tipo Pelicula
     */
    public void insertarPelicula(Pelicula pelicula) {

        String query;

        // Se crea la sentencia que inserta la PELICULA
        if (pelicula.getOtrosDatos().equals("")) {
            // Si no tiene el campo otros_datos
            query = "INSERT INTO PELICULA VALUES ("
                    + "'" + pelicula.getTitulo() + "', "
                    + "'" + pelicula.getSinopsis() + "', "
                    + "'" + pelicula.getWebOficial() + "', "
                    + "'" + pelicula.getTituloOriginal() + "', "
                    + "'" + pelicula.getGenero() + "', "
                    + "'" + pelicula.getNacionalidad() + "', "
                    + pelicula.getDuracion() + ", "
                    + pelicula.getAnyo() + ", "
                    + "'" + pelicula.getDistribuidora() + "', "
                    + "'" + pelicula.getDirector() + "', "
                    + pelicula.getEdadMinima() + ", null)";
        } else {
            // Si tiene el campo otros_datos
            query = "INSERT INTO PELICULA VALUES ("
                    + "'" + pelicula.getTitulo() + "', "
                    + "'" + pelicula.getSinopsis() + "', "
                    + "'" + pelicula.getWebOficial() + "', "
                    + "'" + pelicula.getTituloOriginal() + "', "
                    + "'" + pelicula.getGenero() + "', "
                    + "'" + pelicula.getNacionalidad() + "', "
                    + pelicula.getDuracion() + ", "
                    + pelicula.getAnyo() + ", "
                    + "'" + pelicula.getDistribuidora() + "', "
                    + "'" + pelicula.getDirector() + "', "
                    + pelicula.getEdadMinima() + ", "
                    + "'" + pelicula.getOtrosDatos() + "')";
        }

        ArrayList<String> actores = pelicula.getActores();

        try {
            consulta = conexion.createStatement();
            consulta.executeUpdate(query);
            consulta.close();

            // Se actualiza la relación ACTUA_EN
            String nombrePelicula = pelicula.getTitulo();
            for (int i = 0; i < actores.size(); i++) {
                insertarActuaEn(actores.get(i), nombrePelicula);
            }
        } catch (Exception e) {
            System.out.println("Error insertando en PELICULA: ");
            e.printStackTrace();
        }
    }

    /**
     * Inserta en la relación ACTUA_EN. Así, se puede especificar qué actor
     * aparece en qué película.
     *
     * @param nombreActor - Nombre del actor
     * @param nombrePelicula - Nombre de la película en la que actúa
     */
    public void insertarActuaEn(String nombreActor, String nombrePelicula) {
        try {
            consulta = conexion.createStatement();
            consulta.executeUpdate("INSERT INTO ACTUA_EN VALUES ('" + nombreActor + "'," + "'" + nombrePelicula + "')");
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error insertando en ACTUA_EN: ");
            e.printStackTrace();
        }
    }

    /**
     * Inserta una PROYECCION.
     *
     * @param proyeccion - Objeto del tipo Proyección
     */
    public void insertarProyeccion(Proyeccion proyeccion) {
        String query = "INSERT INTO PROYECCION VALUES("
                + proyeccion.getIdProyeccion() + ", "
                + "'" + proyeccion.getNombreCine() + "', "
                + proyeccion.getIdSala() + ", "
                + "'" + proyeccion.getHoraProyeccion() + "', "
                + "'" + proyeccion.getFechaProyeccion() + "', "
                + "'" + proyeccion.getNombrePelicula() + "', "
                + proyeccion.getPrecio() + ")";
        try {
            consulta = conexion.createStatement();
            consulta.executeUpdate(query);
            consulta.close();

        } catch (Exception e) {
            System.out.println("Error insertando en PROYECCION: ");
            System.out.println("Query: " + query);
            e.printStackTrace();
        }

        crearSitios(proyeccion.getIdProyeccion());
    }

    /**
     * Analiza una SALA y ejecuta un método para registrar sus sitios.
     *
     * @param idProyeccion - ID de la proyección donde se quiere añadir sitios
     */
    public void crearSitios(int idProyeccion) {
        // obtengo filas y columnas
        int filas = -1;
        int columnas = -1;
        String query = "SELECT filas, columnas FROM sala INNER JOIN proyeccion ON "
                + "proyeccion.ID_SALA = sala.ID_SALA WHERE proyeccion.ID_PROYECCION = " + idProyeccion + "";

        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery(query);
            resultado.next();
            filas = resultado.getInt("filas");
            columnas = resultado.getInt("columnas");

            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error recuperando filas y columnas al crear sitios: ");
            e.printStackTrace();
        }

        // Creo los sitios vacíos
        for (int fila = 1; fila <= filas; fila++) {
            for (int columna = 1; columna <= columnas; columna++) {
                crearSitio(fila, columna, idProyeccion);
            }
        }

    }

    /**
     * Inserta los sitios. Es utilizado por el método crearSitios.
     *
     * @param fila - Fila en la que se encuentra el sitio
     * @param columna - Columna en la que se encuentra el sitio
     * @param idProyeccion - Proyección en la que se utilizará el sitio
     */
    public void crearSitio(int fila, int columna, int idProyeccion) {
        String query = "INSERT INTO SITIO VALUES("
                + fila + ", "
                + columna + ", "
                + idProyeccion + ", "
                + "false, null, false)";
        try {
            consulta = conexion.createStatement();
            consulta.executeUpdate(query);
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error insertando SITIO: ");
            e.printStackTrace();
        }
    }

    /**
     * Inserta un COMENTARIO.
     *
     * @param comentario - Objeto del tipo Comentario
     */
    public void insertarComentario(Comentario comentario) {
        try {
            consulta = conexion.createStatement();
            consulta.executeUpdate("INSERT INTO COMENTARIO VALUES ("
                    + "'" + comentario.getCorreo() + "', "
                    + "'" + comentario.getPelicula() + "', "
                    + comentario.getPuntuacion() + ", "
                    + "'" + comentario.getComentario() + "')");
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error al insertar COMENTARIO: ");
            e.printStackTrace();
        }
    }

    /**
     * Inserta una SALA.
     *
     * @param nombreCine - Nombre del cine en el que se encuentra
     * @param numeroSala - Número de sala dentro de ese cine
     */
    private void insertarSala(String nombreCine, int numeroSala) {
        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery("SELECT MAX(ID_SALA) AS MAXIMO FROM SALA");

            int idSala = -1;
            while (resultado.next()) {
                idSala = resultado.getInt("MAXIMO") + 1;
            }
            // Si no hay ninguna sala, se crea la primerita
            if (idSala == -1) {
                idSala = 1;
            }

            consulta.executeUpdate("INSERT INTO SALA VALUES(" + idSala + ",8,10," + numeroSala + ",'" + nombreCine + "')");
            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error insertando en SALA: ");
            e.printStackTrace();
        }

    }

    /**
     * Inserta un CINE.
     *
     * @param nombre - Nombre del cine
     * @param cantidadSalas - Cantidad de salas que tiene
     */
    public void insertarCine(String nombre, int cantidadSalas) {
        try {
            consulta = conexion.createStatement();
            consulta.executeUpdate("INSERT INTO CINE VALUES ('" + nombre + "')");
            consulta.close();
            for (int i = 1; i <= cantidadSalas; i++) {
                insertarSala(nombre, i);
            }
        } catch (Exception e) {
            System.out.println("Error al insertar en CINE: ");
            e.printStackTrace();
        }
    }

    // DELETES__________________________________________________________________
    /**
     * Elimina un COMENTARIO.
     *
     * @param correo - Correo del usuario que lo ha escrito
     * @param pelicula - Película comentada
     */
    public void eliminarComentario(String correo, String pelicula) {
        try {
            consulta = conexion.createStatement();
            consulta.executeUpdate("DELETE FROM COMENTARIO WHERE correo='" + correo + "' AND nombre_pelicula='" + pelicula + "'");
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error eliminando en COMENTARIO: ");
            e.printStackTrace();
        }
    }

    /**
     * Elimina un CLIENTE.
     *
     * @param correo - Correo del usuario a eliminar
     */
    public void eliminarCliente(String correo) {
        try {
            consulta = conexion.createStatement();
            consulta.executeUpdate("DELETE FROM CLIENTE WHERE correo='" + correo + "'");
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error eliminando en CLIENTE: ");
            e.printStackTrace();
        }
    }

    /**
     * Elimina una PELICULA (y de la relación "ACTUA_EN).
     *
     * @param nombrePelicula - Nombre de la película a borrar
     */
    public void eliminarPelicula(String nombrePelicula) {
        try {
            consulta = conexion.createStatement();
            consulta.executeUpdate("DELETE FROM ACTUA_EN WHERE (nombre_pelicula = '" + nombrePelicula + "')");
            consulta.close();
            consulta = conexion.createStatement();
            consulta.executeUpdate("DELETE FROM PELICULA WHERE (nombre_pelicula = '" + nombrePelicula + "')");
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error al eliminar en PELICULA (o en ACTUA_EN): ");
            e.printStackTrace();
        }
    }

    /**
     * Elimina un ACTOR (y de la relación "ACTUA_EN").
     *
     * @param nombreActor - Nombre del actor a borrar
     */
    public void eliminarActor(String nombreActor) {
        try {
            consulta = conexion.createStatement();
            consulta.executeUpdate("DELETE FROM ACTUA_EN WHERE (nombre_actor = '" + nombreActor + "')");
            consulta.close();
            consulta = conexion.createStatement();
            consulta.executeUpdate("DELETE FROM ACTOR WHERE (nombre_actor = '" + nombreActor + "')");
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error eliminando en ACTOR (o en ACTUA_EN): ");
            e.printStackTrace();
        }
    }

    /**
     * Elimina un CINE.
     *
     * @param cine - Nombre del cine a borrar
     */
    public void eliminarCine(String cine) {
        try {
            consulta = conexion.createStatement();
            consulta.executeUpdate("DELETE FROM CINE WHERE (nombre_cine = '" + cine + "')");
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error eliminando en CINE: ");
            e.printStackTrace();
        }
    }

    /**
     * Elimina una SALA.
     *
     * @param idSala - ID de la sala a borrar
     */
    public void eliminarSala(Integer idSala) {
        try {
            consulta = conexion.createStatement();
            consulta.executeUpdate("DELETE FROM SALA WHERE (id_sala = " + idSala + ")");
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error eliminando en SALA: ");
            e.printStackTrace();
        }
    }

    // SELECTS__________________________________________________________________
    /**
     * Devuelve un ArrayList con los títulos de las películas.
     *
     * @return - ArrayList de String
     */
    public ArrayList<String> getTodasLasPeliculas() {
        ArrayList<String> peliculas = new ArrayList<>();
        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery("SELECT nombre_pelicula FROM PELICULA");

            while (resultado.next()) {
                peliculas.add(resultado.getString("nombre_pelicula"));
            }

            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error recuperando todas las peliculas: ");
            e.printStackTrace();
        }
        return peliculas;
    }

    /**
     * Devuelve un ArrayList que contiene las películas ordenadas por género.
     *
     * @return - ArrayList de Pelicula
     */
    public ArrayList<Pelicula> getPeliculasPorGenero() {
        ArrayList<Pelicula> peliculas = new ArrayList<>();
        Pelicula p;

        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery("SELECT * FROM PELICULA ORDER BY genero ASC");

            while (resultado.next()) {
                p = new Pelicula(resultado.getString(1), resultado.getString(2), resultado.getString(3), resultado.getString(4), resultado.getString(5), resultado.getString(6), resultado.getInt(7), resultado.getInt(8), resultado.getString(9), resultado.getString(10), resultado.getInt(11), resultado.getString(12), null);
                peliculas.add(p);
            }

            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error recuperando peliculas: ");
            e.printStackTrace();
        }
        return peliculas;
    }

    /**
     * Devuelve un ArrayList con información de los clientes registrados que
     * tienen entradas compradas.
     *
     * @return - ArrayList de InformeClientes
     */
    public ArrayList<InformeClientes> getClientesConEntrada() {
        ArrayList<InformeClientes> informe = new ArrayList();
        InformeClientes cliente;
        String query = "SELECT CLIENTE.NOMBRE, CLIENTE.APELLIDOS, CLIENTE.CORREO, TMP.NUM_ENTRADAS "
                + "FROM CLIENTE INNER JOIN (SELECT CORREO, count(ID_ENTRADA) AS NUM_ENTRADAS "
                + "FROM CLIENTE_TIENE_ENTRADA GROUP BY CORREO) AS TMP ON CLIENTE.CORREO = TMP.CORREO";
        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery(query);

            while (resultado.next()) {
                cliente = new InformeClientes(resultado.getString(1), resultado.getString(2), resultado.getString(3), resultado.getString(4));
                informe.add(cliente);
            }

            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error recuperando el informe: ");
            e.printStackTrace();
        }
        return informe;
    }

    /**
     * Devuelve un ArrayList con información de las entradas vendidas.
     *
     * @return - ArrayList de InformeEntradas
     */
    public ArrayList<InformeEntradas> getEntradasVendidas() {
        ArrayList<InformeEntradas> informe = new ArrayList();
        InformeEntradas infoEntrada;
        String query = "SELECT ENTRADA.ID_ENTRADA, PROYECCION.NOMBRE_CINE, "
                + "SALA.NUMERO_SALA, ENTRADA.FILA, ENTRADA.COLUMNA, "
                + "PROYECCION.FECHA, PROYECCION.HORA, ENTRADA.PRECIO, "
                + "PROYECCION.NOMBRE_PELICULA "
                + "FROM ENTRADA INNER JOIN PROYECCION "
                + "ON ENTRADA.ID_PROYECCION=PROYECCION.ID_PROYECCION "
                + "INNER JOIN SALA ON PROYECCION.ID_SALA=SALA.ID_SALA";
        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery(query);

            while (resultado.next()) {
                infoEntrada = new InformeEntradas(resultado.getString(1), resultado.getString(2), resultado.getString(3), resultado.getString(4), resultado.getString(5), resultado.getString(6), resultado.getString(7), resultado.getString(8), resultado.getString(9));
                informe.add(infoEntrada);
            }

            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error recuperando el informe: ");
            e.printStackTrace();
        }
        return informe;
    }

    public ArrayList<Sala> getInformeSalas() {
        ArrayList<Sala> salas = new ArrayList<>();
        Sala s;

        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery("SELECT * FROM PELICULA ORDER BY genero ASC");
            /**
             * while (resultado.next()) { s = new Sala(nombre, cine, 0, 0);
             * peliculas.add(p); }
             */
            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error recuperando peliculas: ");
            e.printStackTrace();
        }
        return salas;
    }

    /**
     * Devuelve el número de salas que tiene un CINE.
     *
     * @param nombreCine - Nombre del cine
     * @return - int con el número de salas
     */
    public int getNumeroSalas(String nombreCine) {
        int numeroSalas = -1;
        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery("SELECT count(ID_SALA) AS cantidad_salas FROM SALA WHERE nombre_cine='" + nombreCine + "' GROUP BY NOMBRE_CINE");
            if (resultado.next()) {
                numeroSalas = resultado.getInt("cantidad_salas");
            } else {
                numeroSalas = 0;
            }
            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error recuperando numero de salas: ");
            e.printStackTrace();
        }
        return numeroSalas;
    }

    /**
     * Devuelve un ArrayList con el nombre de los cines.
     *
     * @return - ArrayList de String
     */
    public ArrayList<String> getCines() {
        ArrayList<String> cines = new ArrayList<>();
        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery("SELECT nombre_cine FROM CINE");

            while (resultado.next()) {
                cines.add(resultado.getString("nombre_cine"));
            }

            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error recuperando todos los cines: ");
            e.printStackTrace();
        }

        return cines;
    }

    /**
     * Recupera una butaca y comprueba si está reservada u ocupada. Si está
     * reservada pero no se ha vendido y han pasado más de 10 minutos, se marca
     * como disponible.
     *
     * @param fila - Fila en la que se encuentra
     * @param columna - Columna en la que se encuentra
     * @param idProyeccion - ID de la proyección en la que se está comprobando
     * @return - Objeto del tipo Butaca
     */
    public Butaca recuperarButaca(int fila, int columna, int idProyeccion) {
        Butaca devuelta = null;
        String query = "SELECT * FROM SITIO WHERE (fila = " + fila + " and columna = "
                + columna + " and id_proyeccion = " + idProyeccion + ")";
        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery(query);
            resultado.next();

            boolean reservado = resultado.getBoolean("reservado");
            boolean ocupado = resultado.getBoolean("ocupado");

            Time horaReserva = resultado.getTime("hora_reserva");

            devuelta = new Butaca(fila, columna, idProyeccion, reservado, ocupado, horaReserva);

            // Cierro consulta
            resultado.close();
            consulta.close();

            // Si está reservado, verifico reserva
            if (!ocupado && reservado) {

                LocalTime horaDeReserva = horaReserva.toLocalTime();

                LocalTime ahoraMismo = LocalTime.now();

                int diferenciaEnMinutos = (int) Duration.between(horaDeReserva, ahoraMismo).toMinutes();
                System.out.println("Diferencia: " + diferenciaEnMinutos);
                // Si ha expirado la reserva, desreservo la butaca independientemente de su estado
                if (diferenciaEnMinutos > 10 || diferenciaEnMinutos < -10) {
                    System.out.println("Quito la reserva a la butaca (" + fila + ", " + columna + ")");
                    devuelta.setReservada(false);
                    devuelta.setHoraReserva(null);
                    reescribirButaca(devuelta);
                }
            }

        } catch (Exception e) {
            System.out.println("Error recuperando butaca: ");
            e.printStackTrace();
        }

        return devuelta;
    }

    /**
     * Devuelve un ArrayList con los nombres de los actores que actúan en una
     * película.
     *
     * @param nombrePelicula - Nombre de la película
     * @return - ArrayList de String
     */
    public ArrayList<String> getActoresPelicula(String nombrePelicula) {
        ArrayList<String> actores = new ArrayList<>();
        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery("SELECT nombre_actor FROM ACTUA_EN WHERE (nombre_pelicula = '" + nombrePelicula + "')");

            while (resultado.next()) {
                actores.add(resultado.getString("nombre_actor"));
            }

            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error recuperando actor: ");
            e.printStackTrace();
        }

        return actores;
    }

    /**
     * Devuelve una película dado su nombre.
     *
     * @param nombrePelicula - Nombre de la película
     * @return - Objeto del tipo Pelicula
     */
    public Pelicula recuperarPelicula(String nombrePelicula) {
        Pelicula devuelta = null;
        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery("SELECT * FROM PELICULA WHERE (nombre_pelicula = '" + nombrePelicula + "')");
            resultado.next();

            String sinopsis = resultado.getString("sinopsis");
            String pagina_oficial = resultado.getString("pagina_oficial");
            String titulo_original = resultado.getString("titulo_original");
            String genero = resultado.getString("genero");
            String nacionalidad = resultado.getString("nacionalidad");
            int duracion = resultado.getInt("duracion");
            int anyo = resultado.getInt("anyo");
            String distribuidora = resultado.getString("distribuidora");
            String director = resultado.getString("director");
            int clasificacion_edad = resultado.getInt("clasificacion_edad");
            String otros_datos = resultado.getString("otros_datos");

            // Recupero actores            
            ArrayList<String> actores = getActoresPelicula(nombrePelicula);
            // Creo película y la devuelvo
            devuelta = new Pelicula(nombrePelicula, sinopsis, pagina_oficial,
                    titulo_original, genero, nacionalidad, duracion, anyo,
                    distribuidora, director, clasificacion_edad, otros_datos, actores);

            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error recuperando pelicula: ");
            e.printStackTrace();
        }
        return devuelta;
    }

    /**
     * Devuelve un ArrayList con los nombres de los actores.
     *
     * @return - ArrayList de String
     */
    public ArrayList<String> recuperarTodosLosActores() {
        ArrayList<String> actores = new ArrayList<>();
        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery("SELECT nombre_actor FROM ACTOR");

            while (resultado.next()) {
                String nombre = resultado.getString("nombre_actor");
                if (nombre != null && !nombre.equals("null")) {
                    actores.add(nombre);
                }
            }

            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error recuperando actor: ");
            e.printStackTrace();
        }
        return actores;
    }

    /**
     * Devuelve un ArrayList con todos los comentarios de la base de datos. Así,
     * el administrador puede revisarlos todos en el mismo lugar.
     *
     * @return - ArrayList de Comentario
     */
    public ArrayList<Comentario> getTodosLosComentarios() {
        ArrayList<Comentario> comentarios = new ArrayList<>();
        Comentario c;
        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery("SELECT * FROM COMENTARIO");

            while (resultado.next()) {
                c = new Comentario(resultado.getString(1), resultado.getString(2), resultado.getInt(3), resultado.getString(4));
                comentarios.add(c);
            }

            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error recuperando todas las peliculas: ");
            e.printStackTrace();
        }
        return comentarios;
    }

    /**
     * Devuelve todos los clientes.
     *
     * @return - ArrayList de Cliente
     */
    public ArrayList<Cliente> getTodosLosClientes() {
        ArrayList<Cliente> clientes = new ArrayList<>();
        Cliente c;
        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery("SELECT * FROM CLIENTE");

            while (resultado.next()) {
                c = new Cliente(resultado.getString(1), resultado.getString(2), resultado.getString(3), resultado.getString(4), resultado.getString(5));
                clientes.add(c);
            }

            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error recuperando todas las peliculas: ");
            e.printStackTrace();
        }
        return clientes;
    }

    /**
     * Devuelve los comentarios de una película.
     *
     * @param pelicula - Nombre de la película
     * @return - ArrayList de Comentario
     */
    public ArrayList<Comentario> getComentarios(String pelicula) {
        ArrayList<Comentario> comentarios = new ArrayList<>();
        Comentario coment;
        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery("SELECT * FROM COMENTARIO "
                    + "WHERE nombre_pelicula='" + pelicula + "'");

            while (resultado.next()) {
                coment = new Comentario(resultado.getString(1), resultado.getString(2), resultado.getInt(3), resultado.getString(4));
                comentarios.add(coment);
            }
            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error recuperando comentarios: ");
            e.printStackTrace();
        }
        return comentarios;
    }

    /**
     * Devuelve el nombre y apellidos de un cliente dado su correo.
     *
     * @param correo - Correo del cliente
     * @return - String con el nombre y los apellidos concatenados
     */
    public String getNombreCliente(String correo) {
        String nombreApellido = "";
        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery("SELECT nombre, apellidos FROM CLIENTE "
                    + "WHERE correo='" + correo + "'");

            while (resultado.next()) {
                nombreApellido = resultado.getString(1) + " " + resultado.getString(2);
            }
            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error recuperando el nombre del cliente: ");
            e.printStackTrace();
        }
        return nombreApellido;
    }

    // Otros métodos____________________________________________________________
    /**
     * Comprueba si los datos de acceso son correctos.
     *
     * @param correo - Correo proporcionado por el cliente
     * @param contrasenya - Contraseña proporcionada por el cliente
     * @return - TRUE si están bien, FALSE si no
     */
    public boolean loginCliente(String correo, String contrasenya) {
        boolean login = false;

        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery("SELECT * FROM CLIENTE "
                    + "WHERE correo='" + correo + "' AND contrasenya='" + contrasenya + "'");
            if (resultado.next()) {
                login = true;
            }
            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("No ha podido leer la tabla.");
        }
        return login;
    }

    /**
     * Comprueba si existe un cliente dado su correo.
     *
     * @param correo - Correo del cliente
     * @return - TRUE si existe, FALSE si no
     */
    public boolean existeCliente(String correo) {
        boolean existe = false;

        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery("SELECT * FROM CLIENTE "
                    + "WHERE correo='" + correo + "'");
            if (resultado.next()) {
                existe = true;
            }
            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("No ha podido leer la tabla.");
        }
        return existe;
    }

    /**
     * Comprueba si existe un comentario de un cliente en una película.
     *
     * @param correo - Correo del cliente
     * @param pelicula - Película donde se quiere comprobar
     * @return - TRUE si existe, FALSE si no
     */
    public boolean existeComentario(String correo, String pelicula) {
        boolean existe = false;
        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery("SELECT * FROM COMENTARIO  "
                    + "WHERE correo='" + correo + "' AND nombre_pelicula='" + pelicula + "'");
            if (resultado.next()) {
                existe = true;
            }
            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("No ha podido leer la tabla.");
        }
        return existe;
    }

    /**
     * Comprueba si existe un cliente registrado ha visto una película.
     *
     * @param correo - Correo del cliente
     * @param pelicula - Película
     * @return - TRUE si existe, FALSE si no
     */
    public boolean haVisto(String correo, String pelicula) {
        boolean visto = false;
        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery("SELECT CLIENTE_TIENE_ENTRADA.CORREO, PROYECCION.NOMBRE_PELICULA FROM CLIENTE_TIENE_ENTRADA "
                    + "INNER JOIN ENTRADA ON CLIENTE_TIENE_ENTRADA.ID_ENTRADA=ENTRADA.ID_ENTRADA "
                    + "INNER JOIN PROYECCION ON ENTRADA.ID_PROYECCION=PROYECCION.ID_PROYECCION "
                    + "WHERE CLIENTE_TIENE_ENTRADA.CORREO='" + correo + "' "
                    + "AND PROYECCION.NOMBRE_PELICULA='" + pelicula + "'");
            if (resultado.next()) {
                visto = true;
            }
            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("No ha podido leer la tabla.");
        }
        return visto;
    }

    /**
     * Comprueba si existe un actor.
     *
     * @param nombre - Nombre del actor
     * @return - TRUE si existe, FALSE si no
     */
    public boolean existeActor(String nombre) {
        boolean existe = false;
        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery("SELECT * FROM ACTOR "
                    + "WHERE nombre_actor='" + nombre + "'");
            if (resultado.next()) {
                existe = true;
            }
            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("No ha podido leer la tabla.");
        }
        return existe;
    }

    /**
     * Comprueba si existe un CINE.
     *
     * @param nombre - Nombre del cine
     * @return - TRUE si existe, FALSE si no
     */
    public boolean existeCine(String nombre) {
        boolean existe = false;
        String cad;
        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery("SELECT * FROM CINE");
            while (resultado.next()) {
                cad = resultado.getString("nombre_cine");
                cad = cad.trim();
                if (cad.compareTo(nombre.trim()) == 0) {
                    existe = true;
                }
            }
            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("No ha podido leer la tabla.");
        }
        return existe;
    }

    /**
     * Comprueba si existe una PELICULA.
     *
     * @param nombre - Nombre de la película
     * @return - TRUE si existe, FALSE si no
     */
    public boolean existePelicula(String nombre) {
        boolean existe = false;
        String cad;
        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery("SELECT * FROM PELICULA");
            while (resultado.next()) {
                cad = resultado.getString("nombre_pelicula");
                cad = cad.trim();
                if (cad.compareTo(nombre.trim()) == 0) {
                    existe = true;
                }
            }
            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("No ha podido leer la tabla.");
        }
        return existe;
    }

    /**
     * Devuelve el ID de una sala dado el nombre del cine y el número de sala
     * dentro de ese cine.
     *
     * @param nombreCine - Cine donde se encuentra la sala
     * @param numeroSala - Número de sala dentro de ese cine
     * @return
     */
    public int getidSala(String nombreCine, int numeroSala) {
        int idSala = -1;
        String query = "SELECT id_sala FROM SALA WHERE (sala.NOMBRE_CINE = '" + nombreCine + "' and sala.NUMERO_SALA=" + numeroSala + ")";
        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery(query);
            while (resultado.next()) {
                idSala = resultado.getInt("id_sala");
            }
            // Si no hay ninguna proyeccion, creo la primera
            if (idSala == -1) {
                idSala = 1;
            }

            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error obteniendo el ultimo id de sala: ");
            e.printStackTrace();
        }
        return idSala;
    }

    /**
     * Las salas tienen un ID único que las diferencia, y va por orden. Este
     * método devuelve el ID más alto como ayuda al crear nuevas salas.
     *
     * @return - int con el valor del ID
     */
    public int getMaxIdProyeccion() {
        int idProyeccion = -1;
        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery("SELECT MAX(ID_PROYECCION) AS MAXIMO FROM PROYECCION");
            while (resultado.next()) {
                idProyeccion = resultado.getInt("MAXIMO");
            }
            // Si no hay ninguna proyeccion, creo la primera
            if (idProyeccion == -1) {
                idProyeccion = 1;
            }

            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error obteniendo el ultimo id de proyección: ");
            e.printStackTrace();
        }
        return idProyeccion;
    }

    /**
     * Devuelve el precio que costarán las entradas de una proyección.
     *
     * @param idProyeccion - ID de la proyección
     * @return - float con el precio
     */
    public float getPrecioProyeccion(int idProyeccion) {
        float precio = -1;
        String query = "select precio from proyeccion where id_proyeccion = " + idProyeccion;
        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery(query);
            while (resultado.next()) {
                precio = resultado.getFloat("PRECIO");
            }

            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error obteniendo el precio de la proyección: ");
            e.printStackTrace();
        }
        return precio;
    }

    /**
     * Devuelve la fecha de una proyección.
     *
     * @param idProyeccion - ID de la proyección
     * @return - Date con la fecha
     */
    public Date getFechaProyeccion(int idProyeccion) {
        Date fecha = null;
        String query = "select fecha from proyeccion where id_proyeccion = " + idProyeccion;
        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery(query);
            while (resultado.next()) {
                fecha = resultado.getDate("fecha");
            }

            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error obteniendo el precio de la proyección: ");
            e.printStackTrace();
        }
        return fecha;
    }

    /**
     * Devuelve el nombre de la película que se proyecta en una proyección.
     *
     * @param idProyeccion - ID de la proyección
     * @return - String con el nombre de la película
     */
    public String getNombrePelicula(int idProyeccion) {
        String nombrePelicula = "";
        String query = "select nombre_pelicula from proyeccion where id_proyeccion = " + idProyeccion;
        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery(query);
            while (resultado.next()) {
                nombrePelicula = resultado.getString("nombre_pelicula");
            }

            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error obteniendo el nombre de la pelicula: ");
            e.printStackTrace();
        }
        return nombrePelicula;
    }

    /**
     * Crea una entrada para los clientes que no quieran registrarse.
     *
     * @param fila - Fila de la butaca
     * @param columna - Columna de la butaca
     * @param idProyeccion - ID de la proyección a la que asistirá
     * @return - String con el ID de la entrada creada
     */
    public String crearEntradaNoRegistrada(int fila, int columna, int idProyeccion) {
        // alta entrada
        String idEntrada = "E" + idProyeccion + fila + columna;
        float precio = getPrecioProyeccion(idProyeccion);
        String query = "insert into entrada values('" + idEntrada + "',"
                + idProyeccion + ", "
                + fila + ", "
                + columna + ", "
                + precio + ")";

        try {
            consulta = conexion.createStatement();
            consulta.executeUpdate(query);
            consulta.close();

        } catch (Exception e) {
            System.out.println("Error al insertar en ENTRADA: ");
            e.printStackTrace();
        }
        // actualizar butaca a ocupada
        Butaca aActualizar = recuperarButaca(fila, columna, idProyeccion);

        aActualizar.setOcupada(true);

        reescribirButaca(aActualizar);

        return idEntrada;
    }

    /**
     * Crea una entrada para los clientes que no quieran registrarse.
     *
     * @param fila - Fila de la butaca
     * @param columna - Columna de la butaca
     * @param idProyeccion - ID de la proyección a la que asistirá
     * @param correoCliente - Correo del cliente que compra la entrada
     */
    public void crearEntradaRegistrada(int fila, int columna, int idProyeccion, String correoCliente) {
        // Creo entrada
        String idEntrada = crearEntradaNoRegistrada(fila, columna, idProyeccion);

        // y la linkeo al cliente
        String query = "insert into CLIENTE_TIENE_ENTRADA values("
                + "'" + correoCliente + "', "
                + "'" + idEntrada + "')";
        try {
            consulta = conexion.createStatement();
            consulta.executeUpdate(query);
            consulta.close();

        } catch (Exception e) {
            System.out.println("Error al asociar entrada y cliente: ");
            e.printStackTrace();
        }
    }

    /**
     * Devuelve la entrada asociada a una butaca en una proyección
     *
     * @param fila - Fila de la butaca
     * @param columna - Columna de la butaca
     * @param idProyeccion - ID de la proyección
     * @return - Objeto del tipo Entrada
     */
    public Entrada recuperarEntrada(int fila, int columna, int idProyeccion) {
        Entrada devuelta = null;
        String query = "SELECT * FROM ENTRADA WHERE "
                + "fila = " + fila
                + " and columna = " + columna
                + " and id_proyeccion = " + idProyeccion;

        try {
            consulta = conexion.createStatement();
            resultado = consulta.executeQuery(query);
            while (resultado.next()) {
                String idEntrada = resultado.getString("id_entrada");
                float precio = resultado.getFloat("precio");
                devuelta = new Entrada(idEntrada, idProyeccion, fila, columna, precio);
            }
            resultado.close();
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error leyendo entrada:");
            e.printStackTrace();
        }
        return devuelta;

    }

    /**
     * Actualiza la información de una butaca. Sirve para marcarla como
     * reservada u ocupada, y para dejarla libre si se ha cancelado su compra.
     *
     * @param butaca - Butaca a editar
     */
    public void reescribirButaca(Butaca butaca) {
        String hora = "null";
        String query = "";
        if (butaca.getHoraReserva() != null) {
            hora = butaca.getHoraReserva().toString();
            query = "UPDATE sitio SET reservado = " + butaca.isReservada()
                    + ", ocupado = " + butaca.isOcupada() + ", hora_reserva = '" + hora
                    + "' WHERE fila = " + butaca.getFila() + " AND columna ="
                    + butaca.getColumna() + "AND id_proyeccion =" + butaca.getIdProyeccion();
        } else {
            query = "UPDATE sitio SET reservado = " + butaca.isReservada()
                    + ", ocupado = " + butaca.isOcupada() + ", hora_reserva = null "
                    + "WHERE fila = " + butaca.getFila() + " AND columna ="
                    + butaca.getColumna() + "AND id_proyeccion =" + butaca.getIdProyeccion();
        }

        try {
            consulta = conexion.createStatement();
            consulta.executeUpdate(query);
            consulta.close();
        } catch (Exception e) {
            System.out.println("Error al actualizar butaca: ");
            e.printStackTrace();
        }

    }

    // _________________________________________________________________________
    /**
     * Cierra la conexión
     */
    public void cerrarConexion() {
        try {
            conexion.close();
        } catch (Exception e) {
        }
    }
}
