using AutoMapper;
using SA.Domain.Dtos.Tariff;
using SA.Domain.Entities;

namespace SA.Domain.Mapper;

public class TariffProfile : Profile
{
    public TariffProfile()
    {
        CreateMap<Tariff, TariffGetDto>()
            .ForMember(tariff => tariff.Services, member => member.Ignore());

        CreateMap<TariffCreateOrUpdateDto, Tariff>();
    }
}
