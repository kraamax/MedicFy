    using BackEndMedicFy.Models;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.EntityFrameworkCore;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using System;
namespace MyWebApi.Controllers
{

[Route("api/[controller]")]
[ApiController]
public class MedicamentController : ControllerBase
    {
        private readonly ApiContext _context;
        public MedicamentController(ApiContext context)
        {
            _context = context;
            if(_context.Medicaments.Count()==0){
                Medicament medicament=new Medicament();
                medicament.MedicamentName="Acetaminofen";
                Frequency frecuency= new Frequency();
                frecuency.Type="Diariamente";
                frecuency.DaysNumber=0;
                medicament.Frequency=frecuency;
                medicament.Schedule="8:00AM;7:00AM";
                medicament.Units="Pastilla";
                _context.Medicaments.Add(medicament);
                Duration duration=new Duration();
                duration.FinalDate="";
                duration.InitialDate="8/10/2019";
                duration.haveFinalDate=false;
                medicament.Duration=duration;
                _context.SaveChanges();
            }
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Medicament>> GetMedicament(int id)
        {
            //prueba linq
            var medicament = await _context.Medicaments.FindAsync(id);
            if (medicament == null)
            {
                return NotFound();
            }
                return medicament;
        }
           [HttpGet]
        public async Task<ActionResult<IEnumerable<Medicament>>> GetMedicaments(int id)
        {
          return await _context.Medicaments.Include(e=>e.Frequency).Include(e=>e.Duration).ToListAsync();
        }


        // POST: api/Task
        [HttpPost]
        public async Task<ActionResult<Medicament>> PostMedicament(Medicament item)
        {
            _context.Medicaments.Add(item);
            await _context.SaveChangesAsync();
       
            return CreatedAtAction(nameof(GetMedicament), new { id = item.MedicamentId }, item);
        
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutMedicament(Medicament item)
        {
            Console.WriteLine(item.MedicamentId);
            _context.Entry(item.Duration).State = EntityState.Modified;
            _context.Entry(item.Frequency).State = EntityState.Modified;
            
            _context.Entry(item).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteMedicament(int id)
        {
            var medicament = await _context.Medicaments.Include(m=>m.Duration).Include(m=>m.Frequency).FirstOrDefaultAsync(m=>m.MedicamentId==id);
            if (medicament == null)
            {
                return NotFound();
            }
            _context.Frequencies.Remove(medicament.Frequency);
            _context.Durations.Remove(medicament.Duration);

            _context.Medicaments.Remove(medicament);
            await _context.SaveChangesAsync();
            return NoContent();
        }
    }
}
