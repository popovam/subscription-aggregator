using AutoMapper;
using SA.Domain.Dtos.Service;
using SA.Domain.Dtos.Tariff;
using SA.Domain.Entities;
using SA.Domain.Mapper;
using SA.Infrastructure.Repositories;
using System.ComponentModel.DataAnnotations;

namespace SA.Infrastructure.Services;

/// <summary>
/// Сервис тарифов
/// </summary>
public class TariffService
{
    private readonly ServService _servService;

    private readonly SubscriptionRepository _subscriptionRepository;

    private readonly TariffRepository _tariffRepository;

    public TariffService(
        ServService servService,
        SubscriptionRepository subscriptionRepository, 
        TariffRepository tariffRepository)
    {
        _servService = servService;
        _subscriptionRepository = subscriptionRepository;
        _tariffRepository = tariffRepository;
    }

    private readonly IMapper _mapper = MapperProvider.Provider.GetMapper();

    public TariffGetDto CreateTariff(long subscriptionId, TariffCreateOrUpdateDto tariffDto)
    {
        Subscription subscription = FindSubscription(subscriptionId);

        if (subscription.Tariffs.Any(tariff => tariff.Name == tariffDto.Name))
            throw new ValidationException($"Тариф с названием {tariffDto.Name} в данном сервисе уже существует.");

        Tariff tariff = _mapper.Map<Tariff>(tariffDto);
        tariff.Subscription = subscription;
        subscription.Tariffs.Add(tariff);

        _tariffRepository.Add(tariff);
        _tariffRepository.SaveChanges();

        return MapToDto(tariff);
    }

    public List<TariffGetDto> GetTariffs(long subscriptionId)
    {
        List<TariffGetDto> tariffDtos = [];

        Subscription subscription = FindSubscription(subscriptionId);

        List<Tariff> tariffs = subscription.Tariffs.ToList();

        if (tariffs == null || !tariffs.Any())
            throw new ValidationException("Тарифы не найдены.");

        tariffs = tariffs.OrderBy(service => service.Name)
            .ToList();

        tariffs.ForEach(tariff => tariffDtos.Add(MapToDto(tariff)));

        return tariffDtos;
    }

    public TariffGetDto GetTariff(long tariffId)
    {
        Tariff tariff = _servService.FindTariff(tariffId);

        return MapToDto(tariff);
    }

    public TariffGetDto UpdateTariff(long tariffId, TariffCreateOrUpdateDto tariffDto)
    {
        Tariff tariff = _servService.FindTariff(tariffId);

        tariff = _mapper.Map(tariffDto, tariff);
        _tariffRepository.SaveChanges();

        return MapToDto(tariff);
    }

    public void DeleteTariff(long tariffId)
    {
        Tariff tariff = _servService.FindTariff(tariffId);

        tariff.Subscription.Tariffs.Remove(tariff);

        _tariffRepository.Delete(tariff);
        _tariffRepository.SaveChanges();
    }

    public Subscription FindSubscription(long subscriptionId)
    {
        return _subscriptionRepository.GetById(subscriptionId)
            ?? throw new ValidationException($"Сервис не найден.");
    }

    public TariffGetDto MapToDto(Tariff tariff)
    {
        TariffGetDto tariffDto = _mapper.Map<TariffGetDto>(tariff);
        tariffDto.Services = tariff.Services
            .Select(service => _servService.MapToDto(service))
            .ToList();

        return tariffDto;
    }
}
