using Practic_App.core.Repositories;
using Practic_App.MVVM.Model.Data.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practic_App.MVVM.Model.Data.UW
{
    public class UnitOfWork
    {
        private readonly ApplicationDataContext _context;

        public UnitOfWork(ApplicationDataContext context)
        {
            _context = context;
            Products = new ProductRepository(_context);
            Users = new UserRepository(_context);
            Baskets = new BasketRepository(_context);
            BasketDatas = new BasketDataRepository(_context);
        }

        public IDataRepository<Product> Products { get; private set; }
        public IDataRepository<User> Users { get; private set; }
        public IDataRepository<Basket> Baskets { get; private set; }
        public IDataRepository<BasketData> BasketDatas { get; private set; }

        public int Complete()
        {
            return _context.SaveChanges();
        }

        public void Dispose()
        {
            _context.Dispose();
        }
    }
}
