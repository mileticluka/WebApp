using DAL.DTO;
using DAL.Models;
using AutoMapper;

namespace DAL.Profiles
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<User, UserDTO>().ReverseMap();

            CreateMap<UserDTOForRegistration, User>()
                        .ForMember(dest => dest.PwdHash, opt => opt.MapFrom(src => BCrypt.Net.BCrypt.HashPassword(src.Password)))
                        .ForMember(dest => dest.PwdSalt, opt => opt.MapFrom(src => BCrypt.Net.BCrypt.GenerateSalt()));

            CreateMap<NotificationDTO, Notification>().ReverseMap();
        }
    }
}