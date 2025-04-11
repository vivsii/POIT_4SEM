using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace lab02
{
    public partial class Form2 : Form
    {
        public Form2()
        {
            InitializeComponent();
        }
        public Owner OWNER { get; set; }
        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            char[] text = textBox1.Text.ToCharArray();
            if (text.Any(char.IsDigit))
            {
                MessageBox.Show("Некорректная фамилия");
                textBox1.Text = "";
            }
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {
            char[] text = textBox2.Text.ToCharArray();
            if (text.Any(char.IsDigit))
            {
                MessageBox.Show("Некорректное имя");
                textBox2.Text = "";
            }
        }

        private void textBox3_TextChanged(object sender, EventArgs e)
        {
            char[] text = textBox3.Text.ToCharArray();
            if (text.Any(char.IsDigit))
            {
                MessageBox.Show("Некорректное отчество");
                textBox3.Text = "";
            }
        }

        private void textBox4_TextChanged(object sender, EventArgs e)
        {
            char[] text = textBox4.Text.ToCharArray();
            if (text.Any(char.IsDigit))
            {
                MessageBox.Show("Некорректная серия паспорта");
                textBox4.Text = "";
            }
            if (textBox4.Text.Length > 2)
            {
                MessageBox.Show("Серия паспорта должна состоять из не более чем 2 символов");
                textBox4.Text = textBox4.Text.Substring(0, 2); 
                textBox4.SelectionStart = textBox4.Text.Length; 
            }
        }

        private void textBox5_TextChanged(object sender, EventArgs e)
        {
            if (textBox5.Text == "")
            {
                return;
            }
            if (int.TryParse(textBox5.Text, out int Index))
            {
                if (Index < 0 || Index > 999999999)
                {
                    MessageBox.Show("Некорректный номер паспорта");
                    textBox5.Text = "";
                }
            }
            else
            {
                MessageBox.Show("Некорректный номер паспорта");
                textBox5.Text = "";
            }
        }
        public bool IsCorrect()
        {
            return !string.IsNullOrEmpty(textBox1.Text) &&
                   !string.IsNullOrEmpty(textBox2.Text) &&
                   !string.IsNullOrEmpty(textBox3.Text) &&
                   !string.IsNullOrEmpty(textBox4.Text) &&
                   !string.IsNullOrEmpty(textBox5.Text) &&
                   !string.IsNullOrEmpty(dateTimePicker1.Text);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (IsCorrect())
            {
                OWNER = new Owner(textBox1.Text, textBox2.Text, textBox3.Text,
                DateTime.Parse(dateTimePicker1.Text), textBox4.Text, int.Parse(textBox5.Text));
                Close();
            }
            else
            {
                button1.BackColor = Color.Red;
                MessageBox.Show("Заполните все поля перед выполнением действия.", "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}
