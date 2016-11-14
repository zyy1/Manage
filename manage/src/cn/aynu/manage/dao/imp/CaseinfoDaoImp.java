package cn.aynu.manage.dao.imp;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import cn.aynu.manage.dao.CaseinfoDao;
import cn.aynu.manage.vo.Caseinfo;
import cn.aynu.manage.vo.Pager;
@SuppressWarnings("unchecked")
@Repository("CaseinfoDao")
public class CaseinfoDaoImp extends BaseDaoImpl<Caseinfo> implements CaseinfoDao  {
	@Resource
	private SessionFactory sessionFactory;

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@Override
	public Pager<Caseinfo> pagelist(String hql, String hqlCount, int offset) {
		int pagesize = 15;
		List<Caseinfo> datas = (List<Caseinfo>) sessionFactory.getCurrentSession().createQuery(hql)
				.setFirstResult((offset - 1) * pagesize).setMaxResults(pagesize).list();
		int count = ((Long) sessionFactory.getCurrentSession().createQuery(hqlCount).iterate().next()).intValue();
		Pager<Caseinfo> pg = new Pager<Caseinfo>();
		pg.setDatas(datas);
		pg.setSize(pagesize);
		pg.setTotal(count);
		pg.setOffset(offset);
		return pg;
	}
    public Caseinfo getCaseinfo(int id){
    	
    	return (Caseinfo) sessionFactory.getCurrentSession().get(Caseinfo.class, id);
    } 
	@Override
	public void del(int id) {
		sessionFactory.getCurrentSession().delete(this.getCaseinfo(id));
	}

	public Object uniqueResult(String hql, Object...objects)
	{
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		for(int i = 0; i < objects.length; i ++){
			query.setParameter(i, objects[i]);
		}
		return query.uniqueResult();
	}
	
	/**
	 * 执行原生sql查询
	 * @param sql
	 * @return
	 */
	public Object uniqueResultBySql(String sql)
	{
		return (Object) sessionFactory.getCurrentSession().createSQLQuery(sql).uniqueResult();
	}
	
	public void updatecaseinfo(Caseinfo caseinfo) {
      sessionFactory.getCurrentSession().update(caseinfo);		
	}

	@Override
	public void addCaseinfo(Caseinfo caseinfo) {
      sessionFactory.getCurrentSession().save(caseinfo);		
	}

	/**
	 * 返回所有caseinfo的id,坐标和严重性
	 * @return
	 */
	public List<Caseinfo> retrunAllCaseInfoes(String hql) {
		return sessionFactory.getCurrentSession().createQuery(hql).list();
	}
	

	/**
	 * 返回各种类型案件的发生次数
	 * @return
	 */
	public List<String> returnStringArrByHql(String hql, Object...objects) {
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		for(int i = 0; i < objects.length; i++){
			query.setParameter(i, objects[i]);
		}
		return query.list();
	}

}
