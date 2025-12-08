using SA.Domain.Dtos.Tariff;
using SA.Domain.Entities;

namespace SA.Infrastructure.Services.Interfaces;

/// <summary>
/// Сервис тарифов
/// </summary>
public interface ITariffService
{
    /// <summary>
    /// Создать тариф
    /// </summary>
    /// <param name="subscriptionId">Идентификатор сервиса по подписке</param>
    /// <param name="tariffDto">Модель тарифа</param>
    /// <returns>Модель тарифа</returns>
    TariffGetDto CreateTariff(long subscriptionId, TariffCreateOrUpdateDto tariffDto);

    /// <summary>
    /// Получить список тарифов
    /// </summary>
    /// <param name="subscriptionId">Идентификатор сервиса по подписке</param>
    /// <returns>Список тарифов</returns>
    List<TariffGetDto> GetTariffs(long subscriptionId);

    /// <summary>
    /// Получить тариф
    /// </summary>
    /// <param name="tariffId">Идентификатор тарифа</param>
    /// <returns>Модель тарифа</returns>
    TariffGetDto GetTariff(long tariffId);

    /// <summary>
    /// Обновить тариф
    /// </summary>
    /// <param name="tariffId">Идентификатор тарифа</param>
    /// <param name="tariffDto">Модель тарифа</param>
    /// <returns>Модель тарифа</returns>
    TariffGetDto UpdateTariff(long tariffId, TariffCreateOrUpdateDto tariffDto);

    /// <summary>
    /// Удалить тариф
    /// </summary>
    /// <param name="tariffId">Идентификатор тарифа</param>
    void DeleteTariff(long tariffId);

    /// <summary>
    /// Найти сервис по подписке
    /// </summary>
    /// <param name="subscriptionId">Идентификатор сервиса по подписке</param>
    /// <returns>Подписка</returns>
    Subscription FindSubscription(long subscriptionId);

    /// <summary>
    /// Конвертировать из сущности в модель
    /// </summary>
    /// <param name="tariff">Сущность тарифа</param>
    /// <returns>Модель тарифа</returns>
    TariffGetDto MapToDto(Tariff tariff);
}
