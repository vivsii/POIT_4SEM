using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Data;
using System.Windows.Media;

namespace lab04_05
{
    public class AvailabilityConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is bool isAvailable && isAvailable)
            {
                return App.Current.Resources["InStock1"]; // используем ресурс для "In stock"
            }
            else
            {
                return App.Current.Resources["OutOfStock"]; // используем ресурс для "Out of stock"
            }
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }

    public class AvailabilityColorConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is bool isAvailable && isAvailable)
            {
                return Brushes.Green; // зеленый цвет, если товар в наличии
            }
            else
            {
                return Brushes.Red; // красный цвет, если товар отсутствует
            }
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
