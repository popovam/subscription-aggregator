using AutoMapper;
using Microsoft.Extensions.Logging.Abstractions;

namespace SA.Domain.Mapper;

public class MapperProvider
{
    private static IMapper _mapper;

    public MapperProvider()
    {
        var config = new MapperConfiguration(config =>
        {
            config.AddProfile<TopicProfile>();
            config.AddProfile<SubscriptionProfile>();
            config.AddProfile<TariffProfile>();
            config.AddProfile<ServiceProfile>();
        }, new NullLoggerFactory());

        _mapper = config.CreateMapper();
    }

    public IMapper GetMapper() => _mapper;
}
