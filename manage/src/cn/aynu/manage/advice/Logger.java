package cn.aynu.manage.advice;

import java.util.Map;

import javax.annotation.Resource;

import org.aspectj.lang.ProceedingJoinPoint;

import com.opensymphony.xwork2.ActionContext;

import cn.aynu.manage.service.LogService;
import cn.aynu.manage.util.StringUtil;
import cn.aynu.manage.vo.Log;
import cn.aynu.manage.vo.User;

/**
 *日志记录仪：logger
 */
public class Logger {
	/**
	 * 记录
	 * @param pjp：环绕通知需要的连接点
	 * @return 方法调用返回
	 */
	@Resource
	private LogService logService;
	public Object record(ProceedingJoinPoint pjp)
	{
		//初始化操作时间
		Log log = new Log();
		//设置操作人
		ActionContext ac = ActionContext.getContext();
		if(ac!=null){
			Map<String,Object> sessionMap = ac.getSession();
	
		if(sessionMap!=null)
		{
			User user = (User) sessionMap.get("user");
			if(user!=null)
			{
				log.setOperator(user.getId()+":"+user.getUsername());
			}
		}
		//设置操作名称(方法)
		log.setOperName(pjp.getSignature().getName());
		//设置操作参数
		Object[] params = pjp.getArgs();
		log.setOperParams(StringUtil.arr2String(params));
		//调用对象方法
		try {
			Object ret = pjp.proceed();
			//设置操作结果
			log.setOperResult("success");
			if(ret!=null)
			{
				//设置返回值
				log.setResultMsg(ret.toString());
			}
			return ret;
		} catch (Throwable e) {
			e.printStackTrace();
			log.setOperResult("failure");
			log.setResultMsg(e.getMessage());
		}finally {
			logService.saveEntity(log);
		}
		
		}
		else{
			try {
				Object ret = pjp.proceed();
				return ret;
			} catch (Throwable e) {
				e.printStackTrace();
			}
			
		}
		return null;
	}
}
