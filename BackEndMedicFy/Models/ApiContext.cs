using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
namespace BackEndMedicFy.Models
{
public class ApiContext : IdentityDbContext
{
    public ApiContext(DbContextOptions<ApiContext> options) :
        base(options)
         {
    
         }
        public DbSet<Medicament> Medicaments { get; set; }
        public DbSet<Duration> Durations { get; set; }
        public DbSet<Frequency> Frequencies { get; set; }
        public DbSet<ApplicationUser> ApplicationUsers{ get; set; }

}
}