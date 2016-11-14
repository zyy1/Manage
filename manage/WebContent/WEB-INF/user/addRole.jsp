<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>添加角色</title>
<link href="css/common.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<style>
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
	<form id="form1" name="form1" class="form-inline" method="post"
		action="${pageContext.request.contextPath }/UserAction_addRole">
		<table class="table table-striped table-bordered" align="center"
			cellpadding="3" cellspacing="0" bordercolor="#CCCCCC"
			bgcolor="#f0f8ff">
			<tr>
				<td colspan="4" align="center" class="table-title" valign="center"><h4>
						添加角色<br />
					</h4></td>
			</tr>
			<tr>
				<td width="50%">
					<div class="input-group has-feedback">
						<div class="input-group-addon">角色名</div>
						<input type="text" name="role.roleName" class="form-control"
							placeholder="该项不允许为空！" />
					</div>
				</td>
				<td>
					<div class="input-group has-feedback">
						<div class="input-group-addon">描　述</div>
						<input type="text" name="role.roleDesc" class="form-control"
							placeholder="该项不允许为空！" />
					</div>
				</td>
			</tr>
			<tr>
				<td><input type="submit" value="提交" class="btn btn-primary"
					style="float: right" /></td>
				<td colspan="2"><input type="reset" value="重置"
					class="btn btn-default" /></td>
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
