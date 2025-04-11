using Practic_App.core;
using Practic_App.MVVM.Model;
using Practic_App.MVVM.Model.Data;
using Practic_App.MVVM.Model.Data.UW;
using System.Collections.ObjectModel;

namespace Practic_App.MVVM.ViewModel
{
    public class TovarListViewModel: ObservableObject
    {
        public MainViewModal MainViewModal { get; set; }
        public UnitOfWork DataWorker { get; set; }

        public RelayCommand SelectProductCommand { get; }

        private Product _selectedProduct;
        public Product SelectedProduct { 
            get { return _selectedProduct; } 
            set {
                _selectedProduct = value;
                OnPropertyChanged();
            }
        }

        private List<Product> _products;
        public List<Product> Products
        {
            get
            {
                return _products;
            }
            set
            {
                _products = value;
                OnPropertyChanged();
            }
        }

        public TovarListViewModel(MainViewModal mainViewModal, UnitOfWork dataWorker) {
            DataWorker = dataWorker;
            MainViewModal = mainViewModal;

            Products = DataWorker.Products.GetData();
            SelectProductCommand = new RelayCommand(ShowSelectedProduct);
        }

        private void ShowSelectedProduct(object parameter)
        {
            Product? productRef = parameter as Product;

            if (productRef != null)
            {
                MainViewModal.CurrentView = new ProductViewModel(new Product(productRef), DataWorker, MainViewModal);
            }
        }
    }
}
