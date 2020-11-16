using System.ComponentModel.DataAnnotations;
namespace BackEndMedicFy.Models
{
    public class Duration
    {
        [Key]
        public int DurationId { get; set; }
        public string InitialDate { get; set; }
        public bool haveFinalDate { get; set; }
        public string FinalDate { get; set; }
    }
}