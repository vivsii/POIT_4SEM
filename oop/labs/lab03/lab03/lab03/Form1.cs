using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;
using System.Xml.Serialization;
using System.IO;
using System.Diagnostics;
using Microsoft.VisualBasic;

namespace lab03
{
    public partial class Form1 : Form
    {
        string person;
        Controller controller = new Controller();
        private AccountsData accountsData = new AccountsData();
        private Owner owner { get; set; } = new Owner();
        private Form2 form2Instance;
        public string smsnotification = "unable";
        public string internet = "unable";
        private StatusStrip statusStrip1;
        private ToolStripStatusLabel statusLabel;
        private ToolStripStatusLabel statusLabel1;
        private ToolStripStatusLabel statusLabel2;
        private ToolStripStatusLabel statusLabel3;
        private ToolStripStatusLabel statusLabel4;
        private Timer timer;
        public int CountOfAccounts = 0;
        private ToolStrip toolStrip;
        private ToolStrip toolStrip1;
        private bool isToolStripVisible = true;
        private int currentRowIndex = -1;

        public Form1()
        {
            InitializeComponent();
            InitializeTimer();
            InitializeStatusStrip();
            InitializeToolStrip();
            statusLabel1.Text = "Последнее действие: ";
            statusLabel2.Text = "";
            statusLabel3.Text = "Количество счетов: ";
            statusLabel4.Text = "";

        }
        private void InitializeStatusStrip()
        {
            statusStrip1 = new StatusStrip();
            statusStrip1.Dock = DockStyle.Bottom;
            Controls.Add(statusStrip1);
            statusLabel = new ToolStripStatusLabel();
            statusStrip1.Items.Add(statusLabel);
            statusLabel1 = new ToolStripStatusLabel();
            statusStrip1.Items.Add(statusLabel1);
            statusLabel2 = new ToolStripStatusLabel();
            statusStrip1.Items.Add(statusLabel2);
            statusLabel3 = new ToolStripStatusLabel();
            statusStrip1.Items.Add(statusLabel3);
            statusLabel4 = new ToolStripStatusLabel();
            statusStrip1.Items.Add(statusLabel4);

        }
        private void Timer_Tick(object sender, EventArgs e)
        {
            UpdateStatusLabel();
        }

        private void UpdateStatusLabel()
        {
            statusLabel.Text = $"Текущее время: {DateTime.Now.ToString("HH:mm:ss")}";
        }
        private void InitializeTimer()
        {
            timer = new Timer();
            timer.Interval = 1000; 
            timer.Tick += Timer_Tick;
            timer.Start();
        }
        private void InitializeToolStrip()
        {
            toolStrip = new ToolStrip();
            toolStrip1 = new ToolStrip();
            Controls.Add(toolStrip);
            Controls.Add(toolStrip1);

            // Добавляем кнопки на панель инструментов
            ToolStripDropDownButton searchButton = new ToolStripDropDownButton("Поиск");
            searchButton.DropDownItems.Add("По номеру счета", null, NumberToolStripMenuItem_Click);
            searchButton.DropDownItems.Add("По балансу", null, BalanceToolStripMenuItem_Click);
            searchButton.DropDownItems.Add("По типу вклада", null, TypeToolStripMenuItem_Click);
            searchButton.DropDownItems.Add("По дате открытия", null, DateToolStripMenuItem_Click);
            toolStrip.Items.Add(searchButton);
            ToolStripDropDownButton sortButton = new ToolStripDropDownButton("Сортировка");
            sortButton.DropDownItems.Add("По номеру счета", null, SortNumberToolStripMenuItem_Click);
            sortButton.DropDownItems.Add("По балансу", null, SortBalanceoolStripMenuItem_Click);
            sortButton.DropDownItems.Add("По типу вклада", null, SortTypeToolStripMenuItem_Click);
            sortButton.DropDownItems.Add("По дате открытия", null, SortDateToolStripMenuItem1_Click);
            toolStrip.Items.Add(sortButton);
            AddToolStripButton("Очистить", button4_Click);
            AddToolStripButton("Удалить", button4_Click);
            AddToolStripButton("Вперед", MoveNext);
            AddToolStripButton("Назад", MovePrevious);

            // Добавляем кнопку для скрытия/показа панели инструментов
            ToolStripButton toggleToolStripButton = new ToolStripButton("Скрыть");
            toggleToolStripButton.Click += ToggleToolStripButton_Click;
            toolStrip1.Items.Add(toggleToolStripButton);

        }
        private void MoveNext(object sender, EventArgs e)
        {
            if (currentRowIndex < dataGridView1.Rows.Count - 1)
            {
                currentRowIndex++;
                dataGridView1.Rows[currentRowIndex].Selected = true;
                dataGridView1.CurrentCell = dataGridView1.Rows[currentRowIndex].Cells[0];
            }
        }

