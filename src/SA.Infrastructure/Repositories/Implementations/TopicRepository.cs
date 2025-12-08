using Microsoft.EntityFrameworkCore;
using SA.Domain.Entities;
using SA.Infrastructure.Contexts;
using SA.Infrastructure.Repositories.Interfaces;
using System.Linq.Expressions;

namespace SA.Infrastructure.Repositories.Implementations;

public class TopicRepository : RepositoryBase, ITopicRepository
{
    public TopicRepository(MainContext context) 
        : base(context)
    {
    }
    
    public List<Topic> GetAll(Expression<Func<Topic, bool>>? filter = null)
    {
        if (filter == null)
            return _context.Topics
            .Include(topic => topic.Subscriptions)
            .ThenInclude(subscription => subscription.Tariffs)
            .ThenInclude(tariff => tariff.Services)
            .ToList();

        return _context.Topics
            .Include(topic => topic.Subscriptions)
            .ThenInclude(subscription => subscription.Tariffs)
            .ThenInclude(tariff => tariff.Services)
            .Where(filter)
            .ToList();
    }

    public Topic? GetById(long topicId)
    {
        if (topicId < 0 || topicId > long.MaxValue)
            return null;

        return _context.Topics
            .Include(topic => topic.Subscriptions)
            .ThenInclude(subscription => subscription.Tariffs)
            .ThenInclude(tariff => tariff.Services)
            .FirstOrDefault(topic => topic.Id == topicId);
    }

    public void RaiseTopicRating(long topicId)
    {
        Topic? topic = GetById(topicId);
        if (topic == null)
            return;
        
        topic.Rating += 0.0001M;
        
        SaveChanges();
    }

    public void Delete(Topic topic)
    {
        _context.Topics.Remove(topic);
    }

    public void Add(Topic topic)
    {
        _context.Topics.Add(topic);
    }
}
