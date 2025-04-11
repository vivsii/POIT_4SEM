package Staff;

/*Конструктор по умолчанию public SysAdmin(), который вызывает конструктор
суперкласса Worker без аргументов с помощью ключевого слова super().*/

/*Конструктор public SysAdmin(String surname, String name, int age, int salary, int experience),
который инициализирует поля объекта SysAdmin с помощью переданных параметров и также вызывает
конструктор суперкласса Worker с переданными параметрами с помощью super(surname, name, age, salary, experience).*/
public class SysAdmin extends Worker{
    public SysAdmin(){super();}
    public SysAdmin(String surname, String name, int age, int salary, int experience){
        super(surname,name,age,salary,experience);
    }
/* переопределён метод toString(), который возвращает строковое представление объекта SysAdmin,
включая значения его полей*/
    @Override
    public String toString(){
        return "SysAdmin{" +
                "surname='" + super.getSurname() + '\'' +
                ", name='" + super.getName() + '\'' +
                ", age=" + super.getAge() +
                ", salary=" + super.getSalary()+
                ", experience=" + super.getExperience() + "}";
    }

}
