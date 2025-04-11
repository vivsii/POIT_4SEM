using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Practic_App.core;

namespace Practic_App.MVVM.Model
{
    public class Product: ObservableObject
    {
        private int id;
        private string title;
        private string company;
        private string description;
        private string image = "..\\..\\assets\\cat.png";
        private int price;

        public int Id { 
            get { return id; } 
            set {
                id = value;
                OnPropertyChanged("Id");
            }
        }

        public string Title { 
            get { return title; }
            set { 
                title = value;
                OnPropertyChanged("Title");
            }
        }

        public string Company { 
            get { return company; }
            set
            {
                company = value;
                OnPropertyChanged("Company");
            }
        }

        public string Description {
            get { return description; }
            set
            {
                description = value;
                OnPropertyChanged("Description");
            }
        }

        public string Image {
            get { return image; }
            set {
                image = value;
                OnPropertyChanged("Image");
            }
        }

        public int Price {
            get { return price; }
            set
            {
                price = value;
                OnPropertyChanged("Price");
            }
        }

        public Product(Product product)
        {
            Id= product.Id;
            Title= product.Title;
            Company= product.Company;
            Description= product.Description;
            Image= product.Image;
            Price = product.Price;
        }

        public Product() { }
    }
}
