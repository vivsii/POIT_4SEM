using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Diagnostics;
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
using System.Printing;

namespace lab08
{
    /// <summary>
    /// Логика взаимодействия для Order.xaml
    /// </summary>
    public partial class Order : Window
    {
        public Order()
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
            script = "INSERT INTO ORDERS (OrderID, Client_ID,ProductID, DateOrder, Statuss) VALUES(@orderID, @client_ID, @productID,@dateOrder, @statuss)";

            try
            {
                using (connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand(script, connection);
                    SqlParameter idParam = new SqlParameter("@orderID", OrderID.Text);
                    SqlParameter client_IDParam = new SqlParameter("@client_ID", Client_ID.Text);
                    SqlParameter product_IDParam = new SqlParameter("@productID", Client_ID.Text);
                    SqlParameter dateOrderParam = new SqlParameter("@dateOrder", DateOrder.SelectedDate);
                    SqlParameter statusParam = new SqlParameter("@statuss", Statuss.Text);
                    command.Parameters.Add(idParam);
                    command.Parameters.Add(client_IDParam);
                    command.Parameters.Add(product_IDParam);
                    command.Parameters.Add(dateOrderParam);
                    command.Parameters.Add(statusParam);
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
