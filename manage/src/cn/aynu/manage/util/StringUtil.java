package cn.aynu.manage.util;

import java.util.Set;

public class StringUtil {
	public static String[] formatSelect(String str,String cut){
		if(ValidateUtil.isValid(str))
		{
			return str.split(cut);
		}
		return null;
	}

	

	/**
	 *判断values是否包含value 
	 */
	public static boolean contains(String[] values, String value) {
		if(ValidateUtil.isValid(values))
		{
			for(String s : values)
			{
				if(s.equals(value))
				{
					return true;
				}
			}
		}
		return false;
	}



	/**
	 * 将数组转换成1,2,3的形式
	 */
	public static String arr2String(Object[] value) {
		String temp = "";
		if(ValidateUtil.isValid(value))
		{
			for(Object s : value)
			{
				temp = temp +s+ ",";
			}
			return temp.substring(0,temp.length()-1);
		}
		return temp;
	}
	
	/*public static String extractEntity2String(Set<? extends BaseEntity> entitys)
	{
		String temp = "";
		if(ValidateUtil.isValid(entitys))
		{
			for(BaseEntity b:entitys)
			{
				temp = temp+b.getId()+",";
			}
			return temp.substring(0,temp.length()-1);
		}
		return temp;
	}*/
	
	public static String getDescString(String str)
	{
		if(ValidateUtil.isValid(str)&&str.length()>30)
		{
			return str.substring(0,30);
		}
		return str;
	}
}
