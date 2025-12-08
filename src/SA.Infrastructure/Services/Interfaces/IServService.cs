using SA.Domain.Dtos.Service;
using SA.Domain.Entities;

namespace SA.Infrastructure.Services.Interfaces;

/// <summary>
/// Сервис услуг
/// </summary>
public interface IServService
{
    /// <summary>
    /// Создать улугу
    /// </summary>
    /// <param name="tariffId">Идетификатор тарифа</param>
    /// <param name="serviceDto">Модель услуги</param>
    /// <returns>Добавленная услуга</returns>
    ServiceGetDto CreateService(long tariffId, ServiceCreateOrUpdateDto serviceDto);

    /// <summary>
    /// Полусить список услуг
    /// </summary>
    /// <param name="tariffId">Идетификатор тарифа</param>
    /// <returns>Список услуг</returns>
    List<ServiceGetDto> GetServices(long tariffId);
    
    /// <summary>
    /// Обновить услугу
    /// </summary>
    /// <param name="serviceId">Идентификатор услуги</param>
    /// <param name="serviceDto">Модель услуги</param>
    /// <returns>Обновленная услуга</returns>
    ServiceGetDto UpdateService(long serviceId, ServiceCreateOrUpdateDto serviceDto);

    /// <summary>
    /// Удалить услугу
    /// </summary>
    /// <param name="serviceId">Идентификатор услуги</param>
    void DeleteService(long serviceId);

    /// <summary>
    /// Найти тариф
    /// </summary>
    /// <param name="tariffId">Идентификатор тарифа</param>
    /// <returns>Тариф</returns>
    Tariff FindTariff(long tariffId);

    /// <summary>
    /// Конвертировать сущность в модель
    /// </summary>
    /// <param name="service">Сущность услуги</param>
    /// <returns>Модель услуги</returns>
    ServiceGetDto MapToDto(Service service);
}
