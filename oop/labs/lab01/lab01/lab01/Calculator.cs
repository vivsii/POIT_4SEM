using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace lab01
{
    interface IOperation
    {
        double sin(double x);
        double cos(double x);
        double tan(double x);
        double ctg(double x);
        double pown(double x, int n);
        double sqrt(double x);
        double sqrt3(double x);
    }
    public class Calculator 
    {
        public static  double sin(double x)
        {
            return Math.Round(Math.Sin(x),4);
        }
        public static double cos(double x)
        {
            return Math.Round(Math.Cos(x),4);
        }
        public static double tan(double x)
        {
            return Math.Round(Math.Tan(x), 4);
        }
        public static double ctg (double x) 
        { 
            return Math.Round(1 / Math.Tan(x), 4);
        }

        public static double pow(double x)
        {
            return Math.Pow(x, 2);
        }
        public static double sqrt(double x)
        {
            return Math.Round(Math.Sqrt(x), 4);
        }
        public static double sqrt3(double x)
        {
            return Math.Round(Math.Pow(x, 1.0 / 3.0), 4);
        }
        
    }
}
