package cn.aynu.manage.scheduler;

import java.util.List;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import cn.aynu.manage.service.LogService;
import cn.aynu.manage.util.LogUtil;

/**
 *创建日志表的石英任务 
 */
public class CreateLogTablesTask extends QuartzJobBean{

	private LogService logService;
	public void setLogService(LogService logService) {
		this.logService = logService;
	}
	protected void executeInternal(JobExecutionContext arg0) throws JobExecutionException {
		//1.删除 去年 以及 以前的 所有日志表 和 数据
		String lastYeatAgoTable = LogUtil.generateLogTableName(-12);
		//数据库中是否有数据表？
		String sql = "select table_name from information_schema.tables "
				+ "where table_name like 'logs_%' "
				+ "and table_name <= '"+lastYeatAgoTable+"' "
				+ "order by table_name desc ";
		List<String> list = logService.findSqlQuery(null,sql);
		for(String tableName : list)
		{
			String dropSql = "drop table IF EXISTS "+tableName;
			logService.executeSQL(dropSql);
		}
		
		
		//2.生成下三个月的日志表
		//下一月
		String tableName = LogUtil.generateLogTableName(1);
		logService.createTable(tableName);
		//下二月
		tableName = LogUtil.generateLogTableName(2);
		logService.createTable(tableName);
		//下三月
		tableName = LogUtil.generateLogTableName(3);
		logService.createTable(tableName);
	}
}
