using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace CL1.Models
{
    public class Cliente
    {

        public int codigo { get; set; }


        public string nombre { get; set; }


        public string movil { get; set; }


        public string distrito { get; set; }


        public string correo { get; set; }

    }
}