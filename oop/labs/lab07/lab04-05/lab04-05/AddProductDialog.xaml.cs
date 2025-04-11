using Microsoft.Win32;
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
    /// Логика взаимодействия для AddProductDialog.xaml
    /// </summary>
    public partial class AddProductDialog : Window
    {
        // Свойство для хранения пути к изображению товара
        public string ImagePath { get; set; }
        public string ShortName { get; set; }
        public string Description { get; set; }
        public string Category { get; set; }
        public int Rating { get; set; }
        public double Price { get; set; }
        public int Quantity { get; set; }
        public bool IsOutOfStock { get; set; }
        public int QuantityPurchased { get; set; }

        public AddProductDialog()
        {
            InitializeComponent();
        }

        // Обработчик нажатия кнопки "Выбрать изображение"
        private void Save_Click(object sender, RoutedEventArgs e)
        {
            object errorFillAllFieldsResource = App.Current.Resources["ErrorFillAllFields"];
            object errorInvalidNumericValuesResource = App.Current.Resources["ErrorInvalidNumericValues"];

            if (errorFillAllFieldsResource != null && errorInvalidNumericValuesResource != null)
            {
                // Проверяем, что все необходимые поля заполнены
                if (string.IsNullOrEmpty(ShortNameTextBox.Text) ||
                    string.IsNullOrEmpty(DescriptionTextBox.Text) ||
                    string.IsNullOrEmpty(CategoryTextBox.Text) ||
                    string.IsNullOrEmpty(RatingTextBox.Text) ||
                    string.IsNullOrEmpty(PriceTextBox.Text) ||
                    string.IsNullOrEmpty(QuantityTextBox.Text) ||
                    string.IsNullOrEmpty(QuantityPurchasedTextBox.Text))
                {
                    MessageBox.Show(errorFillAllFieldsResource.ToString(), "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                // Проверяем, что введены корректные числовые значения для цены, количества и т. д.
                double price;
                int rating, quantity, quantityPurchased;
                if (!double.TryParse(PriceTextBox.Text, out price) ||
                    !int.TryParse(RatingTextBox.Text, out rating) ||
                    !int.TryParse(QuantityTextBox.Text, out quantity) ||
                    !int.TryParse(QuantityPurchasedTextBox.Text, out quantityPurchased))
                {
                    MessageBox.Show(errorInvalidNumericValuesResource.ToString(), "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }


                // Устанавливаем свойства класса AddProductDialog
                ShortName = ShortNameTextBox.Text;
                Description = DescriptionTextBox.Text;
                Category = CategoryTextBox.Text;
                Rating = rating;
                Price = price;
                Quantity = quantity;
                QuantityPurchased = quantityPurchased;

                // Устанавливаем свойство IsOutOfStock в зависимости от состояния чекбокса
                IsOutOfStock = IsOutOfStockCheckBox.IsChecked ?? false;

                // Устанавливаем свойство ItemSource для ListBox равным обновленной коллекции товаров
                DialogResult = true;
            }
        }

        // Обработчик нажатия кнопки "Выбрать изображение"
        private void SelectImage_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog();
            openFileDialog.Filter = "Image Files (*.jpg; *.jpeg; *.png; *.bmp)|*.jpg; *.jpeg; *.png; *.bmp";
            if (openFileDialog.ShowDialog() == true)
            {
                // Пользователь выбрал изображение
                ImagePath = openFileDialog.FileName;
                ProductImage.Source = new BitmapImage(new Uri(ImagePath));
            }
        }
        // Обработчик нажатия кнопки "Отменить"
        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            // Закрываем окно диалога с результатом "Cancel"
            DialogResult = false;
        }
    }
}
