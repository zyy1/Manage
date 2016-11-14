package cn.aynu.manage.dao;

import java.util.List;

import cn.aynu.manage.vo.Pager;

public interface BaseDao<T> {
	//写操作
	public void saveEntity(T t);
	public void saveOrUpdateEntity(T t);
	public void updateEntity(T t);
	public void deleteEntity(T t);
	//不知道有多少个参数
	public void batchEntityByHQL(String hql,Object...objects);
	
	//执行sql语句
	public void executeSQL(String sql,Object...objects);
	
	//读操作
	public T loadEntity(Integer id);
	public T getEntity(Integer id);
	public List<T> findEntityByHQL(String hql,Object...objects);
	//只有一个结果的
	public Object uniqueResultByHQL(String hql,Object...objects);
	
	/**
	 *原生的sql语句查询 ,clazz判断是否保存为对象
	 */
	public List findSqlQuery(Class clazz,String sql,Object...objects);
	
	public Object uniqueResultBySql(String sql,Object...objects);
	/**
	 * 分页查询 列表
	 */
	public Pager<T> pagelist(String hql, String hqlCount, Integer offset);
}
