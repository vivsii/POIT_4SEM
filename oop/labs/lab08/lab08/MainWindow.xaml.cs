using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace lab08
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public static string str;
        string script = "";
        public static string connectionString = "Data Source=VIVSII-PC\\SQLEXPRESS;Initial Catalog=CosmeticsShop;Integrated Security=True;TrustServerCertificate=True";
        bool connectionChecked = false;
        DataTable productTable;
        DataTable orderTable;
        DataTable clientsTable;
        DataTable orderedeProductsTable;
        SqlConnection connection;
        SqlCommand command;
        SqlDataAdapter adapter1;
        SqlDataAdapter adapter2;
        SqlDataAdapter adapter3;
        SqlDataAdapter adapter4;
        public MainWindow()
        {
            InitializeComponent();
            Sort_Products.Items.Add("Все строки и столбцы");
            Sort_Products.Items.Add("По id");
            Sort_Products.Items.Add("По названию");
            Sort_Products.Items.Add("По цене(убыванию)");
            Sort_Products.Items.Add("По цене(возрастанию)");
            Sort_Products.Items.Add("По категории");

            Sort_Orders.Items.Add("Все строки и столбцы");
            Sort_Orders.Items.Add("По id заказа");
            Sort_Orders.Items.Add("По id клиента");
            Sort_Orders.Items.Add("По дате заказа");
            Sort_Orders.Items.Add("По статусу заказа");

            Sort_Clients.Items.Add("Все строки и столбцы");
            Sort_Clients.Items.Add("По id");
            Sort_Clients.Items.Add("По имени");
            Sort_Clients.Items.Add("По фамилии");
            Sort_Clients.Items.Add("По email");
            Sort_Clients.Items.Add("По телефону");
        }
        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            if (!connectionChecked)
                CheckConnection();
            try
            {
                connection = new SqlConnection(connectionString);
                connection.Open();

                string sqlExpression = "SELECT * FROM PRODUCTS";
                productTable = new DataTable();
                command = new SqlCommand(sqlExpression, connection);
                adapter1 = new SqlDataAdapter(command);
                adapter1.Fill(productTable);
                ProductGrid.ItemsSource = productTable.DefaultView;

                sqlExpression = "SELECT * FROM ORDERS";
                orderTable = new DataTable();
                command = new SqlCommand(sqlExpression, connection);
                adapter2 = new SqlDataAdapter(command);
                adapter2.Fill(orderTable);
                OrderGrid.ItemsSource = orderTable.DefaultView;

                sqlExpression = "SELECT * FROM CLIENT";
                clientsTable = new DataTable();
                command = new SqlCommand(sqlExpression, connection);
                adapter3 = new SqlDataAdapter(command);
                adapter3.Fill(clientsTable);
                ClientGrid.ItemsSource = clientsTable.DefaultView;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                connection.Close();
            }
        }
        private void CheckConnection()
        {

            try
            {
                using (connection = new SqlConnection(connectionString))
                {
                    try
                    {
                        connection.Open();
                    }
                    catch (SqlException)
                    {
                        using (connection = new SqlConnection(connectionString))
                        {
                            try
                            {
                                connection.Open();
                                var projectPath = Directory.GetParent(Directory.GetCurrentDirectory()).Parent.Parent.FullName;
                                string createDBQuery = "CREATE DATABASE CosteticsShop";
                                SqlCommand createDBCommand = new SqlCommand(createDBQuery, connection);
                                createDBCommand.ExecuteNonQuery();
                                string createTablesQuery = File.ReadAllText(projectPath + @"\Scripts\SQLQuery1.sql");
                                SqlCommand createTablesCommand = new SqlCommand(createTablesQuery, connection);
                                createTablesCommand.ExecuteNonQuery();
                                string insertDataTablesQuery = File.ReadAllText(projectPath + @"\Scripts\SQLQuery2.sql");
                                SqlCommand insertCommand = new SqlCommand(insertDataTablesQuery, connection);
                                insertCommand.ExecuteNonQuery();
                                string createProc1Query = File.ReadAllText(projectPath + @"\Scripts\SQLQuery3.sql");
                                SqlCommand createProc1Command = new SqlCommand(createProc1Query, connection);
                                createProc1Command.ExecuteNonQuery();
                                string createProc2Query = File.ReadAllText(projectPath + @"\Scripts\SQLQuery4.sql");
                                SqlCommand createProc2Command = new SqlCommand(createProc2Query, connection);
                                createProc2Command.ExecuteNonQuery();
                               
                            }
                            catch (SqlException e)
                            {
                                MessageBox.Show(e.Message);
                            }
                        }
                    }
                    finally
                    {
                        connection.Close();
                        connectionChecked = true;
                    }
                }
            }
            catch (ArgumentException e)
            {
                MessageBox.Show(e.Message);
            }
        }
        private void Add_Product_Click(object sender, RoutedEventArgs e)
        {
            var a = new Product();
            try
            {
                a.ShowDialog();
                Window_Loaded(sender, e);
            }
            catch (InvalidOperationException ex)
            {
                MessageBox.Show(ex.Message);
                a.Close();
            }
        }

        private void Add_Сlient_Click(object sender, RoutedEventArgs e)
        {
            var a = new Client();
            try
            {
                a.ShowDialog();
                Window_Loaded(sender, e);
            }
            catch (InvalidOperationException ex)
            {
                MessageBox.Show(ex.Message);
                a.Close();
            }
        }

        
        private void Add_Order_Click(object sender, RoutedEventArgs e)
        {
            var a = new Order();
            try
            {
                a.ShowDialog();
                Window_Loaded(sender, e);
            }
            catch (InvalidOperationException ex)
            {
                MessageBox.Show(ex.Message);
                a.Close();
            }
        }
        private void Update_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                SqlCommandBuilder comandbuilder = new SqlCommandBuilder(adapter1);
                adapter1.Update(productTable);
                adapter1.Update(orderTable);
                adapter1.Update(clientsTable);
                Window_Loaded(sender, e);
            }
            catch (SqlException ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        private void Delete_Product_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (ProductGrid.SelectedItems != null)
                {
                    for (int i = 0; i < ProductGrid.SelectedItems.Count; i++)
                    {
                        DataRowView datarowView = ProductGrid.SelectedItems[i] as DataRowView;
                        if (datarowView != null)
                        {
                            DataRow dataRow = (DataRow)datarowView.Row;
                            dataRow.Delete();
                        }
                    }
                }
                SqlCommandBuilder comandbuilder = new SqlCommandBuilder(adapter1);
                adapter1.Update(productTable);
                Window_Loaded(sender, e);
            }
            catch (SqlException ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        private void Delete_Order_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (OrderGrid.SelectedItems != null)
                {
                    for (int i = 0; i < OrderGrid.SelectedItems.Count; i++)
                    {
                        DataRowView datarowView = OrderGrid.SelectedItems[i] as DataRowView;
                        if (datarowView != null)
                        {
                            DataRow dataRow = (DataRow)datarowView.Row;
                            dataRow.Delete();
                        }
                    }
                }

                SqlCommandBuilder comandbuilder = new SqlCommandBuilder(adapter2);
                adapter2.Update(orderTable);
                Window_Loaded(sender, e);
            }
            catch (SqlException ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        private void Delete_Client_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (ClientGrid.SelectedItems != null)
                {
                    for (int i = 0; i < ClientGrid.SelectedItems.Count; i++)
                    {
                        DataRowView datarowView = ClientGrid.SelectedItems[i] as DataRowView;
                        if (datarowView != null)
                        {
                            DataRow dataRow = (DataRow)datarowView.Row;
                            dataRow.Delete();
                        }
                    }
                }
                SqlCommandBuilder comandbuilder = new SqlCommandBuilder(adapter3);
                adapter3.Update(clientsTable);
                Window_Loaded(sender, e);

            }
            catch (SqlException ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        private void SortProducts(object sender, RoutedEventArgs e)
        {
            switch (Sort_Products.SelectedIndex)
            {
                case 0:
                    script = "ProductID ASC";
                    break;
                case 1:
                    script = "ProductID ASC";
                    break;
                case 2:
                    script = "Name ASC";
                    break;
                case 3:
                    script = "Price ASC";
                    break;
                case 4:
                    script = "Price DESC";
                    break;
                case 5:
                    script = "Category DESC";
                    break;
            }
            productTable.DefaultView.Sort = script;
            ProductGrid.ItemsSource = productTable.DefaultView;
        }
        private void SortOrders(object sender, RoutedEventArgs e)
        {
            switch (Sort_Orders.SelectedIndex)
            {
                case 0:
                    script = "OrderID ASC";
                    break;
                case 1:
                    script = "OrderID ASC";
                    break;
                case 2:
                    script = "Client_ID ASC";
                    break;
                case 3:
                    script = "DateOrder ASC";
                    break;
                case 4:
                    script = "Statuss ASC";
                    break;
            }
            orderTable.DefaultView.Sort = script;
            OrderGrid.ItemsSource = orderTable.DefaultView;
        }
        private void SortClients(object sender, RoutedEventArgs e)
        {
            switch (Sort_Clients.SelectedIndex)
            {
                case 0:
                    script = "ClientID ASC";
                    break;
                case 1:
                    script = "Name ASC";
                    break;
                case 2:
                    script = "LastName ASC";
                    break;
                case 3:
                    script = "Email ASC";
                    break;
                case 4:
                    script = "Phone ASC";
                    break;
            }
            clientsTable.DefaultView.Sort = script;
            ClientGrid.ItemsSource = clientsTable.DefaultView;
        }
        
        private void Procedure1_Click(object sender, RoutedEventArgs e)
        {
            string sqlExpression = "PROC_COUNT_PRODUCTS";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand(sqlExpression, connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                var reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    str = $"{reader.GetName(0)}\t\n";

                    while (reader.Read())
                    {
                        object count = reader.GetValue(0);
                        str += $"{count}\t\n";
                    }
                }
                MessageBox.Show(str);
                reader.Close();
                Window_Loaded(new object(), new RoutedEventArgs());
            }
        }
        private void Procedure2_Click(object sender, RoutedEventArgs e)
        {
            string sqlExpression = "PROC_COUNT_ORDERS";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand(sqlExpression, connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                var reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    str = $"{reader.GetName(0)}\t\n";

                    while (reader.Read())
                    {
                        object count = reader.GetValue(0);
                        str += $"{count}\t\n";
                    }
                }
                MessageBox.Show(str);
                reader.Close();
                Window_Loaded(new object(), new RoutedEventArgs());
            }
        }
        private void Procedure3_Click(object sender, RoutedEventArgs e)
        {
            string sqlExpression = "PROC_COUNT_CLIENTS";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand(sqlExpression, connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                var reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    str = $"{reader.GetName(0)}\t\n";

                    while (reader.Read())
                    {
                        object count = reader.GetValue(0);
                        str += $"{count}\t\n";
                    }
                }
                MessageBox.Show(str);
                reader.Close();
                Window_Loaded(new object(), new RoutedEventArgs());
            }
        }
        private void UPClients_CLick(object sender, RoutedEventArgs e)
        {
            ClientGrid.SelectionMode = DataGridSelectionMode.Single;
            if (ClientGrid.SelectedIndex > 0)
            {
                ClientGrid.SelectedIndex--;
                ClientGrid.ScrollIntoView(ClientGrid.SelectedItem);
            }
        }

        private void DownClients_CLick(object sender, RoutedEventArgs e)
        {
            ClientGrid.SelectionMode = DataGridSelectionMode.Single;
            if (ClientGrid.SelectedIndex < ClientGrid.Items.Count - 1)
            {
                ClientGrid.SelectedIndex++;
                ClientGrid.ScrollIntoView(ClientGrid.SelectedItem);
            }
        }

        private void UPOrders_CLick(object sender, RoutedEventArgs e)
        {
            OrderGrid.SelectionMode = DataGridSelectionMode.Single;
            if (OrderGrid.SelectedIndex > 0)
            {
                OrderGrid.SelectedIndex--;
                OrderGrid.ScrollIntoView(OrderGrid.SelectedItem);
            }
        }

        private void DownOrders_CLick(object sender, RoutedEventArgs e)
        {
            OrderGrid.SelectionMode = DataGridSelectionMode.Single;
            if (OrderGrid.SelectedIndex < OrderGrid.Items.Count - 1)
            {
                OrderGrid.SelectedIndex++;
                OrderGrid.ScrollIntoView(OrderGrid.SelectedItem);
            }
        }

        private void UPProduct_CLick(object sender, RoutedEventArgs e)
        {
            ProductGrid.SelectionMode = DataGridSelectionMode.Single;
            if (ProductGrid.SelectedIndex > 0)
            {
                ProductGrid.SelectedIndex--;
                ProductGrid.ScrollIntoView(ProductGrid.SelectedItem);
            }

        }

        private void DownProduct_CLick(object sender, RoutedEventArgs e)
        {
            ProductGrid.SelectionMode = DataGridSelectionMode.Single;
            if (ProductGrid.SelectedIndex < ProductGrid.Items.Count - 1)
            {
                ProductGrid.SelectedIndex++;
                ProductGrid.ScrollIntoView(ProductGrid.SelectedItem);
            }
        }
        
    }
}