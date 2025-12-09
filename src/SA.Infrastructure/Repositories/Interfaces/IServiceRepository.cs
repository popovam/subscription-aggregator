using SA.Domain.Entities;
using System.Linq.Expressions;

namespace SA.Infrastructure.Repositories.Interfaces;

/// <summary>
/// Репозиторий услуг
/// </summary>
public interface IServiceRepository
{
    /// <summary>
    /// Получить список услуг
    /// </summary>
    /// <param name="filter">Фильтр</param>
    /// <returns>Список услуг</returns>
    List<Service> GetAll(Expression<Func<Service, bool>>? filter = null);
    
    /// <summary>
    /// Получить услугу
    /// </summary>
    /// <param name="serviceId">Идентификатор услуги</param>
    /// <returns>Услуга</returns>
    Service? GetById(long serviceId);
    
    /// <summary>
    /// Удалить услугу
    /// </summary>
    /// <param name="service">Услуга</param>
    void Delete(Service service);

    /// <summary>
    /// Добавить услугу
    /// </summary>
    /// <param name="service">Услуга</param>
    void Add(Service service);
    
    /// <summary>
    /// Сохранить изменения
    /// </summary>
    void SaveChanges();
}
