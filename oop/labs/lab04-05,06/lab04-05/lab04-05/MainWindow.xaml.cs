using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
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
using System.Windows.Navigation;
using System.Windows.Shapes;
using lab04_05.Commands;

namespace lab04_05
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public ObservableCollection<Product> products = new ObservableCollection<Product>();
        private ProductManager productManager;
        public ICommand AddProductCommand { get; private set; }
        public ICommand EditProductCommand { get; private set; }
        public ICommand DeleteProductCommand { get; private set; }

        public MainWindow()
        {
            InitializeComponent();
            AddProductCommand = new AddProductCommand(this, products);
            EditProductCommand = new EditProductCommand(this, ProductListBox);
            DeleteProductCommand = new DeleteProductCommand(this);
            productManager = new ProductManager();
            products = new ObservableCollection<Product>(productManager.LoadProducts());
            ProductListBox.ItemsSource = products;
            ProductList = new List<Product>();
            DataContext = new MainViewModel(this);
        }


        private void SaveProducts()
        {
            productManager.SaveProducts(products.ToList());
        }

        protected override void OnClosed(EventArgs e)
        {
            base.OnClosed(e);
            SaveProducts();
        }
        public void AddProduct()
        {
            undoStack.Push(new List<Product>(products.ToList()));

            // Добавляем новый товар
            Product newProduct = new Product();
            AddProductDialog dialog = new AddProductDialog();
            dialog.Owner = this;
            if (dialog.ShowDialog() == true)
            {
                // Инициализируем новый продукт данными из диалогового окна
                newProduct.ShortName = dialog.ShortName;
                newProduct.Description = dialog.Description;
                newProduct.Category = dialog.Category;
                newProduct.Rating = dialog.Rating;
                newProduct.Price = dialog.Price;
                newProduct.Quantity = dialog.Quantity;
                newProduct.IsOutOfStock = dialog.IsOutOfStock;
                newProduct.QuantityPurchased = dialog.QuantityPurchased;
                newProduct.ImagePath = dialog.ImagePath;
                products.Add(newProduct);
            }
        }
        

        private void ProductListBox_MouseDoubleClick(object sender, MouseButtonEventArgs e)
{
    // Получаем выбранный товар из списка
    Product selectedProduct = ProductListBox.SelectedItem as Product;

    // Проверяем, что товар был выбран
    if (selectedProduct != null)
    {
        // Создаем и отображаем окно ProductDetailsWindow с выбранным товаром
        ProductDetailsWindow detailsWindow = new ProductDetailsWindow(selectedProduct);
        detailsWindow.ShowDialog();
    }
}
        private void SearchProduct_Click(object sender, RoutedEventArgs e)
        {
            // Создаем и открываем окно для поиска товаров
            SearchWindow searchWindow = new SearchWindow("", ProductList);
            searchWindow.ShowDialog();

            // Получаем результаты поиска из окна
            if (searchWindow.DialogResult == true)
            {
                string productName = searchWindow.ProductName;

                // Выполняем поиск товаров по названию и отображаем результаты
                List<Product> foundProducts = SearchProductsByName(productName);
                ShowSearchResults(foundProducts);
            }
        }
        public List<Product> ProductList;

        // Конструктор и другие методы

        private List<Product> SearchProductsByName(string productName)
        {
            List<Product> foundProducts = new List<Product>();

            foreach (Product product in ProductList)
            {
                if (product.ShortName.Contains(productName))
                {
                    foundProducts.Add(product);
                }
            }

            return foundProducts;
        }

        private void ShowSearchResults(List<Product> foundProducts)
        {
            
        }
        private void SortComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ComboBoxItem selectedItem = (ComboBoxItem)SortComboBox.SelectedItem;
            if (SortComboBox != null && SortComboBox.SelectedItem != null && ProductListBox != null && ProductListBox.ItemsSource != null)
            {
                string selectedSortType = selectedItem.Content.ToString();

                switch (selectedSortType)
                {
                    case "По цене":
                        SortListBoxByPrice();
                        break;
                    case "По названию":
                        SortListBoxByName();
                        break;
                    case "По рейтингу":
                        SortListBoxByRating();
                        break;
                    case "По категории":
                        SortListBoxByCategory();
                        break;
                    case "По количеству":
                        SortListBoxByQuantity();
                        break;
                    case "По количеству купленных":
                        SortListBoxByQuantityPurchased();
                        break;
                    case "By price":
                        SortListBoxByPrice();
                        break;
                    case "By name":
                        SortListBoxByName();
                        break;
                    case "By rating":
                        SortListBoxByRating();
                        break;
                    case "By category":
                        SortListBoxByCategory();
                        break;
                    case "By quantity":
                        SortListBoxByQuantity();
                        break;
                    case "By quantity purchased":
                        SortListBoxByQuantityPurchased();
                        break;
                    default:
                        break;
                }
            }
        }
        

    private void SortListBoxByPrice()
    {
        ICollectionView view = CollectionViewSource.GetDefaultView(ProductListBox.ItemsSource);
        view.SortDescriptions.Clear();
        view.SortDescriptions.Add(new SortDescription("Price", ListSortDirection.Ascending));
    }

    private void SortListBoxByName()
    {
        ICollectionView view = CollectionViewSource.GetDefaultView(ProductListBox.ItemsSource);
        view.SortDescriptions.Clear();
        view.SortDescriptions.Add(new SortDescription("ShortName", ListSortDirection.Ascending));
    }

    private void SortListBoxByRating()
        {
            ICollectionView view = CollectionViewSource.GetDefaultView(ProductListBox.ItemsSource);
            view.SortDescriptions.Clear();
            view.SortDescriptions.Add(new SortDescription("Rating", ListSortDirection.Ascending));
        }

        private void SortListBoxByCategory()
        {
            ICollectionView view = CollectionViewSource.GetDefaultView(ProductListBox.ItemsSource);
            view.SortDescriptions.Clear();
            view.SortDescriptions.Add(new SortDescription("Category", ListSortDirection.Ascending));
        }

        private void SortListBoxByQuantity()
        {
            ICollectionView view = CollectionViewSource.GetDefaultView(ProductListBox.ItemsSource);
            view.SortDescriptions.Clear();
            view.SortDescriptions.Add(new SortDescription("Quantity", ListSortDirection.Ascending));
        }

        private void SortListBoxByQuantityPurchased()
        {
            ICollectionView view = CollectionViewSource.GetDefaultView(ProductListBox.ItemsSource);
            view.SortDescriptions.Clear();
            view.SortDescriptions.Add(new SortDescription("QuantityPurchased", ListSortDirection.Ascending));
        }

        private void RuButtonClick(object sender, RoutedEventArgs e)
        {
            Application.Current.Resources.MergedDictionaries.Clear();

            ResourceDictionary dict = new ResourceDictionary();
            dict.Source = new Uri(@"Languages\Russian.xaml", UriKind.Relative);
            Application.Current.Resources.MergedDictionaries.Add(dict);
        }

        private void EngButtonClick(object sender, RoutedEventArgs e)
        {
            // Очищаем список ресурсов перед добавлением новых
            Application.Current.Resources.MergedDictionaries.Clear();

            // Загружаем ресурсы на русском языке
            ResourceDictionary dict = new ResourceDictionary();
            dict.Source = new Uri(@"Languages\English.xaml", UriKind.Relative);
            Application.Current.Resources.MergedDictionaries.Add(dict);
        }

        private void ThemeToggleButton_Loaded(object sender, RoutedEventArgs e)
        {

        }
        private void ThemeComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            // Получаем ссылку на текущее окно
            Window mainWindow = Application.Current.MainWindow;

            // Получаем выбранный элемент в комбобоксе
            ComboBoxItem selectedItem = (ComboBoxItem)((ComboBox)sender).SelectedItem;

            // Получаем текст выбранного элемента
            string theme = selectedItem.Content.ToString();

            // Меняем тему в зависимости от выбранного элемента
            if (theme == "Light")
            {
                // Загружаем светлую тему
                mainWindow.Resources.MergedDictionaries.Clear();
                mainWindow.Resources.MergedDictionaries.Add(new ResourceDictionary() { Source = new Uri("MainWindowStyle.xaml", UriKind.RelativeOrAbsolute) });
            }
            else if (theme == "Dark")
            {
                // Загружаем темную тему
                mainWindow.Resources.MergedDictionaries.Clear();
                mainWindow.Resources.MergedDictionaries.Add(new ResourceDictionary() { Source = new Uri("DarkTheme.xaml", UriKind.RelativeOrAbsolute) });
            }
        }
        private Stack<List<Product>> undoStack = new Stack<List<Product>>();
        private Stack<List<Product>> redoStack = new Stack<List<Product>>();
        private List<Product> productList = new List<Product>();
        private void Undo_Click(object sender, RoutedEventArgs e)
        {
            if (undoStack.Count > 0)
            {
                // Сохраняем текущее состояние списка продуктов в redoStack перед операцией Undo
                redoStack.Push(new List<Product>(products.ToList()));

                // Восстанавливаем предыдущее состояние списка продуктов из undoStack
                products = new ObservableCollection<Product>(undoStack.Pop());
                ProductListBox.ItemsSource = products;
            }
        }

        // Метод для выполнения операции Redo
        private void Redo_Click(object sender, RoutedEventArgs e)
        {
            if (redoStack.Count > 0)
            {
                // Сохраняем текущее состояние списка продуктов в undoStack перед операцией Redo
                undoStack.Push(new List<Product>(products.ToList()));

                // Восстанавливаем следующее состояние списка продуктов из redoStack
                products = new ObservableCollection<Product>(redoStack.Pop());
                ProductListBox.ItemsSource = products;
            }
        }
        public void SaveProductsState()
        {
            // Сохраняем текущее состояние списка продуктов перед удалением
            undoStack.Push(new List<Product>(products.ToList()));
        }

        // Метод для обновления списка продуктов в ListBox
        private void RefreshProductListBox()
        {
            ProductListBox.ItemsSource = null;
            ProductListBox.ItemsSource = productList;
        }

    }
}
