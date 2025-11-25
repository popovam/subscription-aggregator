using SA.Domain.Entities;
using SA.Infrastructure.Contexts;
using System.Linq.Expressions;

namespace SA.Infrastructure.Repositories;

/// <summary>
/// Репозиторий услуг
/// </summary>
public class ServiceRepository : RepositoryBase
{
    public ServiceRepository(MainContext context) 
        : base(context)
    {
    }

    public List<Service> GetAll(Expression<Func<Service, bool>>? filter = null)
    {
        if (filter == null)
            return _context.Services
                .ToList();

        return _context.Services
            .Where(filter)
            .ToList();
    }

    public Service? GetById(long serviceId)
    {
        if (serviceId < 0 || serviceId > long.MaxValue)
            return null;

        return _context.Services
            .FirstOrDefault(service => service.Id == serviceId);
    }

    public void Delete(Service service)
    {
        _context.Services.Remove(service);
    }

    public void Add(Service service)
    {
        _context.Services.Add(service);
    }
}
