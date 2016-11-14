package cn.aynu.manage.spring.listener;

import javax.annotation.Resource;

import org.springframework.context.ApplicationEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import cn.aynu.manage.service.LogService;
import cn.aynu.manage.util.LogUtil;

/**
 *权限监听器，在spring初始化后调用
 */
@Component
public class IniLogsListener implements ApplicationListener {
	@Resource
	private LogService logService;
	public void onApplicationEvent(ApplicationEvent arg0) {
		String tableName = LogUtil.generateLogTableName(0);
		logService.createTable(tableName);
		tableName = LogUtil.generateLogTableName(1);
		logService.createTable(tableName);
		tableName = LogUtil.generateLogTableName(2);
		logService.createTable(tableName);
		System.out.println("初始化日志数据表完成！！！");
	}
}
