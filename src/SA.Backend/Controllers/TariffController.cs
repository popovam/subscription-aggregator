using Microsoft.AspNetCore.Mvc;
using SA.Backend.Responses;
using SA.Domain.Dtos.Tariff;
using SA.Infrastructure.Services;
using Serilog;

namespace SA.Backend.Controllers;

/// <summary>
/// Контроллер для взаимодействия с тарифами
/// </summary>
[Route("api/tariffs")]
[ApiController]
public class TariffController : ControllerBase
{
    private readonly TariffService _service;
    public TariffController(TariffService service)
    {
        _service = service;
    }

    [HttpPost("new")]
    public IActionResult CreateTariff(long subscriptionId, TariffCreateOrUpdateDto tariffDto)
    {
        ApiResponse<TariffGetDto> response = new();
        try
        {
            response.Entity = _service.CreateTariff(subscriptionId, tariffDto);
            response.Message = "Тариф успешно добавлен.";
            return Ok(response.ToJson());
        }
        catch (Exception exception)
        {
            Log.Error(exception, "Не удалось добавить тариф. ");

            response.Message = "Не удалось добавить тариф. " + exception.Message;
            return BadRequest(response.ToJson());
        }
    }

    [HttpGet("all")]
    public IActionResult GetTariffs(long subscriptionId)
    {
        ApiResponse<TariffGetDto> response = new();
        try
        {
            response.Entities = _service.GetTariffs(subscriptionId);
            return Ok(response.ToJson());
        }
        catch (Exception exception)
        {
            Log.Error(exception, "Не удалось получить тарифы. ");

            response.Message = "Не удалось получить тарифы. " + exception.Message;
            return BadRequest(response.ToJson());
        }
    }

    [HttpGet("{tariffId}")]
    public IActionResult GetTariff(long tariffId)
    {
        ApiResponse<TariffGetDto> response = new();
        try
        {
            response.Entity = _service.GetTariff(tariffId);
            return Ok(response.ToJson());
        }
        catch (Exception exception)
        {
            Log.Error(exception, "Не удалось получить тариф. ");

            response.Message = "Не удалось получить тариф. " + exception.Message;
            return BadRequest(response.ToJson());
        }
    }


    [HttpPut("{tariffId}")]
    public IActionResult UpdateTariff(long tariffId, TariffCreateOrUpdateDto tariffDto)
    {
        ApiResponse<TariffGetDto> response = new();
        try
        {
            response.Entity = _service.UpdateTariff(tariffId, tariffDto);
            response.Message = "Тариф успешно обновлен.";
            return Ok(response.ToJson());
        }
        catch (Exception exception)
        {
            Log.Error(exception, "Не удалось обновить тариф. ");

            response.Message = "Не удалось обновить тариф. " + exception.Message;
            return BadRequest(response.ToJson());
        }
    }

    [HttpDelete("{tariffId}")]
    public IActionResult DeleteTariff(long tariffId)
    {
        ApiResponse<TariffGetDto> response = new();
        try
        {
            _service.DeleteTariff(tariffId);
            response.Message = "Тариф успешно удален.";
            return Ok(response.ToJson());
        }
        catch (Exception exception)
        {
            Log.Error(exception, "Не удалось удалить тариф. ");

            response.Message = "Не удалось удалить тариф. " + exception.Message;
            return BadRequest(response.ToJson());
        }
    }
}
