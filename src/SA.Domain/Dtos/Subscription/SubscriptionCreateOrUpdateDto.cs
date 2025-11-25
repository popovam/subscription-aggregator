using System.ComponentModel.DataAnnotations;

namespace SA.Domain.Dtos.Subscription;

/// <summary>
/// Dto для создания или обновления подписки
/// </summary>
public class SubscriptionCreateOrUpdateDto : IDto
{
    /// <summary>
    /// Название
    /// </summary>
    [Required(ErrorMessage = "Название сервиса должно быть заполнено.")]
    [MaxLength(100, ErrorMessage = "Название сервиса не должно быть больше {1} символов.")]
    public string Name { get; set; }

    /// <summary>
    /// Ссылка на сервис
    /// </summary>
    [Required(ErrorMessage = "Ссылка на сервис должна быть заполнена.")]
    [MaxLength(500, ErrorMessage = "Ссылка на сервис не должна быть больше {1} символов.")]
    public string Link { get; set; }

    /// <summary>
    /// Изображение
    /// </summary>
    //public byte[]? Image { get; set; }
}
