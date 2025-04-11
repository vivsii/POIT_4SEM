package by.belstu.lab03.Company;

public interface IDirectory {
    public  int countWorkers(Company company);
    public  void sortBySalary(Company company);
    public  void searchByExp(Company company, int experience);
}
