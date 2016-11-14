package cn.aynu.manage.service;

import java.util.List;
import java.util.Set;

import cn.aynu.manage.vo.Pager;
import cn.aynu.manage.vo.User;
import cn.aynu.manage.vo.safe.Role;
import cn.aynu.manage.vo.safe.Right;
import cn.aynu.manage.vo.safe.Role;

public interface UserService {
	/**
	 * 所有商铺列表
	 */
	List<User> findAllUsers();
	/**
	 * 商铺列表页
	 * @param offset
	 * @return
	 */
	Pager<User> pageList(Integer offset);
	
	/**
	 * 页面跳转
	 */
	Pager<User> getUserListByArgs(User user, Integer offset);
	
	/**
	 * 根据id获取shop对象
	 * @param id
	 * @return
	 */
	User getUserById(Integer id);
	
	
	/**
	 * 删除商铺
	 * @param id
	 */
	void delUser(Integer id);
	
	/**
	 * 插入记录
	 * @param shop
	 */
	void addEntity(Object object);
	
	/**
	 * 更新
	 * @param shop
	 */
	void update(Object object);
	
	/**
	 * 更新Role
	 * @param role
	 */
	void updateRole(Role role);
	
	/**
	 * 验证和用户信息
	 * @param user
	 * @return
	 */
	User chekUser(User user);
	/**
	 * 得到未获得权限的 角色
	 * @param set 
	 * @return
	 */
	List<Role> getWithOutAuthors(Set<Role> set);
	
	/**
	 * 修改用户授权信息
	 * @param model
	 * @param ids
	 */
	public void updateAuthorize(User user, String[] ids);
	
	/**
	 * 返回Role集合
	 * @return
	 */
	List<Role> returnAllRoles();
	
	/**
	 * 角色列表页
	 * @param offset
	 * @return
	 */
	Pager<Role> rolePageList(Integer offset);
	
	/**
	 * 角色页面跳转
	 * @param role
	 * @param offset
	 * @return
	 */
	Pager<Role> getRoleListByArgs(Role role, Integer offset);
	/**
	 * 权限页面跳转
	 * @param role
	 * @param offset
	 * @return
	 */
	Pager<Right> getRightListByArgs(String queryCommon,Right right, Integer offset);
	
	/**
	 * 根据Id获取角色
	 * @param id
	 * @return
	 */
	Role getRoleById(Integer id);
	
	/**
	 * 删除角色
	 * @param id
	 */
	void delRole(Integer id);
	
	/**
	 * 权限列表
	 * @param offset
	 * @return
	 */
	Pager<Right> rightPageList(Integer offset);
	
	/**
	 * 根据id获取权限
	 * @param rightId
	 * @return
	 */
	Right getRightById(Integer rightId);
	
	/**
	 * 得到角色没有的权限
	 * @param rights
	 * @return
	 */
	List<Right> getWithOutRights(Set<Right> rights, List<Right> ownRights);
	
	/**
	 * 修改角色授权
	 * @param role
	 * @param ownRightsIds
	 */
	void updateRoleAuthorize(Role role, String[] ownRightsIds);
	
}
