using Practic_App.core;
using Practic_App.MVVM.Model;
using Practic_App.MVVM.Model.Data;
using Practic_App.MVVM.Model.Data.UW;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace Practic_App.MVVM.ViewModel
{
    public class ProductViewModel: ObservableObject
    {
        public UnitOfWork DataWorker { get; set; }
        public MainViewModal MainViewModal { get; set; }

        public RelayCommand SaveProductCommand { get; }
        public RelayCommand AddBasketCommand { get; }

        private Product _selectedProduct;
        public Product SelectedProduct
        {
            get { return _selectedProduct; }
            set
            {
                _selectedProduct = value;
                OnPropertyChanged();
            }
        }

        public ProductViewModel(Product selectedProduct, UnitOfWork dataWorker, MainViewModal mainViewModal)
        {
            DataWorker = dataWorker;
            MainViewModal = mainViewModal;
            _selectedProduct = selectedProduct;
            SaveProductCommand = new RelayCommand(SaveProduct);
            AddBasketCommand = new RelayCommand(AddToBasket);
        }

        private void AddToBasket(object parameter)
        {
            try
            {
                Product? product = SelectedProduct;

                if (product != null)
                {
                    Basket? basket = DataWorker.Baskets.GetData().FirstOrDefault(b => b.User == MainViewModal.User);

                    if (basket == null)
                    {
                        basket = new Basket { User = MainViewModal.User, UserId = MainViewModal.User.Id };
                        DataWorker.Baskets.AddData(basket);
                    }

                    BasketData basketData = new BasketData { BasketId = basket.Id, ProductId = product.Id };
                    if (DataWorker.BasketDatas.AddData(basketData))
                    {
                        MessageBox.Show("Товар успешно добавлен в корзину!");
                    } else
                    {
                        throw new Exception();
                    }
                }
                else
                {
                    MessageBox.Show("Не удалось добавить товар в корзину!");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Произошла ошибка при добавлении товара в корзину: {ex.Message}");
            }
        }


        private void SaveProduct(object parameter)
        {
            try
            {
                Product? productRef = parameter as Product;

                if (productRef != null)
                {
                    Product? selectedProduct = MainViewModal.TovarLV.Products.FirstOrDefault(p => p.Id == productRef.Id);
                    if (selectedProduct != null)
                    {
                        selectedProduct.Title = productRef.Title;
                        selectedProduct.Company = productRef.Company;
                        selectedProduct.Description = productRef.Description;
                        selectedProduct.Price = productRef.Price;
                        selectedProduct.Image = productRef.Image;

                        if (!DataWorker.Products.ChangeData(productRef.Id, selectedProduct))
                        {
                            throw new Exception();
                        }
                    }

                    MainViewModal.CurrentView = MainViewModal.TovarLV;
                }
                else
                {
                    MessageBox.Show("Не удалось сохранить данные!");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Произошла ошибка при сохранении товара: {ex.Message}");
            }
        }
    }
}
