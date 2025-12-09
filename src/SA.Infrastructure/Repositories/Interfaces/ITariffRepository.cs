using SA.Domain.Entities;
using System.Linq.Expressions;

namespace SA.Infrastructure.Repositories.Interfaces;

/// <summary>
/// Репозиторий тарифов
/// </summary>
public interface ITariffRepository
{
    /// <summary>
    /// Получить список тарифов
    /// </summary>
    /// <param name="filter">Фильтр</param>
    /// <returns>Список тарифов</returns>
    List<Tariff> GetAll(Expression<Func<Tariff, bool>>? filter = null);

    /// <summary>
    /// Получить тариф
    /// </summary>
    /// <param name="tariffId">Идентификатор тарифа</param>
    /// <returns>Тариф</returns>
    Tariff? GetById(long tariffId);

    /// <summary>
    /// Удалить тариф
    /// </summary>
    /// <param name="tariff">Тариф</param>
    void Delete(Tariff tariff);

    /// <summary>
    /// Добавить тариф
    /// </summary>
    /// <param name="tariff">Тариф</param>
    void Add(Tariff tariff);

    /// <summary>
    /// Сохранить изменения
    /// </summary>
    void SaveChanges();
}
