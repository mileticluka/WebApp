using System.ComponentModel.DataAnnotations;

public class UserDTOForRegistration
{
    [Required(ErrorMessage = "Email is required")]
    [EmailAddress(ErrorMessage = "Invalid email address")]
    public string Email { get; set; }
    public string Username { get; set; }

    public string FirstName { get; set; }

    public string LastName { get; set; }

    public string Password { get; set; }

    public int CountryOfResidenceId { get; set; }

    public string? Phone { get; set; }
}