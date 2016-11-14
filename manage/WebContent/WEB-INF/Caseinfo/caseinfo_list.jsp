<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="cn.aynu.manage.vo.Caseinfo"%>
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
<script type="text/javascript" src="js/WdatePicker.js?skin=default"></script>
<link rel="stylesheet" type="text/css" href="css/jquery.fancybox-1.3.4.css" media="screen"></link>
<script type="text/javascript" src="js/artDialog.js"></script>
<title>信息管理系统</title>
<script type="text/javascript">
	$(document).ready(function(){
		/** 新增   **/
	    $("#addBtn").fancybox({
	    	'href'  : '${pageContext.request.contextPath}/CaseinfoAction_toAddCaseinfoPage.action',
	    	'width' : 1100,
	        'height' : 700,
	        'type' : 'iframe',
	        'hideOnOverlayClick' : false,
	        'showCloseButton' : true,
	        'onClosed' : function() { 
	        	window.location.href = 'CaseinfoAction_pagelist';
	        }
	    });
		
	    /** 导入  **/
	     $("#importBtn").fancybox({
	    	'href'  : '${pageContext.request.contextPath}/FileAction_toDataUploadPage?attachmentType=caseinfo',
	    	'width' : 900,
	        'height' : 530,
	        'type' : 'iframe',
	        'hideOnOverlayClick' : false,
	        'showCloseButton' : true,
	        'onClosed' : function() { 
	        	window.location.href = 'CaseinfoAction_pagelist';
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
	        'centerOnScroll' : true,
	        'onClosed' : function (){
	        	window.location.reload();
		     }
	    });
	});
	/** 用户角色   **/
	var userRole = '';

	/** 模糊查询person  **/
	function search(){
		//默认查询 跳转到第一页
		$("#jumpNumTxt").val("1");
		$("#submitForm").attr("action", "CaseinfoAction_blurSearch");
		$("#submitForm").submit();
	}

	/** 新增   **/
	function add(){
		$("#submitForm").attr("action", "/xngzf/archives/luruFangyuan.action").submit();	
	}
	 
	/** Excel导出  **/
	function exportExcel(){
		$("#submitForm").attr("action", "FileAction_exportData?attachmentType=caseinfo").submit();	
	} 
	
	/** 删除 **/
	function del(id){
		// 非空判断
		
		if(id == '') return;
		if(confirm("您确定要删除吗？")){
			$("#submitForm").attr("action", "CaseinfoAction_del.action?id=" + id).submit();			
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
			$("#submitForm").attr("action", "CaseinfoAction_batchDelCaseinfo.action").submit();
		}
	}
	
    /** 跳转到首页**/
    function junmfirstpage(offset){
    	$("input[name='offset']").val(offset);
    	$("#submitForm").attr("action", "CaseinfoAction_blurSearch.action").submit();
    }
	/** 跳转上一页 **/
	function jumpupPage(offset){
	    if(offset==1)
	       alert("已是第一页");
	       else{
	    	   $("input[name='offset']").val(offset-1);
	    	   	$("#submitForm").attr("action", "CaseinfoAction_blurSearch.action").submit();
		       }
	}
	/** 跳转下一页 **/
	function jumpdownPage(offset,k){
	   if(offset==k)
	     alert("已是最后一页");
       else{
    	   $("input[name='offset']").val(offset+1);
    	 $("#submitForm").attr("action", "CaseinfoAction_blurSearch.action").submit();
	     }
	}
	/** 跳转到最后一页**/
    function junmpendpage(offset){
    	$("input[name='offset']").val(offset);
    	$("#submitForm").attr("action", "CaseinfoAction_blurSearch.action").submit();
    }
	/** 输入页跳转 **/
	function jumpInputPage(totalPage){
		// 如果“跳转页数”不为空
		if($("#jumpNumTxt").val() != ''){
			var pageNum = parseInt($("#jumpNumTxt").val());
			alert(pageNum);
			alert(totalPage);
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
		$("#submitForm").attr("action", "CaseinfoAction_blurSearch.action").submit();
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
								<input type="text" size="3" name="number" class="form-control" value="${number }"/>
							</div>						
							<div class="form-group">
								<label>报警时间</label>
								<input type="text" name="callStartTime" class="form-control" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss'})" value="${callStartTime }"/>
								——
								<input type="text" name="callEndTime" class="form-control" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss'})" value="${callEndTime }"/>
							</div>	
							<div class="form-group">
								<label>出警时间</label>
								<input type="text" name="outStartTime" class="form-control" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss'})" value="${outStartTime }"/>
								——
								<input type="text" name="outEndTime" class="form-control" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss'})" value="${outEndTime }"/>
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
							<th width="7%">报警人</th>
						    <th>报警时间</th>
							<th>报警内容</th>
							<th>案发地点</th>
							<th width="7%">接警人</th>
							<th>接警时间</th>
							<th>处置情况</th>
							<th>处置意见</th>
							
							<th>操作</th>
						</tr>
						<%-- <%  List<Person>ls= (List<Person>)request.getAttribute("list");
						 
						    System.out.print(ls.size());
						  %> --%><%
						        Pager<Caseinfo> pg=(Pager<Caseinfo>)request.getAttribute("page");
						         List<Caseinfo> ls = (List<Caseinfo>)pg.getDatas();
						           
						       
						        for(Caseinfo s :ls){
						     /*     System.out.print(s.getName()); */
						    
						  %>
							<tr>
								<td>
								<input type="checkbox" name="IDCheck" value="<%=s.getId()%>"/></td>
								<td><%=s.getNumber()%></td>
								<td><%=s.getCallper()%></td>
							
								<td><%=s.getCalltime().toString()%></td>
								<td><%=s.getContent() %></td>
								<td><%=s.getAddress() %></td>
								
								<td><%=s.getReceive() %></td>
								<td><%=s.getOuttime().toString() %></td>
							
								
								<td><%=s.getDealwith() %></td>
								<td width="5%"><%=s.getSugge() %></td>
								
								<td width="12%">
									<a href="FileAction_toUploadPage?ownerId=<%=s.getId()%>&attachmentType=caseinfo" class="edit">附件</a> 
									<a href="CaseinfoAction_toUpdatePage?id=<%=s.getId()%>" class="edit">编辑</a> 
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
