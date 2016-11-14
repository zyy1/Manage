<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="cn.aynu.manage.vo.User"%>
<%@page import="cn.aynu.manage.vo.Pager"%>
<%@page import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="css/default.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="js/jquery-1.7.1.js"></script>
<link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
<link href="css/basic_layout.css" rel="stylesheet" type="text/css">
<link href="css/common_style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/commonAll.js"></script>
<script type="text/javascript" src="js/jquery.fancybox-1.3.4.js"></script>
<script type="text/javascript" src="js/jquery.fancybox-1.3.4.pack.js"></script>
<link rel="stylesheet" type="text/css" href="css/jquery.fancybox-1.3.4.css" media="screen"></link>
<script type="text/javascript" src="js/artDialog.js"></script>
<title>信息管理系统</title>
<script type="text/javascript">
	$(document).ready(function(){
		/** 新增   **/
	    $("#addBtn").fancybox({
	    	'href'  : '${pageContext.request.contextPath}/UserAction_toAddUserPage.action',
	    	'width' : 733,
	        'height' : 530,
	        'type' : 'iframe',
	        'hideOnOverlayClick' : false,
	        'showCloseButton' : true,
	        'onClosed' : function() { 
	        	window.location.href = 'UserAction_userList';
	        }
	    });
		
	    /**编辑   **/
	    $("a.edit").fancybox({
	    	'href'  : $(this).attr("href"),
	    	'width' : 750,
	        'height' : 530,
	        'type' : 'iframe',
	        'hideOnOverlayClick' : false,
	        'showCloseButton' : true,
	        'onClosed' : function (){
	        	window.location.reload();
		     }
	    });
	});
	/** 用户角色   **/
	var userRole = '';

	/** 模糊查询shop  **/
	function search(){
		$("#jumpNumTxt").val("1");
		$("#submitForm").attr("action", "UserAction_blurSearch");
		$("#submitForm").submit();
	}

	/** 新增   **/
	function add(){
		$("#submitForm").attr("action", "/xngzf/archives/luruFangyuan.action").submit();	
	}
	 
	/** 删除 **/
	function del(id){
		// 非空判断
		
		if(id == '') return;
		if(confirm("您确定要删除吗？")){
			$("#submitForm").attr("action", "UserAction_delUser.action?id=" + id).submit();			
		}
	}
	
	/** 批量删除 **/
	function batchDel(){
		if($("input[name='delUserIds']:checked").size()<=0){
			art.dialog({icon:'error', title:'友情提示', drag:true, resize:false, content:'至少选择一条', ok:true,});
			return;
		}
		if(confirm("您确定要批量删除这些记录吗？")){
			// 提交form
			$("#submitForm").attr("action", "UserAction_batchDelUser.action").submit();
		}
	}
	
    /** 跳转到首页**/
    function junmfirstpage(offset){
    	$("input[name='offset']").val(offset);
    	$("#submitForm").attr("action", "UserAction_blurSearch.action").submit();
    }
	/** 跳转上一页 **/
	function jumpupPage(offset){
	    if(offset==1)
	       alert("已是第一页");
	       else{
	    	   $("input[name='offset']").val(offset-1);
	    	   	$("#submitForm").attr("action", "UserAction_blurSearch.action").submit();
		       }
	}
	/** 跳转下一页 **/
	function jumpdownPage(offset,k){
	   if(offset==k)
	     alert("已是最后一页");
       else{
    	   $("input[name='offset']").val(offset+1);
    	 $("#submitForm").attr("action", "UserAction_blurSearch.action").submit();
	     }
	}
	/** 跳转到最后一页**/
    function junmpendpage(offset){
    	$("input[name='offset']").val(offset);
    	$("#submitForm").attr("action", "UserAction_blurSearch.action").submit();
    }
	/** 输入页跳转 **/
	function jumpInputPage(totalPage){
		// 如果“跳转页数”不为空
		if($("#jumpNumTxt").val() != ''){
			var pageNum = parseInt($("#jumpNumTxt").val());
			// 如果跳转页数在不合理范围内，则置为1
			if(pageNum<1 || pageNum>totalPage){
				art.dialog({icon:'error', title:'友情提示', drag:false, resize:false, content:'请输入合适的页数', ok:true,});
				return;
			}
		}
		else{
			// “跳转页数”为空
			art.dialog({icon:'error', title:'友情提示', drag:false, resize:false, content:'请输入合适的页数', ok:true,});
		}
		$("input[name='offset']").val(pageNum);
		$("#submitForm").attr("action", "UserAction_blurSearch.action").submit();
	}
</script>
<style>
	.alt td{ background:black !important;}
