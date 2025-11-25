using SA.Domain.Dtos.Subscription;

namespace SA.Domain.Dtos.Topic;

/// <summary>
/// Dto для получения темы
/// </summary>
public class TopicGetDto : IDto
{
    /// <summary>
    /// Идентификатор
    /// </summary>
    public long Id { get; set; }

    /// <summary>
    /// Название
    /// </summary>
    public string Name { get; set; } = string.Empty;

    /// <summary>
    /// Изображение
    /// </summary>
    public byte[]? Image { get; set; }

    /// <summary>
    /// Сервисы по подписке
    /// </summary>
    public ICollection<SubscriptionGetDto>? Subscriptions { get; set; }
}
