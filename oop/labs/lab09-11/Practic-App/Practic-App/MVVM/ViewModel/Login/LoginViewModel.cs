using Practic_App.core;
using Practic_App.MVVM.Model;
using Practic_App.MVVM.Model.Data.UW;
using Practic_App.MVVM.View.Login;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace Practic_App.MVVM.ViewModel.Login
{
    public class LoginViewModel: ObservableObject
    {
        public UnitOfWork DataWorker { get; set; }

        private User loginData;
        public User LoginData
        {
            get { return loginData; } 
            set
            {
                loginData = value;
                OnPropertyChanged(nameof(LoginData));
            }
        }

        public RelayCommand LoginCommand { get; set; }
        public RelayCommand OpenRegisterCommand { get; set; }

        public LoginViewModel(UnitOfWork unitOfWork, RelayCommand openRegisterCommand)
        {
            LoginCommand = new RelayCommand(Login);
            OpenRegisterCommand = openRegisterCommand;

            DataWorker = unitOfWork;

            LoginData = new User();
        }

        private void Login(object parameter)
        {
            User? user = DataWorker.Users.GetData().FirstOrDefault(u => u.Password == LoginData.Password 
                && u.Name == LoginData.Name);

            if (user != null)
            {
                ((MainViewModal)Application.Current.MainWindow.DataContext).IsLoggedIn = true;
                ((MainViewModal)Application.Current.MainWindow.DataContext).User = user;
                if (user.IsAdmin)
                {
                    ((MainViewModal)Application.Current.MainWindow.DataContext).IsAdmin = true;
                }
                MessageBox.Show("Авторизация прошла успешно!");

                foreach (Window window in Application.Current.Windows)
                {
                    if (window is LoginWindow)
                    {
                        window.Close();
                        break;
                    }
                }
            }
            else
            {
                MessageBox.Show("Такого пользователя не существует!");
            }
        }
    }
}
