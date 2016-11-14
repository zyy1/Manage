package cn.aynu.manage.vo;

import java.util.Arrays;
import java.util.Set;

import cn.aynu.manage.vo.safe.Right;
import cn.aynu.manage.vo.safe.Role;

public class User implements java.io.Serializable {

	private static final long serialVersionUID = 1603776033714728124L;
	private String username;
	private String password;
	private String email;
	private String phone;
	private String idcard;
	private String work;
	private String workcard;
	private Integer id;
	
	private boolean superAdmin;
	public boolean isSuperAdmin() {
		return superAdmin;
	}
	public void setSuperAdmin(boolean superAdmin) {
		this.superAdmin = superAdmin;
	}
	
	private long[] rightSum;

	
	public long[] getRightSum() {
		return rightSum;
	}
	public void setRightSum(long[] rightSum) {
		this.rightSum = rightSum;
	}
	
	/**
	 * 判断是否拥有对应权限
	 */
	public boolean hasRight(Right r) {
		int pos = r.getRightPos();
		long code = r.getRightCode();
		//不等于0，即有权限
		return (rightSum[pos]&code) != 0;
	}
	/**
	 * 业务方法：计算权限总和
	 */
	public void caculateRightSum()
	{
		int pos = 0;
		long code = 0;
		//遍历所有角色
		for(Role r:roles)
		{
			if("-1".equals(r.getRoleValue()))
			{
				this.superAdmin=true;
				//释放资源
				roles = null;
				return ;
			}
			//遍历所有权限
			for(Right right:r.getRights())
			{
				pos = right.getRightPos();
				code = right.getRightCode();
				
				
				rightSum[pos]=rightSum[pos]+code;
			}
		}
		//释放资源
		roles = null;
	}
	private Set<Role> roles;

	public Set<Role> getRoles() {
		return roles;
	}

	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}

	public User(String username, String password, String email, String phone, String idcard, String work,
			String workcard, Integer id) {
		super();
		this.username = username;
		this.password = password;
		this.email = email;
		this.phone = phone;
		this.idcard = idcard;
		this.work = work;
		this.workcard = workcard;
		this.id = id;
	}

	@Override
	public String toString() {
		return "User [username=" + username + ", password=" + password + ", email=" + email + ", phone=" + phone
				+ ", idcard=" + idcard + ", work=" + work + ", workcard=" + workcard + ", id=" + id + ", superAdmin="
				+ superAdmin + ", rightSum=" + Arrays.toString(rightSum) + ", roles=" + roles + "]";
	}

	public User() {
		super();
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getIdcard() {
		return idcard;
	}

	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}

	public String getWork() {
		return work;
	}

	public void setWork(String work) {
		this.work = work;
	}

	public String getWorkcard() {
		return workcard;
	}

	public void setWorkcard(String workcard) {
		this.workcard = workcard;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

}
