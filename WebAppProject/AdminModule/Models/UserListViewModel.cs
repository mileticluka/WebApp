namespace AdminModule.Models
{
    public class UserListViewModel
    {
        public IEnumerable<UserViewModel> Users { get; set; }
        public int TotalCount { get; set; }
        public string SearchQuery { get; set; }
    }
}