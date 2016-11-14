package cn.aynu.manage.service;

import java.util.List;
import java.util.Set;

import cn.aynu.manage.vo.safe.Right;

public interface RoleService {
	/**
	 * 得到当前角色 没有的权限
	 * @return
	 */
	public List<Right> getWithoutRights(Set<Right> rights);
}
