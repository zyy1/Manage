package cn.aynu.manage.spring.listener;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import org.springframework.context.ApplicationEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;
import org.springframework.web.context.ServletContextAware;

import cn.aynu.manage.service.RightService;
import cn.aynu.manage.vo.safe.Right;

/**
 *权限监听器，在spring初始化后调用
 */
@Component
public class IniRightListener implements ApplicationListener,ServletContextAware {
	@Resource
	private RightService rightService;
	//接受servletContext对象
	private ServletContext sc;
	public void onApplicationEvent(ApplicationEvent arg0) {
		//上下文刷新对象
		if(arg0 instanceof ContextRefreshedEvent)
		{
			List<Right> rights =rightService.findAllEntites();
			Map<String,Object> map = new HashMap<String, Object>();
			for(Right r :rights)
			{
				map.put(r.getRightUrl(), r);
			}
			if(sc!=null)
			{
				System.out.println("初始化所有权限到application中...");
				sc.setAttribute("all_rights_map", map);
			}
		}
	}
	public void setServletContext(ServletContext arg0) {
		this.sc = arg0;
	}

}
