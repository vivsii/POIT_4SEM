using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace lab04_05.Commands
{
    public class DeleteProductCommand : ICommand
    {
        private MainWindow _mainWindow;

        public DeleteProductCommand(MainWindow mainWindow)
        {
            _mainWindow = mainWindow;
        }

        public event EventHandler CanExecuteChanged;

        public bool CanExecute(object parameter)
        {
            return true;
        }

        public void Execute(object parameter)
        {
            Product selectedProduct = parameter as Product;
            if (selectedProduct == null)
            {
                // Если товар не выбран, выводим сообщение об ошибке
                MessageBox.Show("Пожалуйста, выберите товар для удаления.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            // Сохраняем текущее состояние списка продуктов перед удалением
            _mainWindow.SaveProductsState();

            if (selectedProduct != null)
            {
                _mainWindow.products.Remove(selectedProduct);
            }
        }
    }
}
