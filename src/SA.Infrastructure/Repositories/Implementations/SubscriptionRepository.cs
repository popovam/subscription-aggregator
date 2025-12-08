using Microsoft.EntityFrameworkCore;
using SA.Domain.Entities;
using SA.Infrastructure.Contexts;
using SA.Infrastructure.Repositories.Interfaces;
using System.Linq.Expressions;

namespace SA.Infrastructure.Repositories.Implementations;

public class SubscriptionRepository : RepositoryBase, ISubscriptionRepository
{
    public SubscriptionRepository(MainContext context) 
        : base(context)
    {
    }

    public List<Subscription> GetAll(Expression<Func<Subscription, bool>>? filter = null)
    {
        if (filter == null)
            return _context.Subscriptions
                .Include(subscription => subscription.Tariffs)
                .ThenInclude(tariff => tariff.Services)
                .ToList();

        return _context.Subscriptions
            .Include(subscription => subscription.Tariffs)
            .ThenInclude(tariff => tariff.Services)
            .Where(filter)
            .ToList();
    }

    public Subscription? GetById(long subscriptionId)
    {
        if (subscriptionId < 0 || subscriptionId > long.MaxValue)
            return null;

        return _context.Subscriptions
            .Include(subscription => subscription.Tariffs)
            .ThenInclude(tariff => tariff.Services)
            .FirstOrDefault(subscription => subscription.Id == subscriptionId);
    }

    public void Delete(Subscription subscription)
    {
        _context.Subscriptions.Remove(subscription);
    }

    public void Add(Subscription subscription)
    {
        _context.Subscriptions.Add(subscription);
    }
}
