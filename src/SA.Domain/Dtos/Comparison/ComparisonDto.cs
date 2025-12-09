namespace SA.Domain.Dtos.Comparison;

/// <summary>
/// Dto для сравнения
/// </summary>
public class ComparisonDto : IDto
{
    public List<long> SubscriptionIds { get; set; } = new List<long>();

    public List<string> ServiceNames { get; set; } = new List<string>();
}
