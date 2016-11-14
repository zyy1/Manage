<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link href="${pageContext.request.contextPath }/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<head>
<title>修改用户授权</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.9.1.min.js" ></script>
<script type="text/javascript">
	$(function() {
		$('#one1').click(function() {
			var size = $('#left>option:selected').size();
			if (size != 0) {
				$('#left > option:selected').appendTo($('#right'));
			} else {
				$('#left>option:first-child').appendTo($('#right'));
			}
		});
		$('#all1').click(function() {
			$('#left > option').appendTo($('#right'));
		});
		$('#one2').click(function() {
			var size = $('#right>option:selected').size();
			if (size != 0) {
				$('#right > option:selected').appendTo($('#left'));
			} else {
				$('#right>option:first-child').appendTo($('#left'));
			}
		});
		$('#all2').click(function() {
			$('#right > option').appendTo($('#left'));
		});
	});

	function submitForm1() {
		$('#left > option').attr('selected', 'selected');
		return true;
	}
</script>
</head>
<body class="well">
	<table class="table" style="margin: 0 auto; width:100%;"
		align="center">
		<tr style="text-align: center;">
			<td class="table-title" style="text-align: center;"><h3>修改用户授权</h3></td>
		</tr>

		<tr>
			<td style="vertical-align: top;">
				<table style="width:100%;text-align: center;">
					<tr>
						<td><s:form action="UserAction_updateAuthorize"
								namespace="/" method="post" cssClass="form">
								<s:hidden name="id" />
								<table class="table" style="width:100%;text-align: center;" align="center">
									<tr>
										<td>
											<div class="input-group has-feedback">
												<div class="input-group-addon">用户昵称</div>
												<input name="username" class="form-control" disabled="true" value="${username }"/>
											</div>
										</td>
									</tr>
									<tr>
										<td>
											<div class="input-group has-feedback">
												<div class="input-group-addon">邮件地址</div>
												<input name="email" class="form-control" disabled="true" value="${email }"/>
											</div>
										</td>
									</tr>
									<tr align="center">
										<td class="tdFormLabel" colspan="2">
											<table>
												<tr>
													<td width="45%" align="right">
														<%--  --%>
													<div class="input-group has-feedback">
													<div class="input-group-addon"><h4><i class="glyphicon glyphicon-star"></i>已拥有</h4></div>
														<select class="form-control" id="left" size="5" name="ownRoleIds" multiple="multiple" style="width:200px;">
															<s:iterator value="roles">
																<option class="form-control" style="display: block;" value="${id }">${roleName }</option>
															</s:iterator>
														</select>
													</div>
													</td>
													<td width="10%" valign="middle" align="center"><button
														type="button" id="one1" class="btn btn-sm btn-primary"><span class='glyphicon glyphicon-chevron-right'></span></button><br>
													<br> <button type="button" id="one2" value="&lt;"
														class="btn btn-sm btn-primary"><span class='glyphicon glyphicon-chevron-left'></span></button><br>
													<br> <button type="button" id="all1" value="&gt;&gt;"
														class="btn btn-sm btn-primary"><span class="glyphicon glyphicon-menu-right" style="padding:0"></span><span class="glyphicon glyphicon-menu-right" style="margin-left:-8px"></span></button><br>
													<br> <button type="button" id="all2" value="&lt;&lt;"
														class="btn btn-sm btn-primary"><span class="glyphicon glyphicon-menu-left" style="padding:0"></span><span class="glyphicon glyphicon-menu-left" style="margin-left:-8px"></span></button><br>
													<br></td>
													<td width="45%" align="left">
														<%-- <s:select id="right" 
															list="noOwnRoles" 
															name="noOwnRoleIds"
															listKey="id" 
															listValue="roleName"
															multiple="true"
															size="15"
															cssStyle="width:100px">
														</s:select> --%>
															<div class="input-group has-feedback">
														<select class="form-control" multiple="multiple" id="right" size="5" style="width:200px;">
															<s:iterator value="withOutAuthor">
																<option class="form-control" style="display: block;" value="${id }">${roleName }</option>
															</s:iterator>
														</select>
														<div class="input-group-addon"><h4><i class="glyphicon glyphicon-star-empty"></i>未拥有</h4></div>
														</div>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td class="tdFormLabel"></td>
										<td class="tdFormControl"><s:submit value="确定"
												cssClass="btn btn-primary" onclick="javascript:return submitForm1()" /></td>
									</tr>
								</table>
							</s:form></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/bootstrap.min.js">
		
	</script>

</body>
</html>