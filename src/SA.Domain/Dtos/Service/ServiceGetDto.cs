namespace SA.Domain.Dtos.Service;

/// <summary>
/// Dto для получения услуги
/// </summary>
public class ServiceGetDto : IDto
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
    /// Значение
    /// </summary>
    public string Value { get; set; } = string.Empty;
}
