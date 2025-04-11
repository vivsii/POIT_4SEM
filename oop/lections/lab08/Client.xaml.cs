using System;
using System.Collections.Generic;
using System.Data;
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
using System.Data.SqlClient;

namespace lab08
{
    /// <summary>
    /// Логика взаимодействия для Client.xaml
    /// </summary>
    public partial class Client : Window
    {
        public Client()
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
            script = "INSERT INTO CLIENT (IDClient, Name, LastName, Email, Phone) VALUES(@iDClient, @name, @count, @lastName, @email, @phone)";

            try
            {
                using (connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand(script, connection);
                    SqlParameter idParam = new SqlParameter("@iDClient", IDClient.Text);
                    SqlParameter nameParam = new SqlParameter("@name", Name.Text);
                    SqlParameter lnameParam = new SqlParameter("@lastName", LastName.Text);
                    SqlParameter emailParam = new SqlParameter("@email", Email.Text);
                    SqlParameter phoneParam = new SqlParameter("@phone", Phone.Text);
                    command.Parameters.Add(idParam);
                    command.Parameters.Add(nameParam);
                    command.Parameters.Add(lnameParam);
                    command.Parameters.Add(emailParam);
                    command.Parameters.Add(phoneParam);
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