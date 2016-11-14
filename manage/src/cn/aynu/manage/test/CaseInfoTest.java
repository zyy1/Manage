package cn.aynu.manage.test;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import cn.aynu.manage.struts2.action.CaseinfoAction;

public class CaseInfoTest {
	ApplicationContext ac = null;
	CaseinfoAction action = null;
	@Before
	public void before()
	{
		ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		action = (CaseinfoAction) ac.getBean("caseinfoAction");
	}
	
	@Test
	public void test()
	{
		action.riskAnalysis();
	}
}
