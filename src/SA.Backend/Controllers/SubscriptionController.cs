using Microsoft.AspNetCore.Mvc;
using SA.Backend.Responses;
using SA.Domain.Dtos.Service;
using SA.Domain.Dtos.Subscription;
using SA.Infrastructure.Services;
using Serilog;

namespace SA.Backend.Controllers;

/// <summary>
/// Контроллер для взаимодействия с сервисами по подписке
/// </summary>
[Route("api/subscriptions")]
[ApiController]
public class SubscriptionController : ControllerBase
{
    private readonly SubscriptionService _service;
    public SubscriptionController(SubscriptionService service)
    {
        _service = service;
    }

    [HttpPost("new")]
    public IActionResult CreateSubscription(long topicId, SubscriptionCreateOrUpdateDto subscriptionDto)
    {
        ApiResponse<SubscriptionGetDto> response = new();
        try
        {
            response.Entity = _service.CreateSubscription(topicId, subscriptionDto);
            response.Message = "Сервис успешно добавлен.";
            return Ok(response.ToJson());
        }
        catch (Exception exception)
        {
            Log.Error(exception, "Не удалось добавить сервис. ");

            response.Message = "Не удалось добавить сервис. " + exception.Message;
            return BadRequest(response.ToJson());
        }
    }

    [HttpPost("{topicId}/all")]
    public IActionResult GetSubscriptions(long topicId, List<ServiceCreateOrUpdateDto> serviceDtos)
    {
        ApiResponse<SubscriptionGetDto> response = new();
        try
        {
            response.Entities = _service.GetSubscriptions(topicId, serviceDtos);
            return Ok(response.ToJson());
        }
        catch (Exception exception)
        {
            Log.Error(exception, "Не удалось получить сервисы. ");

            response.Message = "Не удалось получить сервисы. " + exception.Message;
            return BadRequest(response.ToJson());
        }
    }

    [HttpGet("{subscriptionId}")]
    public IActionResult GetSubscription(long subscriptionId)
    {
        ApiResponse<SubscriptionGetDto> response = new();
        try
        {
            response.Entity = _service.GetSubscription(subscriptionId);
            return Ok(response.ToJson());
        }
        catch (Exception exception)
        {
            Log.Error(exception, "Не удалось получить сервис. ");

            response.Message = "Не удалось получить сервис. " + exception.Message;
            return BadRequest(response.ToJson());
        }
    }

    [HttpPut("{subscriptionId}")]
    public IActionResult UpdateSubscription(long subscriptionId, SubscriptionCreateOrUpdateDto subscriptionDto)
    {
        ApiResponse<SubscriptionGetDto> response = new();
        try
        {
            response.Entity = _service.UpdateSubscription(subscriptionId, subscriptionDto);
            response.Message = "Сервис успешно обновлен.";
            return Ok(response.ToJson());
        }
        catch (Exception exception)
        {
            Log.Error(exception, "Не удалось обновить сервис. ");

            response.Message = "Не удалось обновить сервис. " + exception.Message;
            return BadRequest(response.ToJson());
        }
    }

    [HttpDelete("{subscriptionId}")]
    public IActionResult DeleteSubscription(long subscriptionId)
    {
        ApiResponse<SubscriptionGetDto> response = new();
        try
        {
            _service.DeleteSubscription(subscriptionId);
            response.Message = "Сервис успешно удален.";
            return Ok(response.ToJson());
        }
        catch (Exception exception)
        {
            Log.Error(exception, "Не удалось удалить сервис. ");

            response.Message = "Не удалось удалить сервис. " + exception.Message;
            return BadRequest(response.ToJson());
        }
    }
}
