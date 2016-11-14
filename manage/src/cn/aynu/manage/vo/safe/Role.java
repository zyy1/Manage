package cn.aynu.manage.vo.safe;


import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import cn.aynu.manage.vo.User;

public class Role implements Serializable{
	private static final long serialVersionUID = -8925957381934034112L;
	private Integer id;
	private String roleName;
	private String roleValue;
	private String roleDesc;
	@Override
	public String toString() {
		return "Role [id=" + id + ", roleName=" + roleName + ", roleValue=" + roleValue + ", roleDesc=" + roleDesc
				+ ", users=" + users + ", rights=" + rights + "]";
	}
	public Integer getId() {
		return id;
	}
	private Set<User> users = new HashSet<User>();
	private Set<Right> rights = new HashSet<Right>();

	public Set<Right> getRights() {
		return rights;
	}
	public void setRights(Set<Right> rights) {
		this.rights = rights;
	}
	public Set<User> getUsers() {
		return users;
	}
	public void setUsers(Set<User> users) {
		this.users = users;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	public String getRoleValue() {
		return roleValue;
	}
	public void setRoleValue(String roleValue) {
		this.roleValue = roleValue;
	}
	public String getRoleDesc() {
		return roleDesc;
	}
	public void setRoleDesc(String roleDesc) {
		this.roleDesc = roleDesc;
	}
}
