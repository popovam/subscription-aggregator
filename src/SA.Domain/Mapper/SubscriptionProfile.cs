using AutoMapper;
using SA.Domain.Dtos.Subscription;
using SA.Domain.Entities;

namespace SA.Domain.Mapper;

public class SubscriptionProfile : Profile
{
    public SubscriptionProfile()
    {
        CreateMap<Subscription, SubscriptionGetDto>()
            .ForMember(subscription => subscription.Tariffs, member => member.Ignore());

        CreateMap<SubscriptionCreateOrUpdateDto, Subscription>();
    }
}
