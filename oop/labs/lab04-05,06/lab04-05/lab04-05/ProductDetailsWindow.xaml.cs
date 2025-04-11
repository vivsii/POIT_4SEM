using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace lab04_05
{
    /// <summary>
    /// Логика взаимодействия для ProductDetailsWindow.xaml
    /// </summary>
    public partial class ProductDetailsWindow : Window
    {
        private Product product;

        public ProductDetailsWindow(Product product)
        {
            InitializeComponent();
            this.product = product;
            DataContext = product; // Устанавливаем выбранный продукт как контекст данных для окна
        }

        // Остальная логика окна
    }

}
