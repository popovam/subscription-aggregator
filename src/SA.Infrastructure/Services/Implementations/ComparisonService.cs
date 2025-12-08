using SA.Domain.Dtos.Comparison;
using SA.Domain.Dtos.Service;
using SA.Domain.Entities;
using SA.Infrastructure.Repositories.Interfaces;
using SA.Infrastructure.Services.Interfaces;

namespace SA.Infrastructure.Services.Impementations;

public class ComparisonService : IComparisonService
{
    private readonly IServiceRepository _serviceRepository;

    private readonly ISubscriptionRepository _subscriptionRepository;

    public ComparisonService(
        IServiceRepository serviceRepository, 
        ISubscriptionRepository subscriptionRepository)
    {
        _serviceRepository = serviceRepository;
        _subscriptionRepository = subscriptionRepository;
    }

    public ComparativeTableDto GetComparativeTable(List<long> subscriptionIds, List<string> serviceNames)
    {
        List<ComparisonSubscriptionItem> columns;
        var comparativeTable = new ComparativeTableDto();

        if (!subscriptionIds.Any())
            throw new Exception("Сравнительная таблица пуста.");

        List<Subscription> subscriptions = _subscriptionRepository.GetAll(subscription =>
            subscriptionIds.Contains(subscription.Id));

        columns = GetComparativeTableColumns(subscriptions, serviceNames);

        comparativeTable.Columns = columns;

        return comparativeTable;
    }

    private List<ComparisonSubscriptionItem> GetComparativeTableColumns(
        List<Subscription> subscriptions, 
        List<string> serviceNames)
    {
        List<ComparisonSubscriptionItem> comparisonSubscriptionItems = new List<ComparisonSubscriptionItem>();
        List<ServiceGetDto> filteredServices;

        serviceNames = serviceNames.Distinct().ToList();

        if (serviceNames.Count != 0)
        {
            foreach (var subscription in subscriptions)
            {
                filteredServices = new List<ServiceGetDto>();
                List<Service> services = GetServices(subscription);

                foreach(var serviceName in serviceNames)
                {
                    Service? service = services.FirstOrDefault(service => service.Name == serviceName);
                    if (service != null)
                        filteredServices.Add(new ServiceGetDto()
                        {
                            Name = serviceName,
                            Value = service.Value
                        });
                }

                if (filteredServices.Count == 0)
                    continue;

                comparisonSubscriptionItems.Add(new ComparisonSubscriptionItem()
                {
                    SubscriptionName = subscription.Name,
                    Services = filteredServices
                });
            }
        }
        else
        {
            serviceNames = subscriptions.SelectMany(subscription => GetServices(subscription))
                .Select(service => service.Name)
                .Distinct()
                .ToList();

            foreach (var subscription in subscriptions)
            {
                List<Service> services = GetServices(subscription);

                filteredServices = serviceNames.Select(serviceName =>
                {
                    return new ServiceGetDto
                    {
                        Name = serviceName,
                        Value = services.FirstOrDefault(service => service.Name == serviceName)?.Value ?? "-"
                    };
                })
                .ToList();

                if (filteredServices.Count == 0)
                    continue;

                comparisonSubscriptionItems.Add(new ComparisonSubscriptionItem()
                {
                    SubscriptionName = subscription.Name,
                    Services = filteredServices
                });
            }
        }

        return comparisonSubscriptionItems;
    }

    private List<Service> GetServices(Subscription subscription)
    {
        return _serviceRepository
            .GetAll(service => service.Tariff.Subscription.Id == subscription.Id)
            .ToList();
    }
}
