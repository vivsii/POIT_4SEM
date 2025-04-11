using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Reflection.Emit;
using System.Security.AccessControl;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static lab01.Form1;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace lab01
{
    public partial class Form1 : Form
    {
        String operation = "";
        Double resultValue = 0;
        Double memory = 0;

        public Form1()
        {
            InitializeComponent();
        }

        Calculator calculator;
        public delegate double Operation(double x);
        public Operation Operations;
        public void button1_click(object sender, EventArgs e)
        {
            if(textBox_result.Text == "Ошибка")
            {
                textBox_result.Text = string.Empty;
                textBox_result.Text = textBox_result.Text + button1.Text;
            }
            else
                textBox_result.Text = textBox_result.Text + button1.Text;
        }
        private void button2_click(object sender, EventArgs e)
        {
            if (textBox_result.Text == "Ошибка")
            {
                textBox_result.Text = string.Empty;
            textBox_result.Text = textBox_result.Text + button2.Text;
            }
            else
            textBox_result.Text = textBox_result.Text + button2.Text;
        }
        private void button3_click(object sender, EventArgs e)
        {
            if (textBox_result.Text == "Ошибка")
            {
                textBox_result.Text = string.Empty;
                textBox_result.Text = textBox_result.Text + button3.Text;
            }
            else
                textBox_result.Text = textBox_result.Text + button3.Text;
        }
        private void button4_click(object sender, EventArgs e)
        {
            if (textBox_result.Text == "Ошибка")
            {
                textBox_result.Text = string.Empty;
                textBox_result.Text = textBox_result.Text + button4.Text;
            }
            else
                textBox_result.Text = textBox_result.Text + button4.Text;
        }
        private void button5_click(object sender, EventArgs e)
        {
            if (textBox_result.Text == "Ошибка")
            {
                textBox_result.Text = string.Empty;
                textBox_result.Text = textBox_result.Text + button5.Text;
            }
            else
                textBox_result.Text = textBox_result.Text + button5.Text;
        }
        private void button6_click(object sender, EventArgs e)
        {
            if (textBox_result.Text == "Ошибка")
            {
                textBox_result.Text = string.Empty;
                textBox_result.Text = textBox_result.Text + button6.Text;
            }
            else
                textBox_result.Text = textBox_result.Text + button6.Text;
        }
        private void button7_click(object sender, EventArgs e)
        {
            if (textBox_result.Text == "Ошибка")
            {
                textBox_result.Text = string.Empty;
                textBox_result.Text = textBox_result.Text + button7.Text;
            }
            else
                textBox_result.Text = textBox_result.Text + button7.Text;
        }
        private void button8_click(object sender, EventArgs e)
        {
            if (textBox_result.Text == "Ошибка")
            {
                textBox_result.Text = string.Empty;
                textBox_result.Text = textBox_result.Text + button8.Text;
            }
            else
                textBox_result.Text = textBox_result.Text + button8.Text;
        }
        private void button9_click(object sender, EventArgs e)
        {
            if (textBox_result.Text == "Ошибка")
            {
                textBox_result.Text = string.Empty;
                textBox_result.Text = textBox_result.Text + button9.Text;
            }
            else
                textBox_result.Text = textBox_result.Text + button9.Text;
        }
        private void button10_click(object sender, EventArgs e)
        {
            if (textBox_result.Text == "Ошибка")
            {
                textBox_result.Text = string.Empty;
                textBox_result.Text = textBox_result.Text + button10.Text;
            }
            else
                textBox_result.Text = textBox_result.Text + button10.Text;
        }
        private void button11_click(object sender, EventArgs e)
        {
            if (!textBox_result.Text.Contains(","))
            {
                if(textBox_result.Text == string.Empty)
                {
                    textBox_result.Text = string.Empty;
                }
                else
                    textBox_result.Text = textBox_result.Text + button11.Text;
            }
        }

        public void clear_click(object sender, EventArgs e)
        {
            textBox_result.Text = string.Empty;
        }
        private void button23_Click(object sender, EventArgs e)
        {
            if (!textBox_result.Text.Contains("-"))
            {
                if (textBox_result.Text == string.Empty)
                {
                    textBox_result.Text = string.Empty;
                }
                else
                    resultValue = Double.Parse(textBox_result.Text);
                textBox_result.Text = "-" + resultValue;
            }
            else
                textBox_result.Text = "" + resultValue;
        }

        public void sin_click(object sender, EventArgs e)
        {
            try
            {
                operation = "sin";
                resultValue = Double.Parse(textBox_result.Text);
                textBox_result.Text = "sin" + "(" + textBox_result.Text + ")";
                Operations += (resultValue) => Calculator.sin(resultValue);
            }
            catch
            {
                textBox_result.Text = "Ошибка";
            }
        }
        public void cos_click(object sender, EventArgs e)
        {
            try
            {
                operation = "cos";
                resultValue = Double.Parse(textBox_result.Text);
                textBox_result.Text = "cos" + "(" + textBox_result.Text + ")";
                Operations += (resultValue) => Calculator.cos(resultValue);
            }
            catch
            {
                textBox_result.Text = "Ошибка";
            }
        }
        public void tg_click(object sender, EventArgs e)
        {
            try
            {
                operation = "tg";
                resultValue = Double.Parse(textBox_result.Text);
                textBox_result.Text = "tg" + "(" + textBox_result.Text + ")";
                Operations += (resultValue) => Calculator.tan(resultValue);
            }
            catch
            {
                textBox_result.Text = "Ошибка";
            }
        }
        public void ctg_click(object sender, EventArgs e)
        {
            try
            {
                operation = "ctg";
                resultValue = Double.Parse(textBox_result.Text);
                textBox_result.Text = "ctg" + "(" + textBox_result.Text + ")";
                Operations += (resultValue) => Calculator.ctg(resultValue);
            }
            catch
            {
                textBox_result.Text = "Ошибка";
            }
        }
        private void pow_click(object sender, EventArgs e)
        {
            try
            {
                operation = "pow";
                resultValue = Double.Parse(textBox_result.Text);
                textBox_result.Text = resultValue + "²";
                Operations += (resultValue) => Calculator.pow(resultValue);
            }
            catch
            {
                textBox_result.Text = "Ошибка";
            }
        }
        private void sqrt2_click(object sender, EventArgs e)
        {
            try
            {
                operation = "sqrt2";
                resultValue = Double.Parse(textBox_result.Text);
                textBox_result.Text = "√" + resultValue;
                Operations += (resultValue) => Calculator.sqrt(resultValue);
            }
            catch
            {
                textBox_result.Text = "Ошибка";
            }
        }
        private void sqrt3_click(object sender, EventArgs e)
        {
            try
            {
                operation = "sqrt3";
                resultValue = Double.Parse(textBox_result.Text);
                textBox_result.Text = "∛"+resultValue;
                Operations += (resultValue) => Calculator.sqrt3(resultValue);
            }
            catch
            {
                textBox_result.Text = "Ошибка";
            }
        }
        private void memoryDelete(object sender, EventArgs e)
        {
            try
            {
                memory = 0;
            }
            catch
            {
                textBox_result.Text = "Ошибка";
            }
        }
        private void memory_click(object sender, EventArgs e)
        {
            try
            {
                if (memory == 0)
                {
                    memory = Double.Parse(textBox_result.Text);
                }
                else
                    textBox_result.Text = memory.ToString();
            }
            catch
            {
                textBox_result.Text = "Ошибка";
            }
        }
        public void result_click(object sender, EventArgs e)
        {
            switch(operation)
            {
                case "sin":
                    try
                    {
                        textBox_result.Text = string.Empty;
                        textBox_result.Text = Operations(resultValue).ToString();
                    }
                    catch
                    {
                        textBox_result.Text = "Ошибка";
                    }
                    break;
                case "cos":
                    try
                    {
                        textBox_result.Text = string.Empty;
                        textBox_result.Text = Operations(resultValue).ToString();
                    }
                    catch
                    {
                        textBox_result.Text = "Ошибка";
                    }
                    break;
                case "tg":
                    try
                    {
                        textBox_result.Text = string.Empty;
                        textBox_result.Text = Operations(resultValue).ToString();
                    }
                    catch
                    {
                        textBox_result.Text = "Ошибка";
                    }
                    break;
                case "ctg":
                    try
                    {
                        textBox_result.Text = string.Empty;
                        textBox_result.Text = Operations(resultValue).ToString();
                    }
                    catch 
                    {
                        textBox_result.Text = "Ошибка";
                    }
                    break;
                case "pow":
                    try
                    {
                        textBox_result.Text = string.Empty;
                        textBox_result.Text = Operations(resultValue).ToString();
                    }
                    catch
                    {
                        textBox_result.Text = "Ошибка";
                    }
                    break;
                case "sqrt2":
                    try
                    {
                        textBox_result.Text = string.Empty;
                        textBox_result.Text = Operations(resultValue).ToString();
                    }
                    catch
                    {
                        textBox_result.Text = "Ошибка";
                    }
                    break;
                case "sqrt3":
                    try
                    {
                        textBox_result.Text = string.Empty;
                        textBox_result.Text = Operations(resultValue).ToString();
                    }
                    catch
                    {
                        textBox_result.Text = "Ошибка";
                    }
                    break;
            }
        }
    }
}
