using Practic_App.core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practic_App.MVVM.Model
{
    public class User: ObservableObject
    {
        private int id;
        private string name;
        private string email;
        private string password;
        private string address;
        private bool isAdmin;

        public int Id { 
            get { return id; }
            set { id = value; OnPropertyChanged("Id"); }
        }
        public string Name { 
            get { return name; } 
            set { name = value; OnPropertyChanged("Name"); }
        }
        public string Email {
            get { return email; }
            set { email = value; OnPropertyChanged("Email"); }
        }
        public string Password { 
            get { return password; }
            set { password = value; OnPropertyChanged("Password");}
        }

        public string Address { 
            get { return address; }
            set { address = value; OnPropertyChanged("Address"); }
        }

        public bool IsAdmin
        {
            get { return isAdmin; }
            set { isAdmin = value; OnPropertyChanged("IsAdmin"); }
        } 
    }
}
