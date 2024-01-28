using Microsoft.AspNetCore.Mvc;
using DAL.Interfaces;
using DAL.Models;

namespace API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CountryController : ControllerBase
    {
        private readonly ICountryRepository _countryRepository;

        public CountryController(ICountryRepository countryRepository)
        {
            _countryRepository = countryRepository;
        }

        [HttpGet]
        public ActionResult<IEnumerable<Country>> GetCountries()
        {
            var countries = _countryRepository.GetCountries();
            return Ok(new { Message = "Successfully retrieved countries", Data = countries });
        }

        [HttpGet("{id}")]
        public ActionResult<Country> GetCountry(int id)
        {
            var country = _countryRepository.GetCountry(id);

            if (country == null)
            {
                return NotFound(new { Message = $"Country with ID {id} not found" });
            }

            return Ok(new { Message = "Successfully retrieved country", Data = country });
        }
    }
}
