using SA.Domain.Dtos.Comparison;

namespace SA.Infrastructure.Services.Interfaces;

/// <summary>
/// Сервис сравнения
/// </summary>
public interface IComparisonService
{
    /// <summary>
    /// Получить сравнительную таблицу
    /// </summary>
    /// <param name="comparisonDto">Данные для сравнения</param>
    /// <returns>Сравнительная таблица</returns>
    ComparativeTableDto GetComparativeTable(List<long> subscriptionIds, List<string> serviceNames);
}
