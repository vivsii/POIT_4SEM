using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Text.RegularExpressions;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using System.Xml.Serialization;
using System.Runtime.Serialization.Formatters.Binary;
using System.IO;
using System.Net;
using System.Xml.Linq;
using System.Data.SqlClient;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.Button;
using System.Diagnostics;

namespace lab02
{
    public partial class Form1 : Form
    {
        string person;
        private AccountsData accountsData = new AccountsData();
        private Owner owner { get; set; } = new Owner();
        private Form2 form2Instance;
        public string smsnotification = "unable";
        public string internet = "unable";
        public Form1()
        {
            InitializeComponent();
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
            if (textBox1.Text == "")
            {
                return;
            }
            if (int.TryParse(textBox1.Text, out int number))
            {
                if (number < 0 || number > 999999999)
                {
                    MessageBox.Show("Некорректный номер");
                    textBox1.Text = "";
                }
            }
            else
            {
                MessageBox.Show("Некорректный номер");
                textBox1.Text = "";
            }
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {
            if (textBox2.Text == "")
            {
                return;
            }
            if (double.TryParse(textBox2.Text, out double number))
            {
                if (number < 0 || number > 999999999999)
                {
                    MessageBox.Show("Некорректный баланс");
                    textBox2.Text = "";
                }
            }
            else
            {
                MessageBox.Show("Некорректный баланс");
                textBox2.Text = "";
            }
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
            if(checkBox1.Checked)
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
                dataGridView1.DataSource = accountsData.Accounts;

                dataGridView1.Refresh();

                MessageBox.Show("Счет успешно открыт");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка: " + ex.Message);
            }
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
                MessageBox.Show("Данные успешно очищены в XML файле.");
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
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка при открытии файла: " + ex.Message);
            }
        }
    }
}
