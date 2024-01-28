using Microsoft.AspNetCore.Mvc;
using DAL.Interfaces;
using DAL.Models;
using System.Collections.Generic;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Authentication.JwtBearer;

namespace API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class VideoController : ControllerBase
    {
        private readonly IVideoRepository _videoRepository;

        public VideoController(IVideoRepository videoRepository)
        {
            _videoRepository = videoRepository;
        }

        [HttpGet]
        public ActionResult<IEnumerable<Video>> GetVideos()
        {
            var videos = _videoRepository.GetVideos();
            return Ok(new { Message = "Successfully retrieved videos", Data = videos });
        }

        [HttpGet("{id}")]
        public ActionResult<Video> GetVideo(int id)
        {
            var video = _videoRepository.GetVideoById(id);

            if (video == null)
            {
                return NotFound(new { Message = $"Video with ID {id} not found" });
            }

            return Ok(new { Message = "Successfully retrieved video", Data = video });
        }

        [HttpPost]
        public ActionResult<Video> AddVideo(Video video)
        {
            _videoRepository.AddVideo(video);
            return CreatedAtAction(nameof(GetVideo), new { id = video.Id }, new { Message = "Successfully added video", Data = video });
        }

        [HttpPut("{id}")]
        public IActionResult UpdateVideo(int id, Video video)
        {
            if (id != video.Id)
            {
                return BadRequest(new { Message = "Invalid request" });
            }

            _videoRepository.UpdateVideo(video);

            return NoContent();
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteVideo(int id)
        {
            _videoRepository.DeleteVideo(id);

            return NoContent();
        }
    }
}
