package org.example.lab10;

public class University {
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    private String name;

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    private String city;
    public University(String name, String city){
        this.city = city;
        this.name = name;
    }
}
