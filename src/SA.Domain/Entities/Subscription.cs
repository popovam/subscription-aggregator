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
    public required string Name { get; set; }

    /// <summary>
    /// Ссылка на сервис
    /// </summary>
    [MaxLength(500)]
    public required string Link { get; set; }

    /// <summary>
    /// Изображение
    /// </summary>
    public byte[]? Image { get; set; }

    /// <summary>
    /// Тема
    /// </summary>
    public required Topic Topic { get; set; }

    /// <summary>
    /// Тарифы
    /// </summary>
    public ICollection<Tariff> Tariffs { get; set; } = new List<Tariff>();
}
