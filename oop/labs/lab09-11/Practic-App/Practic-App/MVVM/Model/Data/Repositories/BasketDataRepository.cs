using Microsoft.EntityFrameworkCore;
using Practic_App.core.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practic_App.MVVM.Model.Data.Repositories
{
    public class BasketDataRepository: IDataRepository<BasketData>
    {
        private readonly ApplicationDataContext dbContext;

        public BasketDataRepository(ApplicationDataContext dbContext)
        {
            this.dbContext = dbContext;
        }

        public bool AddData(BasketData data)
        {
            try
            {
                dbContext.BasketDatas.Add(data);
                dbContext.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool ChangeData(int id, BasketData newData)
        {
            throw new NotImplementedException();
        }

        public List<BasketData> GetData()
        {
            try
            {
                return dbContext.BasketDatas.ToList();
            }
            catch (Exception ex)
            {
                return new List<BasketData>();
            }
        }

        public bool RemoveData(BasketData data)
        {
            try
            {
                dbContext.BasketDatas.Remove(data);
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
