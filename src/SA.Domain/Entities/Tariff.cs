using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;

namespace SA.Domain.Entities;

/// <summary>
/// Тариф
/// </summary>
public class Tariff
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
    /// Стоимость
    /// </summary>
    public required decimal Price { get; set; }

    /// <summary>
    /// Сервис по подписке
    /// </summary>
    public required Subscription Subscription { get; set; }

    /// <summary>
    /// Услуги
    /// </summary>
    public ICollection<Service> Services { get; set; } = new List<Service>();
}
