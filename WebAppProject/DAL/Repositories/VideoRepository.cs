using System.Collections.Generic;
using System.Linq;
using DAL.Models;
using DAL.DataContexts;
using DAL.Interfaces;

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

        public Video GetVideoById(int videoId)
        {
            return _context.Videos.FirstOrDefault(v => v.Id == videoId);
        }

        public void AddVideo(Video video)
        {
            _context.Videos.Add(video);
            _context.SaveChanges();
        }

        public void UpdateVideo(Video video)
        {
            _context.Videos.Update(video);
            _context.SaveChanges();
        }

        public void DeleteVideo(int videoId)
        {
            var video = _context.Videos.Find(videoId);
            if (video != null)
            {
                _context.Videos.Remove(video);
                _context.SaveChanges();
            }
        }
    }
}