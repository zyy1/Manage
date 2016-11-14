package cn.aynu.manage.dao;

import java.util.List;

import cn.aynu.manage.vo.Caseinfo;
import cn.aynu.manage.vo.Pager;


public interface CaseinfoDao extends BaseDao<Caseinfo>{
	
	public Pager<Caseinfo> pagelist(String hql, String hqlCount, int offset);
    public void del(int id);
    public Caseinfo getCaseinfo(int id);
    public void updatecaseinfo(Caseinfo caseinfo);
    public void addCaseinfo(Caseinfo caseinfo);
	public Object uniqueResult(String hql, Object...objects);
    /**
	 * 返回所有caseinfo的id,坐标和严重性
	 * @return
	 */
	public List<Caseinfo> retrunAllCaseInfoes(String hql);
	
	/**
	 * 返回各种类型案件的发生次数
	 * @return
	 */
	public List<String> returnStringArrByHql(String hql, Object...objects);
	/**
	 * 执行原生sql查询
	 * @param sql
	 * @return
	 */
	public Object uniqueResultBySql(String sql);
    
}
