using SA.Domain.Dtos.Service;

namespace SA.Domain.Dtos.Tariff;

/// <summary>
/// Dto для получения тарифа
/// </summary>
public class TariffGetDto : IDto
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
    /// Стоимость
    /// </summary>
    public decimal Price { get; set; }

    /// <summary>
    /// Услуги
    /// </summary>
    public ICollection<ServiceGetDto>? Services { get; set; }
}
