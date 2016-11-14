package cn.aynu.manage.struts2.interceptor;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionProxy;
import com.opensymphony.xwork2.interceptor.Interceptor;

import cn.aynu.manage.service.RightService;
import cn.aynu.manage.util.ValidateUtil;

/**
 * 开发时 ， 使用（添加权限到Rights表中） ，防止已经加入的 权限名 丢失（对权限的append 而不是用util快速添加）
 * @author yehao
 */
@Component
public class CatchUrlInterceptor implements Interceptor {
	private static final long serialVersionUID = -2567029236017133639L;

	@Resource
	private RightService rightService;
	public void destroy() {
	}

	public void init() {
	}

	public String intercept(ActionInvocation arg0) throws Exception {
		ActionProxy ap = arg0.getProxy();
		//actionName
		String actionName = ap.getActionName();
		String nameSpace = ap.getNamespace();
		if(!ValidateUtil.isValid(nameSpace)||nameSpace.equals("/"))
		{
			nameSpace = "";
		}
		String url = nameSpace+"/"+actionName;
		//添加权限(得到rightService)到数据库的rights表
		//两种方式
		//(1)
		/*ApplicationContext ac = (ApplicationContext) arg0.getInvocationContext().getApplication().get(WebApplicationContext.ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE);
		RightService rs = (RightService) ac.getBean("rightService");*/
//		//(2)
//		ServletContext sc = ServletActionContext.getServletContext();
//		ApplicationContext ac1 = WebApplicationContextUtils.getWebApplicationContext(sc);
		rightService.appendRightUrl(url);
		return arg0.invoke();
	}

}
