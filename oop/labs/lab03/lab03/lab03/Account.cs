using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;
using System.ComponentModel.DataAnnotations;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using System.Reflection;
using System.Security.Policy;
using System.Web;
using lab03;

namespace lab03
{
    [Serializable]
    [XmlRoot("AccountsData")]
    public class AccountsData
    {
        [XmlElement("Account")]
        public List<Account> Accounts = new List<Account>();
    }
    [Serializable]
    public class Account
    {
        public int countOfAccounts = 0;
        [Required(ErrorMessage = "Номер счета обязательно для заполнения")]
        public int AccountNumber { get; set; }
        public string TypeOfDeposite { get; set; }
        [Range(0.0, 100000000000000000.0, ErrorMessage = "Баланс должен быть минимум 0")]
        public double Balance { get; set; }
        public DateTime DateOpening { get; set; }
        public string OwnerOfAccount { get; set; }
        public string SMS { get; set; }
        public string InternetBanking { get; set; }
        public Owner owner { get; set; }
        public Account() { }
        public Account(int accountNumber, string typeOfDeposite, double balance, DateTime dateOpening,
            string ownerOfAccount, string sms, string internetBanking, Owner someowner)
        {
            AccountNumber = accountNumber;
            TypeOfDeposite = typeOfDeposite;
            Balance = balance;
            DateOpening = dateOpening;
            OwnerOfAccount = ownerOfAccount;
            SMS = sms;
            InternetBanking = internetBanking;
            owner = someowner;
        }
        public int Count()
        {
            countOfAccounts++;
           return countOfAccounts;
        }
        //public override string ToString()
        //{
        //    return $"Данные Cчета:\n" +
        //        $"Номер счета: {AccountNumber}\n" +
        //        $"Тип вклада: {TypeOfDeposite}\n" +
        //        $"Баланс: {Balance}\n" +
        //        $"Дата открытия: {DateOpening}\n" +
        //        $"Владелец: {OwnerOfAccount}\n" +
        //        $"Смс Оповещение: {SMS}\n" +
        //        $"Интернет банкиг: {InternetBanking}\n" +
        //        $"Владелец: {owner}\n";
        //}
    }
}
