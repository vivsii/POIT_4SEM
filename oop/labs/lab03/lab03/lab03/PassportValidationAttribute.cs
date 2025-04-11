using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace lab03
{
    public class PassportValidationAttribute : ValidationAttribute
    {
        private int _minValue;
        private int _maxValue;

        public PassportValidationAttribute(int minValue, int maxValue)
        {
            _minValue = minValue;
            _maxValue = maxValue;
        }

        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            if (value == null)
            {
                return new ValidationResult("Номер не может быть пустым");
            }

            int index;
            if (!int.TryParse(value.ToString(), out index))
            {
                return new ValidationResult("Номер должен быть числом");
            }

            if (index < _minValue || index > _maxValue)
            {
                return new ValidationResult($"Номер должен быть от {_minValue} до {_maxValue}");
            }

            return ValidationResult.Success;
        }
    }
}
