using AdminModule.Models;
using AutoMapper;
using DAL.Interfaces;
using DAL.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace AdminModule.Controllers
{
    public class TagController : Controller
    {

        private ITagRepository _tagRepository;

        private IMapper _mapper;

        public TagController(ITagRepository tagRepository, IMapper mapper)
        {

            this._tagRepository = tagRepository;
            this._mapper = mapper;
        }

        public ActionResult Index()
        {
            var model = _mapper.Map<IList<TagViewModel>>(_tagRepository.GetTags());
            return View(model);
        }

        // GET: TagController/Details/5
        public ActionResult Details(int id)
        {
            var model = _mapper.Map<TagViewModel>(_tagRepository.GetTag(id));
            return View(model);
        }

        // GET: TagController/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: TagController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(TagViewModel tagViewModel)
        {
            if(ModelState.IsValid)
            {
                var model = _mapper.Map<Tag>(tagViewModel);
                _tagRepository.InsertTag(model);
                return( RedirectToAction("Index") );
            }
            return View(tagViewModel);
        }

        // GET: TagController/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: TagController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int id, TagViewModel tagViewModel)
        {
            if(ModelState.IsValid)
            {
                var model = _mapper.Map<Tag>(tagViewModel);
                _tagRepository.UpdateTag(id, model);
                return RedirectToAction("Index");
            }
            else
            {
                return View(tagViewModel);
            }
        }

        // GET: TagController/Delete/5
        public ActionResult Delete(int id)
        {
            _tagRepository.DeleteTag(id);
            return RedirectToAction("Index");
        }
    }
}
