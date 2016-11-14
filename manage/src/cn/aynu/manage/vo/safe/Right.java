package cn.aynu.manage.vo.safe;


import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

public class Right implements Serializable{
	private static final long serialVersionUID = -8565410698619618420L;
	private Integer id;
	private String rightName = "未命名";
	private String rightUrl;
	private String rightDesc;
	private long rightCode;// 权限码,1<<n
	private int rightPos; // 权限位,相当于对权限分组,从0开始
	private Boolean common=false;//是否是公共资源(默认flase)
	public Boolean isCommon() {
		return common;
	}
	@Override
	public String toString() {
		return "Right [id=" + id + ", rightName=" + rightName + ", rightUrl=" + rightUrl + ", rightDesc=" + rightDesc
				+ ", rightCode=" + rightCode + ", rightPos=" + rightPos + ", common=" + common + ", roles=" + roles
				+ "]";
	}
	public void setCommon(Boolean common) {
		this.common = common;
	}
	private Set<Role> roles = new HashSet<Role>();
	public Set<Role> getRoles() {
		return roles;
	}
	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getRightName() {
		return rightName;
	}
	public void setRightName(String rightName) {
		this.rightName = rightName;
	}
	public String getRightUrl() {
		return rightUrl;
	}
	public void setRightUrl(String rightUrl) {
		this.rightUrl = rightUrl;
	}
	public String getRightDesc() {
		return rightDesc;
	}
	public void setRightDesc(String rightDesc) {
		this.rightDesc = rightDesc;
	}
	public long getRightCode() {
		return rightCode;
	}
	public void setRightCode(long rightCode) {
		this.rightCode = rightCode;
	}
	public int getRightPos() {
		return rightPos;
	}
	public void setRightPos(int rightPos) {
		this.rightPos = rightPos;
	}

}
