package cn.aynu.manage.test;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import cn.aynu.manage.service.PersonService;
import cn.aynu.manage.struts2.action.PersonAction;

public class test {
	public static void main(String[] args) {
		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		/*
		 * UserService usi = (UserService) ac.getBean("userService"); User u =
		 * new User();
		 * 
		 * User newUser = usi.chekUser(u); if(newUser!=null){
		 * System.out.println(newUser.getWork()); }
		 */
		/* User use =(User) ac.getBean("user"); */
		SessionFactory s = (SessionFactory) ac.getBean("sessionFactory");
		Session s1 = s.openSession();
		Transaction tx = s1.beginTransaction();
		/*
		 * String hql="from User u where u.username=? and u.password =?"; use =
		 * (User) s1.createQuery(hql).setParameter(0, "admin").setParameter(1,
		 * "admin").uniqueResult();
		 */
		PersonAction pa = (PersonAction) ac.getBean("personAction");
		PersonService personService = (PersonService) ac.getBean("personService");
		/*
		 * String sa= (String)pa.Person_list(); System.out.println(sa);
		 */
		/* List<Person> list= personService.Plist(); */
		//
		/* System.out.println(list.size()); */
		/*
		 * for(int i=0;i<list.size();i++) {
		 * System.out.println(list.get(i).getName());
		 * 
		 * 
		 * }
		 */
		/*
		 * for(Person ls:list) {
		 * 
		 * System.out.println(ls.getName()); }
		 */
	}
}
