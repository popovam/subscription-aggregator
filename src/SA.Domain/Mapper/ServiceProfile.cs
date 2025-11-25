using AutoMapper;
using SA.Domain.Dtos.Service;
using SA.Domain.Entities;

namespace SA.Domain.Mapper;

public class ServiceProfile : Profile
{
    public ServiceProfile()
    {
        CreateMap<Service, ServiceGetDto>();

        CreateMap<ServiceCreateOrUpdateDto, Service>();
    }
}
