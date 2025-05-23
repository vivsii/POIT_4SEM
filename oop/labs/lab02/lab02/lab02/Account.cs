﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using System.Reflection;
using System.Security.Policy;
using System.Web;

namespace lab02
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
        public int AccountNumber { get; set; }
        public string TypeOfDeposite { get; set; }
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
    }
}
