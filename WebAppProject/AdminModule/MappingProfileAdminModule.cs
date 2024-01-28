using AdminModule.Models;
using AutoMapper;
using DAL.DTO;
using DAL.Models;

namespace AdminModule
{
    public class MappingProfileAdminModule : Profile
    {
        public MappingProfileAdminModule()
        {
            CreateMap<Country, CountryViewModel>().ReverseMap();
            CreateMap<Tag, TagViewModel>().ReverseMap();
            CreateMap<Genre,GenreViewModel>().ReverseMap();
            CreateMap<User, UserViewModel>().ReverseMap();
        }
    }
}