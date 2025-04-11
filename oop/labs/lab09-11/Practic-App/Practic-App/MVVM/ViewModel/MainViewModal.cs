using Practic_App.core;
using Practic_App.MVVM.Model;
using Practic_App.MVVM.Model.Data;
using Practic_App.MVVM.Model.Data.UW;
using Practic_App.MVVM.View.Login;
using Practic_App.MVVM.ViewModel.Login;
using System.Windows;
using System.Windows.Input;

namespace Practic_App.MVVM.ViewModel
{
    public class MainViewModal: ObservableObject
    {
        private bool _isLoggedIn;
        private bool _isAdmin;
        private User _user;
        public bool IsLoggedIn
        {
            get { return _isLoggedIn; }
            set
            {
                _isLoggedIn = value;
                OnPropertyChanged(nameof(IsLoggedIn));
            }
        }

        public bool IsAdmin
        {
            get { return _isAdmin; }
            set
            {
                _isAdmin = value;
                OnPropertyChanged(nameof(IsAdmin));
            }
        }

        public User User
        {
            get { return _user; }
            set
            {
                _user = value;
                OnPropertyChanged(nameof(User));
            }
        }

        public UnitOfWork DataWorker { get; set; }

        public ICommand CloseApplicationCommand { get; }
        public ICommand MinimizeApplicationCommand { get; }

        public RelayCommand LoginWindowCommand { get; }
        public RelayCommand RegisterWindowCommand { get; }

        public RelayCommand LogOutCommand { get; }

        public RelayCommand TovarListCommand { get; }
        public RelayCommand AddTovarCommand { get; }
        public RelayCommand DeleteProductCommand { get; }
        public RelayCommand BasketCommand { get; }


        public TovarListViewModel TovarLV { get; set; }
        public AddTovarViewModal AddTovarV { get; set; }
        public DeleteProductViewModel DeleteProductV { get; set; }
        public BasketViewModel BasketV { get; set; }


        private object _currentView;
        public object CurrentView { 
            get { return _currentView; }
            set {
                _currentView = value;
                OnPropertyChanged();
            } 
        }

        public MainViewModal()
        {
            DataWorker = new UnitOfWork(new ApplicationDataContext());
            User = new User();

            LogOutCommand = new RelayCommand(o => { IsLoggedIn = false; IsAdmin = false; User = null; });

            RegisterWindowCommand = new RelayCommand(OpenRegister);
            LoginWindowCommand = new RelayCommand(OpenLogin);

            CloseApplicationCommand = new RelayCommand(CloseApplication);
            MinimizeApplicationCommand = new RelayCommand(MinimizeApplication);

            DeleteProductCommand = new RelayCommand(o => { CurrentView = DeleteProductV; });
            TovarListCommand = new RelayCommand(o => { CurrentView = TovarLV; });
            AddTovarCommand = new RelayCommand(o => { CurrentView = AddTovarV; });
            BasketCommand = new RelayCommand(o => { CurrentView = BasketV; BasketV.GetBasketData(); });

            TovarLV = new TovarListViewModel(this, DataWorker);
            AddTovarV = new AddTovarViewModal(TovarLV.Products, DataWorker);
            DeleteProductV = new DeleteProductViewModel(TovarLV.Products, DataWorker);
            BasketV = new BasketViewModel(DataWorker);

            CurrentView = TovarLV;
        }

        private void OpenRegister(object parameter)
        {
            foreach (Window window in Application.Current.Windows)
            {
                if (window is LoginWindow)
                {
                    window.Close();
                    break;
                }
            }

            RegisterWindow registerWindow = new RegisterWindow(new RegisterViewModel(DataWorker));
            registerWindow.Show();
        }

        private void OpenLogin(object parameter) {
            LoginWindow loginWindow = new LoginWindow(new LoginViewModel(DataWorker, RegisterWindowCommand));
            loginWindow.Show();
        }

        private void CloseApplication(object parameter)
        {
            Application.Current.Shutdown();
        }

        private void MinimizeApplication(object parameter)
        {
            Application.Current.MainWindow.WindowState = WindowState.Minimized;
        }
    }
}
