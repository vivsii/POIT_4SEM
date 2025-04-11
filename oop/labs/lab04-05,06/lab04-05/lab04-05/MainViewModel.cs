using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;
using System.Windows.Input;
using lab04_05.Commands;
namespace lab04_05
{
    public class MainViewModel : INotifyPropertyChanged
    {
        public ICommand AddProductCommand { get; private set; }
        public ICommand EditProductCommand { get; private set; }
        public ICommand DeleteProductCommand { get; private set; }

        public ListBox ProductListBox { get; private set; }
        private Stack<List<Product>> undoStack;

        public MainViewModel(MainWindow mainWindow)
        {
            AddProductCommand = new AddProductCommand(mainWindow, mainWindow.products);
            EditProductCommand = new EditProductCommand(mainWindow, mainWindow.ProductListBox);
            DeleteProductCommand = new DeleteProductCommand(mainWindow);
        }
        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

        private string _exampleProperty;
        public string ExampleProperty
        {
            get { return _exampleProperty; }
            set
            {
                if (_exampleProperty != value)
                {
                    _exampleProperty = value;
                    OnPropertyChanged(nameof(ExampleProperty));
                }
            }
        }
    }
}
