using System.Collections.Generic;
using DAL.Models;

namespace DAL.Interfaces
{
    public interface IVideoRepository
    {
        IEnumerable<Video> GetVideos();
        Video GetVideoById(int videoId);
        void AddVideo(Video video);
        void UpdateVideo(Video video);
        void DeleteVideo(int videoId);
    }
}