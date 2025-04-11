using System;
using System.Collections.Generic;
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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace lab04_05
{
    /// <summary>
    /// Логика взаимодействия для Events.xaml
    /// </summary>
    public partial class Events : Page
    {
        public Events()
        {
            InitializeComponent();
        }

        private void Control_MouseDown(object sender, MouseButtonEventArgs e)
        {
            textBlock1.Text = textBlock1.Text + "sender: " + sender.ToString() + "\n";
            textBlock1.Text = textBlock1.Text + "source: " + e.Source.ToString() + "\n\n";
        }

        //private void button4_Click(object sender, 
        //    EventArgs e)
        //{
        //    textBlock1.Text = string.Empty;

        //}

        private void Control_MouseEnter(object sender, MouseEventArgs e)
        {
            textBlock1.Text = string.Empty;

            textBlock1.Text = textBlock1.Text + "sender: " + sender.ToString() + "\n";
            textBlock1.Text = textBlock1.Text + "source: " + e.Source.ToString() + "\n\n";
        }

    }
}
