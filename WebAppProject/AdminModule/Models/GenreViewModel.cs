using System.ComponentModel.DataAnnotations;

namespace AdminModule.Models
{
    public class GenreViewModel
    {
        [Key]
        public int Id { get; set; }

        [Required(ErrorMessage = "Name is Required")]
        public string Name { get; set; } = null!;
        public string? Description { get; set; }
    }
}
