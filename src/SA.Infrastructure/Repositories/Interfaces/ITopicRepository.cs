using SA.Domain.Entities;
using System.Linq.Expressions;

namespace SA.Infrastructure.Repositories.Interfaces;

/// <summary>
/// Репозиторий тем
/// </summary>
public interface ITopicRepository
{
    /// <summary>
    /// Получить список тем
    /// </summary>
    /// <param name="filter">Фильтр</param>
    /// <returns>Список тем</returns>
    List<Topic> GetAll(Expression<Func<Topic, bool>>? filter = null);

    /// <summary>
    /// Получить тему
    /// </summary>
    /// <param name="topicId">Идентификатор темы</param>
    /// <returns>Тема</returns>
    Topic? GetById(long topicId);

    /// <summary>
    /// Повысить рейтинг темы
    /// </summary>
    /// <param name="topicId">Идентификатор темы</param>
    void RaiseTopicRating(long topicId);

    /// <summary>
    /// Удалить тему
    /// </summary>
    /// <param name="topic">Тема</param>
    void Delete(Topic topic);

    /// <summary>
    /// Добавить тему
    /// </summary>
    /// <param name="topic">Тема</param>
    void Add(Topic topic);

    /// <summary>
    /// Сохранить изменения
    /// </summary>
    void SaveChanges();
}
