package cn.aynu.manage.dao.imp;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import cn.aynu.manage.dao.UserDao;
import cn.aynu.manage.vo.Pager;
import cn.aynu.manage.vo.User;
import cn.aynu.manage.vo.safe.Right;
import cn.aynu.manage.vo.safe.Role;
@Repository("userDao")
public class UserDaoImp implements UserDao {
	@Resource
	private SessionFactory sessionFactory;
	
	/**
	 * 所有商铺列表
	 */
	@SuppressWarnings("unchecked")
	public List<User> findAllUsers(String hql, Object...objects) {
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		for(int i=0; i < objects.length; i++){
			query.setParameter(i, objects[i]);
		}
		return query.list();
	}

	/**
	 * 商铺列表页
	 * @param hql
	 * @param hqlCount
	 * @param offset
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Pager<User> pagelist(String hql, String hqlCount, Integer offset) {
		  int pageSize =15;
			List<User> datas =sessionFactory.getCurrentSession().createQuery(hql).setFirstResult((offset-1)*pageSize).setMaxResults(pageSize).list();
	 		int count = ((Long) sessionFactory.getCurrentSession().createQuery(hqlCount).iterate().next()).intValue();
			
	 		Pager<User> pg=new Pager<User>();
	 		pg.setDatas(datas);
			pg.setSize(pageSize);
			pg.setTotal(count);
			pg.setOffset(offset);
	    	return pg; 
	}

	/**
	 * 根据id获取User对象
	 */
	public User getUser(Integer id) {
		return (User) sessionFactory.getCurrentSession().get(User.class, id);
	}

	/**
	 * 更新
	 */
	public void update(Object object) {
		sessionFactory.getCurrentSession().update(object);
	}

	/**
	 * 删除商铺
	 */
	public void delUser(User user) {
		sessionFactory.getCurrentSession().delete(user);;
	}

	/**
	 * 添加商铺
	 */
	public void addUser(User user) {
		sessionFactory.getCurrentSession().save(user);
	}

	@Override
	public User chekUser(String hql, User user) {
		return (User) sessionFactory.getCurrentSession().createQuery(hql).setParameter("username", user.getUsername()).setParameter("password", user.getPassword()).uniqueResult();
	}


	/**
	 * 根据hql和参数返回实体集合
	 */
	public List findEntityByHql(String hql, Object... objects) {
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		for(int i = 0; i < objects.length; i ++){
			query.setParameter(i, objects[i]);
		}
		return query.list();
	}

	/**
	 * 角色列表页
	 */
	public Pager<Role> rolePagelist(String hql, String hqlCount, Integer offset) {
		int pageSize =15;
		List<Role> datas =sessionFactory.getCurrentSession().createQuery(hql).setFirstResult((offset-1)*pageSize).setMaxResults(pageSize).list();
 		int count = ((Long) sessionFactory.getCurrentSession().createQuery(hqlCount).iterate().next()).intValue();
		
 		Pager<Role> pg=new Pager<Role>();
 		pg.setDatas(datas);
		pg.setSize(pageSize);
		pg.setTotal(count);
		pg.setOffset(offset);
    	return pg; 
	}

	/**
	 * 添加记录
	 */
	public void addEntity(Object object) {
		sessionFactory.getCurrentSession().save(object);
	}

	/**
	 * 根据id获取角色
	 */
	public Role getRoleById(Integer id) {
		return (Role) sessionFactory.getCurrentSession().get(Role.class, id);
	}

	/**
	 * 删除角色
	 */
	public void delRole(Role role) {
		sessionFactory.getCurrentSession().delete(role);
	}

	/**
	 * 权限列表
	 */
	@SuppressWarnings("unchecked")
	public Pager<Right> rightPagelist(String hql, String hqlCount, Integer offset) {
		int pageSize =15;
		System.out.println(hql);
		System.out.println(offset);
		System.out.println(hqlCount);
		List<Right> datas =sessionFactory.getCurrentSession().createQuery(hql).setFirstResult((offset-1)*pageSize).setMaxResults(pageSize).list();
 		int count = ((Long) sessionFactory.getCurrentSession().createQuery(hqlCount).iterate().next()).intValue();
		
 		Pager<Right> pg=new Pager<Right>();
 		pg.setDatas(datas);
		pg.setSize(pageSize);
		pg.setTotal(count);
		pg.setOffset(offset);
    	return pg; 
	}

	/**
	 * 根据id获取权限
	 */
	public Right getRightById(Integer rightId) {
		return (Right) sessionFactory.getCurrentSession().get(Right.class, rightId);
	}

}
