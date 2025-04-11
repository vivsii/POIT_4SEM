package com.example.task04;


import com.example.P2P.Weather;

import javax.jms.*;
import javax.naming.InitialContext;
import java.io.BufferedReader;
import java.io.InputStreamReader;

public class MySender {
    public static void main(String[] args) {
        try { //создать соединение
            /*Properties props = new Properties();
            props.setProperty(Context.INITIAL_CONTEXT_FACTORY, "com.sun.enterprise.naming.SerialInitContextFactory");
            Context ctx = new InitialContext(props);*/
            InitialContext ctx = new InitialContext();
            QueueConnectionFactory f=
                    (QueueConnectionFactory)ctx.lookup("java:comp/DefaultJMSConnectionFactory");

            QueueConnection con = f.createQueueConnection();
            con.start();
//2) создать queue session
            QueueSession session =
                    con.createQueueSession(false, Session.AUTO_ACKNOWLEDGE);
//3) получить Queue object
            Queue queue = (Queue) ctx.lookup("BankCard");
//4)создать QueueSender object
            QueueSender sender = session.createSender(queue);
//5) создатть TextMessage object
            ObjectMessage msg = session.createObjectMessage();

//6) записать сообщение
            BufferedReader b =
                    new BufferedReader(new InputStreamReader(System.in));
            while (true) {
                System.out.println("Enter Msg, end to terminate:");
                String s = b.readLine();
                if (s.equals("end"))
                    break;
                Weather weather = new Weather("Minsk", 15.5, 1.2, 3.4);
                msg.setObject(weather);
//7) послать
                sender.send(msg);
                System.out.println("Message successfully sent.");
            }
//8) закрыть
            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}