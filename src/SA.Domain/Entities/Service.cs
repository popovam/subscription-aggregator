using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;

namespace SA.Domain.Entities;

/// <summary>
/// Услуга
/// </summary>
public class Service
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
    /// Значение
    /// </summary>
    [MaxLength(100)]
    public required string Value { get; set; }

    /// <summary>
    /// Тариф
    /// </summary>
    public required Tariff Tariff { get; set; }
}
