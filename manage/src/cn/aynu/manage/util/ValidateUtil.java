package cn.aynu.manage.util;

import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import cn.aynu.manage.struts2.UserAware;
import cn.aynu.manage.vo.User;
import cn.aynu.manage.vo.safe.Right;

/**
 * 验证字符串，对象数组，集合，电子邮件是否有效
 */
public class ValidateUtil {
	/**
	 * 字符串是否有效
	 */
	public static boolean isValid(String src) {
		// 为空返回false
		return !(src == null || "".equals(src.trim()));
	}

	/**
	 * 集合对象是否有效（上转型对象）
	 */
	public static boolean isValid(Collection col) {
		return !(col == null || col.isEmpty());
	}

	/**
	 * 对象数组是否有效
	 */
	public static boolean isValid(Object[] values) {
		if (values == null || values.length == 0) {
			return false;
		}
		return true;
	}

	/**
	 * 是否是一个电子邮件
	 */
	public static boolean isEmail(String email) {
		String string = "^([a-z0-9A-Z]+[-|_|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
		if (email.matches(string)) {
			return true;
		}
		return false;
	}

	/**
	 * 是否是一个日期格式的字符串
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isValidDate(String str) {
		boolean convertSuccess = true;
		// 指定日期格式为四位年/两位月份/两位日期，注意yyyy/MM/dd区分大小写；
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		try {
			// 设置lenient为false.
			// 否则SimpleDateFormat会比较宽松地验证日期，比如2007/02/29会被接受，并转换成2007/03/01
			format.setLenient(false);
			format.parse(str);
		} catch (Exception e) {
			e.printStackTrace();
			// 如果throw java.text.ParseException或者NullPointerException，就说明格式不对
			convertSuccess = false;
		}
		return convertSuccess;
	}

	
	
	/**
	 * 判断是否有权限
	 */
	public static boolean hasRight(HttpServletRequest req,String namespace,String actionName,Object action)
	{
		if(!ValidateUtil.isValid(namespace)
				||"/".equals(namespace))
		{
			namespace="";
		}
		String url = namespace+"/"+actionName;
		HttpSession session = req.getSession();
		Map<String,Right> map = (Map<String, Right>) req.getServletContext().getAttribute("all_rights_map");
		//System.out.println(url);
		Right r = map.get(url);
		//注入user
		User user = (User) session.getAttribute("user");
		if(action!=null && action instanceof UserAware && user!=null)
		{
			((UserAware)action).setUser(user);
		}
		//公共资源？
		if(r==null || r.isCommon())
		{
			return true;
		}
		else {
			//登录？
			if(user == null)
			{
				return false;
			}
			else{
				//超级管理员？
				if(user.isSuperAdmin())
				{
					return true;
				}
				else{
					//有权限？
					if(user.hasRight(r))
					{
						return true;
					}
					else{
						return false;
					}
				}
			}
		}
	}
}
