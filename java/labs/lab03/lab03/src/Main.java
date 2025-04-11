import by.belstu.lab03.Company.Company;
import Staff.Engineer;
import Staff.ProgType;
import Staff.Programmer;
import Staff.SysAdmin;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.log4j.xml.DOMConfigurator;

public class Main {
    static {
        new DOMConfigurator().doConfigure("log/log4j.xml", LogManager.getLoggerRepository());
    }
    private static final Logger LOG = Logger.getLogger(Main.class);

    public static void main(String[] args) {
        try {
            LOG.info("Starting program");
            Company ITCompany = new Company();
            Company.Director director = ITCompany.new Director("Смелов");
            //director.sortBySalary(ITCompany);
            ITCompany.addWorker(new Engineer("Дубина", "Артем", 18, 5, 3));
            ITCompany.addWorker(new SysAdmin("Ппукин", "Иван", 28, 3000, 6));
            ITCompany.addWorker(new Programmer("Клавиатурович", "Саша", 27, 4000, 7, ProgType.Middle));
            ITCompany.addWorker(new Programmer("Телефон", "Олег", 30, 4500, 10, ProgType.Senior));
            ITCompany.addWorker(new Programmer("Дудкин", "Анастасия", 29, 4500, 10, ProgType.Senior));
            System.out.println(director.countWorkers(ITCompany));
            director.searchByExp(ITCompany, 10);
            System.out.println("----------------------------------------------------------");
            director.sortBySalary(ITCompany);
            for (var s: ITCompany.getStaff()) {
                System.out.println(s.getName() + " " + s.getSalary());
            }
        }
        catch (NullPointerException ex) {
            System.out.println(ex.getMessage());
        }

    }
}