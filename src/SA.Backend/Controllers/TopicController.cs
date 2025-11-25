using Microsoft.AspNetCore.Mvc;
using SA.Backend.Responses;
using SA.Domain.Dtos.Topic;
using SA.Infrastructure.Services;
using Serilog;

namespace SA.Backend.Controllers;

/// <summary>
/// Контроллер для взаимодействия с темами
/// </summary>
[Route("api/topics")]
[ApiController]
public class TopicController : ControllerBase
{
    private readonly TopicService _service;
    public TopicController(TopicService service)
    {
        _service = service;
    }

    [HttpPost("new")]
    public IActionResult CreateTopic(TopicCreateOrUpdateDto topicDto)
    {
        ApiResponse<TopicGetDto> response = new();
        try
        {
            response.Entity = _service.CreateTopic(topicDto);
            response.Message = "Тема успешно создана.";
            return Ok(response.ToJson());
        }
        catch (Exception exception)
        {
            Log.Error(exception, "Не удалось создать тему. ");

            response.Message = "Не удалось создать тему. " + exception.Message;
            return BadRequest(response.ToJson());
        }
    }

    [HttpGet("all")]
    public IActionResult GetTopics()
    {
        ApiResponse<TopicGetDto> response = new();
        try
        {
            response.Entities = _service.GetTopics();
            return Ok(response.ToJson());
        }
        catch (Exception exception)
        {
            Log.Error(exception, "Не удалось получить темы. ");

            response.Message = "Не удалось получить темы. " + exception.Message;
            return BadRequest(response.ToJson());
        }
    }

    [HttpGet("{topicId}")]
    public IActionResult GetTopics(long topicId)
    {
        ApiResponse<TopicGetDto> response = new();
        try
        {
            response.Entity = _service.GetTopic(topicId);
            return Ok(response.ToJson());
        }
        catch (Exception exception)
        {
            Log.Error(exception, "Не удалось получить тему. ");

            response.Message = "Не удалось получить тему. " + exception.Message;
            return BadRequest(response.ToJson());
        }
    }

    [HttpPut("{topicId}")]
    public IActionResult UpdateTopic(long topicId, TopicCreateOrUpdateDto topicDto)
    {
        ApiResponse<TopicGetDto> response = new();
        try
        {
            response.Entity = _service.UpdateTopic(topicId, topicDto);
            response.Message = "Тема успешно обновлена.";
            return Ok(response.ToJson());
        }
        catch (Exception exception)
        {
            Log.Error(exception, "Не удалось обновить тему. ");

            response.Message = "Не удалось обновить тему. " + exception.Message;
            return BadRequest(response.ToJson());
        }
    }

    [HttpDelete("{topicId}")]
    public IActionResult DeleteTopic(long topicId) 
    {
        ApiResponse<TopicGetDto> response = new();
        try
        {
            _service.DeleteTopic(topicId);
            response.Message = "Тема успешно удалена.";
            return Ok(response.ToJson());
        }
        catch (Exception exception)
        {
            Log.Error(exception, "Не удалось удалить тему. ");

            response.Message = "Не удалось удалить тему. " + exception.Message;
            return BadRequest(response.ToJson());
        }
    }
}
