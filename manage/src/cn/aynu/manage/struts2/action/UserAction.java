package cn.aynu.manage.struts2.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import cn.aynu.manage.service.RightService;
import cn.aynu.manage.service.RoleService;
import cn.aynu.manage.service.UserService;
import cn.aynu.manage.vo.Pager;
import cn.aynu.manage.vo.User;
import cn.aynu.manage.vo.safe.Right;
import cn.aynu.manage.vo.safe.Role;
/**
 * @author yehao
 *
 */
@Controller("userAction")
@Scope("prototype")
public class UserAction extends ActionSupport implements ModelDriven<User> {
	
	private static final long serialVersionUID = -5115531220769808535L;

	@Resource
	private UserService userService;
	
	private User user = new User();
	private Role role = new Role();
	private Right right = new Right();
	private Pager<User> page = null;
	private Pager<Role> rolePage = null;
	private Pager<Right> rightPage = null;
	private Integer offset = 1;
	private int pageType = 3;
	//分页查询标志  （list 、listByArgs）
	private String selectPageFlag;
	//接受批量删除user的id集合
	private List<Integer> delUserIds = new ArrayList<Integer>();
	//接收批量删除role的id集合
	private List<Integer> delRoleIds = new ArrayList<Integer>();
	//接收批量删除right的id集合
	private List<Integer> delRightIds = new ArrayList<Integer>();
	private int msg;
	//角色集合
	private List<Role> roles;
	//权限集合
	private Set<Right> rights;
	//角色id
	private Integer roleId;
	//权限Id
	private Integer rightId;
	//角色没有的权限
	private List<Right> withOutRight;
	private String[] ownRightsIds;
	/**
	 * 用户列表
	 * @return String
	 */
	public String userList(){
		page = userService.pageList(offset);
		if (page != null) {
			return "toUserListPage";
		}
		else {
			return ERROR;
		}
	}
	
	/**
	 * 角色列表
	 * @return
	 */
	public String roleList(){
		rolePage = userService.rolePageList(offset);
		if (rolePage != null) {
			return "toRoleListPage";
		}
		else {
			return ERROR;
		}
	}

	/**
	 * 权限列表
	 * @return
	 */
	public String rightList(){
		rightPage = userService.rightPageList(offset);
		if (rightPage != null) {
			return "toRightListPage";
		}
		else {
			return ERROR;
		}
	}
	
	/**
	 * 页面跳转
	 */
	public String blurSearch(){
		page = userService.getUserListByArgs(user,offset);
		if (page != null) {
			selectPageFlag = "listByArgs";
			return "per_list";
		}
		else {
			return ERROR;
		}
	}

	/**
	 *角色页面跳转
	 */
	public String blurSearchRole(){
		rolePage = userService.getRoleListByArgs(role,offset);
		if (rolePage != null) {
			selectPageFlag = "listByArgs";
			return "role_list";
		}
		else {
			return ERROR;
		}
	}

	//查询 的 是否是公共资源
	private String queryCommon;
	public String getQueryCommon() {
		return queryCommon;
	}

	public void setQueryCommon(String queryCommon) {
		this.queryCommon = queryCommon;
	}

	/**
	 *角色页面跳转
	 */
	public String blurSearchRight(){
		rightPage = userService.getRightListByArgs(queryCommon,right,offset);
		if (rightPage != null) {
			selectPageFlag = "listByArgs";
			return "right_list";
		}
		else {
			return ERROR;
		}
	}
	
	/**
	 * 去更新用户信息页面
	 * @return
	 */
	public String toUpdatePage(){
		user = userService.getUserById(user.getId());
		return "toUpdatePage";
	}
	
	/**
	 * 去更新角色信息页面
	 * @return
	 */
	public String toUpdateRolePage(){
		role = userService.getRoleById(roleId);
		return "toUpdateRolePage";
	}
	/**
	 * 去更新权限信息页面
	 * @return
	 */
	public String toUpdateRightPage(){
		right = userService.getRightById(rightId);
		return "toUpdateRightPage";
	}
	
	/**
	 * 更新用户信息
	 * @return
	 */
	public String updateUser(){
		userService.update(user);
		return "toUpdateSuccessPage";
	}
	
	/**
	 * 更新角色信息
	 * @return
	 */
	public String updateRole(){
		role.setId(roleId);
		userService.updateRole(role);
		return "toUpdateSuccessPage";
	}

	/**
	 * 更新角权限信息
	 * @return
	 */
	public String updateRight(){
		
		right.setId(rightId);
		userService.update(right);
		return "toUpdateSuccessPage";
	}
	
	/**
	 * 删除用户
	 * @return
	 */
	public String delUser(){
		userService.delUser(user.getId());
		return "del";
	}

	/**
	 * 删除角色
	 * @return
	 */
	public String delRole(){
		userService.delRole(roleId);
		return "delRole";
	}
	
	/**
	 * 添加用户
	 * @return
	 */
	public String addUser(){
		userService.addEntity(user);
		return "addSuccess";
	}

	/**
	 * 添加角色
	 * @return
	 */
	public String addRole(){
		userService.addEntity(role);
		return "addSuccess";
	}
	
	/**
	 * 批量删除用户
	 * @return
	 */
	public String batchDelUser(){
		for(Integer id : delUserIds){
			userService.delUser(id);
		}
		return "batchDel-success";
	}

