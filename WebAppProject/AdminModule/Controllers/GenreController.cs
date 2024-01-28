using AdminModule.Models;
using AutoMapper;
using DAL.Interfaces;
using DAL.Models;
using DAL.Repositories;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace AdminModule.Controllers
{
    public class GenreController : Controller
    {

        private IGenreRepository _genreRepository;

        private IMapper _mapper;

        public GenreController(IGenreRepository genreRepository, IMapper mapper)
        {

            this._genreRepository = genreRepository;
            this._mapper = mapper;
        }

        public ActionResult Index()
        {
            var model = _mapper.Map<IList<GenreViewModel>>(_genreRepository.GetGenres());
            return View(model);
        }

        // GET: GenreController/Details/5
        public ActionResult Details(int id)
        {
            var model = _mapper.Map<GenreViewModel>(_genreRepository.GetGenreById(id));
            return View(model);
        }

        // GET: GenreController/Create
        public ActionResult Create()
        {   
            return View();
        }

        // POST: GenreController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(GenreViewModel genreViewModel)
        {
            if (ModelState.IsValid)
            {
                var model = _mapper.Map<Genre>(genreViewModel);
                _genreRepository.AddGenre(model);
                return (RedirectToAction("Index"));
            }
            return View(genreViewModel);
        }

        // GET: GenreController/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: GenreController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int id, GenreViewModel genreViewModel)
        {
            if (ModelState.IsValid)
            {
                var model = _mapper.Map<Genre>(genreViewModel);
                _genreRepository.UpdateGenre(id, model);
                return RedirectToAction("Index");
            }
            else
            {
                return View(genreViewModel);
            }
        }

        // GET: GenreController/Delete/5
        public ActionResult Delete(int id)
        {
            _genreRepository.DeleteGenre(id);

            var updatedGenres = _mapper.Map<IList<GenreViewModel>>(_genreRepository.GetGenres());

            return PartialView("_GenreListPartial", updatedGenres);
        }

    }
}
