using SA.Domain.Dtos.Topic;
using SA.Domain.Entities;

namespace SA.Infrastructure.Services.Interfaces;

/// <summary>
/// Сервис тем
/// </summary>
public interface ITopicService
{
    /// <summary>
    /// Создать тему
    /// </summary>
    /// <param name="topicDto">Модель темы для создания</param>
    /// <returns>Тема</returns>
    TopicGetDto CreateTopic(TopicCreateOrUpdateDto topicDto);

    /// <summary>
    /// Получить список тем
    /// </summary>
    /// <returns>Список тем</returns>
    List<TopicGetDto> GetTopics();

    /// <summary>
    /// Получить тему
    /// </summary>
    /// <param name="topicId">Идентификатор темы</param>
    /// <returns>Тема</returns>
    TopicGetDto GetTopic(long topicId);

    /// <summary>
    /// Обновить тему
    /// </summary>
    /// <param name="topicId">Идентификатор темы</param>
    /// <param name="topicDto">Модель темы для обновления</param>
    /// <returns>Тема</returns>
    TopicGetDto UpdateTopic(long topicId, TopicCreateOrUpdateDto topicDto);

    /// <summary>
    /// Удалить тему
    /// </summary>
    /// <param name="topicId">Идентификатор темы</param>
    void DeleteTopic(long topicId);

    /// <summary>
    /// Конвертировать сущность в модель
    /// </summary>
    /// <param name="topic">Сущность темы</param>
    /// <returns>Модель темы</returns>
    TopicGetDto MapToDto(Topic topic);
}
