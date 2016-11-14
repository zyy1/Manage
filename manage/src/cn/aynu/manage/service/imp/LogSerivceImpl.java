package cn.aynu.manage.service.imp;


import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.hibernate.id.UUIDHexGenerator;
import org.springframework.stereotype.Service;

import cn.aynu.manage.dao.BaseDao;
import cn.aynu.manage.service.LogService;
import cn.aynu.manage.util.LogUtil;
import cn.aynu.manage.util.ValidateUtil;
import cn.aynu.manage.vo.Log;
import cn.aynu.manage.vo.Pager;

@Service("logService")
public class LogSerivceImpl extends BaseServiceImpl<Log> implements LogService {
	@Resource(name="logDao")
	public void setBaseDao(BaseDao<Log> baseDao) {
		super.setBaseDao(baseDao);
	}

	public void createTable(String tableName) {
		//System.out.println("create");
		String sql = "create table if not exists "+tableName+" like log";
		this.executeSQL(sql);
	}

	//重写saveEntity方法
	public void saveEntity(Log t) {
		String currentMonthTable = LogUtil.generateLogTableName(0);
		UUIDHexGenerator uuid = new UUIDHexGenerator();
		String id = (String) uuid.generate(null, null);
		String sql = "insert into "+currentMonthTable
				+" (id,OPERPARAMS,OPERRESULT,OPERNAME,OPERATOR,RESULTMSG,OPERTIME) "
				+ "values(?,?,?,?,?,?,?)";
		try {
			this.executeSQL(sql, id,t.getOperParams(),t.getOperResult(),t.getOperName(),t.getOperator(),t.getResultMsg(),t.getOperTime());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	
	/**
	 * 查询最近n月的日志  和  总数量 
	 */
	public Map<String,Object> findNearLogs(String operator,String result,int n,String operStartTime,String operEndTime,Integer offset){
		//获得当前月
		String currentLogTable = LogUtil.generateLogTableName(0);
		//数据库中是否有数据表？
		String sql = "select table_name from information_schema.tables "
				+ "where table_name like 'logs_%' "
				+ "and table_name <= '"+currentLogTable+"' "
				+ "order by table_name desc "
				+ "limit 0,"+n;
		List list = this.findSqlQuery(null,sql);
		String tableName = "";
		String logListSql = "";
		String logCountSql = "";
		
		for(int i=0;i<list.size();i++)
		{
			tableName = (String) list.get(i);
			logListSql = logListSql + "select * from "+tableName+" where 1 = '1'";
			logCountSql = logCountSql + "select count(id) as logCount from "+tableName+" where 1 = '1'";
			if(ValidateUtil.isValid(operator))
			{
				logListSql = logListSql + " and OPERATOR like '%"+operator+"%'";
				logCountSql = logCountSql + " and OPERATOR like '%"+operator+"%'";
			}
			if(ValidateUtil.isValid(result))
			{
				logListSql = logListSql + " and OPERRESULT = '"+result+"'";
				logCountSql = logCountSql + " and OPERRESULT = '"+result+"'";
			}
			if(ValidateUtil.isValid(operStartTime))
			{
				logListSql = logListSql + " and OPERTIME > '"+operStartTime+"'";
				logCountSql = logCountSql + " and OPERTIME > '"+operStartTime+"'";
			}
			if(ValidateUtil.isValid(operEndTime))
			{
				logListSql = logListSql + " and OPERTIME < '"+operEndTime+"'";
				logCountSql = logCountSql + " and OPERTIME < '"+operEndTime+"'";
			}
			if(i+1 != list.size())
			{
				logListSql = logListSql + " union ";
				logCountSql = logCountSql + " union ";
			}
		}
		//如果等于 offset 等于 -1，表示导出所有 筛选条件的日志
		if(offset == -1)
		{
			logListSql = logListSql + " ORDER BY OPERTIME DESC";
		}
		else{
			logListSql = logListSql + " ORDER BY OPERTIME DESC limit "+(offset-1)*15+","+offset*15;
		}
		logCountSql = "select sum(logCount) from ("+logCountSql+") as cc";
		Map<String,Object> map = new HashMap<>();  
		map.put("logs", this.findSqlQuery(Log.class,logListSql));
		map.put("logCount", ((BigDecimal)this.uniqueResultBySql(logCountSql)).intValue());
		return map;
	}

	public Pager<Log> pagelist(Log log, String operStartTime, String operEndTime, Integer offset) {
		Pager<Log> page = new Pager<>();
		try {
			Map<String,Object> map = this.findNearLogs(log.getOperator(),log.getOperResult(),LogUtil.calculateMonthsBetweenTwoDate(operStartTime, operEndTime), operStartTime, operEndTime,offset);
			page.setDatas((List<Log>)map.get("logs"));
			page.setOffset(offset);
			//默认一页显示 15条记录
			page.setSize(15);
			page.setTotal((Integer)map.get("logCount"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return page;
	}
}