        // Метод для перехода к предыдущей строке в DataGridView
        private void MovePrevious(object sender, EventArgs e)
        {
            if (currentRowIndex > 0)
            {
                currentRowIndex--;
                dataGridView1.Rows[currentRowIndex].Selected = true;
                dataGridView1.CurrentCell = dataGridView1.Rows[currentRowIndex].Cells[0];
            }
        }

        private void ToggleToolStripButton_Click(object sender, EventArgs e)
        {
            isToolStripVisible = !isToolStripVisible; // Инвертируем флаг видимости

            // Изменяем видимость панели инструментов
            toolStrip.Visible = isToolStripVisible;

            // Изменяем текст кнопки скрытия/показа
            ((ToolStripButton)sender).Text = isToolStripVisible ? "Скрыть" : "Показать";
        }
        private void AddToolStripButton(string text, EventHandler clickEvent)
        {
            ToolStripButton button = new ToolStripButton(text);
            button.Click += clickEvent;
            toolStrip.Items.Add(button);
        }
        private void Form1_Load(object sender, EventArgs e)
        {
            dataGridView1.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.AllCells;
            dataGridView1.RowsDefaultCellStyle.WrapMode = DataGridViewTriState.True;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            form2Instance = new Form2();
            form2Instance.Show();
            form2Instance.FormClosed += Form2_FormClosed;
        }
        private void Form2_FormClosed(object sender, FormClosedEventArgs e)
        {
            if (form2Instance.IsCorrect())
            {
                owner = form2Instance.OWNER;
                button1.BackColor = Color.Green;
            }
        }
        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            controller.input_Number_Validation(textBox1);
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {
            controller.input_Balance_Validation(textBox2);
        }

        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {
            person = "Fiz";
        }

        private void radioButton2_CheckedChanged(object sender, EventArgs e)
        {
            person = "Yur";

        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            if (checkBox1.Checked)
            {
                smsnotification = "enable";
            }
        }

