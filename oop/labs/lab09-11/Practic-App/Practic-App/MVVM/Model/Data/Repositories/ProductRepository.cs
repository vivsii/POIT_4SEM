using Practic_App.core.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practic_App.MVVM.Model.Data.Repositories
{
    public class ProductRepository: IDataRepository<Product> 
    {
        private readonly ApplicationDataContext dbContext;

        public ProductRepository(ApplicationDataContext dbContext)
        {
            this.dbContext = dbContext;
        }

        public bool AddData(Product data)
        {
            using (var transaction = dbContext.Database.BeginTransaction())
            {
                try
                {
                    dbContext.Products.Add(data);
                    dbContext.SaveChanges();
                    transaction.Commit();
                    return true;
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    return false;
                }
            }
        }

        public bool ChangeData(int id, Product newData)
        {
            try
            {
                Product product = dbContext.Products.Find(id);

                if (product != null)
                {
                    product.Title = newData.Title;
                    product.Company = newData.Company;
                    product.Description = newData.Description;
                    product.Price = newData.Price;
                    product.Image = newData.Image;

                    dbContext.SaveChanges();
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public List<Product> GetData()
        {
            try
            {
                return dbContext.Products.ToList();
            }
            catch (Exception ex)
            {
                return new List<Product>();
            }
        }

        public bool RemoveData(Product data)
        {
            try
            {
                dbContext.Products.Remove(data);
                dbContext.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        //public async Task LoadDataAsync()
        //{
        //    try
        //    {
        //        var data = await ProductRepository.GetData();
        //    }
        //    catch (Exception ex)
        //    {
        //    return false;
        //    }
        //}
    }
}
