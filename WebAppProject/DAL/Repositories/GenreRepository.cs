using System.Collections.Generic;
using System.Linq;
using DAL.Models;
using DAL.DataContexts;
using DAL.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace DAL.Repositories
{
    public class GenreRepository : IGenreRepository
    {
        private readonly RwamoviesContext _context;

        public GenreRepository(RwamoviesContext context)
        {
            _context = context;
        }

        public IEnumerable<Genre> GetGenres()
        {
            return _context.Genres.ToList();
        }

        public Genre GetGenreById(int genreId)
        {
            return _context.Genres.FirstOrDefault(g => g.Id == genreId);
        }

        public void AddGenre(Genre genre)
        {
            _context.Genres.Add(genre);
            _context.SaveChanges();
        }

        public void UpdateGenre(int genreId, Genre updatedGenre)
        {
            Genre existingGenre = _context.Genres.Find(genreId);

            if (existingGenre != null)
            {
                existingGenre.Name = updatedGenre.Name;
                existingGenre.Description = updatedGenre.Description;

                _context.Entry(existingGenre).State = EntityState.Modified;

                _context.SaveChanges();
            }
            else
            {
                throw new InvalidOperationException($"Genre with ID {genreId} not found.");
            }
        }

        public void DeleteGenre(int genreId)
        {
            var genre = _context.Genres
                .Include(g => g.Videos)
                    .ThenInclude(v => v.VideoTags)
                .FirstOrDefault(g => g.Id == genreId);

            if (genre != null)
            {
                try
                {
                    _context.VideoTags.RemoveRange(genre.Videos.SelectMany(v => v.VideoTags));
                    _context.Videos.RemoveRange(genre.Videos);
                    _context.Genres.Remove(genre);
                    _context.SaveChanges();
                }
                catch (DbUpdateException ex)
                {
                    throw new Exception("Error deleting genre.", ex);
                }
            }
        }
    }
}