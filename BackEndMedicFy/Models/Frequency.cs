using System.ComponentModel.DataAnnotations;
namespace BackEndMedicFy.Models
{
    public class Frequency
    {
        [Key]
        public int FrequencyId { get; set; }
        public string Type { get; set; }
        public int DaysNumber { get; set; }
    }
}