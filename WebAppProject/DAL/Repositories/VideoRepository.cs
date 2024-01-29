using System.Collections.Generic;
using System.Linq;
using DAL.Models;
using DAL.DataContexts;
using DAL.Interfaces;
using Microsoft.EntityFrameworkCore;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace DAL.Repositories
{
    public class VideoRepository : IVideoRepository
    {
        private readonly RwamoviesContext _context;

        public VideoRepository(RwamoviesContext context)
        {
            _context = context;
        }

        public IEnumerable<Video> GetVideos()
        {
            return _context.Videos.ToList();
        }

        public IEnumerable<Video> GetVideosFiltered(string query)
        {
            return _context.Videos
                .Include(v => v.Image)
                .Include(v => v.Genre)
                .Where(video =>
                    video.Name.Contains(query) ||
                    video.Genre.Name.Contains(query))
                .ToList();
        }

        public IEnumerable<Video> GetVideosFilteredAll()
        {
            return _context.Videos
                .Include(v => v.Image)
                .Include(v => v.Genre)
                .ToList();
        }

        //FIX
        public Video GetVideoById(int videoId)
        {
            return _context.Videos.Include( v => v.Genre).Include(v=>v.Image).FirstOrDefault(v => v.Id == videoId);
        }

        public void AddVideo(Video video)
        {
            _context.Videos.Add(video);
            _context.SaveChanges();
        }

        public void UpdateVideo(Video video)
        {
            var existingVideo = _context.Videos
                .Include(v => v.Genre)
                .FirstOrDefault(v => v.Id == video.Id);

            if (existingVideo != null)
            {
                _context.Entry(existingVideo).CurrentValues.SetValues(video);

                existingVideo.Genre = video.Genre;

                _context.SaveChanges();
            }
        }

        public void DeleteVideo(int videoId)
        {
            var video = _context.Videos.Include(v => v.VideoTags).FirstOrDefault(v => v.Id == videoId);

            if (video != null)
            {
                _context.VideoTags.RemoveRange(video.VideoTags);

                _context.Videos.Remove(video);

                _context.SaveChanges();
            }
        }
    }
}