using SA.Domain.Dtos.Service;

namespace SA.Domain.Dtos.Comparison;

/// <summary>
/// Сервис по подписке в сравнении
/// </summary>
public class ComparisonSubscriptionItem
{
    public required string SubscriptionName { get; set; }

    public ICollection<ServiceGetDto> Services { get; set; } = new List<ServiceGetDto>();
}
