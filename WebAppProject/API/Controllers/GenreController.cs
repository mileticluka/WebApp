using Microsoft.AspNetCore.Mvc;
using DAL.Interfaces;
using DAL.Models;
using System.Collections.Generic;

namespace API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class GenreController : ControllerBase
    {
        private readonly IGenreRepository _genreRepository;

        public GenreController(IGenreRepository genreRepository)
        {
            _genreRepository = genreRepository;
        }

        [HttpGet]
        public ActionResult<IEnumerable<Genre>> GetGenres()
        {
            var genres = _genreRepository.GetGenres();
            return Ok(new { Message = "Successfully retrieved genres", Data = genres });
        }

        [HttpGet("{id}")]
        public ActionResult<Genre> GetGenre(int id)
        {
            var genre = _genreRepository.GetGenreById(id);

            if (genre == null)
            {
                return NotFound(new { Message = $"Genre with ID {id} not found" });
            }

            return Ok(new { Message = "Successfully retrieved genre", Data = genre });
        }

        [HttpPost]
        public ActionResult<Genre> AddGenre(Genre genre)
        {
            _genreRepository.AddGenre(genre);
            return CreatedAtAction(nameof(GetGenre), new { id = genre.Id }, new { Message = "Successfully added genre", Data = genre });
        }

        [HttpPut("{id}")]
        public IActionResult UpdateGenre(int id, Genre genre)
        {
            if (id != genre.Id)
            {
                return BadRequest(new { Message = "Invalid request" });
            }

            _genreRepository.UpdateGenre(id,genre);

            return NoContent();
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteGenre(int id)
        {
            _genreRepository.DeleteGenre(id);

            return NoContent();
        }
    }
}
