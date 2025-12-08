using AutoMapper;
using SA.Domain.Dtos.Service;
using SA.Domain.Entities;
using SA.Domain.Mapper;
using SA.Infrastructure.Repositories.Interfaces;
using SA.Infrastructure.Services.Interfaces;
using System.ComponentModel.DataAnnotations;

namespace SA.Infrastructure.Services.Impementations;

public class ServService : IServService
{
    private readonly ITariffRepository _tariffRepository;

    private readonly IServiceRepository _serviceRepository;
    
    private readonly IMapper _mapper;

    public ServService(
        ITariffRepository tariffRepository,
        IServiceRepository serviceRepository,
        MapperProvider mapperProvider)
    {
        _tariffRepository = tariffRepository;
        _serviceRepository = serviceRepository;
        _mapper = mapperProvider.GetMapper();
    }

    public ServiceGetDto CreateService(long tariffId, ServiceCreateOrUpdateDto serviceDto)
    {
        Tariff tariff = FindTariff(tariffId);

        if (tariff.Services.Any(service => service.Name == serviceDto.Name))
            throw new ValidationException($"Услуга с таким названием уже существует в данном тарифе.");

        Service service = _mapper.Map<Service>(serviceDto);
        service.Tariff = tariff;
        tariff.Services.Add(service);

        _serviceRepository.Add(service);
        _serviceRepository.SaveChanges();

        return MapToDto(service);
    }

    public List<ServiceGetDto> GetServices(long tariffId)
    {
        List<ServiceGetDto> serviceDtos = [];

        Tariff tariff = FindTariff(tariffId);

        List<Service> services = tariff.Services.ToList();

        if (services == null || !services.Any())
            throw new ValidationException("Услуги по данному тарифу не найдены.");

        services = services.OrderBy(service => service.Name)
            .ToList();

        services.ForEach(service => serviceDtos.Add(MapToDto(service)));

        return serviceDtos;
    }

    public ServiceGetDto UpdateService(long serviceId, ServiceCreateOrUpdateDto serviceDto)
    {
        Service service = FindService(serviceId);

        service = _mapper.Map(serviceDto, service);
        _serviceRepository.SaveChanges();

        return MapToDto(service);
    }

    public void DeleteService(long serviceId) 
    {
        Service service = FindService(serviceId);

        service.Tariff.Services.Remove(service);

        _serviceRepository.Delete(service);
        _serviceRepository.SaveChanges();
    }

    public Tariff FindTariff(long tariffId)
    {
        return _tariffRepository.GetById(tariffId)
            ?? throw new Exception("Тариф не найден.");
    }

    public ServiceGetDto MapToDto(Service service)
    {
        return _mapper.Map<ServiceGetDto>(service);
    }

    private Service FindService(long serviceId)
    {
        return _serviceRepository.GetById(serviceId)
            ?? throw new ValidationException($"Услуга не найдена.");
    }
}
