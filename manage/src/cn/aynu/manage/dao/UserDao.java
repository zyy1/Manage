package cn.aynu.manage.dao;

import java.util.List;

import cn.aynu.manage.vo.Pager;
import cn.aynu.manage.vo.User;
import cn.aynu.manage.vo.safe.Right;
import cn.aynu.manage.vo.safe.Role;

public interface UserDao {
	/**
	 * 所有用户列表
	 */
	List<User> findAllUsers(String hql, Object...objects);
	
	/**
	 * 用户列表页
	 * @param hql
	 * @param hqlCount
	 * @param offset
	 * @return
	 */
	Pager<User> pagelist(String hql, String hqlCount, Integer offset);
	
	/**
	 * 根据id获取User对象
	 * @param id
	 * @return
	 */
	User getUser(Integer id);

	/**
	 * 更新
	 * @param User
	 */
	void update(Object object);

	/**
	 * 删除用户
	 * @param id
	 */
	void delUser(User user);

	/**
	 * 添加用户
	 * @param User
	 */
	void addUser(User user);
	
	//查询角色
	User chekUser(String hql, User user);

	/**
	 * 返回实体集合根据Hql和参数
	 * @param hql
	 * @return List<T>
	 */
	@SuppressWarnings("rawtypes")
	List findEntityByHql(String hql, Object...objects);
	
	/**
	 * 角色列表页
	 * @param hql
	 * @param hqlCount
	 * @param offset
	 * @return
	 */
	Pager<Role> rolePagelist(String hql, String hqlCount, Integer offset);
	
	/**
	 * 插入记录
	 * @param object
	 */
	void addEntity(Object object);
	
	/**
	 * 根据Id获取角色
	 * @param id
	 * @return
	 */
	Role getRoleById(Integer id);

	/**
	 * 删除角色
	 * @param role
	 */
	void delRole(Role role);
	
	/**
	 * 权限列表
	 * @param hql
	 * @param hqlCount
	 * @param offset
	 * @return
	 */
	Pager<Right> rightPagelist(String hql, String hqlCount, Integer offset);
	
	/**
	 * 根据id获取权限
	 * @param rightId
	 * @return
	 */
	Right getRightById(Integer rightId);
	
}
