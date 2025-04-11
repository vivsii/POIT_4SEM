using lab03;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace lab03
{
    public partial class Form2 : Form
    {
        public Form2()
        {
            InitializeComponent();
        }
        Controller controller = new Controller();
        public Owner OWNER { get; set; }
        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            controller.input_fio_Validation(textBox1);
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {
            controller.input_fio_Validation(textBox2);
        }

        private void textBox3_TextChanged(object sender, EventArgs e)
        {
            controller.input_fio_Validation(textBox3);
        }

        private void textBox4_TextChanged(object sender, EventArgs e)
        {
            controller.input_seria_Validation(textBox4);
        }

        private void textBox5_TextChanged(object sender, EventArgs e)
        {
            controller.input_passport_Validation(textBox5);
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
