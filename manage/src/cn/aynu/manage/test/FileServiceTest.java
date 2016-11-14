package cn.aynu.manage.test;

import java.util.ArrayList;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import cn.aynu.manage.service.FileService;
import cn.aynu.manage.vo.Person;

public class FileServiceTest {
	ApplicationContext ac = null; 
	@Before
	public void before1(){
		ac = new ClassPathXmlApplicationContext("applicationContext.xml");
	}
	
	@Test
	public void test1()
	{
		FileService fileService = (FileService) ac.getBean("fileService");
		List<String> headers = new ArrayList<>();
		List<List<String>> list = fileService.getDataListForExcelQuit("person",Person.class,headers);
		for(List data : list)
		{
			//System.out.println(data);
		}
		System.out.println(headers);
	}
}
