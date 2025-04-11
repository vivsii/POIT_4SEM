package org.example;

import org.example.cars.Bus;
import org.example.cars.MaxSpeed;
import org.example.cars.PassengerCar;
import org.example.cars.Truck;
import org.example.park.Park;
import org.xml.sax.SAXException;

import javax.xml.bind.JAXBException;
import java.io.IOException;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) throws JAXBException, IOException, SAXException {
        try {

            Park park = new Park();

            Truck truck = new Truck(100, 10000, MaxSpeed.M210.getMaxSpeed());

            Serialization.validate(park);

            Serialization carSerialization = new Serialization();
            park = carSerialization.deserializeFromXml();

            boolean work = true;

            while (work) {
                Park.Manager manager = park.new Manager();
                System.out.println("Выберите операцию");
                System.out.println("1. Вывести весь таксопарк");
                System.out.println("2. Стоимость таксопарка");
                System.out.println("3. Показать отсортированный парк по расходу топлива");
                System.out.println("4. Машины с диапозоном скорости");
                System.out.println("5. Сериализовать в xml");
                System.out.println("6. Десериализовать из xml");
                System.out.println("7. Сериализовать в json");
                System.out.println("8. Десериализовать из json");
                System.out.println("9. Добавить автомобиль");
                System.out.println("0. Закрыть программу");
                Scanner scanner = new Scanner(System.in);
                String answer = scanner.nextLine();

                switch (answer) {
                    case "1" -> System.out.println(park);
                    case "2" ->{
                        long price = manager.getParkPrice();
                        System.out.println("Итого: " + price + "\n");
                    }
                    case "3" -> System.out.println("Итого: \n" + manager.getSortedPark());
                    case "4" -> {
                        System.out.println("Нижняя граница скорости: ");
                        int m1 = scanner.nextInt();
                        System.out.println("Верхняя граница скорости: ");
                        int m2 = scanner.nextInt();
                        if(m2 > m1) System.out.println("Диапазон от " + m1 + " до " + m2 + ": \n" + manager.getCarsWithMaxSpeedRange(m1, m2));
                        else System.out.println("Неправильное значение диапазона скорости");
                    }
                    case "5" -> carSerialization.serializeToXml(park);
                    case "6" -> park = carSerialization.deserializeFromXml();
                    case "7" -> carSerialization.serializeToJson(park);
                    case "8" -> park = carSerialization.deserializeFromJson();
                    case "9" -> {
                        System.out.println("1. Truck");
                        System.out.println("2. Bus");
                        System.out.println("3. Passenger Car");
                        String car = scanner.nextLine();
                        System.out.println("price: ");
                        long price = scanner.nextLong();
                        System.out.println("fuel consumption: ");
                        float fuelConsumption = scanner.nextFloat();
                        System.out.println("max speed: ");
                        int maxSpeed = scanner.nextInt();
                        switch (car){
                            case "1" -> park.getCars().add(new Truck(price, fuelConsumption, maxSpeed));
                            case "2" -> park.getCars().add(new Bus(price, fuelConsumption, maxSpeed));
                            case "3" -> park.getCars().add(new PassengerCar(price, fuelConsumption, maxSpeed));

                        }
                    }
                    case "0" -> work = false;
                    default -> System.out.println("Неправильный ввод");
                }
            }

        }catch (Exception e){
            throw e;
        }
    }



}