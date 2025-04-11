using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace lab04_05
{
    public class Magazine : DependencyObject
    {
        public static readonly DependencyProperty TitleProperty;
        public static readonly DependencyProperty PriceProperty;

        static Magazine()
        {
            TitleProperty = DependencyProperty.Register("Title", typeof(string), typeof(Magazine));

            FrameworkPropertyMetadata metadata = new FrameworkPropertyMetadata();
            metadata.CoerceValueCallback = new CoerceValueCallback(CorrectValue);//вызываться для коррекции значений свойства перед тем, как они будут присвоены.

            PriceProperty = DependencyProperty.Register("Price", typeof(int), typeof(Magazine), metadata, new ValidateValueCallback(ValidateValue));
        }

        private static object CorrectValue(DependencyObject d, object baseValue)
        {
            int currentValue = (int)baseValue;
            if (currentValue > 500)  // если больше 500, возвращаем 500
                return 500;
            return currentValue; // иначе возвращаем текущее значение
        }
        private static bool ValidateValue(object value)
        {
            int currentValue = (int)value;
            if (currentValue >= 0) // если текущее значение от нуля и выше
                return true;
            return false;
        }
        public string Title
        {
            get { return (string)GetValue(TitleProperty); }
            set { SetValue(TitleProperty, value); }
        }
        public int Price
        {
            get { return (int)GetValue(PriceProperty); }
            set { SetValue(PriceProperty, value); }
        }
    }
}
