using System.ComponentModel.DataAnnotations;

namespace SA.Domain.Dtos.Service;

/// <summary>
/// Dto для создания или обновления услуги
/// </summary>
public class ServiceCreateOrUpdateDto : IDto
{
    /// <summary>
    /// Название
    /// </summary>
    [Required(ErrorMessage = "Название услуги должно быть заполнено.")]
    [MaxLength(100, ErrorMessage = "Название услуги не должно быть больше {1} символов.")]
    public string Name { get; set; }

    /// <summary>
    /// Значение
    /// </summary>
    [Required(ErrorMessage = "Значение услуги должно быть заполнено.")]
    [MaxLength(100, ErrorMessage = "Значение услуги не должно быть больше {1} символов.")]
    public string Value { get; set; }
}
