namespace AdminModule.Models
{
    public class VideoListViewModel
    {
        public IEnumerable<VideoViewModel> Videos { get; set; }
        public int TotalCount { get; set; }
        public string SearchQuery { get; set; }
    }
}
