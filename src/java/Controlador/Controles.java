package Controlador;

import Dao.DAOComuneroImpl;
import Dao.DAOLimiteDias;
import Dao.DAOLoginImpl;
import Dao.DAOMedidorImpl;
import Dao.DAOTipoConsumoImpl;
import Dao.DAOTipousuarioImpl;
import Modelo.Comunero;
import Modelo.Consumo;
import Dao.DAOConsumoImpl;
import Modelo.LimiteDias;
import Modelo.Login;
import Modelo.Medidor;
import Modelo.TipoConsumo;
import Modelo.Tipousuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;
import org.json.JSONArray;
import org.json.JSONObject;

@MultipartConfig//ponemos esto para que nos permita obtener datos mediante formdata
public class Controles extends HttpServlet {

    Login log;
    Comunero comunero;
    Consumo consumo;
    TipoConsumo tipoconsumo;
    LimiteDias limiteDias;
    /*creamos un objeto de daologinimpl para enviar los parametros para la conexion mediante la clase*/
    DAOLoginImpl daologinimpl;
    DAOComuneroImpl dAOComuneroImpl;
    DAOTipousuarioImpl dAOTipousuarioImpl;
    DAOMedidorImpl dAOMedidorImpl;
    DAOConsumoImpl dAOConsumoImpl;
    DAOTipoConsumoImpl dAOTipoConsumoImpl;
    DAOLimiteDias dAOLimiteDias;
    //Creamos un objeto de tipo prinwriter esto para poder imprimir el json, desde el servlet
    PrintWriter out = null;
    JSONObject json;
    JSONArray arrjson;
    boolean respuesta;//para poder obtener respuesta si se logro hacer la insercion
    //Variables generales para obtener los datos del formulario RegistroSocios
    String accion, cedula, primer_nombre, segundo_nombre, primer_apellido, segundo_Apellido, telefono, fecha_nacimiento,
            direccion_vivienda, referencia_geografica, usuario, Contrasenia;
    int pk_comuner, edad, fk_comuna, fk_tipousuario;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String user = String.valueOf(session.getAttribute("user"));
        String passw = String.valueOf(session.getAttribute("passw"));
        if (!user.equals("null") && !passw.equals("null")) {
            inicioSecion(request, response, user, passw);
        } else if (user.equals("null") || passw.equals("null")) {
            inicioSecion(request, response, user, passw);
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        switch (accion) {
            case "IniciarSesion":
                //leemos la entrada de datos resividos
                String user = request.getParameter("user");
                String passw = request.getParameter("passw");
                inicioSecion(request, response, user, passw);
                break;
            case "CerrarSesion":
                try {
                HttpSession session = request.getSession();
                session.invalidate();
                out = response.getWriter();
                json = new JSONObject();
                json.put("estateLogin", "LogOut");
                out.print(json);
                out.close();
                json = null;

            } catch (IOException e) {
                System.out.println("a sucedido un error " + e.getMessage());
            }
            break;
            case "cargarSocios":
                buscarRegistros(request, response);
                break;
            case "editarSocio":
                buscarRegistroSocio(request, response);
                break;
            case "listarTipoUsuarios":
                listarTipoUsuario(request, response);
                break;
            case "Guardar":
                guardarRegistroSocio(request, response);
                break;

            case "Actualizar":
                actualizarRegistroSocio(request, response);
                break;
            case "Eliminar":
                //System.out.println("Eliminando datos de usuario");
                eliminarRegistroSocio(request, response);
                break;
            case "buscarSocioConsumo":
                buscarSocioConsumo(request, response);
                break;
            case "buscarUltimoConsumo":
                buscarUltimoConsumoMedidor(request, response);
                break;
            case "ListarTipoConsumo":
                listarTipoConsumo(request, response);
                break;
            case "buscarFechaLimite":
                buscarDiasLimite(request, response);
                break;
            case "guardarConsumo":
                guardarConsumo(request, response);
                break;
            case "ListConsumoImpaga":
                listarConsumosImpaga(request, response);
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    //este metodo nos sirve para verificar el inicio de secion
    private void inicioSecion(HttpServletRequest request, HttpServletResponse response, String user, String passw) throws IOException {

        try {
            out = response.getWriter();
            //creamos una objeto para almacenar los datos recividos
            log = new Login();
            //ejecutamos el metodo que consulta el usuario y contraseña
            daologinimpl = new DAOLoginImpl();
            //asignamos lo devuelto a un nuevo objeto
            log = daologinimpl.listar(user, passw);
            if (log == null) {
                HttpSession session = request.getSession();
                session.invalidate();
                json = new JSONObject();
                json.put("error", "error");
                out.print(json);
                out.close();
                json = null;
            } else if (log != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", log.getUsuario());
                session.setAttribute("passw", log.getContrasenia());
                session.setAttribute("pk_comunidad", log.getComunero().getComuna().getPk_comuna());
                json = new JSONObject();
                //agregamos propiedades al json
                json.put("pk_login", log.getPk_login());
                json.put("usuario", log.getUsuario());
                json.put("contraseña", log.getContrasenia());
                json.put("pk_tipousuario", log.getTipoUsuario().getPk_tipousuario());
                json.put("tipo_usuario", log.getTipoUsuario().getTipo_usuario());
                json.put("pk_comunero", log.getComunero().getPk_comunero());
                json.put("primer_nombre", log.getComunero().getPrimer_nombre());
                json.put("segundo_nombre", log.getComunero().getSegundo_nombre());
                json.put("primer_apellido", log.getComunero().getPrimer_apellido());
                json.put("segundo_apellido", log.getComunero().getSegundo_apellido());
                json.put("pk_comuna", log.getComunero().getComuna().getPk_comuna());
                json.put("nombre_comuna", log.getComunero().getComuna().getNombre_comuna());
                out.print(json);
                out.close();
                json = null;
            }

        } catch (SQLException e) {
            System.out.println("Error no se a podido obtener los datos " + e.getMessage());
            out.close();
        }
    }

    //este metodo tiene como proposito buscar los datos de la BD buscando solo los que pertenecen a cierta comunidad
    private void buscarRegistros(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            //creamoun objeto con el cual vamos a imprimir el resultado a json
            out = response.getWriter();
            //creamos la instancia de la clase que ejecuta la consulta
            dAOComuneroImpl = new DAOComuneroImpl();
            //creamos una lista tipo Comunero para agregar lo resicivido 
            List<Comunero> lista = null;//primero vaciamos la lista
            /*creamos un bojeto de secion para obtener el id de la comuna*/
            HttpSession session = request.getSession();
            lista = dAOComuneroImpl.listar(Integer.parseInt(String.valueOf(session.getAttribute("pk_comunidad"))));//llenamos la lista con los parametros recividos
            //comprobamos que la lista no este vacia
            if (lista.size() <= 0) {
                //creamos una istancia del objeto jsonArray, aqui le ponemos con el proposito de que se aga iterable para verificar en el js 
                arrjson = new JSONArray();
                json = new JSONObject();
                json.put("error", "error");
                arrjson.put(json);
                out.print(arrjson);
                out.close();
                json = null;
                arrjson = null;
            } else if (lista.size() >= 1) {
                //creamos una istancia del objeto jsonArray
                arrjson = new JSONArray();
                for (Comunero comunero : lista) {//con un cliclo for recorremos la lista
                    //creamos una istancia del objeto jsonArray
                    json = new JSONObject();
                    json.put("pk_comunero", comunero.getPk_comunero());
                    json.put("cedula", comunero.getCedula());
                    json.put("primer_nombre", comunero.getPrimer_nombre());
                    json.put("segundo_nombre", comunero.getSegundo_nombre());
                    json.put("primer_apellido", comunero.getPrimer_apellido());
                    json.put("segundo_apellido", comunero.getSegundo_apellido());
                    json.put("telefono", comunero.getTelefono());
                    json.put("edad", comunero.getEdad());
                    arrjson.put(json);
                }
                out.print(arrjson);
                out.close();
                json = null;
                arrjson = null;

            }

        } catch (SQLException e) {
            System.out.println("Error no se a podido obtener los datos " + e.getMessage());
            out.close();
        }
    }

    //esta metodo se encarga de buscar los datos de un comunero por su id
    private void buscarRegistroSocio(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String Id = request.getParameter("id_comunero");
            //creamoun objeto con el cual vamos a imprimir el resultado a json
            out = response.getWriter();
            //creamos la instancia de la clase que ejecuta la consulta
            daologinimpl = new DAOLoginImpl();
            //creamos una instancia para guardar los datos de la consulta(login)
            log = new Login();
            log = daologinimpl.listarID(Integer.parseInt(Id));//llenamos el objeto con los parametros recividos
            //log = daologinimpl.listarID();//llenamos el objeto con los parametros recividos
            //comprobamos que la lista no este vacia
            if (log == null) {
                //creamos una instancia del objeto json
                json = new JSONObject();
                json.put("error", "error");
                out.print(json);
                out.close();
                json = null;
            } else if (log != null) {
                //creamos una istancia del objeto jsonArray
                json = new JSONObject();
                json.put("cedula", log.getComunero().getCedula());
                json.put("primer_nombre", log.getComunero().getPrimer_nombre());
                json.put("segundo_nombre", log.getComunero().getSegundo_nombre());
                json.put("primer_apellido", log.getComunero().getPrimer_apellido());
                json.put("segundo_apellido", log.getComunero().getSegundo_apellido());
                json.put("telefono", log.getComunero().getTelefono());
                json.put("direccion_vivienda", log.getComunero().getDireccion_vivienda());
                json.put("referencia_geografica", log.getComunero().getReferencia_geografica());
                json.put("nombre_comuna", log.getComunero().getComuna().getNombre_comuna());
                json.put("fecha_nacimiento", log.getComunero().getFecha_nacimiento());
                json.put("edad", log.getComunero().getEdad());
                json.put("usuario", log.getUsuario());
                json.put("contrasenia", log.getContrasenia());
                json.put("pk_tipousuario", log.getTipoUsuario().getPk_tipousuario());
                out.print(json);
                out.close();
                json = null;
            }
        } catch (SQLException e) {
            System.out.println("Error no se a podido obtener los datos " + e.getMessage());
            out.close();
        }
    }

