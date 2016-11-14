package cn.aynu.manage.test;

import java.io.IOException;

import org.junit.Before;
import org.junit.Test;

import cn.aynu.manage.util.PoiUtil;

public class PoiTest {
	PoiUtil pu = null;
	@Before
	public void before(){
		pu = new PoiUtil();
	}

	@Test
	public void test1() throws Exception
	{
		try {
			System.out.println(pu.readExceltoSql("C:\\Users\\yehao\\Desktop\\aa.xlsx","caseinfo"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
