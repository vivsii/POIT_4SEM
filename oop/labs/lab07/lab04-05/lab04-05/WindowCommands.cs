using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace lab04_05
{
    internal class WindowCommands
    {
        static WindowCommands()
        {
            Exit = new RoutedCommand("Exit", typeof(MainWindow));
            RoutedUICommand = new RoutedUICommand("RoutedUICommand", "RoutedUICommand", typeof(MainWindow));
        }
        public static RoutedCommand Exit { get; set; }
        public static RoutedUICommand RoutedUICommand { get; set; }
    }
}
