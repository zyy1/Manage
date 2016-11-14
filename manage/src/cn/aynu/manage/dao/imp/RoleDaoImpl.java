package cn.aynu.manage.dao.imp;

import org.springframework.stereotype.Repository;

import cn.aynu.manage.dao.RoleDao;
import cn.aynu.manage.vo.safe.Role;

@Repository(value="roleDao")
public class RoleDaoImpl extends BaseDaoImpl<Role> implements RoleDao{

}
