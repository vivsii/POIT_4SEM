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
    /// Логика взаимодействия для SearchResultsWindow.xaml
    /// </summary>
    public partial class SearchResultsWindow : Window
    {
        public SearchResultsWindow(List<Product> foundProducts)
        {
            InitializeComponent();
            ProductListBox.ItemsSource = foundProducts;
        }
        private void ProductListBox_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            // Получаем выбранный товар из списка
            Product selectedProduct = ProductListBox.SelectedItem as Product;

            // Проверяем, что товар был выбран
            if (selectedProduct != null)
            {
                // Создаем и отображаем окно ProductDetailsWindow с выбранным товаром
                ProductDetailsWindow detailsWindow = new ProductDetailsWindow(selectedProduct);
                detailsWindow.ShowDialog();
            }
        }
    }

}
