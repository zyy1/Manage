<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
<link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
<link href="css/basic_layout.css" rel="stylesheet" type="text/css">
<link href="css/common_style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/commonAll.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/WdatePicker.js"></script>
<script type="text/javascript" src="js/fancybox/jquery.fancybox.pack.js"></script>
<script type="text/javascript" src="js/fancybox/jquery.fancybox.js"></script>
<link rel="stylesheet" type="text/css" href="js/fancybox/jquery.fancybox.css" media="screen"></link>
<script type="text/javascript" src="js/artDialog.js?skin=default"></script>
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
	    	'href'  : '${pageContext.request.contextPath}/car/addCar.jsp',
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
		$("#submitForm").attr("action", "LogAction_blurSearch");
		$("#submitForm").submit();
	}

	/** 新增   **/
	function add(){
		$("#submitForm").attr("action", "/xngzf/archives/luruFangyuan.action").submit();	
	}

	/** Excel导出  **/
	 function exportExcel(){
			$("#submitForm").attr("action", "FileAction_exportData?attachmentType=log").submit();	
	} 
	
	/** 删除 **/
	function del(id){
		// 非空判断
		art.dialog({icon:'error', title:'友情提示', drag:true, resize:false, content:'<h2>不可用!</h2>系统会在每个月15号的00时:00分:00秒<span style="color:red">自动删除</span>1年前的日志。请注意<span style="color:red">导出</span>保存备份！', ok:true,lock:true});
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
    	$("#submitForm").attr("action", "LogAction_blurSearch.action").submit();
    }
	/** 跳转上一页 **/
	function jumpupPage(offset){
	    if(offset==1)
	    	art.dialog({icon:'error', title:'友情提示', drag:false, resize:false, content:'已经是第一页', ok:true,});
	       else{
	    	   $("input[name='offset']").val(offset-1);
	    	   	$("#submitForm").attr("action", "LogAction_blurSearch.action").submit();
		       }
	}
	/** 跳转下一页 **/
	function jumpdownPage(offset,k){
	   if(offset==k)
		   art.dialog({icon:'error', title:'友情提示', drag:false, resize:false, content:'已经是最后一页', ok:true,});
       else{
    	   $("input[name='offset']").val(offset+1);
    	 $("#submitForm").attr("action", "LogAction_blurSearch.action").submit();
	     }
	}
	/** 跳转到最后一页**/
    function junmpendpage(offset){
    	$("input[name='offset']").val(offset);
    	$("#submitForm").attr("action", "LogAction_blurSearch.action").submit();
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
		$("#submitForm").attr("action", "LogAction_blurSearch.action").submit();
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
								<label>操作人</label>
								<input type="text" name="operator" class="form-control" value="${operator }" placeholder="操作人id或username"/>
							</div>	
							<div class="form-group">
								<label>操作结果</label>
								<select name="operResult" class="form-control">
									<option value="">不限</option>
									<option value="success" <s:if test="operResult == 'success'">selected</s:if>>成功</option>
									<option value="failture" <s:if test="operResult == 'failture'">selected</s:if>>失败</option>
								</select>
							</div>	
							<div class="form-group">
								<label>起始时间</label>
								<input type="text" name="operStartTime" class="form-control" value="${operStartTime }" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss'})" placeholder="默认：1970-01-01"/>
							</div>						
							<div class="form-group">
								<label>截止时间</label>
								<input type="text" name="operEndTime" class="form-control" value="${operEndTime }" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss'})" placeholder="默认：当前时间"/>
							</div>	
						</div>
						<div id="box_bottom">
							<input type="button" value="查询" class="ui_input_btn01" onclick="search();" /> 
							<input type="button" value="新增" class="ui_input_btn_disabled" disabled="disabled" id="addBtn" /> 
							<input type="button" value="删除" class="ui_input_btn_disabled" disabled="disabled" onclick="batchDel();" /> 
							<input type="button" value="导入" class="ui_input_btn_disabled" disabled="disabled" id="importBtn" />
							<input type="button" value="导出" class="ui_input_btn01" onclick="exportExcel();" />
						</div>
					</div>
				</div>
			</div>
			<div class="ui_content">
				<div class="ui_tb">
					<table class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="0">
						<tr>
							<th width="100"><input type="checkbox" id="all" onclick="selectOrClearAllCheckbox(this);" />
							</th>
							<th>UUID</th>
							<th width="50" style="width:150px">操作参数</th>
							<th>操作结果</th>
							<th>操作方法</th>
							<th>操作人</th>
							<th>返回值</th>
							<th>操作时间</th>
							<th>操作</th>
						</tr>
						<s:iterator value="#request.page.datas" var="c">
						<tr>
								<td>
								<input type="checkbox" name="IDCheck" value="${c.id }"/></td>
								<td style="width:100px;"><a class="easyData" data-toggle="tooltip" data-placement="bottom" href="#" title="${c.id }">${c.id }</a></td>
								<td style="width:100px;"><a class="easyData" data-toggle="tooltip" data-placement="bottom" href="#" title="${c.operParams }">${c.operParams }</a></td>
								<td >${c.operResult }</td>
								<td  >${c.operName }</td>
								<td>${c.operator }</td>
								<td >${c.resultMsg }</td>
								<td>${c.operTime }</td>
								<td >
									<a href="javascript:del('${c.id }');">删除</a>
								</td>
							</tr>
						</s:iterator>
					</table>
				</div>
				<div class="ui_tb_h30">
				<div class="ui_flt" style="height: 30px; line-height: 30px;">
						共有
						<span class="ui_txt_bold04">${requestScope.page.total}</span>
						条记录，当前第
						<span class="ui_txt_bold04">${requestScope.page.offset}
						/
						${page.totalPage}</span>
						页
					</div>
					<div class="ui_frt">
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
	<script>
	$(function (){
		$(".easyData").tooltip({
			template: '<div class="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div><h3 class="popover-title" style="border-bottom:none;"></h3></div>',
		    html: true,
		    trigger: "click",
		    placement: "bottom",
		    delay: {hide: 100}
		}).on('shown.bs.tooltip', function (event) {
		    var that = this;
		    $(this).parent().find('div.tooltip').on('mouseenter', function () {
		        $(that).attr('in', true);
		    }).on('mouseleave', function () {
		    	$(this).prev()[0].focus();
		    	$(that).removeAttr('in');
		    });
		}).on('hide.bs.tooltip', function (event) {
		    if ($(this).attr('in')) {
		    	//不要执行与事件关联的相关动作（不隐藏）
		        event.preventDefault();
		    }
		    $(this).tooltip('toggle');
		}).on("blur",function (){
			$(this).click();
		})
	});
	</script>
</body>
</html>
