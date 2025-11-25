using SA.Infrastructure.Repositories;
using SA.Infrastructure.Services;

namespace SA.Backend;

public static class ServiceProviderExtensions
{
    public static void AddServices(this IServiceCollection services)
    {
        services.AddScoped<ServService>();
        services.AddScoped<TariffService>();
        services.AddScoped<SubscriptionService>();
        services.AddScoped<TopicService>();
    }

    public static void AddRepositoties(this IServiceCollection services)
    {
        services.AddScoped<ServiceRepository>();
        services.AddScoped<TariffRepository>();
        services.AddScoped<SubscriptionRepository>();
        services.AddScoped<TopicRepository>();
    }
}
