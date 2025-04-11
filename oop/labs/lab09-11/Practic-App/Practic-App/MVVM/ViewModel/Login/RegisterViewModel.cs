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
    public class RegisterViewModel: ObservableObject
    {
        public UnitOfWork DataWorker { get; set; }

        private User registerData = new User();
        public User RegisterData
        {
            get { return registerData; } 
            set
            {
                registerData = value;
                OnPropertyChanged(nameof(RegisterData));
            }
        }

        public RelayCommand RegisterCommand { get; set; }

        public RegisterViewModel(UnitOfWork unitOfWork)
        {
            DataWorker = unitOfWork;
            RegisterCommand = new RelayCommand(Register);

            RegisterData = new User();
        }

        private void Register(object parameter)
        {
            try
            {
                User? checkUser = DataWorker.Users.GetData().FirstOrDefault(u => 
                    u.Name == RegisterData.Name &&
                    u.Address == RegisterData.Address &&
                    u.Email == RegisterData.Email &&
                    u.Password == RegisterData.Password
                );

                if (checkUser != null)
                {
                    MessageBox.Show("Такой пользователь уже существует!");
                    return;
                }

                DataWorker.Users.AddData(RegisterData);
                MessageBox.Show("Аккаунт успешно создан!");

                foreach (Window window in Application.Current.Windows)
                {
                    if (window is RegisterWindow)
                    {
                        window.Close();
                        break;
                    }
                }
            }
            catch (Exception)
            {
                MessageBox.Show("Ошибка регистрации!");
            }
        }
    }
}
