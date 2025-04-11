using System;
using System.Collections.ObjectModel;
using System.Windows.Input;

namespace lab04_05.Commands
{
    public class AddProductCommand : ICommand
    {
        private readonly MainWindow _mainWindow;
        private readonly ObservableCollection<Product> _products;

        public AddProductCommand(MainWindow mainWindow, ObservableCollection<Product> products)
        {
            _mainWindow = mainWindow ?? throw new ArgumentNullException(nameof(mainWindow));
            _products = products ?? throw new ArgumentNullException(nameof(products));
        }


        public event EventHandler CanExecuteChanged;

        public bool CanExecute(object parameter)
        {
            return _mainWindow != null;
        }

        public void Execute(object parameter)
        {
            _mainWindow.AddProduct();
        }
    }
}
