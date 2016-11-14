<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="cn.aynu.manage.vo.Pager"%>
<%@page import="cn.aynu.manage.vo.safe.Right"%>
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
	    	'href'  : '${pageContext.request.contextPath}/UserAction_toAddRightPage.action',
	    	'width' : 733,
	        'height' : 530,
	        'type' : 'iframe',
	        'hideOnOverlayClick' : false,
	        'showCloseButton' : true,
	        'onClosed' : function() { 
	        	window.location.href = 'UserAction_rightList';
	        }
	    });
		
	    /**编辑   **/
	    $("a.edit").fancybox({
	    	'href'  : $(this).attr("href"),
	    	'width' : 733,
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
	var userright = '';

	/** 模糊查询right  **/
	function search(){
		$("#jumpNumTxt").val("1");
		$("#submitForm").attr("action", "UserAction_blurSearchRight");
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
			$("#submitForm").attr("action", "UserAction_delRight.action?rightId=" + id).submit();			
		}
	}
	
	/** 批量删除 **/
	function batchDel(){
		if($("input[name='delRightIds']:checked").size()<=0){
			art.dialog({icon:'error', title:'友情提示', drag:true, resize:false, content:'至少选择一条', ok:true,});
			return;
		}
		if(confirm("您确定要批量这些记录吗？")){
			// 提交form
			$("#submitForm").attr("action", "UserAction_batchDelRight.action").submit();
		}
	}
	
    /** 跳转到首页**/
    function junmfirstpage(offset){
    	$("input[name='offset']").val(offset);
    	$("#submitForm").attr("action", "UserAction_blurSearchRight.action").submit();
    }
	/** 跳转上一页 **/
	function jumpupPage(offset){
	    if(offset==1)
	       alert("已是第一页");
	       else{
	    	   $("input[name='offset']").val(offset-1);
	    	   	$("#submitForm").attr("action", "UserAction_blurSearchRight.action").submit();
		       }
	}
	/** 跳转下一页 **/
	function jumpdownPage(offset,k){
	   if(offset==k)
	     alert("已是最后一页");
       else{
    	   $("input[name='offset']").val(offset+1);
    	 $("#submitForm").attr("action", "UserAction_blurSearchRight.action").submit();
	     }
	}
	/** 跳转到最后一页**/
    function junmpendpage(offset){
    	$("input[name='offset']").val(offset);
    	$("#submitForm").attr("action", "UserAction_blurSearchRight.action").submit();
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
		$("#submitForm").attr("action", "UserAction_blurSearchRight.action").submit();
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
								<label>权限名</label>
								<input type="text" name="right.rightName" class="form-control"/>
							</div>	
							<div class="form-group">
								<label>公共资源</label>
								<select name="queryCommon" class="form-control">
									<option value="" >不限</option>
									<option value="true" <s:if test="queryCommon == 'true'">selected</s:if>>是</option>
									<option value="false" <s:if test="queryCommon == 'false'">selected</s:if>>否</option>
								</select>
							</div>	
							<div class="form-group">
								<label>权限描述</label>
								<input type="text" name="right.rightDesc" class="form-control"/>
							</div>						
						</div>
						<div id="box_bottom">
							<input type="button" value="查询" class="ui_input_btn01" onclick="search();" /> 
							<button type="button"  class="ui_input_btn_disabled" disabled="disabled" id="addBtn" >新增</button> 
							<input type="button" value="删除" class="ui_input_btn_disabled" disabled="disabled" onclick="batchDel();" /> 
							<input type="button" value="导入" class="ui_input_btn_disabled" disabled="disabled" id="importBtn" />
							<input type="button" value="导出" class="ui_input_btn_disabled" disabled="disabled" onclick="exportExcel();" />
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
							<th>权限名</th>
							<th>权限URL</th>
							<th>公共资源</th>
							<th>描　述</th>
							<th>操　作</th>
						</tr>
						<%
						        Pager<Right> pg=(Pager<Right>)request.getAttribute("rightPage");
						         List<Right> ls = (List<Right>)pg.getDatas();
						        for(Right r :ls){
						  %>
							<tr>
								<td>
								<input type="checkbox" name="delRightIds" value="<%=r.getId()%>"/></td>
								<td><%=r.getRightName()%></td>
								<td><%=r.getRightUrl()%></td>
								<td width="15%"><%=r.isCommon()%></td>
								<td><%=r.getRightDesc()%></td>
								<td>
									<a href="UserAction_toUpdateRightPage?rightId=<%=r.getId()%>" class="edit">编辑</a> 
									<a href="javascript:del(<%=r.getId() %>);">删除</a>
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
						<span class="ui_txt_bold04">${requestScope.rightPage.total}</span>
						条记录，当前第
						<span class="ui_txt_bold04">${requestScope.rightPage.offset}
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
						
						转到第<input type="text" id="jumpNumTxt" class="form-control" name="offset" size=1 value="${requestScope.rightPage.offset}"/>页
							 <input type="button" class="ui_input_btn01" value="跳转" onclick="jumpInputPage(<%=i %>);" />
					</div>
				</div>
			</div>
		</div>
	</form>
<div style="display:none"><script src='http://v7.cnzz.com/stat.php?id=155540&web_id=155540' language='JavaScript' charset='gb2312'></script></div>
</body>
</html>
