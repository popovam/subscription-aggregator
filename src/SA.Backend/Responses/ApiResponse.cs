using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using SA.Domain.Dtos;

namespace SA.Backend.Responses;

[JsonObject(NamingStrategyType = typeof(SnakeCaseNamingStrategy))]
public class ApiResponse<TEntity>
    where TEntity : IDto
{
    public string? Message { get; set; }

    public TEntity? Entity { get; set; }

    public ICollection<TEntity>? Entities { get; set; }

    public string ToJson()
    {
        var settings = new JsonSerializerSettings()
        {
            NullValueHandling = NullValueHandling.Ignore,
        };
        return JsonConvert.SerializeObject(this, Formatting.Indented, settings);
    }
}
