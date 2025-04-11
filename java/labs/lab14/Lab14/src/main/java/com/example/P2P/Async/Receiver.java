package com.example.P2P.Async;

import com.example.P2P.Weather;
import com.sun.messaging.ConnectionConfiguration;
import com.sun.messaging.ConnectionFactory;

import javax.jms.*;

public class Receiver implements MessageListener {
    ConnectionFactory factory = new com.sun.messaging.ConnectionFactory();
    JMSConsumer consumer;

    Receiver() {
        try (JMSContext context = factory.createContext("admin", "admin")) {
            factory.setProperty(ConnectionConfiguration.imqAddressList,
                    "mq://127.0.0.1:7676,mq://127.0.0.1:7676");
            Destination weatherQueue = context.createQueue("P2PAsync");
            consumer =  context.createConsumer(weatherQueue);
            consumer.setMessageListener(this);
            System.out.println("Listening to queue...");
// wait for messages
            Thread.sleep(100000);
        } catch (InterruptedException e) {
            System.out.println("Error: " + e.getMessage());
        } catch (JMSException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
    @Override
    public void onMessage(Message msg){
        try{
            System.out.println("Got the text message from the queue: " +
                    msg.getBody(Weather.class).toString());
            System.out.println("Message: " + msg);
        } catch (JMSException e){
            System.err.println("JMSException: " + e.toString());
        }
    }
    public static void main(String[] args){
        new Receiver();
    }
}
