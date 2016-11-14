package cn.aynu.manage.test;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import cn.aynu.manage.service.PersonService;
import cn.aynu.manage.vo.Person;

public class PersonDaoTest {
	ApplicationContext ac = null;
	@Before
	public void before1(){
		 ac = new ClassPathXmlApplicationContext("applicationContext.xml");
	}
	
	@Test
	public void test1()
	{
		PersonService ps = (PersonService) ac.getBean("personService");
		System.out.println(ps);
		
		Person p = ps.getperson(50);
		System.out.println(p);
	}
}
