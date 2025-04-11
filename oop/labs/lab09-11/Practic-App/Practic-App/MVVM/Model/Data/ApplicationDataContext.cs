using Microsoft.EntityFrameworkCore;

namespace Practic_App.MVVM.Model.Data
{
    public class ApplicationDataContext : DbContext
    {
        public DbSet<Product> Products { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<BasketData> BasketDatas { get; set; }
        public DbSet<Basket> Baskets { get; set; }

        public ApplicationDataContext() {
            Database.EnsureCreated();
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer("Data Source=VIVSII-PC\\SQLEXPRESS;Initial Catalog=CosmeticShop1;Integrated Security=True;Encrypt=False");
        }
    }
}
