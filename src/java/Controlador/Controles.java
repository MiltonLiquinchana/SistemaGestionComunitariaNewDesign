package Controlador;

import Dao.DAOComuneroImpl;
import Dao.DAOLoginImpl;
import Dao.DAOTipousuarioImpl;
import Modelo.Comunero;
import Modelo.Login;
import Modelo.Tipousuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author MiltonLQ
 */
public class Controles extends HttpServlet {

    /*creamos un objeto de daologinimpl para enviar los parametros para la conexion mediante la clase*/
    DAOLoginImpl daologinimpl;
    Login log;
    DAOComuneroImpl dAOComuneroImpl;
    DAOTipousuarioImpl dAOTipousuarioImpl;
    //Creamos un objeto de tipo prinwriter esto para poder imprimir el json, desde el servlet
    PrintWriter out = null;
    JSONObject json;
    JSONArray arrjson;

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

        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

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
                arrjson.putAll(json);
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
                    arrjson.putAll(json);
                }
                out.print(arrjson);
                out.close();
                json=null;
                arrjson=null;

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
                json=null;
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
                json=null;
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
                arrjson.putAll(json);
                out.print(arrjson);
                out.close();
                json=null;
                arrjson=null;
            } else if (lista.size() >= 1) {
                //creamos una istancia del objeto jsonArray
                arrjson = new JSONArray();
                for (Tipousuario tipousuario : lista) {//con un cliclo for recorremos la lista
                    //creamos una istancia del objeto jsonArray
                    json = new JSONObject();
                    json.put("pk_tipousuario", tipousuario.getPk_tipousuario());
                    json.put("tipo_usuario", tipousuario.getTipo_usuario());
                    arrjson.putAll(json);
                }
                out.print(arrjson);
                out.close();
                json=null;
                arrjson=null;

            }

        } catch (SQLException e) {
            System.out.println("Error no se a podido obtener los datos " + e.getMessage());
            out.close();
        }
    }

}
