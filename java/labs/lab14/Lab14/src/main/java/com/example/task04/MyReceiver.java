package com.example.task04;

import com.example.P2P.Weather;

import javax.jms.*;
import javax.naming.InitialContext;

public class MyReceiver {
    public static void main(String[] args) {
        try {
//1) создать и стартовать connection
            /*Properties properties = new Properties();
            properties.setProperty(Context.INITIAL_CONTEXT_FACTORY, "com.sun.enterprise.naming.SerialInitContextFactory");
            InitialContext ctx = new InitialContext(properties);*/
            InitialContext ctx = new InitialContext();
            QueueConnectionFactory f=
                    (QueueConnectionFactory)ctx.lookup("jsm/DefaultJMSConnectionFactory");
            QueueConnection con = f.createQueueConnection();
            con.start();
//2) создать Queue session
            QueueSession session = con.createQueueSession(false, Session.AUTO_ACKNOWLEDGE);
//3) полуситьQueue object
            Queue queue = (Queue) ctx.lookup("BankCard");
//4)создаь QueueReceiver
            QueueReceiver receiver = session.createReceiver(queue);
            MessageConsumer consumer = session.createConsumer(queue);
            Message message = consumer.receive();
            if (message instanceof ObjectMessage) {
                ObjectMessage objectMessage = (ObjectMessage) message;
                Weather msg = null;
                try {
                    msg = (Weather) objectMessage.getObject();
                } catch (JMSException e) {
                    e.printStackTrace();
                }
                System.out.println(msg.toString());
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}