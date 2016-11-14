<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>编辑商铺信息</title>
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
	<form id="form1" name="form1" method="post"
		action="${pageContext.request.contextPath }/ShopAction_updateShop">
		<input type="hidden" name="id" value="${id }" />
		<table class="table table-striped table-bordered" align="center">
		
			<tr>
				<td colspan="4" align="center" class="table-title" valign="center"><h4>
						修改商铺信息<br />
					</h4></td>
			</tr>
			<tr>
			
				<td width="50%">
					<div class="input-group has-feedback">
						<div class="input-group-addon">编　　号</div>
						<input type="text" name="number" class="form-control" value="${number }"
							placeholder="该项不允许为空！" />
					</div>
				</td>
				
				<td width="50%">
					<div class="input-group has-feedback">
						<div class="input-group-addon">店铺地址</div>
						<input type="text" name="unit" class="form-control" value="${unit }"
							placeholder="该项不允许为空！" />
					</div>
				</td>
				
			</tr>
			<tr>
				<td>
					<div class="input-group has-feedback">
						<div class="input-group-addon">房　　间</div>
						<input type="text" name="room" class="form-control" placeholder="该项不允许为空！" value="${room }"/>
					</div>
				</td>
				<td>
					<div class="input-group has-feedback">
						<div class="input-group-addon">店　　名</div>
						<input type="text" name="shopName" class="form-control" placeholder="该项不允许为空！" value="${shopName }"/>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="input-group has-feedback">
						<div class="input-group-addon">行　　业</div>
						<input type="text" name="shopType" class="form-control" placeholder="该项不允许为空！" value="${shopType }"/>
					</div>
				</td>
				<td>
					<div class="input-group has-feedback">
						<div class="input-group-addon">店　　主</div>
						<input type="text" name="bossName" class="form-control" placeholder="该项不允许为空！" value="${bossName }"/>
					</div>

				</td>
			</tr>
			<tr>
			<td>
					<div class="input-group has-feedback">
						<div class="input-group-addon">楼　　层</div>
						<select name="floor" class="form-control">
							<option value="${floor }">${floor }</option>
							<option value="一层">一层</option>
							<option value="二层">二层</option>
							<option value="三层">三层</option>
							<option value="四层">四层</option>
							<option value="五层">五层</option>
							<option value="六层">六层</option>
							<option value="七层">七层</option>
							<option value="八层">八层</option>
							<option value="九层">九层</option>
							<option value="十层">十层</option>
							<option value="十一层">十一层</option>
							<option value="十二层">十二层</option>
							<option value="十三层">十三层</option>
							<option value="十四层">十四层</option>
							<option value="十五层">十五层</option>
							<option value="十六层">十六层</option>
							<option value="十七层">十七层</option>
							<option value="十八层">十八层</option>
							<option value="十九层">十九层</option>
							<option value="二十层">二十层</option>
							<option value="二十一层">二十一层</option>
							<option value="二十二层">二十二层</option>
							<option value="二十三层">二十三层</option>
							<option value="二十四层">二十四层</option>
							<option value="二十五层">二十五层</option>
							<option value="二十六层">二十六层</option>
							<option value="二十七层">二十七层</option>
							<option value="二十八层">二十八层</option>
							<option value="二十九层">二十九层</option>
							<option value="三十层">三十层</option>
						</select>
					</div>
				</td>
					<td>
				<div class="input-group has-feedback">
						<div class="input-group-addon">店主身份证</div>
						<input type="text" name="bossIdCard" class="form-control" placeholder="该项不允许为空！" value="${bossIdCard }"/>
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
