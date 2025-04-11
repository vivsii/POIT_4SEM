using Microsoft.Win32;
using Practic_App.core;
using Practic_App.MVVM.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Media.Imaging;
using System.Windows;
using Practic_App.MVVM.Model.Data;
using Practic_App.MVVM.Model.Data.UW;

namespace Practic_App.MVVM.ViewModel
{
    public class AddTovarViewModal: ObservableObject
    {
        public UnitOfWork DataWorker { get; set; }

        private List<Product> Products { get; set; }

        public RelayCommand CreateProductCommand { get; }
        public RelayCommand ChooseImageCommand { get; }

        private Product _newProduct;
        public Product NewProduct
        {
            get { return _newProduct; }
            set {
                _newProduct = value;
                OnPropertyChanged();
            }
        }

        public AddTovarViewModal(List<Product> products, UnitOfWork dataWorker)
        {
            CreateProductCommand = new RelayCommand(AddProduct);
            ChooseImageCommand = new RelayCommand(ChooseImage);

            NewProduct = new Product();
            Products = products;
            DataWorker = dataWorker;
        }

        private void ChooseImage(object parameter)
        {
            OpenFileDialog op = new OpenFileDialog();
            op.Title = "Select a picture";
            op.Filter = "All supported graphics|*.jpg;*.jpeg;*.png|" +
              "JPEG (*.jpg;*.jpeg)|*.jpg;*.jpeg|" +
              "Portable Network Graphic (*.png)|*.png";
            if (op.ShowDialog() == true)
            {
                NewProduct.Image = op.FileName;
            }
        }

        private void AddProduct(object parameter)
        {
            try
            {
                Product? productRef = parameter as Product;

                if (productRef != null && DataWorker.Products.AddData(productRef))
                {
                    Products.Add(productRef);
                    NewProduct = new Product();
                    MessageBox.Show("Товар успешно добавлен!");
                }
                else
                {
                    MessageBox.Show("Не удалось добавить товар!");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Произошла ошибка при добавлении товара: {ex.Message}");
            }
        }
    }
}
