using SA.Domain.Entities;
using System.Linq.Expressions;

namespace SA.Infrastructure.Repositories.Interfaces;

/// <summary>
/// Репозиторий сервисов по подписке
/// </summary>
public interface ISubscriptionRepository
{
    /// <summary>
    /// Получить список подписок
    /// </summary>
    /// <param name="filter">Фильтр</param>
    /// <returns>Список подписок</returns>
    List<Subscription> GetAll(Expression<Func<Subscription, bool>>? filter = null);

    /// <summary>
    /// Получить подписку
    /// </summary>
    /// <param name="subscriptionId">Идентификатор подписки</param>
    /// <returns>Подписка</returns>
    Subscription? GetById(long subscriptionId);

    /// <summary>
    /// Удалить подписку
    /// </summary>
    /// <param name="subscription">Подписка</param>
    void Delete(Subscription subscription);

    /// <summary>
    /// Добавить подписку
    /// </summary>
    /// <param name="subscription">Подписка</param>
    void Add(Subscription subscription);

    /// <summary>
    /// Сохранить изменения
    /// </summary>
    void SaveChanges();
}
