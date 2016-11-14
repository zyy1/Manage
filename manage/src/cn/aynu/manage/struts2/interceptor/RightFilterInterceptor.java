package cn.aynu.manage.struts2.interceptor;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionProxy;
import com.opensymphony.xwork2.interceptor.Interceptor;

import cn.aynu.manage.util.ValidateUtil;

public class RightFilterInterceptor implements Interceptor {

	/**
	 *  µÇÂ¼À¹½ØÆ÷
	 */
	private static final long serialVersionUID = -1302540506691000976L;

	public void destroy() {
	}

	public void init() {
	}

	@SuppressWarnings("unused")
	public String intercept(ActionInvocation arg0) throws Exception {
		
		
		/**
		 * ÐÞ¸Ä
		 */
		ActionProxy proxy = arg0.getProxy();
		String ns = proxy.getNamespace();
		String actionName = proxy.getActionName();
		
		Object action = (Object) arg0.getAction();
		if(ValidateUtil.hasRight(ServletActionContext.getRequest(), ns, actionName,action))
		{
			return arg0.invoke();
		}
		else{
			return "error_noRight_page";
		}
	}

}
