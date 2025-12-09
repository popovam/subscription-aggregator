using SA.Domain.Mapper;
using SA.Infrastructure.Repositories.Implementations;
using SA.Infrastructure.Repositories.Interfaces;
using SA.Infrastructure.Services.Impementations;
using SA.Infrastructure.Services.Interfaces;

namespace SA.Backend;

public static class ServiceProviderExtensions
{
    public static void AddServices(this IServiceCollection services)
    {
        services.AddScoped<IServService, ServService>();
        services.AddScoped<ITariffService, TariffService>();
        services.AddScoped<ISubscriptionService, SubscriptionService>();
        services.AddScoped<ITopicService, TopicService>();
        services.AddScoped<IComparisonService, ComparisonService>();
    }

    public static void AddRepositoties(this IServiceCollection services)
    {
        services.AddScoped<IServiceRepository, ServiceRepository>();
        services.AddScoped<ITariffRepository, TariffRepository>();
        services.AddScoped<ISubscriptionRepository, SubscriptionRepository>();
        services.AddScoped<ITopicRepository, TopicRepository>();
    }

    public static void AddMapper(this IServiceCollection services)
    {
        services.AddSingleton<MapperProvider>();
    }
}
