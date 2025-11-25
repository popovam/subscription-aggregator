using AutoMapper;
using SA.Domain.Dtos.Service;
using SA.Domain.Dtos.Subscription;
using SA.Domain.Entities;
using SA.Domain.Mapper;
using SA.Infrastructure.Repositories;
using System.ComponentModel.DataAnnotations;

namespace SA.Infrastructure.Services;

/// <summary>
/// Сервис подписок
/// </summary>
public class SubscriptionService
{
    private readonly TariffService _tariffService;

    private readonly TopicRepository _topicRepository;

    private readonly SubscriptionRepository _subscriptionRepository;

    private readonly ServiceRepository _serviceRepository;

    public SubscriptionService(
        TopicRepository topicRepository, 
        TariffService tariffService, 
        SubscriptionRepository subscriptionRepository, 
        ServiceRepository serviceRepository)
    {
        _topicRepository = topicRepository;
        _tariffService = tariffService;
        _subscriptionRepository = subscriptionRepository;
        _serviceRepository = serviceRepository;
    }

    private readonly IMapper _mapper = MapperProvider.Provider.GetMapper();

    public SubscriptionGetDto CreateSubscription(long topicId, SubscriptionCreateOrUpdateDto subscriptionDto)
    {
        Topic topic = FindTopic(topicId);

        if (topic.Subscriptions.Any(subscription => subscription.Name == subscriptionDto.Name))
            throw new ValidationException($"Сервис с таким названием уже существует в данной теме.");
        
        Subscription subscription = _mapper.Map<Subscription>(subscriptionDto);
        subscription.Topic = topic;
        topic.Subscriptions.Add(subscription);

        _subscriptionRepository.Add(subscription);
        _subscriptionRepository.SaveChanges();

        return MapToDto(subscription);
    }

    public List<SubscriptionGetDto> GetSubscriptions(long topicId, List<ServiceCreateOrUpdateDto> serviceDtos)
    {
        List<SubscriptionGetDto> subscriptionDtos = [];

        Topic topic = FindTopic(topicId);

        List<Subscription> subscriptions = topic.Subscriptions.ToList();

        if (serviceDtos.Any())
            subscriptions = GetFilteredSubscriptions(subscriptions, serviceDtos);

        if (subscriptions == null || !subscriptions.Any())
            throw new ValidationException("Сервисы не найдены.");

        subscriptions = subscriptions.OrderBy(subscription => subscription.Name)
            .ToList();

        subscriptions.ForEach(subscription => subscriptionDtos.Add(MapToDto(subscription)));

        return subscriptionDtos;
    }

    public SubscriptionGetDto GetSubscription(long subscriptionId)
    {
        Subscription subscription = _tariffService.FindSubscription(subscriptionId);

        return MapToDto(subscription);
    }

    public SubscriptionGetDto UpdateSubscription(long subscriptionId, SubscriptionCreateOrUpdateDto subscriptionDto)
    {
        Subscription subscription = _tariffService.FindSubscription(subscriptionId);

        subscription = _mapper.Map(subscriptionDto, subscription);
        _subscriptionRepository.SaveChanges();

        return MapToDto(subscription);
    }

    public void DeleteSubscription(long subscriptionId)
    {
        Subscription subscription = _tariffService.FindSubscription(subscriptionId);

        subscription.Topic.Subscriptions.Remove(subscription);

        _subscriptionRepository.Delete(subscription);
        _subscriptionRepository.SaveChanges();
    }

    private List<Subscription> GetFilteredSubscriptions(
        List<Subscription> subscriptions, 
        List<ServiceCreateOrUpdateDto> serviceDtos)
    {
        List<Service> services = _serviceRepository
            .GetAll(service => subscriptions
                .Select(subscription => subscription.Id)
                .Contains(service.Tariff.Subscription.Id));

        services = services.Where(service => serviceDtos
            .Select(serviceDto => serviceDto.Name)
            .Contains(service.Name))
            .ToList();

        List<Subscription> filteredSubcriptios = services.Where(service => serviceDtos
            .Select(serviceDto => serviceDto.Value)
            .Contains(service.Value))
            .Select(service => service.Tariff.Subscription)
            .ToList();

        return filteredSubcriptios;
    }

    public Topic FindTopic(long topicId)
    {
        return _topicRepository.GetById(topicId)
            ?? throw new Exception($"Тема не найдена.");
    }

    public SubscriptionGetDto MapToDto(Subscription subscription)
    {
        SubscriptionGetDto subscriptionDto = _mapper.Map<SubscriptionGetDto>(subscription);
        subscriptionDto.Tariffs = subscription.Tariffs
            .Select(tariff => _tariffService.MapToDto(tariff))
            .ToList();

        return subscriptionDto;
    }
}
