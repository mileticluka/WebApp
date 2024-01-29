using AdminModule.Models;
using AutoMapper;
using DAL.Interfaces;
using DAL.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace AdminModule.Controllers
{
    public class VideoController : Controller
    {


        private IVideoRepository _videoRepository;

        private IMapper _mapper;

        public VideoController(IVideoRepository videoRepository, IMapper mapper)
        {

            this._videoRepository = videoRepository;
            this._mapper = mapper;
        }

        // GET: VideoController
        public ActionResult Index(string searchQuery)
        {
            IEnumerable<Video> videos;

            if (string.IsNullOrEmpty(searchQuery))
            {
                videos = _videoRepository.GetVideosFilteredAll();
            }
            else
            {
                videos = _videoRepository.GetVideosFiltered(searchQuery);
            }

            var videoViewModels = _mapper.Map <IEnumerable<VideoViewModel>>(videos);

            var model = new VideoListViewModel
            {
                Videos = videoViewModels,
                TotalCount = videoViewModels.Count(),
                SearchQuery = searchQuery
            };

            return View(model);
        }
        



        // GET: VideoController/Details/5
        public ActionResult Details(int id)
        {
            var video = _videoRepository.GetVideoById(id);

            var videoViewModel = _mapper.Map<VideoViewModel>(video);

            return View(videoViewModel);
        }

        // GET: VideoController/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: VideoController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: VideoController/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: VideoController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int id, IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: VideoController/Delete/5
        public ActionResult Delete(int id)
        {
            _videoRepository.DeleteVideo(id);
            return RedirectToAction("Index");
        }
    }
}
