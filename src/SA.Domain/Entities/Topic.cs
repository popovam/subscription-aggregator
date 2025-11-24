using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;

namespace SA.Domain.Entities;

/// <summary>
/// Тема
/// </summary>
[Index(nameof(Name), IsUnique = true)]
public class Topic
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
    /// Рейтинг
    /// </summary>
    public decimal Rating { get; set; }

    /// <summary>
    /// Изображение
    /// </summary>
    public byte[]? Image { get; set; }

    /// <summary>
    /// Сервисы по подписке
    /// </summary>
    public ICollection<Subscription> Subscriptions { get; set; } = new List<Subscription>();
}
