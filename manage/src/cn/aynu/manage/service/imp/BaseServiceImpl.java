package cn.aynu.manage.service.imp;

import java.util.List;

import org.apache.poi.ss.formula.functions.T;

import cn.aynu.manage.dao.BaseDao;
import cn.aynu.manage.service.BaseService;
import cn.aynu.manage.vo.Caseinfo;
import cn.aynu.manage.vo.Pager;

public class BaseServiceImpl<T> implements BaseService<T>{
	
	private BaseDao<T> baseDao;
	public void setBaseDao(BaseDao<T> baseDao) {
		this.baseDao = baseDao;
	}
	
	public void saveEntity(T t) {
		baseDao.saveEntity(t);
	}

	public void saveOrUpdateEntity(T t) {
		baseDao.saveOrUpdateEntity(t);
	}

	public void updateEntity(T t) {
		baseDao.updateEntity(t);
	}

	public void deleteEntity(T t) {
		baseDao.deleteEntity(t);
	}

	public void batchEntityByHQL(String hql, Object... objects) {
		baseDao.batchEntityByHQL(hql, objects);
	}

	public void executeSQL(String sql, Object... objects) {
		baseDao.executeSQL(sql, objects);
	}

	public T loadEntity(Integer id) {
		return baseDao.loadEntity(id);
	}

	public T getEntity(Integer id) {
		return baseDao.getEntity(id);
	}

	public List<T> findEntityByHQL(String hql, Object... objects) {
		return baseDao.findEntityByHQL(hql, objects);
	}

	public Object uniqueResultByHQL(String hql, Object... objects) {
		return baseDao.uniqueResultByHQL(hql, objects);
	}

	public List findSqlQuery(Class clazz, String sql, Object... objects) {
		return baseDao.findSqlQuery(clazz, sql, objects);
	}
	public Object uniqueResultBySql(String sql,Object...objects){
		return baseDao.uniqueResultBySql(sql, objects);
	}
	
	public Pager<T> pagelist(int offset,String hql,String hqlCount) {
		return baseDao.pagelist(hql, hqlCount, offset);
	}
	
}