	/**
	 * 批量删除角色
	 * @return
	 */
	public String batchDelRole(){
		for(Integer id : delRoleIds){
			userService.delRole(id);
		}
		return "batchDelRole-success";
	}
	@Resource
	private RightService rightService;
	// 验证用户信息
	public String checkUser() {
		User newUser = userService.chekUser(user);
		if (newUser == null)
			msg = 2;

		else {
			msg = 1;
			//初始化权限长度数组，并计算权限总和
			Integer maxPos = rightService.getMaxRightPos();
			newUser.setRightSum(new long[maxPos+1]);
			newUser.caculateRightSum();
			ActionContext.getContext().getSession().put("user", newUser);
		}

		return SUCCESS;
	}
	
	
	
	
	/**
	 * setter/getter
	 * @return
	 */
	public User getModel() {
		return user;
	}
	public Pager<User> getPage() {
		return page;
	}
	public void setPage(Pager<User> page) {
		this.page = page;
	}
	public Integer getOffset() {
		return offset;
	}
	public void setOffset(Integer offset) {
		this.offset = offset;
	}
	public int getPageType() {
		return pageType;
	}
	public void setPageType(int pageType) {
		this.pageType = pageType;
	}
	public String getSelectPageFlag() {
		return selectPageFlag;
	}
	public void setSelectPageFlag(String selectPageFlag) {
		this.selectPageFlag = selectPageFlag;
	}
	public List<Integer> getDelUserIds() {
		return delUserIds;
	}
	public void setDelUserIds(List<Integer> delUserIds) {
		this.delUserIds = delUserIds;
	}
	public int getMsg() {
		return msg;
	}
	public void setMsg(int msg) {
		this.msg = msg;
	}
	//没有的权限
	private List<Role> withOutAuthor;
	public List<Role> getWithOutAuthor() {
		return withOutAuthor;
	}
	public void setWithOutAuthor(List<Role> withOutAuthor) {
		this.withOutAuthor = withOutAuthor;
	}

	/**
	 * 到用户授权管理界面
	 * 1.得到已授权角色
	 * 2.得到未授权角色
	 * @return
	 */
	public String toAuthorizePage()
	{	
		user = userService.getUserById(user.getId());
		withOutAuthor = userService.getWithOutAuthors(user.getRoles());
		return "toAuthorizePage";
	}
	
	@Resource
	private RoleService roleService;
	/**
	 * 到角色授权管理界面
	 * @return
	 */
	public String toRoleAuthorizePage(){
		//获取已经拥有的权限
		role = userService.getRoleById(roleId);
		rights = role.getRights();
		//获取没有的权限
		withOutRight = roleService.getWithoutRights(role.getRights());
		return "toRoleAuthorizePage";
	}
	
	public String[] getOwnRoleIds() {
		return ownRoleIds;
	}
	public void setOwnRoleIds(String[] ownRoleIds) {
		this.ownRoleIds = ownRoleIds;
	}
	//下拉框传过来的 角色 id
	private String[] ownRoleIds;
	/**
	 * 修改用户授权
	 * @return
	 */
	public String updateAuthorize()
	{
		userService.updateAuthorize(user, ownRoleIds);
		return "updateAuthorize-success";
	}

	/**
	 * 修改角色授权
	 * @return
	 */
	public String updateRoleAuthorize()
	{
		Role role = userService.getRoleById(roleId);
		userService.updateRoleAuthorize(role, ownRightsIds);
		return "updateAuthorize-success";
	}
	
	public List<Role> getRoles() {
		return roles;
	}
	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}
	public Set<Right> getRights() {
		return rights;
	}

	public void setRights(Set<Right> rights) {
		this.rights = rights;
	}

	public Pager<Role> getRolePage() {
		return rolePage;
	}
	public void setRolePage(Pager<Role> rolePage) {
		this.rolePage = rolePage;
	}
	public List<Integer> getDelRoleIds() {
		return delRoleIds;
	}
	public void setDelRoleIds(List<Integer> delRoleIds) {
		this.delRoleIds = delRoleIds;
	}
	public Role getRole() {
		return role;
	}
	public void setRole(Role role) {
		this.role = role;
	}
	public Integer getRoleId() {
		return roleId;
	}
	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}
	public Pager<Right> getRightPage() {
		return rightPage;
	}
	public void setRightPage(Pager<Right> rightPage) {
		this.rightPage = rightPage;
	}
	public List<Integer> getDelRightIds() {
		return delRightIds;
	}
	public void setDelRightIds(List<Integer> delRightIds) {
		this.delRightIds = delRightIds;
	}
	public Integer getRightId() {
		return rightId;
	}
	public void setRightId(Integer rightId) {
		this.rightId = rightId;
	}
	public Right getRight() {
		return right;
	}
	public void setRight(Right right) {
		this.right = right;
	}
	public List<Right> getWithOutRight() {
		return withOutRight;
	}
	public void setWithOutRight(List<Right> withOutRight) {
		this.withOutRight = withOutRight;
	}
	public String[] getOwnRightsIds() {
		return ownRightsIds;
	}
	public void setOwnRightsIds(String[] ownRightsIds) {
		this.ownRightsIds = ownRightsIds;
	}
	
	/**
	 * 用户登出
	 * @return
	 */
	public String logout(){
		ActionContext.getContext().getSession().clear();
		return "toIndexPage";
	}
	
	public String toHomePage()
	{
		return "toHomePage";
	}
	public String toAddUserPage()
	{
		return "toAddUserPage";
	}
	
	public String toAddRolePage()
	{
		return "toAddRolePage";
	}
	
}
