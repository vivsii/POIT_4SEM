package org.example;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.example.cars.Bus;
import org.example.cars.Car;
import org.example.cars.PassengerCar;
import org.example.cars.Truck;
import org.example.park.Park;
import org.example.park.ParkErrorHandler;
import org.xml.sax.SAXException;

import javax.xml.XMLConstants;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import javax.xml.bind.util.JAXBSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;
import java.io.*;
import java.util.stream.Collectors;

public class Serialization {

    private static final Class[] classes = {Park.class, Car.class, Bus.class, Truck.class, PassengerCar.class};



    public void serializeToXml(Park park) throws JAXBException{
        StringWriter writer = new StringWriter();

        JAXBContext context = JAXBContext.newInstance(classes);
        Marshaller marshaller = context.createMarshaller();
        marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
        marshaller.marshal(park, writer);

        try(FileWriter fileWriter = new FileWriter("D:\\уник\\java\\лабораторные\\lab04\\Lab3\\src\\main\\resources\\park.xml", false))
        {
            fileWriter.write(writer.toString());
            fileWriter.flush();
        }
        catch(IOException ex){
            System.out.println(ex.getMessage());
        }
    }

    public Park deserializeFromXml() throws JAXBException, FileNotFoundException {

        BufferedReader br = new BufferedReader(new FileReader("D:\\уник\\java\\лабораторные\\lab04\\Lab3\\src\\main\\resources\\park.xml"));
        String body = br.lines().collect(Collectors.joining());
        StringReader reader = new StringReader(body);

        JAXBContext context = JAXBContext.newInstance(classes);
        Unmarshaller unmarshaller = context.createUnmarshaller();

        return (Park) unmarshaller.unmarshal(reader);
    }

    public static void validate(Park park) throws SAXException, JAXBException, IOException {
        SchemaFactory sf = SchemaFactory.newInstance( XMLConstants.W3C_XML_SCHEMA_NS_URI );
        Schema schema = sf.newSchema( new File( "D:\\уник\\java\\лабораторные\\lab04\\Lab3\\src\\main\\resources\\park_schema.xsd" ) );

        Validator validator = schema.newValidator();
        validator.setErrorHandler( new ParkErrorHandler() );

        JAXBContext context = JAXBContext.newInstance(classes);
        JAXBSource parkSource = new JAXBSource(context, park);

        validator.validate(parkSource);

        System.out.println("Validation successful\n");
    }

    public void serializeToJson(Park park) throws IOException {
        StringWriter writer = new StringWriter();
        ObjectMapper mapper = new ObjectMapper();
        mapper.writeValue(writer, park);

        try(FileWriter fileWriter = new FileWriter("D:\\уник\\java\\лабораторные\\lab04\\Lab3\\src\\main\\resources\\park.json", false))
        {
            fileWriter.write(writer.toString());
            fileWriter.flush();
        }
        catch(IOException ex){
            System.out.println(ex.getMessage());
        }
    }

    public Park deserializeFromJson() throws IOException {
        BufferedReader br = new BufferedReader(new FileReader("D:\\уник\\java\\лабораторные\\lab04\\Lab3\\src\\main\\resources\\park.json"));
        String body = br.lines().collect(Collectors.joining());
        StringReader reader = new StringReader(body);

        ObjectMapper mapper = new ObjectMapper();
        return mapper.readValue(reader, Park.class);
    }

}
