using Practic_App.core;
using Practic_App.MVVM.Model;
using Practic_App.MVVM.Model.Data;
using Practic_App.MVVM.Model.Data.UW;
using System.Collections.ObjectModel;
using System.Windows;

namespace Practic_App.MVVM.ViewModel
{
    public class DeleteProductViewModel: ObservableObject
    {
        public UnitOfWork DataWorker { get; set; }

        public RelayCommand DeleteProductCommand { get; }

        private List<Product> products;
        public List<Product> Products {
            get { return products; }
            set {
                products = value;
                OnPropertyChanged("Products");
            }
        }

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

        public DeleteProductViewModel(List<Product> _products, UnitOfWork dataWorker)
        {
            DataWorker = dataWorker;
            Products = _products;

            DeleteProductCommand = new RelayCommand(DeleteProduct);
        }

        private void DeleteProduct(object parameter)
        {
            if (SelectedProduct != null)
            {
                Products.Remove(SelectedProduct);
                DataWorker.Products.RemoveData(SelectedProduct);

                MessageBox.Show("Товар успешно удален!");
            }
            else
            {
                MessageBox.Show("Ошибка удаления товара");
            }
        }
    }
}
