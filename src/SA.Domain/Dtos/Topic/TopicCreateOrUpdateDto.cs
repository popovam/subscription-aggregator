using System.ComponentModel.DataAnnotations;

namespace SA.Domain.Dtos.Topic;

/// <summary>
/// Dto для создания или обновления темы
/// </summary>
public class TopicCreateOrUpdateDto : IDto
{
    /// <summary>
    /// Название
    /// </summary>
    [Required(ErrorMessage = "Название темы должно быть заполнено.")]
    [MaxLength(100, ErrorMessage = "Название темы не должно быть больше {1} символов.")]
    public string Name { get; set; }

    /// <summary>
    /// Изображение
    /// </summary>
    //public byte[]? Image { get; set; }
}
