using Microsoft.EntityFrameworkCore;
namespace BackEndMedicFy.Models
{
public class ApiContext : DbContext
{
    public ApiContext(DbContextOptions<ApiContext> options) :
        base(options)
         {
    
         }
        public DbSet<Medicament> Medicaments { get; set; }
        public DbSet<Duration> Durations { get; set; }
        public DbSet<Frequency> Frequencies { get; set; }

}
}