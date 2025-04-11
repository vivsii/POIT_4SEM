using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace lab02
{
    [Serializable]
    public class Owner
    {
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public DateTime DateBirth { get; set; }
        public string PassportSeries { get; set; }
        public int PasportNumber { get; set; }
        public Owner() { }
        public Owner(string lastName, string firstName, string middleName, DateTime dateBirth, string passportSeries, int pasportNumber)
        {
            LastName = lastName;
            FirstName = firstName;
            MiddleName = middleName;
            DateBirth = dateBirth;
            PassportSeries = passportSeries;
            PasportNumber = pasportNumber;
        }
        public Owner(Owner owner)
        {
            LastName = owner.LastName;
            FirstName = owner.FirstName;
            MiddleName = owner.MiddleName;
            DateBirth = owner.DateBirth;
            PassportSeries = owner.PassportSeries;
            PasportNumber = owner.PasportNumber;
        }
    }
}
