using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using CL1.Models;


namespace CL1.Controllers
{
    public class FuenteController : Controller
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["cn"].ConnectionString);
        //Colecciones


   

        List<Cliente> ListCliente()
        {
            List<Cliente> aClientes = new List<Cliente>();
            cn.Open();
            SqlCommand cmd = new SqlCommand("SP_LISTACLIENTES", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                aClientes.Add(new Cliente()
                {
                    codigo = int.Parse(dr[0].ToString()),
                    nombre = dr[1].ToString(),
                    movil = dr[2].ToString(),
                    distrito = dr[3].ToString(),
                    correo = dr[4].ToString()
                });
            }
            dr.Close();
            cn.Close();
            return aClientes;
        }

        //BUSQUEDA PARA LA ACTUALIZACIÓN
        List<ClienteO> ListClienteO()
        {

            List<ClienteO> aClientes = new List<ClienteO>();
            cn.Open();
            SqlCommand cmd = new SqlCommand("SP_CLIENTES", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                aClientes.Add(new ClienteO()
                {
                    codigo = int.Parse(dr[0].ToString()),
                    nombre = dr[1].ToString(),
                    movil = dr[2].ToString(),
                    distrito = int.Parse(dr[3].ToString()),
                    correo = dr[4].ToString()
                });

            }

            dr.Close();
            cn.Close();
            return aClientes;
        }

        List<Distrito> ListDistrito()
        {

            List<Distrito> aDistritos = new List<Distrito>();
            cn.Open();
            SqlCommand cmd = new SqlCommand("SP_LISTARDISTRITO", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                aDistritos.Add(new Distrito()
                {
                    codigo = int.Parse(dr[0].ToString()),
                    nombre = dr[1].ToString()
                });

            }

            dr.Close();
            cn.Close();
            return aDistritos;
        }

        //Metodos para la generacion de vistas
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult listadoCliente()
        {
            return View(ListCliente());
        }

        public ActionResult nuevoCliente()
        {
            //Para el combobox
            ViewBag.distrito = new SelectList(ListDistrito(), "codigo", "nombre");
            return View(new ClienteO());
        }

        [HttpPost]
        public ActionResult nuevoCliente(ClienteO objC)
        {
            if (!ModelState.IsValid)
            {
                return View(objC);
            }
            cn.Open();
            ViewBag.mensaje = "";
            //Inicio de La transaccion
            SqlTransaction tr = cn.BeginTransaction(IsolationLevel.Serializable);
            try
            {
                SqlCommand cmd = new SqlCommand("SP_MANTENIMIENTOCLIENTE",cn,tr);
                //Parametros SQL @IDE,@NOM,@MOV,@DIS,@COR 
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IDE",objC.codigo);
                cmd.Parameters.AddWithValue("@NOM", objC.nombre);
                cmd.Parameters.AddWithValue("@MOV", objC.movil);
                cmd.Parameters.AddWithValue("@DIS", objC.distrito);
                cmd.Parameters.AddWithValue("@COR", objC.correo);
                int n = cmd.ExecuteNonQuery();
                //Asegurar que se registren
                tr.Commit();
                ViewBag.mensaje = n.ToString() + " Cliente Registrado";
            }
            catch (Exception ex)
            {
                //Recarga para el registro
                ViewBag.mensaje = ex.Message;
                tr.Rollback();
            }
            cn.Close();
            ViewBag.distrito = new SelectList(ListDistrito(), "codigo", "nombre",objC.distrito);
            return View(objC);
        }

        public ActionResult modificaCliente(int id)
        {
            //Metodo para la busqueda
            ClienteO objC = ListClienteO().Where(c => c.codigo == id).FirstOrDefault();
            ViewBag.distrito = new SelectList(ListDistrito(), "codigo", "nombre", objC.distrito);
            return View(objC);
           
        }

        [HttpPost]
        public ActionResult modificaCliente(ClienteO objC)
        {
            if (!ModelState.IsValid)
            {
                return View(objC);
            }
            cn.Open();
            ViewBag.mensaje = "";
            //Inicio de La transaccion
            SqlTransaction tr = cn.BeginTransaction(IsolationLevel.Serializable);
            try
            {
                SqlCommand cmd = new SqlCommand("SP_MANTENIMIENTOCLIENTE", cn, tr);
                //Parametros SQL @IDE,@NOM,@MOV,@DIS,@COR 
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IDE", objC.codigo);
                cmd.Parameters.AddWithValue("@NOM", objC.nombre);
                cmd.Parameters.AddWithValue("@MOV", objC.movil);
                cmd.Parameters.AddWithValue("@DIS", objC.distrito);
                cmd.Parameters.AddWithValue("@COR", objC.correo);
                int n = cmd.ExecuteNonQuery();
                //Asegurar que se registren
                tr.Commit();
                ViewBag.mensaje = n.ToString() + " Cliente Actualizado";
            }
            catch (Exception ex)
            {
                //Recarga para el registro
                ViewBag.mensaje = ex.Message;
                tr.Rollback();
            }
            cn.Close();
            ViewBag.distrito = new SelectList(ListDistrito(), "codigo", "nombre", objC.distrito);
            return View(objC);
        }

        public ActionResult detalleCliente(int id)
        {
            Cliente objE = ListCliente().Where(e => e.codigo == id).FirstOrDefault();
            return View(objE);
        }

        public ActionResult eliminaCliente(int id)
        {
            Cliente objC = ListCliente().Where(e => e.codigo == id).FirstOrDefault();
            List<SqlParameter> lista = new List<SqlParameter>() {
             new SqlParameter(){
                ParameterName="@IDE",
                SqlDbType=SqlDbType.Int,
                Value=objC.codigo }
            };

            CRUD("SP_ELIMINACLIENTE", lista);
            return RedirectToAction("listadoCliente");
        }

        void CRUD(String proceso, List<SqlParameter> pars)
        {
            cn.Open();
            try
            {
                SqlCommand cmd = new SqlCommand(proceso, cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddRange(pars.ToArray());
                cmd.ExecuteNonQuery();
            }
            catch (Exception)
            {
            }
            cn.Close();
        }

    }
}