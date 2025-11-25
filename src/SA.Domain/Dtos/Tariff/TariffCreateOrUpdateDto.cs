using System.ComponentModel.DataAnnotations;

namespace SA.Domain.Dtos.Tariff;

/// <summary>
/// Dto для создания или обновления тарифа
/// </summary>
public class TariffCreateOrUpdateDto : IDto
{
    /// <summary>
    /// Название
    /// </summary>
    [Required(ErrorMessage = "Название тарифа должно быть заполнено.")]
    [MaxLength(100, ErrorMessage = "Название тарифа не должно быть больше {1} символов.")]
    public string Name { get; set; }

    /// <summary>
    /// Стоимость
    /// </summary>
    [Required(ErrorMessage = "Стоимость тарифа должна быть заполнена.")]
    public decimal Price { get; set; }
}
