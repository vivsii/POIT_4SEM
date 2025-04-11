using Practic_App.core.Repositories;

namespace Practic_App.MVVM.Model.Data
{
    public static class DataWorker
    {
        public static bool AddProduct(Product product)
        {
            try
            {
                using (ApplicationDataContext db = new ApplicationDataContext())
                {
                    db.Products.Add(product);
                    db.SaveChanges();
                    return true;
                }
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public static bool RemoveProduct(Product product)
        {
            try
            {
                using (ApplicationDataContext db = new ApplicationDataContext())
                {
                    db.Products.Remove(product);
                    db.SaveChanges();
                    return true;
                }
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public static bool ChangeData(int id, Product newProduct)
        {
            try
            {
                using (ApplicationDataContext db = new ApplicationDataContext())
                {
                    Product product = db.Products.Find(id);

                    if (product != null)
                    {
                        product.Title = newProduct.Title;
                        product.Company = newProduct.Company;
                        product.Description = newProduct.Description;
                        product.Price = newProduct.Price;
                        product.Image = newProduct.Image;

                        db.SaveChanges();
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public static List<Product> GetProducts()
        {
            try
            {
                using (ApplicationDataContext db = new ApplicationDataContext())
                {
                    return db.Products.ToList();
                }
            }
            catch (Exception ex)
            {
                return new List<Product>(); 
            }
        }
    }
}
