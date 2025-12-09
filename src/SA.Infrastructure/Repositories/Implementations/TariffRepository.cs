using Microsoft.EntityFrameworkCore;
using SA.Domain.Entities;
using SA.Infrastructure.Contexts;
using SA.Infrastructure.Repositories.Interfaces;
using System.Linq.Expressions;

namespace SA.Infrastructure.Repositories.Implementations;

public class TariffRepository : RepositoryBase, ITariffRepository
{
    public TariffRepository(MainContext context) 
        : base(context)
    {
    }

    public List<Tariff> GetAll(Expression<Func<Tariff, bool>>? filter = null)
    {
        if (filter == null)
            return _context.Tariffs
                .Include(tariff => tariff.Services)
                .ToList();
     
        return _context.Tariffs
            .Include(tariff => tariff.Services)
            .Where(filter)
            .ToList();
    }

    public Tariff? GetById(long tariffId)
    {
        if (tariffId < 0 || tariffId > long.MaxValue)
            return null;

        return _context.Tariffs
            .Include(tariff => tariff.Services)
            .FirstOrDefault(tariff => tariff.Id == tariffId);
    }

    public void Delete(Tariff tariff)
    {
        _context.Tariffs.Remove(tariff);
    }

    public void Add(Tariff tariff)
    {
        _context.Tariffs.Add(tariff);
    }
}
