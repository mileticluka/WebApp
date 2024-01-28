using DAL.Models;

namespace AdminModule.Models
{
    public class UserViewModel
    {
        public int Id { get; set; }
        public string Username { get; set; } = null!;

        public string FirstName { get; set; } = null!;

        public string LastName { get; set; } = null!;

        public string Email { get; set; } = null!;

        public string? Phone { get; set; }

        public bool IsConfirmed { get; set; }
        public virtual Country CountryOfResidence { get; set; } = null!;

    }
}