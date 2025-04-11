using Practic_App.core;
using Practic_App.MVVM.Model;
using Practic_App.MVVM.Model.Data.UW;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace Practic_App.MVVM.ViewModel
{
    public class BasketViewModel: ObservableObject
    {
        public UnitOfWork DataWorker { get; set; }

        public RelayCommand RemoveProductCommand { get; set; }

        private ObservableCollection<Product> productList;
        public ObservableCollection<Product> ProductList
        {
            get { return productList; }
            set {
                productList = value;
                OnPropertyChanged(nameof(productList));
            }
        }

        public BasketViewModel(UnitOfWork unitOfWork)
        {
            DataWorker = unitOfWork;

            ProductList = new ObservableCollection<Product>();
            RemoveProductCommand = new RelayCommand(RemoveProduct);
        }

        public void GetBasketData()
        {
            Basket? basket = DataWorker.Baskets.GetData().Find(b => b.User == ((MainViewModal)Application.Current.MainWindow.DataContext).User);
            if (basket != null)
            {
                List<BasketData> basketData = DataWorker.BasketDatas.GetData().Where(b => b.Basket == basket).ToList();
                ObservableCollection<Product> products = new ObservableCollection<Product>();
                foreach (BasketData item in basketData)
                {
                    products.Add(item.Product);
                }

                ProductList = products;
            }
            else
            {
                ProductList = new ObservableCollection<Product>();
            }
        }

        private void RemoveProduct(object parameter)
        {
            Product? product = parameter as Product;

            if (product != null)
            {
                Basket? basket = DataWorker.Baskets.GetData().Find(b => b.User == ((MainViewModal)Application.Current.MainWindow.DataContext).User);
                if (basket != null)
                {
                    BasketData? basketDataToRemove = DataWorker.BasketDatas.GetData().FirstOrDefault(bd => bd.Basket == basket && bd.Product == product);
                    if (basketDataToRemove != null)
                    {
                        DataWorker.BasketDatas.RemoveData(basketDataToRemove);
                    }
                }

                productList.Remove(product);
                MessageBox.Show("Товар успешно удален!");
            }
            else
            {
                MessageBox.Show("Ошибка удаления товара из корзины!");
            }
        }

    }
}
