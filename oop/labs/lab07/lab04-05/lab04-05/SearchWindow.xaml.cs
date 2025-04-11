using System;
using System.Collections.Generic;
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
using System.Windows.Shapes;

namespace lab04_05
{
    /// <summary>
    /// Логика взаимодействия для SearchWindow.xaml
    /// </summary>
    public partial class SearchWindow : Window
    {
        public string ProductName { get; private set; }
        public List<Product> ProductList { get; private set; }

        public SearchWindow(string initialProductName, List<Product> productList)
        {
            InitializeComponent();
            ProductNameTextBox.Text = initialProductName;
            ProductList = productList;
        }

        private void OK_Click(object sender, RoutedEventArgs e)
        {
            ProductName = ProductNameTextBox.Text;
            DialogResult = true;
            List<Product> foundProducts = SearchProductsByName(ProductName);
            SearchResultsWindow resultsWindow = new SearchResultsWindow(foundProducts);
            resultsWindow.ShowDialog();
        }

        private List<Product> SearchProductsByName(string productName)
        {
            List<Product> foundProducts = new List<Product>();

            // Загружаем все товары из файла XML
            List<Product> allProducts = LoadAllProducts();

            // Выполняем поиск по названию товара
            foreach (Product product in allProducts)
            {
                if (product.ShortName.Contains(productName))
                {
                    foundProducts.Add(product);
                }
            }

            return foundProducts;
        }

        private List<Product> LoadAllProducts()
        {
            ProductManager productManager = new ProductManager();
            return productManager.LoadProducts();
        }

        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            DialogResult = false;
        }
    }
}
