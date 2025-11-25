using System.ComponentModel.DataAnnotations;

namespace SA.Domain.Entities;

/// <summary>
/// Сервис по подписке
/// </summary>
public class Subscription
{
    /// <summary>
    /// Идентификатор
    /// </summary>
    [Key]
    public long Id { get; set; }

    /// <summary>
    /// Название
    /// </summary>
    [MaxLength(100)]
    public string Name { get; set; } = string.Empty;

    /// <summary>
    /// Ссылка на сервис
    /// </summary>
    [MaxLength(500)]
    public string Link { get; set; } = string.Empty;

    /// <summary>
    /// Изображение
    /// </summary>
    public byte[]? Image { get; set; }

    /// <summary>
    /// Тема
    /// </summary>
    public Topic Topic { get; set; }

    /// <summary>
    /// Тарифы
    /// </summary>
    public ICollection<Tariff> Tariffs { get; set; } = new List<Tariff>();
}
