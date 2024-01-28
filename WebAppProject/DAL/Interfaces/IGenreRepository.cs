using System.Collections.Generic;
using DAL.Models;

namespace DAL.Interfaces
{
    public interface IGenreRepository
    {
        IEnumerable<Genre> GetGenres();
        Genre GetGenreById(int genreId);
        void AddGenre(Genre genre);
        void UpdateGenre(int genreId, Genre genre);
        void DeleteGenre(int genreId);
    }
}