        private void checkBox2_CheckedChanged(object sender, EventArgs e)
        {
            if (checkBox2.Checked)
            {
                internet = "enable";
            }
        }
        private void button2_Click(object sender, EventArgs e)
        {
            try
            {
                CreateAccount();
                SaveData();
                CountOfAccounts++;
                statusLabel4.Text = CountOfAccounts.ToString();
                button1.BackColor = System.Drawing.Color.GhostWhite;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Заполните все поля!");
            }
        }
        private void CreateAccount()
        {
            try
            {
                Account account = new Account
                (
                    int.Parse(textBox1.Text),
                    comboBox1.Text,
                    double.Parse(textBox2.Text),
                    DateTime.Parse(dateTimePicker1.Text),
                    person,
                    smsnotification,
                    internet,
                    new Owner(owner)
                );

                accountsData.Accounts.Add(account);
                dataGridView1.DataSource = null;
                dataGridView1.DataSource = accountsData.Accounts;
                dataGridView1.Refresh();

                MessageBox.Show("Счет успешно открыт");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка: " + ex.Message);
            }
            statusLabel2.Text = "Сохранили счет";
        }
        private void SaveData()
        {
            try
            {
                using (FileStream stream = new FileStream("accounts.xml", FileMode.Create))
                {
                    XmlSerializer serializer = new XmlSerializer(typeof(AccountsData));
                    serializer.Serialize(stream, accountsData);
                }
                smsnotification = "unable";
                internet = "unable";
                statusLabel2.Text = "Сохранили счет";
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        private void button3_Click(object sender, EventArgs e)
        {
            try
            {
                using (FileStream stream = new FileStream("accounts.xml", FileMode.Open))
                {
                    XmlSerializer serializer = new XmlSerializer(typeof(AccountsData));
                    accountsData = (AccountsData)serializer.Deserialize(stream);
                }
                BindingList<Account> accountsList = new BindingList<Account>(accountsData.Accounts.ToList());
                dataGridView1.DataSource = accountsList;
                MessageBox.Show("Данные успешно загружены из XML файла.");
                statusLabel2.Text = "Загрузили данные из xml-файла";
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        private void button4_Click(object sender, EventArgs e)
        {
            try
            {
                accountsData.Accounts = new List<Account>();
                XmlSerializer serializer = new XmlSerializer(typeof(AccountsData));
                using (FileStream stream = new FileStream("accounts.xml", FileMode.Create))
                {
                    serializer.Serialize(stream, accountsData);
                }
                dataGridView1.DataSource = null;
                dataGridView1.Refresh();
                CountOfAccounts = 0;
                statusLabel4.Text = CountOfAccounts.ToString();
                MessageBox.Show("Данные успешно очищены в XML файле.");
                statusLabel2.Text = "Очистили данные из xml-файла";
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void linkLabel1_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            try
            {
                Process.Start("accounts.xml");
                statusLabel2.Text = "Очистил данные из xml-файл";
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка при открытии файла: " + ex.Message);
            }
        }

        private void AboutProgrammToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MessageBox.Show("\nВерсия: 1.0\nЕвсеенко Виктория Павловна\n");

        }

        private void SortNumberToolStripMenuItem_Click(object sender, EventArgs e)
        {
            accountsData = new AccountsData();
            foreach (DataGridViewRow row in dataGridView1.Rows)
            {
                if (row.DataBoundItem is Account account)
                {
                    accountsData.Accounts.Add(account);
                }
            }
            accountsData.Accounts.Sort((x, y) => x.AccountNumber.CompareTo(y.AccountNumber));

            dataGridView1.DataSource = null;
            dataGridView1.DataSource = accountsData.Accounts;
            dataGridView1.Refresh();
            statusLabel2.Text = "Очистили данные из xml-файла";
        }

        private void SortBalanceoolStripMenuItem_Click(object sender, EventArgs e)
        {
            statusLabel2.Text = "Сортировка по балансу";
            accountsData = new AccountsData();
            foreach (DataGridViewRow row in dataGridView1.Rows)
            {
                if (row.DataBoundItem is Account account)
                {
                    accountsData.Accounts.Add(account);
                }
            }
            accountsData.Accounts.Sort((x, y) => x.Balance.CompareTo(y.Balance));

            dataGridView1.DataSource = null;
            dataGridView1.DataSource = accountsData.Accounts;
            dataGridView1.Refresh();
        }

        private void SortDateToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            statusLabel2.Text = "Сортировка по дате";
            accountsData = new AccountsData();
            foreach (DataGridViewRow row in dataGridView1.Rows)
            {
                if (row.DataBoundItem is Account account)
                {
                    accountsData.Accounts.Add(account);
                }
            }
            accountsData.Accounts.Sort((x, y) => x.DateOpening.CompareTo(y.DateOpening));

            dataGridView1.DataSource = null;
            dataGridView1.DataSource = accountsData.Accounts;
            dataGridView1.Refresh();
        }
        private void SortTypeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            statusLabel2.Text = "Сортировка по типу вклада";
            accountsData = new AccountsData();
            foreach (DataGridViewRow row in dataGridView1.Rows)
            {
                if (row.DataBoundItem is Account account)
                {
                    accountsData.Accounts.Add(account);
                }
            }
            accountsData.Accounts.Sort((x, y) => x.TypeOfDeposite.CompareTo(y.TypeOfDeposite));

            dataGridView1.DataSource = null;
            dataGridView1.DataSource = accountsData.Accounts;
            dataGridView1.Refresh();
        }

        private void NumberToolStripMenuItem_Click(object sender, EventArgs e)
        {
            statusLabel2.Text = "Поиск по номеру счета";
            accountsData = new AccountsData();
            foreach (DataGridViewRow row in dataGridView1.Rows)
            {
                if (row.DataBoundItem is Account account)
                {
                    accountsData.Accounts.Add(account);
                }
            }
            string result = Interaction.InputBox("Введите номер счета:");
            int intresult = int.Parse(result);
            var FindedAccounts = from i in accountsData.Accounts where i.AccountNumber == intresult select i;
            accountsData = new AccountsData();
            foreach (var account in FindedAccounts)
            {
                accountsData.Accounts.Add(account);
            }

            if (accountsData.Accounts.Count() == 0)
            {
                MessageBox.Show("Cчета не найдены");
            }
            else
            {
                Form3 form3 = new Form3(accountsData);
                form3.Show();
            }
        }

        private void TypeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            statusLabel2.Text = "Поиск по типу вклада";
            accountsData = new AccountsData();
            foreach (DataGridViewRow row in dataGridView1.Rows)
            {
                if (row.DataBoundItem is Account account)
                {
                    accountsData.Accounts.Add(account);
                }
            }
            string result = Interaction.InputBox("Введите тип вклада:");
            var FindedAccounts = from i in accountsData.Accounts where i.TypeOfDeposite == result select i;
            accountsData = new AccountsData();
            foreach (var account in FindedAccounts)
            {
                accountsData.Accounts.Add(account);
            }

            if (accountsData.Accounts.Count() == 0)
            {
                MessageBox.Show("Cчета не найдены");
            }
            else
            {
                Form3 form3 = new Form3(accountsData);
                form3.Show();
            }
        }

        private void BalanceToolStripMenuItem_Click(object sender, EventArgs e)
        {
            statusLabel2.Text = "Поиск по балансу";
            accountsData = new AccountsData();
            foreach (DataGridViewRow row in dataGridView1.Rows)
            {
                if (row.DataBoundItem is Account account)
                {
                    accountsData.Accounts.Add(account);
                }
            }
            string result = Interaction.InputBox("Введите баланс на счету:");
            int intresult = int.Parse(result);
            var FindedAccounts = from i in accountsData.Accounts where i.Balance == intresult select i;
            accountsData = new AccountsData();
            foreach (var account in FindedAccounts)
            {
                accountsData.Accounts.Add(account);
            }

            if (accountsData.Accounts.Count() == 0)
            {
                MessageBox.Show("Cчета не найдены");
            }
            else
            {
                Form3 form3 = new Form3(accountsData);
                form3.Show();
            }
        }

        private void DateToolStripMenuItem_Click(object sender, EventArgs e)
        {
            try
            {
                statusLabel2.Text = "Поиск по дате открытия";
                accountsData = new AccountsData();
                foreach (DataGridViewRow row in dataGridView1.Rows)
                {
                    if (row.DataBoundItem is Account account)
                    {
                        accountsData.Accounts.Add(account);
                    }
                }
                string result = Interaction.InputBox("Введите дату открытия счета:");
                DateTime dateresult = DateTime.Parse(result);
                var FindedAccounts = from i in accountsData.Accounts where i.DateOpening == dateresult select i;
                accountsData = new AccountsData();
                foreach (var account in FindedAccounts)
                {
                    accountsData.Accounts.Add(account);
                }

                if (accountsData.Accounts.Count() == 0)
                {
                    MessageBox.Show("Cчета не найдены");
                }
                else
                {
                    Form3 form3 = new Form3(accountsData);
                    form3.Show();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
