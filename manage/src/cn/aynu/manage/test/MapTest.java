package cn.aynu.manage.test;

import java.util.Calendar;
import java.util.Date;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import cn.aynu.manage.service.MapService;

public class MapTest {
	ApplicationContext ac = null; 
	@Before
	public void before1(){
		ac = new ClassPathXmlApplicationContext("applicationContext.xml");
	}
	@Test
	public void test1()
	{
		Date date = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);//date 换成已经已知的Date对象
        System.out.println(cal.get(Calendar.HOUR_OF_DAY));
	}
	@Test
	public void test2()
	{
		MapService mp = (MapService) ac.getBean("mapService");
		//System.out.println(mp.getAvgOutTime(0, 2));
		System.out.println(mp.getCaseTimeData());
		
	}
}