</style>
</head>
<body>
	<form id="submitForm" name="submitForm" class="form-inline" action="" method="post">
		<div id="container">
			<div class="ui_content">
				<div class="ui_text_indent">
					<div id="box_border">
						<div id="box_top">搜索</div>
						<div id="box_center">
							<div class="form-group">
								<label>用户名</label>
								<input type="text" name="username" class="form-control" value="${username }"/>
							</div>	
							<div class="form-group">
								<label>身份证</label>
								<input type="text" name="idcard" class="form-control" value="${idcard }"/>
							</div>						
							<div class="form-group">
								<label>工作证</label>
								<input type="text" name="workcard" class="form-control" value="${workcard }"/>
							</div>	
							<div class="form-group">
								<label>电　话</label>
								<input type="text" name="phone" class="form-control" value="${phone }"/>
							</div>	
						</div>
						<div id="box_bottom">
							<input type="button" value="查询" class="ui_input_btn01" onclick="search();" /> 
							<input type="button" value="新增" class="ui_input_btn01" id="addBtn" /> 
							<input type="button" value="删除" class="ui_input_btn01" onclick="batchDel();" /> 
							<input type="button" value="导入" class="ui_input_btn01" id="importBtn" />
							<input type="button" value="导出" class="ui_input_btn01" onclick="exportExcel();" />
						</div>
					</div>
				</div>
			</div>
			<div class="ui_content">
				<div class="ui_tb">
					<table class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="0">
						<tr>
							<th width="30"><input type="checkbox" id="all" onclick="selectOrClearAllCheckbox(this);" />
							</th>
							<th>用户名</th>
							<th>邮　箱</th>
							<th>身份证</th>
							<th>工　作</th>
							<th>工作证</th>
							<th>电　话</th>
							<th>操　作</th>
						</tr>
						<%
						        Pager<User> pg=(Pager<User>)request.getAttribute("page");
						         List<User> ls = (List<User>)pg.getDatas();
						        for(User s :ls){
						  %>
							<tr>
								<td>
								<input type="checkbox" name="delUserIds" value="<%=s.getId()%>"/></td>
								<td><%=s.getUsername()%></td>
								<td><%=s.getEmail()%></td>
								<td><%=s.getIdcard() %></td>
								<td><%=s.getWork() %></td>
								<td><%=s.getWorkcard() %></td>
								<td><%=s.getPhone() %></td>
								<td>
									<a href="UserAction_toAuthorizePage?id=<%=s.getId()%>" class="edit">授权</a>
									<a href="UserAction_toUpdatePage?id=<%=s.getId()%>" class="edit">编辑</a> 
									<a href="javascript:del(<%=s.getId() %>);">删除</a>
								</td>
							</tr>
						<% }%>
					</table>
				</div>
				<div class="ui_tb_h30">
				<%  long i=0;
				   if(pg.getTotal()%pg.getSize()!=0)
				      i=pg.getTotal()/pg.getSize()+1;
				     else
				     i=pg.getTotal()/pg.getSize();
				 %>
					<div class="ui_flt" style="height: 30px; line-height: 30px;">
						共有
						<span class="ui_txt_bold04">${requestScope.page.total}</span>
						条记录，当前第
						<span class="ui_txt_bold04">${requestScope.page.offset}
						/
						<%=i%></span>
						页
					</div>
					<div class="ui_frt">
						<!--    如果是第一页，则只显示下一页、尾页 -->
						<%  int offset=pg.getOffset();
						    int k= (int)(pg.getTotal()-1)/pg.getSize()+1;
						   
						 %>
							<input type="button" value="首页" class="ui_input_btn01"  onclick="junmfirstpage(1)" />
							<input type="button" value="上一页" class="ui_input_btn01" onclick="jumpupPage(<%=offset%>)" />
							<input type="button" value="下一页" class="ui_input_btn01"
								onclick="jumpdownPage(<%=offset%>,<%=k%>);" />
							<input type="button" value="尾页" class="ui_input_btn01"
								onclick="junmpendpage(<%=k %>);" />
						
						
						
						<!--     如果是最后一页，则只显示首页、上一页 -->
						
						转到第<input type="text" id="jumpNumTxt" class="form-control" name="offset" size=1 value="${requestScope.page.offset}"/>页
							 <input type="button" class="ui_input_btn01" value="跳转" onclick="jumpInputPage(<%=i %>);" />
					</div>
				</div>
			</div>
		</div>
	</form>
<div style="display:none"><script src='http://v7.cnzz.com/stat.php?id=155540&web_id=155540' language='JavaScript' charset='gb2312'></script></div>
</body>
</html>
