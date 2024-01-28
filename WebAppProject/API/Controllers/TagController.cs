using Microsoft.AspNetCore.Mvc;
using DAL.Interfaces;
using DAL.Models;
using System.Collections.Generic;

namespace API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class TagController : ControllerBase
    {
        private readonly ITagRepository _tagRepository;

        public TagController(ITagRepository tagRepository)
        {
            _tagRepository = tagRepository;
        }

        [HttpGet]
        public ActionResult<IEnumerable<Tag>> GetTags()
        {
            var tags = _tagRepository.GetTags();
            return Ok(new { Message = "Successfully retrieved tags", Data = tags });
        }

        [HttpGet("{id}")]
        public ActionResult<Tag> GetTag(int id)
        {
            var tag = _tagRepository.GetTag(id);

            if (tag == null)
            {
                return NotFound(new { Message = $"Tag with ID {id} not found" });
            }

            return Ok(new { Message = "Successfully retrieved tag", Data = tag });
        }

        [HttpPost]
        public ActionResult<int> InsertTag(Tag tag)
        {
            var tagId = _tagRepository.InsertTag(tag);
            return CreatedAtAction(nameof(GetTag), new { id = tagId }, new { Message = "Successfully inserted tag", Data = tagId });
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteTag(int id)
        {
            _tagRepository.DeleteTag(id);
            return NoContent();
        }

        [HttpGet("videos/{videoId}")]
        public ActionResult<IEnumerable<Tag>> GetTagsForVideo(int videoId)
        {
            var tags = _tagRepository.GetTagsForVideo(videoId);
            return Ok(new { Message = $"Successfully retrieved tags for video with ID {videoId}", Data = tags });
        }

        [HttpPost("videos/{videoId}/add/{tagId}")]
        public IActionResult AddTagToVideo(int videoId, int tagId)
        {
            _tagRepository.AddTagToVideo(tagId, videoId);
            return NoContent();
        }

        [HttpDelete("videos/{videoId}/remove/{tagId}")]
        public IActionResult RemoveTagFromVideo(int videoId, int tagId)
        {
            _tagRepository.RemoveTagFromVideo(tagId, videoId);
            return NoContent();
        }
    }
}
