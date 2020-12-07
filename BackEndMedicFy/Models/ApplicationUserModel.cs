using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BackEndMedicFy.Models
{
    public class ApplicationUserModel
    {
        public string Name { get; set; }
        public string BornDate { get; set; }
        public string Sex { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
    }
}
