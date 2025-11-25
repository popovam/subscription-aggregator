using AutoMapper;
using SA.Domain.Dtos.Topic;
using SA.Domain.Entities;

namespace SA.Domain.Mapper;

public class TopicProfile : Profile
{
    public TopicProfile()
    {
        CreateMap<Topic, TopicGetDto>()
            .ForMember(topic => topic.Subscriptions, member => member.Ignore());

        CreateMap<TopicCreateOrUpdateDto, Topic>();
    }
}
