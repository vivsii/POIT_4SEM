using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace lab04_05
{
    public class Product : INotifyPropertyChanged
    {
        private string shortName;
        public string ShortName
        {
            get { return shortName; }
            set
            {
                if (shortName != value)
                {
                    shortName = value;
                    OnPropertyChanged("ShortName");
                }
            }
        }

        private string description;
        public string Description
        {
            get { return description; }
            set
            {
                if (description != value)
                {
                    description = value;
                    OnPropertyChanged("Description");
                }
            }
        }

        private string imagePath;
        public string ImagePath
        {
            get { return imagePath; }
            set
            {
                if (imagePath != value)
                {
                    imagePath = value;
                    OnPropertyChanged("ImagePath");
                }
            }
        }

        private string category;
        public string Category
        {
            get { return category; }
            set
            {
                if (category != value)
                {
                    category = value;
                    OnPropertyChanged("Category");
                }
            }
        }

        private int rating;
        public int Rating
        {
            get { return rating; }
            set
            {
                if (rating != value)
                {
                    rating = value;
                    OnPropertyChanged("Rating");
                }
            }
        }

        private double price;
        public double Price
        {
            get { return price; }
            set
            {
                if (price != value)
                {
                    price = value;
                    OnPropertyChanged("Price");
                }
            }
        }

        private int quantity;
        public int Quantity
        {
            get { return quantity; }
            set
            {
                if (quantity != value)
                {
                    quantity = value;
                    OnPropertyChanged("Quantity");
                }
            }
        }

        private bool isOutOfStock;
        public bool IsOutOfStock
        {
            get { return isOutOfStock; }
            set
            {
                if (isOutOfStock != value)
                {
                    isOutOfStock = value;
                    OnPropertyChanged("IsOutOfStock");
                }
            }
        }

        private int quantityPurchased;
        public int QuantityPurchased
        {
            get { return quantityPurchased; }
            set
            {
                if (quantityPurchased != value)
                {
                    quantityPurchased = value;
                    OnPropertyChanged("QuantityPurchased");
                }
            }
        }

        public event PropertyChangedEventHandler PropertyChanged;

        protected void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}