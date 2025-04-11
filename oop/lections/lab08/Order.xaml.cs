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
        private void Add_Click(object sender, RoutedEventArgs e)
        {
            var a = new OrderedProducts();
            try
            {
                a.ShowDialog();
            }
            catch (InvalidOperationException ex)
            {
                MessageBox.Show(ex.Message);
                a.Close();
            }
        }

        private void Save_Click(object sender, RoutedEventArgs e)
        {
            SqlTransaction tx = null;
            script = "INSERT INTO APARTMENT (OrderID, Client_ID, DateOrder, Status) VALUES(@orderID, @client_ID, @dateOrder, @status)";

            try
            {
                using (connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand(script, connection);
                    SqlParameter idParam = new SqlParameter("@orderID", OrderID.Text);
                    SqlParameter client_IDParam = new SqlParameter("@client_ID", Client_ID.Text);
                    SqlParameter dateOrterParam = new SqlParameter("@dateOrter", DateOrder.SelectedDate);
                    SqlParameter statusParam = new SqlParameter("@status", Status.Text);
                    command.Parameters.Add(idParam);
                    command.Parameters.Add(client_IDParam);
                    command.Parameters.Add(dateOrterParam);
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
