using Practic_App.core.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practic_App.MVVM.Model.Data.Repositories
{
    public class BasketRepository: IDataRepository<Basket>
    {
        private readonly ApplicationDataContext dbContext;

        public BasketRepository(ApplicationDataContext dbContext)
        {
            this.dbContext = dbContext;
        }

        public bool AddData(Basket data)
        {
            try
            {
                dbContext.Baskets.Add(data);
                dbContext.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool ChangeData(int id, Basket newData)
        {
            throw new NotImplementedException();
        }

        public List<Basket> GetData()
        {
            try
            {
                return dbContext.Baskets.ToList();
            }
            catch (Exception ex)
            {
                return new List<Basket>();
            }
        }

        public bool RemoveData(Basket data)
        {
            try
            {
                dbContext.Baskets.Remove(data);
                dbContext.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}
