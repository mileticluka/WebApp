using DAL.Models;
using DAL.DataContexts;
using DAL.Interfaces;

namespace DAL.Repositories
{
    public class CountryRepository : ICountryRepository
    {
        private readonly RwamoviesContext dataContext;

        public CountryRepository(RwamoviesContext dataContext)
        {
            this.dataContext = dataContext;
        }

        public IList<Country> GetCountries()
        {
            return this.dataContext.Countries.ToList();
        }
        public IList<Country> GetCountries(int page, int pageSize)
        {
            page = Math.Max(page, 1);
            pageSize = Math.Max(pageSize, 1);

            int skip = (page - 1) * pageSize;

            List<Country> countries = dataContext.Countries
                .Skip(skip)
                .Take(pageSize)
                .ToList();

            return countries;
        }

        public Country GetCountry(int id)
        {
            return this.dataContext.Countries.FirstOrDefault(c => c.Id == id);
        }
    }
}
