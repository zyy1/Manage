package cn.aynu.manage.dao.imp;

import java.lang.reflect.ParameterizedType;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import cn.aynu.manage.dao.BaseDao;
import cn.aynu.manage.vo.Caseinfo;
import cn.aynu.manage.vo.Pager;
import cn.aynu.manage.vo.Shop;
import cn.aynu.manage.vo.UploadFile;

@SuppressWarnings("unchecked")
@Repository("baseDao")
public abstract class BaseDaoImpl<T> implements BaseDao<T> {
	public Class<T> clazz;
	public BaseDaoImpl()
	{
		//反射机制 获取class
		ParameterizedType type=(ParameterizedType) this.getClass().getGenericSuperclass();
		clazz = (Class<T>) type.getActualTypeArguments()[0];
	}
	
	@Autowired
	private SessionFactory sessionFactory;
	public void saveEntity(T t) {
		sessionFactory.getCurrentSession().save(t);
	}

	public void saveOrUpdateEntity(T t) {
		sessionFactory.getCurrentSession().saveOrUpdate(t);
	}

	public void updateEntity(T t) {
		sessionFactory.getCurrentSession().update(t);
	}

	public void deleteEntity(T t) {
		sessionFactory.getCurrentSession().delete(t);
	}
	

	public void batchEntityByHQL(String hql, Object... objects) {
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		for(int i = 0; i<objects.length; i++)
		{
			query.setParameter(i, objects[i]);
		}
		query.executeUpdate();
	}

	public T loadEntity(Integer id) {
		return (T) sessionFactory.getCurrentSession().load(clazz, id);
	}

	
	public T getEntity(Integer id) {
		return (T) sessionFactory.getCurrentSession().get(clazz, id);
	}

	public List<T> findEntityByHQL(String hql, Object... objects) {
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		for(int i = 0; i<objects.length; i++)
		{
			query.setParameter(i, objects[i]);
		}
		return query.list();
	}
	
	//执行sql语句
	public void executeSQL(String sql,Object...objects){
		SQLQuery query = sessionFactory.getCurrentSession().createSQLQuery(sql);
		for(int i = 0; i<objects.length; i++)
		{
			query.setParameter(i, objects[i]);
		}
		query.executeUpdate();
	}
	
	public Object uniqueResultBySql(String sql, Object...objects)
	{
		SQLQuery query = sessionFactory.getCurrentSession().createSQLQuery(sql);
		for(int i = 0; i<objects.length; i++)
		{
			query.setParameter(i, objects[i]);
		}
		return query.uniqueResult();
	}
	
	//只有一个结果的
	public Object uniqueResultByHQL(String hql,Object...objects){
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		for(int i = 0; i<objects.length; i++)
		{
			query.setParameter(i, objects[i]);
		}
		return query.uniqueResult();
	}
	/**
	 *原生的sql语句查询 
	 */
	public List findSqlQuery(Class clazz,String sql,Object...objects){
		SQLQuery query = sessionFactory.getCurrentSession().createSQLQuery(sql);
		if(clazz!=null)
		{
			//封装成clazz对象
			query.addEntity(clazz);
		}
		for(int i = 0; i<objects.length; i++)
		{
			query.setParameter(i, objects[i]);
		}
		return query.list();
	}
	
	/**
	 * 返回唯一结果
	 * @param hql
	 * @param objects
	 * @return
	 */
	public Object uniqueResult(String hql, Object...objects) {
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		for(int i = 0; i < objects.length; i ++){
			query.setParameter(i, objects[i]);
		}
		return query.uniqueResult();
	}
	/**
	 * 根据hql和参数返回字符串数组
	 * @param hql
	 * @param objects
	 * @return
	 */
	public List<String> returnStringArrByHql(String hql, Object...objects) {
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		for(int i = 0; i < objects.length; i++){
			query.setParameter(i, objects[i]);
		}
		return query.list();
	}
	
	/**
	 * 列表页
	 * @param hql
	 * @param hqlCount
	 * @param offset
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Pager<T> pagelist(String hql, String hqlCount, Integer offset) {
		  	int pageSize =15;
			List<T> datas =sessionFactory.getCurrentSession().createQuery(hql).setFirstResult((offset-1)*pageSize).setMaxResults(pageSize).list();
	 		int count = ((Long) sessionFactory.getCurrentSession().createQuery(hqlCount).iterate().next()).intValue();
			
	 		Pager<T> pg=new Pager<T>();
	 		pg.setDatas(datas);
			pg.setSize(pageSize);
			pg.setTotal(count);
			pg.setOffset(offset);
	    	return pg; 
	}
}
