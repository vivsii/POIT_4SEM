using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Net.Sockets;
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
    /// Логика взаимодействия для OrderedProducts.xaml
    /// </summary>
    public partial class OrderedProducts : Window
    {
        public OrderedProducts()
        {
            InitializeComponent();
            connectionString = MainWindow.connectionString;
        }
        public string path;
        string script = "";
        string connectionString;
        SqlConnection connection;
        private void Save_Click(object sender, RoutedEventArgs e)
        {
            SqlTransaction tx = null;
            script = "INSERT INTO ORDER_PRODUCTS (OrderID, ProductID, Quantity) VALUES(@orderID, @productID, @quantity)";

            try
            {
                using (connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand(script, connection);
                    SqlParameter idOParam = new SqlParameter("@orderID", OrderID.Text);
                    SqlParameter idCParam = new SqlParameter("@productID", ProductID.Text);
                    SqlParameter lnameParam = new SqlParameter("@quantity", Quantity.Text);
                    command.Parameters.Add(idOParam);
                    command.Parameters.Add(idCParam);
                    command.Parameters.Add(lnameParam);
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
