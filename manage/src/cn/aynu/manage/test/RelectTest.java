package cn.aynu.manage.test;

import java.lang.reflect.Field;

import org.junit.Test;

import cn.aynu.manage.vo.Person;

public class RelectTest {
	@Test
	public void test1()
	{
		Person person = new Person();
		person.setAddress("add");
		Class clazz = person.getClass();
		Field fields[] = clazz.getFields();//c.getDeclaredFields()--->自己生命的成员变量
		System.out.println("11"+fields.length);
		for(Field f:fields)
		{
			System.out.print(f.getType().getName()+" ");
			System.out.println(f.getName());
		}

	}
}
