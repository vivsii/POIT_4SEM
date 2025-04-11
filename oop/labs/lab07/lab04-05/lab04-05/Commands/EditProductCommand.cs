using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media.Imaging;

namespace lab04_05.Commands
{
    public class EditProductCommand : ICommand
    {
        private readonly MainWindow _mainWindow;
        private readonly ListBox _productListBox;

        public EditProductCommand(MainWindow mainWindow, ListBox productListBox)
        {
            _mainWindow = mainWindow ?? throw new ArgumentNullException(nameof(mainWindow));
            _productListBox = productListBox ?? throw new ArgumentNullException(nameof(productListBox));
        }

        public event EventHandler CanExecuteChanged;

        public bool CanExecute(object parameter)
        {
            return _mainWindow != null;
        }

        public void Execute(object parameter)
        {
            EditProduct(_productListBox);
        }
        public void EditProduct(object parameter)
        {
            Product selectedProduct = _productListBox.SelectedItem as Product;

            if (selectedProduct == null)
            {
                MessageBox.Show("Пожалуйста, выберите товар для редактирования.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            AddProductDialog dialog = new AddProductDialog();

            dialog.Loaded += (s, args) =>
            {
                dialog.ShortNameTextBox.Text = selectedProduct.ShortName;
                dialog.DescriptionTextBox.Text = selectedProduct.Description;
                dialog.CategoryTextBox.Text = selectedProduct.Category;
                dialog.RatingTextBox.Text = selectedProduct.Rating.ToString();
                dialog.PriceTextBox.Text = selectedProduct.Price.ToString();
                dialog.QuantityTextBox.Text = selectedProduct.Quantity.ToString();
                dialog.IsOutOfStockCheckBox.IsChecked = selectedProduct.IsOutOfStock;
                dialog.QuantityPurchasedTextBox.Text = selectedProduct.QuantityPurchased.ToString();

                if (!string.IsNullOrEmpty(selectedProduct.ImagePath) && System.IO.File.Exists(selectedProduct.ImagePath))
                {
                    dialog.ProductImage.Source = new BitmapImage(new Uri(selectedProduct.ImagePath));
                    dialog.ImagePath = selectedProduct.ImagePath;
                }
            };
            if (dialog.ShowDialog() == true)
            {
                selectedProduct.ShortName = dialog.ShortNameTextBox.Text;
                selectedProduct.Description = dialog.DescriptionTextBox.Text;
                selectedProduct.Category = dialog.CategoryTextBox.Text;
                selectedProduct.Rating = int.Parse(dialog.RatingTextBox.Text);
                selectedProduct.Price = double.Parse(dialog.PriceTextBox.Text);
                selectedProduct.Quantity = int.Parse(dialog.QuantityTextBox.Text);
                selectedProduct.IsOutOfStock = dialog.IsOutOfStockCheckBox.IsChecked ?? false;
                selectedProduct.QuantityPurchased = int.Parse(dialog.QuantityPurchasedTextBox.Text);
                selectedProduct.ImagePath = dialog.ImagePath;
            }
        }
    }

}
