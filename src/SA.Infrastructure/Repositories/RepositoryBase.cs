using SA.Infrastructure.Contexts;

namespace SA.Infrastructure.Repositories;

/// <summary>
/// Базовый репозиторий
/// </summary>
public abstract class RepositoryBase
{
    protected readonly MainContext _context;

    public RepositoryBase(MainContext context)
    {
        _context = context;
    }

    public void SaveChanges()
    {
        _context.SaveChanges();
    }
}
