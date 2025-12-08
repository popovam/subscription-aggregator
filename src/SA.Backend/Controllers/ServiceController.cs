using Microsoft.AspNetCore.Mvc;
using SA.Backend.Responses;
using SA.Domain.Dtos.Service;
using SA.Infrastructure.Services.Interfaces;
using Serilog;

namespace SA.Backend.Controllers;

/// <summary>
/// Контроллер для взаимодействия с услугами
/// </summary>
[Route("api/services")]
[ApiController]
public class ServiceController : ControllerBase
{
    private readonly IServService _service;
    public ServiceController(IServService service)
    {
        _service = service;
    }

    [HttpPost("new")]
    public IActionResult CreateService(long tariffId, ServiceCreateOrUpdateDto serviceDto)
    {
        ApiResponse<ServiceGetDto> response = new();
        try
        {
            response.Entity = _service.CreateService(tariffId, serviceDto);
            response.Message = "Услуга успешно добавлена.";
            return Ok(response.ToJson());
        }
        catch (Exception exception)
        {
            Log.Error(exception, "Не удалось добавить услугу. ");

            response.Message = "Не удалось добавить услугу. " + exception.Message;
            return BadRequest(response.ToJson());
        }
    }

    [HttpGet("all")]
    public IActionResult GetServices(long tariffId)
    {
        ApiResponse<ServiceGetDto> response = new();
        try
        {
            response.Entities = _service.GetServices(tariffId);
            return Ok(response.ToJson());
        }
        catch (Exception exception)
        {
            Log.Error(exception, "Не удалось получить услуги. ");

            response.Message = "Не удалось получить услуги. " + exception.Message;
            return BadRequest(response.ToJson());
        }
    }

    [HttpPut("{serviceId}")]
    public IActionResult UpdateService(long serviceId, ServiceCreateOrUpdateDto serviceDto)
    {
        ApiResponse<ServiceGetDto> response = new();
        try
        {
            response.Entity = _service.UpdateService(serviceId, serviceDto);
            response.Message = "Услуга успешно обновлена.";
            return Ok(response.ToJson());
        }
        catch (Exception exception)
        {
            Log.Error(exception, "Не удалось обновить услугу. ");

            response.Message = "Не удалось обновить услугу. " + exception.Message;
            return BadRequest(response.ToJson());
        }
    }

    [HttpDelete("{serviceId}")]
    public IActionResult DeleteService(long serviceId)
    {
        ApiResponse<ServiceGetDto> response = new();
        try
        {
            _service.DeleteService(serviceId);
            response.Message = "Услуга успешно удалена.";
            return Ok(response.ToJson());
        }
        catch (Exception exception)
        {
            Log.Error(exception, "Не удалось удалить услугу. ");

            response.Message = "Не удалось удалить услугу. " + exception.Message;
            return BadRequest(response.ToJson());
        }
    }
}
