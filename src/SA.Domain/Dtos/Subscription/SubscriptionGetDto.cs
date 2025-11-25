using SA.Domain.Dtos.Tariff;

namespace SA.Domain.Dtos.Subscription;

/// <summary>
/// Dto для получения подписки
/// </summary>
public class SubscriptionGetDto : IDto
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
    /// Ссылка на сервис
    /// </summary>
    public string Link { get; set; } = string.Empty;

    /// <summary>
    /// Изображение
    /// </summary>
    public byte[]? Image { get; set; }

    /// <summary>
    /// Тарифы
    /// </summary>
    public ICollection<TariffGetDto>? Tariffs { get; set; }
}
