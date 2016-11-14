package cn.aynu.manage.service.imp;

import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.aynu.manage.dao.imp.RightDaoImpl;
import cn.aynu.manage.util.ValidateUtil;
import cn.aynu.manage.vo.safe.Right;

@Service("roleService")
public class RoleServiceImpl implements cn.aynu.manage.service.RoleService {
	
	@Resource
	private RightDaoImpl rightDao;
	/**
	 * 得到当前角色 没有的权限
	 * @return
	 */
	public List<Right> getWithoutRights(Set<Right> rights) {
		String hql;
		if(!ValidateUtil.isValid(rights))
		{
			hql = "from Right";
		}
		else{
			String roleIdString =""; 
			for(Right r : rights)
			{
				roleIdString = roleIdString+r.getId()+",";
			}
			hql = "from Right r where r.id not in ("+roleIdString.substring(0, roleIdString.length()-1)+")";
		}
		return rightDao.findEntityByHQL(hql);
	}

}
