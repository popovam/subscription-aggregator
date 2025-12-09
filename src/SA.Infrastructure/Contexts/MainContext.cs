using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using SA.Domain.Entities;

namespace SA.Infrastructure.Contexts;

/// <summary>
/// Основной контекст
/// </summary>
public class MainContext : DbContext
{
    public MainContext() : base()
    {
        AppContext.SetSwitch("Npgsql.EnableLegacyTimestampBehavior", true);
    }

    public DbSet<Topic> Topics => Set<Topic>();
    public DbSet<Subscription> Subscriptions => Set<Subscription>();
    public DbSet<Tariff> Tariffs => Set<Tariff>();
    public DbSet<Service> Services => Set<Service>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Subscription>()
            .HasOne(subscription => subscription.Topic)
            .WithMany(topic => topic.Subscriptions)
            .OnDelete(DeleteBehavior.Cascade);

        modelBuilder.Entity<Tariff>()
            .HasOne(tariff => tariff.Subscription)
            .WithMany(subcription => subcription.Tariffs)
            .OnDelete(DeleteBehavior.Cascade);

        modelBuilder.Entity<Service>()
            .HasOne(service => service.Tariff)
            .WithMany(tariff => tariff.Services)
            .OnDelete(DeleteBehavior.Cascade);

        base.OnModelCreating(modelBuilder);
    }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        if (!optionsBuilder.IsConfigured)
        {
            var basePath = Directory.GetCurrentDirectory();

            IConfigurationRoot configuration = new ConfigurationBuilder()
                .SetBasePath(basePath)
                .AddJsonFile("appsettings.json", optional: true)
                .AddJsonFile("appsettings.Development.json", optional: true)
                .Build();

            var connectionString = configuration.GetConnectionString("Database")
                ?? throw new Exception("Не удалось найти строку подключения.");

            optionsBuilder.UseNpgsql(connectionString);
            optionsBuilder.UseSnakeCaseNamingConvention();
        }

        base.OnConfiguring(optionsBuilder);
    }
}
