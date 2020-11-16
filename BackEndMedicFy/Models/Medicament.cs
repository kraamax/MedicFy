using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace BackEndMedicFy.Models
{
    public class Medicament
    {
        [Key]
        public int MedicamentId { get; set; }
        public string MedicamentName { get; set; }
        public string Units { get; set; }
        public Frequency Frequency { get; set; }
        public string Schedule { get; set; }
        public Duration Duration { get; set; }
    }
}