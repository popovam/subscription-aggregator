using Microsoft.AspNetCore.Mvc;
using SA.Backend.Responses;
using SA.Domain.Dtos.Comparison;
using SA.Infrastructure.Services.Interfaces;
using Serilog;

namespace SA.Backend.Controllers;

/// <summary>
/// Контроллер для взаимодействия с сравнительной таблицей
/// </summary>
[ApiController]
[Route("api/comparison")]
public class ComparisonController : ControllerBase
{
    private readonly IComparisonService _service;

    public ComparisonController(IComparisonService service)
    {
        _service = service;
    }

    [HttpPost()]
    public IActionResult GetCompariveTable([FromBody] ComparisonDto comparisonDto)
    {
        ApiResponse<ComparativeTableDto> response = new();
        try
        {
            response.Entity = _service.GetComparativeTable(comparisonDto.SubscriptionIds, comparisonDto.ServiceNames);
            return Ok(response.ToJson());
        }
        catch (Exception exception)
        {
            Log.Error(exception, "Не удалось составить сравнительную таблицу. ");

            response.Message = "Не удалось составить сравнительную таблицу. " + exception.Message;
            return BadRequest(response.ToJson());
        }
    }
}
