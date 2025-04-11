using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;
using System.Threading.Tasks;

namespace lab03
{
    [Serializable]
    public class Owner
    {
        [Required(ErrorMessage = "Поле обязательно для заполнения")]
        public string LastName { get; set; }
        [Required(ErrorMessage = "Поле обязательно для заполнения")]
        public string FirstName { get; set; }
        [Required(ErrorMessage = "Поле обязательно для заполнения")]
        public string MiddleName { get; set; }
        public DateTime DateBirth { get; set; }
        [RegularExpression(@"[A-Z]{2}",ErrorMessage = "Номер обязателен для заполнения")]
        public string PassportSeries { get; set; }
        [Range(0, 999999, ErrorMessage = "Баланс должен быть минимум 0")]
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
        public override string ToString()
        {
            return
                $"{LastName},\n" +
                $"{FirstName},\n" +
                $"{MiddleName},\n" +
                $"{DateBirth}\n" +
                $"{PassportSeries}{PasportNumber},\n";
        }

    }
}
