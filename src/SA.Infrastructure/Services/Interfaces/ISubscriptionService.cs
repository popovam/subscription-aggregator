using SA.Domain.Dtos.Service;
using SA.Domain.Dtos.Subscription;
using SA.Domain.Entities;

namespace SA.Infrastructure.Services.Interfaces;

/// <summary>
/// Сервис подписок
/// </summary>
public interface ISubscriptionService
{
    /// <summary>
    /// Создать сервис по подписке
    /// </summary>
    /// <param name="topicId">Идентификатор темы</param>
    /// <param name="subscriptionDto">Модель сервиса по подписке</param>
    /// <returns>Модель сервиса по подписке</returns>
    SubscriptionGetDto CreateSubscription(long topicId, SubscriptionCreateOrUpdateDto subscriptionDto);

    /// <summary>
    /// Получить список сервисов по подписке
    /// </summary>
    /// <param name="topicId">Идентификатор темы</param>
    /// <param name="serviceDtos">Список услуг (критерии)</param>
    /// <returns>Список сервисов</returns>
    List<SubscriptionGetDto> GetSubscriptions(long topicId, List<ServiceCreateOrUpdateDto> serviceDtos);

    /// <summary>
    /// Получить сервис по подписке
    /// </summary>
    /// <param name="subscriptionId">Идентификатор сервиса по подписке</param>
    /// <returns>Модель сервиса по подписке</returns>
    SubscriptionGetDto GetSubscription(long subscriptionId);

    /// <summary>
    /// Обновить сервис по подписке
    /// </summary>
    /// <param name="subscriptionId">Идентификатор сервиса по подписке</param>
    /// <param name="subscriptionDto">Модель сервиса по подписке</param>
    /// <returns>Модель сервиса по подписке</returns>
    SubscriptionGetDto UpdateSubscription(long subscriptionId, SubscriptionCreateOrUpdateDto subscriptionDto);

    /// <summary>
    /// Удалить сервис по подписке
    /// </summary>
    /// <param name="subscriptionId">Идентификатор сервиса по подписке</param>
    void DeleteSubscription(long subscriptionId);

    /// <summary>
    /// Найти тему
    /// </summary>
    /// <param name="topicId">Идентификатор темы</param>
    /// <returns>Тема</returns>
    Topic FindTopic(long topicId);

    /// <summary>
    /// Конвертировать из сущности в модель
    /// </summary>
    /// <param name="subscription">Сущность сервиса по подписке</param>
    /// <returns>Модель сервиса по подписке</returns>
    SubscriptionGetDto MapToDto(Subscription subscription);
}
