using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace lab04_05
{
    public class ProductManager
    {
        private string filePath = "products.xml";

        public List<Product> LoadProducts()
        {
            if (File.Exists(filePath))
            {
                XmlSerializer serializer = new XmlSerializer(typeof(List<Product>));
                using (FileStream stream = File.OpenRead(filePath))
                {
                    return (List<Product>)serializer.Deserialize(stream);
                }
            }
            else
            {
                return new List<Product>();
            }
        }

        public void SaveProducts(List<Product> products)
        {
            XmlSerializer serializer = new XmlSerializer(typeof(List<Product>));
            using (FileStream stream = File.Create(filePath))
            {
                serializer.Serialize(stream, products);
            }
        }
    }
}