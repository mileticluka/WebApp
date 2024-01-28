using DAL.Models;

namespace DAL.Interfaces
{
    public interface ICountryRepository
    {
        public IList<Country> GetCountries();
        public Country GetCountry(int id);

        public IList<Country> GetCountries(int page, int pageSize);
    }
}