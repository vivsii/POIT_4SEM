using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace lab03
{
    public class Controller
    {
        public void input_Number_Validation(Control control)
        {
            if (control.Text == "")
            {
                return;
            }
            if (int.TryParse(control.Text, out int number))
                {
                if (number < 0 || number > 999999999999)
                {
                    MessageBox.Show("Некорректный номер");
                    control.Text = "";
                }
            }
            else
            {
                MessageBox.Show("Некорректный номер");
                control.Text = "";
            }

        }
        public void input_Balance_Validation(Control control)
        {
            if (control.Text == "")
            {
                return;
            }
            if (double.TryParse(control.Text, out double number))
                {
                if (number < 0 || number > 999999999)
                {
                    MessageBox.Show("Некорректный баланс");
                    control.Text = "";
                }
            }
            else
            {
                MessageBox.Show("Некорректный баланс");
                control.Text = "";
            }
        }
        public void input_fio_Validation(Control control)
        {
            char[] text = control.Text.ToCharArray();
            if (text.Any(char.IsDigit))
            {
                MessageBox.Show("Некорректная фамилия");
                control.Text = "";
            }
        }
        public void input_seria_Validation(Control control)
        {
            char[] text = control.Text.ToCharArray();
            if (text.Any(char.IsDigit))
            {
                MessageBox.Show("Некорректная серия паспорта");
                control.Text = "";
            }
            if (control.Text.Length > 2)
            {
                MessageBox.Show("Серия паспорта должна состоять из не более чем 2 символов");
                control.Text = control.Text.Substring(0, 2);
            }
        }
        public void input_passport_Validation(Control control)
        {
            if (control.Text == "")
            {
                return;
            }
            if (int.TryParse(control.Text, out int Index))
            {
                if (Index < 0 || Index > 999999999)
                {
                    MessageBox.Show("Некорректный номер паспорта");
                    control.Text = "";
                }
            }
            else
            {
                MessageBox.Show("Некорректный номер паспорта");
                control.Text = "";
            }
        }
    }
}
