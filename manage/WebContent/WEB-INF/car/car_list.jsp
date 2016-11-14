<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
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
		
		/** 导入  **/
	    $("#importBtn").fancybox({
	    	'href'  : '${pageContext.request.contextPath}/FileAction_toDataUploadPage?attachmentType=car',
	   		'width' : 900,
	       'height' : 530,
	       'type' : 'iframe',
	       'hideOnOverlayClick' : false,
	       'showCloseButton' : true,
	       'onClosed' : function() { 
	       	window.location.href = 'CarAction_pagelist';
	       }
	   }); 
		
		/** 新增   **/
	    $("#addBtn").fancybox({
	    	'href'  : '${pageContext.request.contextPath}/CarAction_toAddCarPage.action',
	    	'width' : 1100,
	        'height' : 700,
	        'type' : 'iframe',
	        'hideOnOverlayClick' : false,
	        'showCloseButton' : true,
	        'onClosed' : function() { 
	        	window.location.href = 'CarAction_pagelist';
	        }
	    });
		
	    /**编辑   **/
	    $("a.edit").fancybox({
	    	'href'  : $(this).attr("href"),
	    	'width' : 1100,
	        'height' : 700,
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

	/** 模糊查询person  **/
	function search(){
		$("#jumpNumTxt").val("1");
		$("#submitForm").attr("action", "CarAction_blurSearch");
		$("#submitForm").submit();
	}

	/** 新增   **/
	function add(){
		$("#submitForm").attr("action", "/xngzf/archives/luruFangyuan.action").submit();	
	}

	/** Excel导出  **/
	 function exportExcel(){
			$("#submitForm").attr("action", "FileAction_exportData?attachmentType=car").submit();	
	} 
	
	/** 删除 **/
	function del(id){
		// 非空判断
		
		if(id == '') return;
		if(confirm("您确定要删除吗？")){
			$("#submitForm").attr("action", "CarAction_del.action?id=" + id).submit();			
		}
	}
	
	/** 批量删除 **/
	function batchDel(){
		if($("input[name='IDCheck']:checked").size()<=0){
			art.dialog({icon:'error', title:'友情提示', drag:true, resize:false, content:'至少选择一条', ok:true,});
			return;
		}
		if(confirm("您确定要批量删除这些记录吗？")){
			// 提交form
			$("#submitForm").attr("action", "PersonAction_batchDelPerson.action").submit();
		}
	}
	
    /** 跳转到首页**/
    function junmfirstpage(offset){
    	$("input[name='offset']").val(offset);
    	$("#submitForm").attr("action", "CarAction_blurSearch.action").submit();
    }
	/** 跳转上一页 **/
	function jumpupPage(offset){
	    if(offset==1)
	    	art.dialog({icon:'error', title:'友情提示', drag:false, resize:false, content:'已经是第一页', ok:true,});
	       else{
	    	   $("input[name='offset']").val(offset-1);
	    	   	$("#submitForm").attr("action", "CarAction_blurSearch.action").submit();
		       }
	}
	/** 跳转下一页 **/
	function jumpdownPage(offset,k){
	   if(offset==k)
		   art.dialog({icon:'error', title:'友情提示', drag:false, resize:false, content:'已经是最后一页', ok:true,});
       else{
    	   $("input[name='offset']").val(offset+1);
    	 $("#submitForm").attr("action", "CarAction_blurSearch.action").submit();
	     }
	}
	/** 跳转到最后一页**/
    function junmpendpage(offset){
    	$("input[name='offset']").val(offset);
    	$("#submitForm").attr("action", "CarAction_blurSearch.action").submit();
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
		$("#submitForm").attr("action", "CarAction_blurSearch.action").submit();
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
								<label>编号</label>
								<input type="text" name="number" class="form-control" value="${number }"/>
							</div>	
							<div class="form-group">
								<label>车主姓名</label>
								<input type="text" name="name" class="form-control" value="${name }"/>
							</div>	
							<div class="form-group">
								<label>车辆牌号</label>
								<input type="text" name="carnum" class="form-control" value="${carnum }"/>
							</div>						
							<div class="form-group">
								<label>车辆型号</label>
								<input type="text" name="carExplain" class="form-control" value="${carExplain }"/>
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
							<th>编号</th>
							<th>车辆型号</th>
							<th>车辆牌号</th>
							<th>购入日期</th>
							<th>车主姓名</th>
							<th>车主性别</th>
							<th>发动机号</th>
							<th>车架号</th>
							<th>操作</th>
						</tr>
						<s:iterator value="#request.page.datas" var="c">
						<tr>
								<td>
								<input type="checkbox" name="IDCheck" value="${c.id }"/></td>
								<td>${c.number }</td>
								<td>${c.carExplain }</td>
								<td>${c.carnum }</td>
								<td>${c.day }</td>
								<td>${c.name }</td>
								<td>${c.sex }</td>
								<td>${c.numa }</td>
								<td>${c.numb }</td>
								<td>
									<a href="FileAction_toUploadPage?ownerId=${c.id }&attachmentType=car" class="edit">附件</a> 
									<a href="CarAction_toUpdatePage?id=${c.id }" class="edit">编辑</a> 
									<a href="javascript:del(${c.id });">删除</a>
								</td>
							</tr>
						</s:iterator>
					</table>
				</div>
				<div class="ui_tb_h30">
<%-- 				<%  long i=0;
				   if(pg.getTotal()%pg.getSize()!=0)
				      i=pg.getTotal()/pg.getSize()+1;
				     else
				     i=pg.getTotal()/pg.getSize();
				 %>
 --%>					<div class="ui_flt" style="height: 30px; line-height: 30px;">
						共有
						<span class="ui_txt_bold04">${requestScope.page.total}</span>
						条记录，当前第
						<span class="ui_txt_bold04">${requestScope.page.offset}
						/
						${page.totalPage}</span>
						页
					</div>
					<div class="ui_frt">
	<%-- 					<!--    如果是第一页，则只显示下一页、尾页 -->
						<%  int offset=pg.getOffset();
						    int k= (int)(pg.getTotal()-1)/pg.getSize()+1;
						   
						 %> --%>
							<input type="button" value="首页" class="ui_input_btn01"  onclick="junmfirstpage(1)" />
							<input type="button" value="上一页" class="ui_input_btn01" onclick="jumpupPage(${page.offset })" />
							<input type="button" value="下一页" class="ui_input_btn01"
								onclick="jumpdownPage(${page.offset },${page.totalPage});" />
							<input type="button" value="尾页" class="ui_input_btn01" onclick="junmpendpage(${page.totalPage});" />
						
						
						
						<!--     如果是最后一页，则只显示首页、上一页 -->
						
						转到第<input type="text" id="jumpNumTxt" class="form-control" name="offset" size=1 value="${requestScope.page.offset}"/>页
							 <input type="button" class="ui_input_btn01" value="跳转" onclick="jumpInputPage(${page.totalPage});" />
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>
