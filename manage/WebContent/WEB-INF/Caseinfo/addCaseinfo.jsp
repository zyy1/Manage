<%@ page language="java" import="java.util.*" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>案件情况登记</title>
<link href="${pageContext.request.contextPath }/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<style>
.well {
	margin: 0px;
	margin-top: 5px;
}

.well a {
	margin-left: 10px;
}
.date-picker-wp {
	display: none;
	position: absolute;
	background: #f1f1f1;
	left: 40px;
	top: 40px;
	border-top: 4px solid #3879d9;
}

.date-picker-wp table {
	border: 1px solid #ddd;
}

.date-picker-wp td {
	background: #fafafa;
	width: 22px;
	height: 18px;
	border: 1px solid #ccc;
	font-size: 12px;
	text-align: center;
}

.date-picker-wp td.noborder {
	border: none;
	background: none;
}

.date-picker-wp td a {
	color: #1c93c4;
	text-decoration: none;
}

.strong {
	font-weight: bold
}

.hand {
	cursor: pointer;
	color: #3879d9
}
</style>

</head>

<body class="well">
	<form id="form1" name="form1" method="post" 
		action="${pageContext.request.contextPath }/CaseinfoAction_addCaseinfo">
		<input type="hidden" name="id" value="${id }" />
		<input type="hidden" name="siteX" value="${siteX }" />
		<input type="hidden" name="siteY" value="${siteY }" />
		<table class="table table-striped table-bordered">
			<tr>
				<td colspan="4" align="center" valign="center"><h4>案件情况登记
					</h4></td>
			</tr>
			<tr>
				<td width="50%">
					<div class="input-group has-feedback">
						<div class="input-group-addon">编　　号</div>
						<input type="text" name="number" class="form-control"  value="${number}" placeholder="该项不允许为空！"/>
					</div>
				</td>
				<td width="50%">
					<div class="input-group has-feedback">
						<div class="input-group-addon">接警人员</div>
						<input type="text" name="receive" value="${receive }"
							class="form-control" />
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="input-group has-feedback">
					<div class="input-group-addon">报警方式</div>
					
					
				 <select name="calltype"
						class="form-control">
							<option value="">--请选择--</option>
							<option value="1" <s:if test='%{calltype == "1"}'>selected</s:if>>指挥中心(110、122)指令</option>
							<option value="2" <s:if test='%{calltype == "2"}'>selected</s:if>>执勤巡逻发现</option>
							<option value="3" <s:if test='%{calltype == "3"}'>selected</s:if>>器材报警</option>
							<option value="4" <s:if test='%{calltype == "4"}'>selected</s:if>>口头报警</option>
							<option value="5" <s:if test='%{calltype == "5"}'>selected</s:if>>电话报警</option>
							<option value="6" <s:if test='%{calltype == "6"}'>selected</s:if>>举报</option>
							<option value="7" <s:if test='%{calltype == "7"}'>selected</s:if>>扭送现行</option>
							<option value="8" <s:if test='%{calltype == "8"}'>selected</s:if>>投案自首</option>
							<option value="9" <s:if test='%{calltype == "9"}'>selected</s:if>>其他部门移送</option>
							<option value="10" <s:if test='%{calltype == "10"}'>selected</s:if>>线索传递</option>
							<option value="11" <s:if test='%{calltype == "11"}'>selected</s:if>>其他</option>
					</select>
					</div>
				</td>
				<td>
				<div class="input-group has-feedback">
				<div class="input-group-addon">出警时间</div>
				 <input type="text" name="outtime" class="form-control" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss'})" value="${outtime }"
						id="demo2" size="5" /> 
				</div>
				</td>
			</tr>
			<tr>
				<td height="28">
				<div class="input-group has-feedback">
				<div class="input-group-addon">报警人员</div>
				 <input type="text"
						name="callper" id="Callperson" class="form-control" value="${ callper}" />

			</div></td>
				<td>
				<div class="input-group has-feedback">
				<div class="input-group-addon">出警人员</div>
				 <input type="text"
						name="outper" id="Outperson"  value="${outper }" class="form-control" />
				</div></td>
			</tr>
			<tr>
				<td><div class="input-group has-feedback">
				<div class="input-group-addon">报警时间</div>
				<input type="text" name="calltime" value="${calltime }"
						id="date-input" size="5" class="form-control" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss'})"/> 
				</div>
				</td>
				<td><div class="input-group has-feedback">
				<div class="input-group-addon">出警车辆</div>
				 <input type="text" name="outcar" value="${outcar}" class="form-control"
						id="Outcar" />
				</div></td>
			</tr>
			<tr>
				<td>
					<div class="input-group has-feedback">
				<div class="input-group-addon">摘　　要</div>
					<input type="text" name="smallContent" class="form-control" value="${smallContent }" style="margin-bottom:5px;"/>
				</div>
				<div class="input-group has-feedback">
				<div class="input-group-addon">报警内容</div>
				<textarea name="content" id="content" cols="25" class="form-control"
						rows="3">${content}</textarea>
						</div></td>
				<td><div class="input-group has-feedback">
				<div class="input-group-addon">处置情况</div>
				<textarea name="dealwith"
							id="dealwith" cols="25" rows="5" class="form-control">${dealwith}</textarea>
				</div></td>
			</tr>
			<tr>
				<td><div class="input-group has-feedback">
				<div class="input-group-addon">案件类型</div>
				<select name="caseType"
						class="form-control">
							<option value="">--请选择--</option>
							<option value="1" <s:if test="%{caseType==1}">selected</s:if>>火灾地震等</option>
							<option value="2" <s:if test="%{caseType==2}">selected</s:if>>交通事故等</option>
							<option value="3" <s:if test="%{caseType==3}">selected</s:if>>打架斗殴等</option>
							<option value="4" <s:if test="%{caseType==4}">selected</s:if>>抢劫偷盗等</option>
							<option value="5" <s:if test="%{caseType==5}">selected</s:if>>贩毒强奸等</option>
							<option value="6" <s:if test="%{caseType==6}">selected</s:if>>拐卖儿童等</option>
					</select>
					</div>
					</td>
				<td>
				<div class="input-group has-feedback">
				<div class="input-group-addon">严重指数</div>
				<select name="serious"
						class="form-control">
						<option value="">--请选择--</option>
						<option value="30" <s:if test="%{serious==30}">selected</s:if>>不严重</option>
						<option value="60" <s:if test="%{serious==60}">selected</s:if>>一般严重</option>
						<option value="80" <s:if test="%{serious==80}">selected</s:if>>比较严重</option>
						<option value="100" <s:if test="%{serious==100}">selected</s:if>>特别严重</option>
					</select>
					</div>
				
				</td>
			</tr>
			
			<tr>
				<td><div class="input-group has-feedback">
				<div class="input-group-addon">案发地点</div>
				<input type="text" name="address" id="Address"  value="${address}"  class="form-control"/></div></td>
				<td><div class="input-group has-feedback">
				<div class="input-group-addon">处置意见</div>
				
			     <input type="text"
						name="sugge" id="Suggestion"  class="form-control" value="${sugge }"/>
				</div></td>
			</tr>
			<tr>
				<td><div class="input-group has-feedback">
				<div class="input-group-addon">报警者电话</div>
				 <input type="text" name="phone"class="form-control"
						id="Phonenum" value="${phone}" />
				</div></td>
				<td><div class="input-group has-feedback">
				<div class="input-group-addon">处理警员</div>
				<input type="text"
						name="dealper" id="Dealwithperson" class="form-control"  value="${dealper}"/>
				</div></td>
			</tr>
			<tr>
				<td width="62"><input type="submit" value="提交" class="btn btn-primary" style="float:right;"/>&nbsp;</td>
				
				<td width="64"><input type="reset" value="重置" class="btn btn-default" />&nbsp;</td>
			</tr>
		</table>
	</form>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/js/jquery-1.9.1.min.js">
		
	</script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/js/bootstrap.min.js">
		
	</script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/js/WdatePicker.js"></script>
	<script type="text/javascript">
		$(function() {
			$('a').tooltip();
			$("#form1")
					.submit(
							function() {
								var flag = true;
								var inputArr = $("#form1 input:text");
								var selectArr = $("#form1 select");
								inputArr
										.each(function() {
											console.log("input:"
													+ $(this).val());
											if ($(this).val() == ""
													|| $(this).val() == null) {
												$(this).parent().addClass(
														"has-error");
												$(this)
														.parent()
														.append(
																'<span class="glyphicon glyphicon-remove form-control-feedback"></span>');
												$(this).attr('placeholder',
														'该项不允许为空！');
												flag = false;
											}
										})
								selectArr
										.each(function() {
											console.log("select:"
													+ $(this).val());
											if ($(this).val() == ""
													|| $(this).val() == null) {
												$(this).parent().addClass(
														"has-error");
												$(this)
														.parent()
														.append(
																'<span class="glyphicon glyphicon-remove form-control-feedback"></span>');
												$(this).attr('placeholder',
														'该项不允许为空！');
												flag = false;
											}
										})
								return flag;
							})
		});
	</script>
</body>
</html>
