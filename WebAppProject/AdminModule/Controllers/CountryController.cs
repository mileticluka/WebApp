using AdminModule.Models;
using AutoMapper;
using DAL.Interfaces;
using DAL.Repositories;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace AdminModule.Controllers
{
    public class CountryController : Controller
    {

        private ICountryRepository _countryRepository;

        private IMapper _mapper;

        public CountryController(ICountryRepository countryRepository, IMapper mapper)
        {

            this._countryRepository = countryRepository;
            this._mapper = mapper;
        }

        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public ActionResult GetTotalCount()
        {
            return Json((int)Math.Ceiling((double)_countryRepository.GetCountries().Count() / 20));
        }

        [HttpGet]
        public ActionResult GetCountries(int page = 1, int pageSize = 20)
        {
            var model = _mapper.Map<IList<CountryViewModel>>(_countryRepository.GetCountries(page,pageSize));

            return PartialView("_CountryListPartial", model);
        }

        // GET: 
        [HttpGet]
        public IActionResult GetPagedCountries(int page)
        {
            var pageSize = 10;
            var skip = (page - 1) * pageSize;
            var countryViewModels = _mapper.Map<IList<CountryViewModel>>(_countryRepository.GetCountries(skip, pageSize));
            return PartialView("_CountryListPartial", countryViewModels);
        }

        // GET: CountryController/Details/5
        public ActionResult Details(int id)
        {

            var countryViewModel = _mapper.Map<CountryViewModel>(_countryRepository.GetCountry(id));

            return View(countryViewModel);
        }
    }
}
