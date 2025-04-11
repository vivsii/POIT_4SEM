using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practic_App.MVVM.Model
{
    public class BasketData
    {
        public int Id { get; set; }
        public int ProductId { get; set; }
        public int BasketId { get; set; }

        public Basket Basket { get; set; }
        public Product Product { get; set; }
    }
}
