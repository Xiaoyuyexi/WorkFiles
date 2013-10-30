package com.unicom.mms;

import org.apache.commons.configuration.CompositeConfiguration;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.unicom.memcached.CacheClientImpl;
import com.unicom.mms.activemq.PostcardMMSListener;
import com.unicom.mms.activemq.client.MsgPublisher;
import com.unicom.mms.util.PropertiesConfig;

public class InitInstance {
	private static InitInstance initInstance = null;
	public  PostcardMMSListener postcardMMSListener=null;
	public  MsgPublisher msgPublisher=null;
	public  CacheClientImpl cacheClientImpl=null;
	public CompositeConfiguration mm7;
	public CompositeConfiguration test;
	
	public static InitInstance getInstance(){
		if(initInstance == null){
			initInstance = new InitInstance();
		}
		return initInstance;
	}
	
	private InitInstance(){
		try{
			mm7 = new PropertiesConfig("/mm7.properties").getConfig();
			test = new PropertiesConfig("/test.properties").getConfig();
			ApplicationContext context = new ClassPathXmlApplicationContext("classpath:modules/applicationContext.xml");
			if(context!=null){
				System.out.println("success load spring");
			}
			msgPublisher= (MsgPublisher) context.getBean("msgPublisher");
			postcardMMSListener = (PostcardMMSListener) context.getBean("postcardMMSListener");
			cacheClientImpl= (CacheClientImpl) context.getBean("cache");
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void start(){
		try{
		msgPublisher.run();
		postcardMMSListener.run();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}