    /*esta metodo se encarga de listar los tipos de usuarior y estos almacenarlos en una cookie
    con javascript se revisa si existe solo se rellena desde la cookie caso contrario se llena desde aqui
     */
    private void listarTipoUsuario(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            //creamoun objeto con el cual vamos a imprimir el resultado a json
            out = response.getWriter();
            //creamos la instancia de la clase que ejecuta la consulta
            dAOTipousuarioImpl = new DAOTipousuarioImpl();
            //creamos una lista tipo Tipousuario para agregar lo resicivido 
            List<Tipousuario> lista = null;//primero vaciamos la lista
            lista = dAOTipousuarioImpl.listar();//llenamos la lista con los parametros recividos
            //comprobamos que la lista no este vacia
            if (lista.size() <= 0) {
                //creamos una istancia del objeto jsonArray, aqui le ponemos con el proposito de que se aga iterable para verificar en el js 
                arrjson = new JSONArray();
                json = new JSONObject();
                json.put("error", "error");
                arrjson.put(json);
                out.print(arrjson);
                out.close();
                json = null;
                arrjson = null;
            } else if (lista.size() >= 1) {
                //creamos una istancia del objeto jsonArray
                arrjson = new JSONArray();
                for (Tipousuario tipousuario : lista) {//con un cliclo for recorremos la lista
                    //creamos una istancia del objeto jsonArray
                    json = new JSONObject();
                    json.put("pk_tipousuario", tipousuario.getPk_tipousuario());
                    json.put("tipo_usuario", tipousuario.getTipo_usuario());
                    arrjson.put(json);
                }
                out.print(arrjson);
                out.close();
                json = null;
                arrjson = null;

            }

        } catch (SQLException e) {
            System.out.println("Error no se a podido obtener los datos " + e.getMessage());
            out.close();
        }
    }

    /*este metodo sirve para crear un nuevo registro en la BD del comunero*/
    private void guardarRegistroSocio(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            accion = request.getParameter("accion");
            cedula = request.getParameter("cedula");
            primer_nombre = request.getParameter("pNombre");
            segundo_nombre = request.getParameter("sNombre");
            primer_apellido = request.getParameter("pApellido");
            segundo_Apellido = request.getParameter("sApellido");
            telefono = request.getParameter("nTelefono");
            fecha_nacimiento = request.getParameter("fechNacimiento");
            direccion_vivienda = request.getParameter("direccion");
            referencia_geografica = request.getParameter("refGeografica");
            usuario = request.getParameter("nUsuario");
            Contrasenia = request.getParameter("contrasenia");
            edad = Integer.parseInt(request.getParameter("edad"));
            HttpSession session = request.getSession();
            fk_comuna = Integer.parseInt(String.valueOf(session.getAttribute("pk_comunidad")));//esto se obtiene desde la session
            fk_tipousuario = Integer.parseInt(request.getParameter("tipoUsuario"));
            respuesta = dAOComuneroImpl.registrarEditarEliminar(accion, 1, cedula, primer_nombre, segundo_nombre, primer_apellido, segundo_Apellido, telefono, fecha_nacimiento, edad, fk_comuna, direccion_vivienda, referencia_geografica, usuario, Contrasenia, fk_tipousuario);
            //System.out.println(respuesta);
            //creamoun objeto con el cual vamos a imprimir el resultado a json
            out = response.getWriter();
            json = new JSONObject();//creamos una instancia de  la clase json          
            if (respuesta) {
                json.put("message", "Error");//asignamos el mensaje correspondire true si no se guardo, false si se guardo
            } else {
                json.put("message", "Completado");//asignamos el mensaje correspondire true si no se guardo, false si se guardo
            }
            //mandamos el json
            out.print(json);
            out.close();//cerramos la imprecion
            json = null;//limpiamos el json
        } catch (SQLException e) {
            System.out.println("Error no se a podido procesar la peticion " + e.getMessage());
            out.close();
        }
    }

    /*este metodo sirve para actualizar los registros de un socio en la BD*/
    private void actualizarRegistroSocio(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            accion = request.getParameter("accion");
            pk_comuner = Integer.parseInt(request.getParameter("pk_comuner"));
            cedula = request.getParameter("cedula");
            primer_nombre = request.getParameter("pNombre");
            segundo_nombre = request.getParameter("sNombre");
            primer_apellido = request.getParameter("pApellido");
            segundo_Apellido = request.getParameter("sApellido");
            telefono = request.getParameter("nTelefono");
            fecha_nacimiento = request.getParameter("fechNacimiento");
            direccion_vivienda = request.getParameter("direccion");
            referencia_geografica = request.getParameter("refGeografica");
            usuario = request.getParameter("nUsuario");
            Contrasenia = request.getParameter("contrasenia");
            edad = Integer.parseInt(request.getParameter("edad"));
            HttpSession session = request.getSession();
            fk_comuna = Integer.parseInt(String.valueOf(session.getAttribute("pk_comunidad")));//esto se obtiene desde la session
            fk_tipousuario = Integer.parseInt(request.getParameter("tipoUsuario"));
            respuesta = dAOComuneroImpl.registrarEditarEliminar(accion, pk_comuner, cedula, primer_nombre, segundo_nombre, primer_apellido, segundo_Apellido, telefono, fecha_nacimiento, edad, fk_comuna, direccion_vivienda, referencia_geografica, usuario, Contrasenia, fk_tipousuario);
            System.out.println(respuesta);
            //creamoun objeto con el cual vamos a imprimir el resultado a json
            out = response.getWriter();
            json = new JSONObject();//creamos una instancia de  la clase json          
            if (respuesta) {
                json.put("message", "Error");//asignamos el mensaje correspondire true si no se guardo, false si se guardo
            } else {
                json.put("message", "Completado");//asignamos el mensaje correspondire true si no se guardo, false si se guardo
            }
            //mandamos el json
            out.print(json);
            out.close();//cerramos la imprecion
            json = null;//limpiamos el json
        } catch (SQLException e) {
            System.out.println("Error no se a podido procesar la peticion " + e.getMessage());
            out.close();
        }
    }

    /*este metodo sirve para eliminar un registro enrealidad solo lo desabilita*/
    private void eliminarRegistroSocio(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            accion = request.getParameter("accion");
            pk_comuner = Integer.parseInt(request.getParameter("pk_comuner"));
            respuesta = dAOComuneroImpl.registrarEditarEliminar(accion, pk_comuner, "", "", "", "", "", "", "2021-01-18", 1, 1, "", "", "", "", 1);
            System.out.println(respuesta);
            //creamoun objeto con el cual vamos a imprimir el resultado a json
            out = response.getWriter();
            json = new JSONObject();//creamos una instancia de  la clase json          
            if (respuesta) {
                json.put("message", "Error");//asignamos el mensaje correspondire true si no se guardo, false si se guardo
            } else {
                json.put("message", "Completado");//asignamos el mensaje correspondire true si no se guardo, false si se guardo
            }
            //mandamos el json
            out.print(json);
            out.close();//cerramos la imprecion
            json = null;//limpiamos el json
        } catch (SQLException e) {
            System.out.println("Error no se a podido procesar la peticion " + e.getMessage());
            out.close();
        }
    }

    /*este metodo sirve para buscar los datos basicos del comunero y sus numeros de medidor*/
    private void buscarSocioConsumo(HttpServletRequest request, HttpServletResponse response) throws IOException {

        try {
            //creamoun objeto con el cual vamos a imprimir el resultado a json
            out = response.getWriter();
            String dato = request.getParameter("dato");
            dAOComuneroImpl = new DAOComuneroImpl();
            comunero = new Comunero();
            comunero = dAOComuneroImpl.consultaComuneroCedula(dato);
            arrjson = new JSONArray();
            //obtenemos el listado de los numeros de medidor
            List<Medidor> lista = null;
            dAOMedidorImpl = new DAOMedidorImpl();
            lista = dAOMedidorImpl.listar(dato);
            //System.out.println(lista.size());
            if (comunero == null || lista.size() <= 0) {
                json = new JSONObject();
                json.put("error", "error");
                arrjson.put(json);
            }
            if (comunero != null) {
                json = new JSONObject();
                //agregamos propiedades al json
                json.put("pk_comunero", comunero.getPk_comunero());
                json.put("cedula", comunero.getCedula());
                json.put("primer_nombre", comunero.getPrimer_nombre());
                json.put("segundo_nombre", comunero.getSegundo_nombre());
                json.put("primer_apellido", comunero.getPrimer_apellido());
                json.put("segundo_apellido", comunero.getSegundo_apellido());
                arrjson.put(json);
            }
            if (lista.size() >= 1) {
                for (Medidor medidor : lista) {
                    json = new JSONObject();
                    json.put("pk_medidor", medidor.getPk_medidor());
                    json.put("numero_medidor", medidor.getNumero_medidor());
                    arrjson.put(json);
                }
            }
            out.print(arrjson);
            out.close();
            json = null;
            arrjson = null;
        } catch (SQLException e) {
            System.out.println("Error no se a podido obtener los datos " + e.getMessage());
            out.close();
        }
    }

    /*este metodo sirve para buscar el ultimo consumo registrado del medidor*/
    private void buscarUltimoConsumoMedidor(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int pk_medidor = Integer.parseInt(request.getParameter("pk_medidor"));
            out = response.getWriter();
            consumo = new Consumo();
            dAOConsumoImpl = new DAOConsumoImpl();
            consumo = dAOConsumoImpl.consultarUltimoConsumoMedidor(pk_medidor);
            if (consumo.getLectura_anterior() == null) {
                json = new JSONObject();
                json.put("error", "error");
            } else if (consumo.getLectura_anterior() != null) {
                json = new JSONObject();
                json.put("lectura_anterior", consumo.getLectura_anterior());
            }
            out.print(json);
            out.close();
            json = null;
        } catch (SQLException e) {
            System.out.println("Error no se a podido obtener los datos " + e.getMessage());
            out.close();
        }

    }

    /*este metodo nos sive para definir el tipo de consumo dependiendo de cuanto consumio*/
    private void listarTipoConsumo(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            //creamos un objeto para la imprecion
            out = response.getWriter();
            //creamos un objeto de tipo json para parsear el objeto de tipo consumo
            //recuperamos el valor enviado desde el formulario
            int valor = Integer.parseInt(request.getParameter("valor"));
            tipoconsumo = new TipoConsumo();
            dAOTipoConsumoImpl = new DAOTipoConsumoImpl();
            HttpSession session = request.getSession();
            tipoconsumo = dAOTipoConsumoImpl.listarTipoConsumo(Integer.parseInt(String.valueOf(session.getAttribute("pk_comunidad"))), valor);
            if (tipoconsumo == null) {
                json = new JSONObject();
                json.put("error", "error");

            } else if (tipoconsumo != null) {
                json = new JSONObject();
                json.put("pk_tipoconsumo", tipoconsumo.getPk_tipoconsumo());
                json.put("tipoConsumo", tipoconsumo.getTipo_consumo());
                double totalpagar = 0;
                if (valor <= tipoconsumo.getLimitem_cubico() && tipoconsumo.getTarifa_basica() > 0) {
                    totalpagar = tipoconsumo.getTarifa_basica();
                }
                if (valor > tipoconsumo.getLimitem_cubico() && tipoconsumo.getTarifa_basica() > 1) {
                    totalpagar = Double.valueOf(valor) * tipoconsumo.getValor();
                }
                if (valor <= tipoconsumo.getLimitem_cubico() && tipoconsumo.getTarifa_basica() < 1) {
                    totalpagar = Double.valueOf(valor) * tipoconsumo.getValor();
                }
                if (valor > tipoconsumo.getLimitem_cubico() && tipoconsumo.getTarifa_basica() < 1) {
                    totalpagar = Double.valueOf(valor) * tipoconsumo.getValor();
                }
                json.put("totalPagar", totalpagar);
            }
            out.print(json);
            out.close();
            json = null;

        } catch (SQLException e) {
            System.out.println("Error no se a podido obtener los datos " + e.getMessage());
            out.close();
        }
    }

    /*este metodo sirve para consulta el limite de dias para pagar este valor se agrega a la fecha actual*/
    private void buscarDiasLimite(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {

            out = response.getWriter();
            limiteDias = new LimiteDias();
            dAOLimiteDias = new DAOLimiteDias();
            HttpSession session = request.getSession();
            limiteDias = dAOLimiteDias.buscarLimiteDias(Integer.parseInt(String.valueOf(session.getAttribute("pk_comunidad"))));
            if (limiteDias == null) {
                json = new JSONObject();
                json.put("error", "error");
            } else if (limiteDias != null) {
                json = new JSONObject();
                json.put("LimiteDias", limiteDias.getLimiteDias());
            }
            out.print(json);
            out.close();
            json = null;

        } catch (Exception e) {
        }
    }

    /*este metodo sive para guardar los datos del consumo*/
    private void guardarConsumo(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            out = response.getWriter();
            /*recuperamos lo enviado desde el fomrulario*/
            int lectura_ante, lectura_actual, consumo_mcubic, fk_medido, fk_tipoconsumo;
            String fecha_lectu, fecha_limit;
            double total_pag;
            lectura_ante = Integer.parseInt(request.getParameter("lecturaAnterior"));
            lectura_actual = Integer.parseInt(request.getParameter("lecturaActual"));
            consumo_mcubic = Integer.parseInt(request.getParameter("conumoCubico"));
            fk_medido = Integer.parseInt(request.getParameter("numMedidor"));
            fk_tipoconsumo = Integer.parseInt(request.getParameter("tipoConsumo"));
            fecha_lectu = request.getParameter("fechaRegistro");
            fecha_limit = request.getParameter("fechaLimite");
            total_pag = Double.parseDouble(request.getParameter("totalPagar"));
            dAOConsumoImpl = new DAOConsumoImpl();
            respuesta = dAOConsumoImpl.registrar(lectura_ante, lectura_actual, fecha_lectu, fecha_limit, consumo_mcubic, total_pag, fk_medido, fk_tipoconsumo);
            System.out.println(respuesta);
            json = new JSONObject();//creamos una instancia de  la clase json          
            if (respuesta) {
                json.put("message", "Error");//asignamos el mensaje correspondire true si no se guardo, false si se guardo
            } else {
                json.put("message", "Completado");//asignamos el mensaje correspondire true si no se guardo, false si se guardo
            }
            out.print(json);
            out.close();
            json = null;
        } catch (SQLException e) {
            System.out.println("Error no se a podido procesar la peticion " + e.getMessage());
            out.close();
        }

    }

    private void listarConsumosImpaga(HttpServletRequest request, HttpServletResponse response) throws IOException {

        try {
            out = response.getWriter();
            int pk_medidor = Integer.parseInt(request.getParameter("fk_medidor"));
            List<Consumo> lista = null;
            dAOConsumoImpl = new DAOConsumoImpl();
            lista = dAOConsumoImpl.ListarConsumoImpaga(pk_medidor);
            arrjson = new JSONArray();
            if (lista.size() <= 0) {
                json = new JSONObject();
                json.put("error", "error");
                arrjson.put(json);
            } else {
                for (Consumo consumo : lista) {
                    json = new JSONObject();
                    json.put("pk_consumo", consumo.getPk_consumo());
                    json.put("fecha_lectura", consumo.getFecha_lectura());
                    arrjson.put(json);
                }
            }

            out.print(arrjson);
            out.close();
            json = null;
            arrjson = null;
        } catch (SQLException e) {
            System.out.println("Error no se a podido obtener los datos " + e.getMessage());
            out.close();
        }
    }

}
