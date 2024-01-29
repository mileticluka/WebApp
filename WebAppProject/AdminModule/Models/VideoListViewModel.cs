namespace AdminModule.Models
{
    public class VideoListViewModel
    {
        public IEnumerable<VideoViewModel> Videos { get; set; }
        public int TotalCount { get; set; }
        public string SearchQuery { get; set; }
        public int PageSize { get; internal set; }
        public int CurrentPage { get; internal set; }
        public int TotalPages { get; internal set; }
    }
}
