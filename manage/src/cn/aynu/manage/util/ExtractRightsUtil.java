package cn.aynu.manage.util;

import java.io.File;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.net.URISyntaxException;
import java.net.URL;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import cn.aynu.manage.service.RightService;

/**
 * 抽取所有权限
 */
public class ExtractRightsUtil {
	public static void main(String[] args) throws URISyntaxException {
		System.out.println("hah");
		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		RightService rightService = (RightService) ac.getBean("rightService");
		// 得到action加载后所在的地址
		ClassLoader loader = ExtractRightsUtil.class.getClassLoader();
		URL url = loader.getResource("cn/aynu/manage/struts2/action");
		File dir = new File(url.toURI());
		// 得到所有action加载后的class文件
		File[] files = dir.listFiles();
		String fname = null;
		for (File f : files) {
			fname = f.getName();
			if (fname.endsWith(".class") && !fname.equals("BaseAction.class")) {
				processAction(fname,rightService);
			}
		}
	}
	/**
	 *处理Action 
	 */
	private static void processAction(String fname,RightService rs) {
		String pkName = "cn.aynu.manage.struts2.action";
		String simpleClassName = fname.substring(0,fname.indexOf(".class"));
		String className = pkName +"."+ simpleClassName;
		Class returnType = null;
		String mname = null;
		Class []parametersType = null;
		String url = null;
		try {
			//得到具体类
			Class clazz = Class.forName(className);
			//得到自己声明的方法（不要从父类继承来的）
			Method[] methods = clazz.getDeclaredMethods();
			for(Method m : methods)
			{
				returnType = m.getReturnType();			//方法返回类型
				mname = m.getName();					//方法名称
				parametersType = m.getParameterTypes();	//方法参数类型
				if(returnType==String.class 
						&& !ValidateUtil.isValid(parametersType) 
						&& Modifier.isPublic(m.getModifiers()))
				{
					if(m.getName().equals("execute"))
					{
						url = "/"+simpleClassName;
					}
					else{
						url = "/"+simpleClassName+"_"+mname;
					}
					rs.appendRightUrl(url);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	

}
