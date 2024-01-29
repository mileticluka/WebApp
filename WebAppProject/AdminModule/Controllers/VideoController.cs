using AdminModule.Models;
using AutoMapper;
using DAL.Interfaces;
using DAL.Models;
using DAL.Repositories;
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
        public ActionResult Index(string searchQuery, int page = 1)
        {
            const int pageSize = 5;

            IEnumerable<Video> videos;

            if (string.IsNullOrEmpty(searchQuery))
            {
                videos = _videoRepository.GetVideosFilteredAll();
            }
            else
            {
                videos = _videoRepository.GetVideosFiltered(searchQuery);
            }

            var totalCount = videos.Count();
            var totalPages = (int)Math.Ceiling((double)totalCount / pageSize);

            var videoViewModels = _mapper.Map<IEnumerable<VideoViewModel>>(videos.Skip((page - 1) * pageSize).Take(pageSize));

            var model = new VideoListViewModel
            {
                Videos = videoViewModels,
                TotalCount = totalCount,
                SearchQuery = searchQuery,
                PageSize = pageSize,
                CurrentPage = page,
                TotalPages = totalPages
            };

            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                return PartialView("_VideoListPartial", model);
            }

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
            var videoViewModel = new VideoViewModel(); // Assuming VideoViewModel is your view model for creating a new video
            return View(videoViewModel);
        }

        // POST: VideoController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(VideoViewModel videoViewModel)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    var video = _mapper.Map<Video>(videoViewModel);
                    _videoRepository.AddVideo(video);
                    return RedirectToAction(nameof(Index));
                }

                return View(videoViewModel);
            }
            catch
            {
                return View();
            }
        }

        // GET: VideoController/Edit/5
        public ActionResult Edit(int id)
        {
            var video = _videoRepository.GetVideoById(id);
            var videoViewModel = _mapper.Map<VideoViewModel>(video);
            return View(videoViewModel);
        }
        // POST: VideoController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int id, VideoViewModel videoViewModel)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    var existingVideo = _videoRepository.GetVideoById(id);

                    if (existingVideo != null)
                    {
                        _mapper.Map(videoViewModel, existingVideo);

                        _videoRepository.UpdateVideo(existingVideo);
                        return RedirectToAction("Index");
                    }
                }
                else
                {
                    // Print validation errors
                    foreach (var modelStateKey in ModelState.Keys)
                    {
                        var modelStateVal = ModelState[modelStateKey];
                        foreach (var error in modelStateVal.Errors)
                        {
                            // Print the error messages to the console
                            Console.WriteLine($"Model Error: {error.ErrorMessage}");
                        }
                    }
                }

                return View(videoViewModel);
            }
            catch (Exception ex)
            {
                // Log or print the exception
                Console.WriteLine($"Exception: {ex.Message}");
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
