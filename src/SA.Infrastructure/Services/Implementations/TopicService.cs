using AutoMapper;
using SA.Domain.Dtos.Topic;
using SA.Domain.Entities;
using SA.Domain.Mapper;
using SA.Infrastructure.Repositories.Interfaces;
using SA.Infrastructure.Services.Interfaces;

namespace SA.Infrastructure.Services.Impementations;

public class TopicService : ITopicService
{
    private readonly ISubscriptionService _subscriptionService;

    private readonly ITopicRepository _topicRepository;

    private readonly IMapper _mapper;

    public TopicService(
        ISubscriptionService subscriptionService,
        ITopicRepository topicRepository, 
        MapperProvider mapperProvider)
    {
        _topicRepository = topicRepository;
        _subscriptionService = subscriptionService;
        _mapper = mapperProvider.GetMapper();
    }

    public TopicGetDto CreateTopic(TopicCreateOrUpdateDto topicDto)
    {
        if (_topicRepository.GetAll(topic => topic.Name == topicDto.Name).Any())
            throw new Exception($"Тема с названием {topicDto.Name} уже существует.");

        Topic topic = _mapper.Map<Topic>(topicDto);

        _topicRepository.Add(topic);
        _topicRepository.SaveChanges();

        return MapToDto(topic);
    }

    public List<TopicGetDto> GetTopics()
    {
        List<TopicGetDto> topicDtos = [];

        List<Topic> topics = _topicRepository.GetAll();

        if (topics == null || !topics.Any())
            throw new Exception("Темы не найдены.");

        topics = topics.OrderByDescending(topic => topic.Rating)
            .ToList();

        topics.ForEach(topic => topicDtos.Add(MapToDto(topic)));

        return topicDtos;
    }

    public TopicGetDto GetTopic(long topicId)
    {
        Topic topic = _subscriptionService.FindTopic(topicId);

        _topicRepository.RaiseTopicRating(topic.Id);

        return MapToDto(topic);
    }

    public TopicGetDto UpdateTopic(long topicId, TopicCreateOrUpdateDto topicDto)
    {
        Topic topic = _subscriptionService.FindTopic(topicId);

        topic = _mapper.Map(topicDto, topic);
        _topicRepository.SaveChanges();

        return MapToDto(topic);
    }

    public void DeleteTopic(long topicId)
    {
        Topic topic = _subscriptionService.FindTopic(topicId);

        _topicRepository.Delete(topic);
        _topicRepository.SaveChanges();
    }

    public TopicGetDto MapToDto(Topic topic)
    {
        TopicGetDto topicDto = _mapper.Map<TopicGetDto>(topic);
        topicDto.Subscriptions = topic.Subscriptions
            .Select(subscription => _subscriptionService.MapToDto(subscription))
            .ToList();

        return topicDto;
    }
}
