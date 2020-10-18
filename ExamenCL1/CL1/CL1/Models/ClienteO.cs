using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace CL1.Models
{
    public class ClienteO
    {
        [DisplayName("Codigo del Cliente")]
        public int codigo { get; set; }



        [DisplayName("Nombre del Cliente")]
        [Required(ErrorMessage = "Ingrese el Nombre del Cliente")]
        public string nombre { get; set; }



        [DisplayName("Movil del Cliente")]
        [Required(ErrorMessage = "Ingrese el Movil del Cliente")]
        public string movil { get; set; }



        [DisplayName("Nombre del distrito")]
        [Required(ErrorMessage = "Ingrese el distrito")]
        public int distrito { get; set; }



        [DisplayName("Nombre del correo")]
        [Required(ErrorMessage = "Ingrese el correo")]
        public string correo { get; set; }
    }
}