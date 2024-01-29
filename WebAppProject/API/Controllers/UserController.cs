using Microsoft.AspNetCore.Mvc;
using DAL.Interfaces;
using DAL.Models;
using DAL.DTO;
using AutoMapper;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using DAL.Repositories;
using System.ComponentModel.DataAnnotations;
using System.Web;
using Newtonsoft.Json.Linq;

namespace API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UserController : ControllerBase
    {
        private readonly IUserRepository _userRepository;
        private readonly ICountryRepository _countryRepository;
        private readonly INotificationRepository _notificationRepository;
        private readonly IMapper _mapper;

        public UserController(IUserRepository userRepository, IMapper mapper, ICountryRepository countryRepository, INotificationRepository notificationRepository)
        {
            _userRepository = userRepository;
            _countryRepository = countryRepository;
            _notificationRepository = notificationRepository;
            _mapper = mapper;
        }

        [HttpGet]
        public ActionResult<IEnumerable<UserDTO>> GetUsers()
        {
            var users = _userRepository.GetUsers();
            var userDTOs = _mapper.Map<IEnumerable<UserDTO>>(users);
            return Ok(new { Message = "Successfully retrieved users", Data = userDTOs });
        }

        [HttpGet("{id}")]
        public ActionResult<UserDTO> GetUser(int id)
        {
            var user = _userRepository.GetUserById(id);

            if (user == null)
            {
                return NotFound(new { Message = $"User with ID {id} not found" });
            }

            var userDTO = _mapper.Map<UserDTO>(user);
            return Ok(new { Message = "Successfully retrieved user", Data = userDTO });
        }

        [HttpPost("register")]
        public ActionResult<UserDTO> Register(UserDTOForRegistration userDTOForRegistration)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(new { Message = "Invalid input data" });
            }

            var country = _countryRepository.GetCountry(userDTOForRegistration.CountryOfResidenceId);
            if (country == null)
            {
                return BadRequest(new { Message = "Invalid CountryId" });
            }

            if (_userRepository.GetUserByUsername(userDTOForRegistration.Username) != null)
            {
                return BadRequest(new { Message = "User with that username already exists" });
            }

            if (!ModelState.IsValid)
            {
                return BadRequest(new { Message = "Invalid input data", Errors = ModelState.Values.SelectMany(v => v.Errors) });
            }

            string salt = BCrypt.Net.BCrypt.GenerateSalt();
            string hashedPassword = BCrypt.Net.BCrypt.HashPassword(userDTOForRegistration.Password, salt);

            var newUser = new User
            {
                Username = userDTOForRegistration.Username,
                FirstName = userDTOForRegistration.FirstName,
                LastName = userDTOForRegistration.LastName,
                Email = userDTOForRegistration.Email,
                PwdHash = hashedPassword,
                PwdSalt = salt,
                CountryOfResidenceId = userDTOForRegistration.CountryOfResidenceId,
                CreatedAt = DateTime.Now
            };

            _userRepository.AddUser(newUser);

            var insertedUserDTO = _mapper.Map<UserDTO>(newUser);

            var validationNotification = new Notification();
            validationNotification.ReceiverEmail = userDTOForRegistration.Email;
            validationNotification.Subject = "Validate your email";
            var validationLink = Url.Link("ConfirmUser", new { controller = "User", id = insertedUserDTO.Id });
            var fullValidationLink = validationLink;

            if (!fullValidationLink.StartsWith(Request.Scheme, StringComparison.OrdinalIgnoreCase))
            {
                fullValidationLink = $"{Request.Scheme}://{Request.Host.Value}{validationLink}";
            }

            validationNotification.Body = $"Click this link to validate your email: {fullValidationLink}";

            _notificationRepository.SendNotification(_notificationRepository.InsertNotification(validationNotification));

            return Ok(CreatedAtAction(nameof(GetUser), new { id = insertedUserDTO.Id }, new { Message = "Successfully registered user", Data = insertedUserDTO }));
        }

        [HttpPost("login")]
        public ActionResult Login(UserDTOForLogin userDTOForLogin)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(new { Message = "Invalid input data" });
            }

            var user = _userRepository.GetUserByUsername(userDTOForLogin.Username);

            if (user == null || !BCrypt.Net.BCrypt.Verify(userDTOForLogin.Password, user.PwdHash))
            {
                return Unauthorized(new { Message = "Invalid username or password" });
            }

            var token = GenerateJwtToken(user);

            return Ok(new { Message = "Successfully logged in", Token = "Bearer " + token });
        }

        private string GenerateJwtToken(User user)
        {
            var key = Encoding.UTF8.GetBytes("fIAslEIxCWmML9WRfIAslEIxCWmML9WR");
            var tokenHandler = new JwtSecurityTokenHandler();
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[]
                {
                    new Claim(ClaimTypes.Name, user.Username),
                }),
                Expires = DateTime.UtcNow.AddHours(1),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };

            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }

        [HttpPut("{id}")]
        public IActionResult UpdateUser(int id, UserDTO userDTO)
        {
            if (id != userDTO.Id)
            {
                return BadRequest(new { Message = "Invalid request" });
            }

            var user = _mapper.Map<User>(userDTO);
            _userRepository.UpdateUser(id,user);

            return Ok(new { Message = $"Sucesfully updated user with Id: {id}" });
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteUser(int id)
        {
            _userRepository.DeleteUser(id);

            return Ok(new { Message = $"Sucesfully deleted user with Id: {id}" });
        }

        [HttpGet("validate/{id}", Name = "ConfirmUser")]
        public IActionResult ConfirmUser(int id)
        {
            var user = _userRepository.GetUserById(id);

            if (user == null)
            {
                return NotFound(new { Message = $"User with ID {id} not found" });
            }

            user.IsConfirmed = true;
            _userRepository.UpdateUser(id, user);

            return Ok(new { Message = "User confirmed successfully", Data = _mapper.Map<UserDTO>(user) });
        }
    }
}