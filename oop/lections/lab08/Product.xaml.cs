using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Diagnostics.Metrics;
using System.IO;
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

namespace lab08
{
    /// <summary>
    /// Логика взаимодействия для Product.xaml
    /// </summary>
    public partial class Product : Window
    {
        public Product()
        {
            InitializeComponent();
            connectionString = MainWindow.connectionString;
        }
        public string path;
        string script = "";
        string connectionString;
        SqlConnection connection;

        private void Photo_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                OpenFileDialog openFileDialog = new OpenFileDialog();
                openFileDialog.Filter = "JPG Files (*.jpg)|*.jpg|JPEG Files (*.jpeg)|*.jpeg|PNG Files (*.png)|*.png";
                if (openFileDialog.ShowDialog() == true)
                {
                    string filePath = openFileDialog.FileName;

                    string[] parts = filePath.Split('\\');

                    path = parts[parts.Length - 1];
                    var projectPath = Directory.GetParent(Directory.GetCurrentDirectory()).Parent.Parent.FullName;

                    File.Copy(filePath, projectPath + "/images/" + path, true);

                    imgDynamic.Source = new BitmapImage(new Uri(projectPath + "/images/" + path));
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        }

        private void Save_Click(object sender, RoutedEventArgs e)
        {
            SqlTransaction tx = null;
            script = "INSERT INTO APARTMENT (IDProduct, Name, Description, Price, Category, Image) VALUES(@iDProduct, @name, @description, @price, @category, @image)";

            try
            {
                using (connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand(script, connection);
                    SqlParameter idParam = new SqlParameter("@iDProduct", IDProduct.Text);
                    SqlParameter nameParam = new SqlParameter("@name", Name.Text);
                    SqlParameter descriptionParam = new SqlParameter("@description", Description.Text);
                    SqlParameter priceParam = new SqlParameter("@price", Price.Text);
                    SqlParameter categoryParam = new SqlParameter("@category", Category.Text);
                    SqlParameter imageParam = new SqlParameter("@image", path);
                    command.Parameters.Add(idParam);
                    command.Parameters.Add(nameParam);
                    command.Parameters.Add(descriptionParam);
                    command.Parameters.Add(priceParam);
                    command.Parameters.Add(categoryParam);
                    command.Parameters.Add(imageParam);
                    tx = connection.BeginTransaction();
                    command.Transaction = tx;
                    command.ExecuteNonQuery();
                    tx.Commit();
                    Close();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                if (tx != null && tx.Connection != null && tx.Connection.State == ConnectionState.Open)
                {
                    tx.Rollback();
                }
            }
        }
    }
}
