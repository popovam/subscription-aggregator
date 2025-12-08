namespace SA.Domain.Dtos.Comparison;

/// <summary>
/// Сравнительная таблица
/// </summary>
public class ComparativeTableDto : IDto
{
    public ICollection<ComparisonSubscriptionItem> Columns { get; set; } 
        = new List<ComparisonSubscriptionItem>();
}
