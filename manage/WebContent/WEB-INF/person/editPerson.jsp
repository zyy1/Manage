<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>编辑人口信息</title>
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
  <style>
    .date-picker-wp{
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
      .strong {font-weight: bold}
      .hand {cursor: pointer; color: #3879d9}
   </style>
   
</head>

<body class="well">
<form id="form1" name="form1" method="post" action="${pageContext.request.contextPath }/PersonAction_updatePerson">
	<input type="hidden" name="id" value="${id }" />
  <table  class="table table-striped table-bordered" align="center" cellpadding="3" cellspacing="0" bordercolor="#CCCCCC" bgcolor="#f0f8ff">
    <tr>
      <td colspan="4" align="center" class="table-title" valign="center"><h4>修改人口信息<br />
      </h4></td>
    </tr>
    <tr>
      <td width="50%">
		  <div class="input-group has-feedback">
		  	<div class="input-group-addon">编　　号</div>
	      	<input type="text" name="number" class="form-control" value="${number }" placeholder="该项不允许为空！"/>
	      </div>
      </td>
      <td width="50%">
      <div class="input-group has-feedback">
		<div class="input-group-addon">职　　业</div>
      	<input type="text" name="professional" class="form-control" value="${professional }" />
      </div>
      </td>
    </tr>
    <tr>
    <td>
           <div class="input-group has-feedback">
		<div class="input-group-addon">姓　　名</div>
     <input type="text" name="name" class="form-control" value="${name }" />
     </div>
     </td>
     <td>
          <div class="input-group has-feedback">
		<div class="input-group-addon">电　　话</div>
     <input type="text" name="tel" class="form-control" value="${tel }"/>
     </div>
     </td>
    </tr>
    <tr>
    <td>
           <div class="input-group has-feedback">
		<div class="input-group-addon">性　　别</div>
      <select name="sex" class="form-control">
          <option value="">--请选择--</option>
          
          <s:if test='#request.sex == "男"'>
          	<option value="男" selected="selected">男</option>
          	<option value="女">女</option>
          </s:if>
          <s:elseif test='#request.sex == "女"'>
          	<option value="男">男</option>
          	<option value="女" selected="selected">女</option>
          </s:elseif>
          <s:else>
            <option value="男">男</option>
          	<option value="女">女</option>
          </s:else>
         </select>
         </div>
          </td>
      <td>
                 <div class="input-group has-feedback">
		<div class="input-group-addon">居住事由</div>
      <select name="liveReason" class="form-control">
          <option value="${liveReason}">${liveReason}</option>
          <option value="常住人员">常住人员</option>
          <option value="上学">上学</option>
          <option value="工作">工作</option>
          <option value="其他">其他</option>
       </select>
       </div>
      </td>
    </tr>
    <tr>
    
      <td>
        <div class="input-group has-feedback">
		<div class="input-group-addon">身份证号</div>
      <input type="text" name="idCard" value="${idCard }" class="form-control"/>
      </div>
      
      </td>
      <td>
        <div class="input-group has-feedback">
		<div class="input-group-addon">户籍地址</div>
      <input type="text" name="household" value="${household }" class="form-control"/>
      </div>
      </td>
    </tr>
    <tr>
      <td>
        <div class="input-group has-feedback">
		<div class="input-group-addon">居住类型</div>
      <select name="type" class="form-control">
         <option value="${type }">${type }</option>
         <option value="暂时居住">暂时居住</option>
         <option value="长期居住">长期居住</option>
         </select>
         </div>
      </td>
      <td>
        <div class="input-group has-feedback">
		<div class="input-group-addon">户口类型</div>
      <select name="householdType" class="form-control">
         <option value="${householdType }">${householdType }</option>
         <option value="城镇">城镇</option>
         <option value="农村">农村</option>
         </select>
         </div>
      </td>
    </tr>
    <tr>
      <td>
        <div class="input-group has-feedback">
		<div class="input-group-addon">楼　　号</div>
      <input type="text" name="unit" value="${unit }" class="form-control"/>
      </div>
      </td>
     <td>
       <div class="input-group has-feedback">
		<div class="input-group-addon">民　　族</div>
     <select name="national" class="form-control">
          <option value="${national }">${national }</option>
          <option value="汉族">汉族</option>
          <option value="壮族">壮族</option>
          <option value="满族">满族</option>
          <option value="回族">回族</option>
          <option value="苗族">苗族</option>
          <option value="维吾尔族">维吾尔族</option>
          <option value="土家族">土家族</option>
          <option value="彝族">彝族</option>
          <option value="蒙古族">蒙古族</option>
          <option value="藏族">藏族</option>
          <option value="布依族">布依族</option>
          <option value="侗族">侗族</option>
          <option value="瑶族">瑶族</option>
          <option value="朝鲜族">朝鲜族</option>
          <option value="白族">白族</option>
          <option value="哈尼族">哈尼族</option>
          <option value="哈萨克族">哈萨克族</option>
          <option value="黎族">黎族</option>
          <option value="傣族">傣族</option>
          <option value="畲族">畲族</option>
          <option value="傈僳族">傈僳族</option>
          <option value="仡佬族">仡佬族</option>
          <option value="东乡族">东乡族</option>
          <option value="高山族">高山族</option>
          <option value="拉祜族">拉祜族</option>
          <option value="水族">水族</option>
          <option value="佤族">佤族</option>
          <option value="纳西族">纳西族</option>
          <option value="羌族">羌族</option>
          <option value="土族">土族</option>
          <option value="仫佬族">仫佬族</option>
          <option value="锡伯族">锡伯族</option>
          <option value="柯尔克孜族">柯尔克孜族</option>
          <option value="达斡尔族">达斡尔族</option>
          <option value="景颇族">景颇族</option>
          <option value="毛南族">毛南族</option>
          <option value="撒拉族">撒拉族</option>
          <option value="布朗族">布朗族</option>
          <option value="塔吉克族">塔吉克族</option>
          <option value="阿昌族">阿昌族</option>
          <option value="普米族">普米族</option>
          <option value="鄂温克族">鄂温克族</option>
          <option value="怒族">怒族</option>
          <option value="京族">京族</option>
          <option value="基诺族">基诺族</option>
          <option value="德昂族">德昂族</option>
          <option value="保安族">保安族</option>
          <option value="俄罗斯族">俄罗斯族</option>
          <option value="裕固族">裕固族</option>
          <option value="乌兹别克族">乌兹别克族</option>
          <option value="门巴族">门巴族</option>
          <option value="鄂伦春族">鄂伦春族</option>
          <option value="独龙族">独龙族</option>
          <option value="塔塔尔族">塔塔尔族</option>
          <option value="赫哲族">赫哲族</option>
          <option value="珞巴族">珞巴族</option>
          </select>
          
         </div>
      </td>
    </tr>
    <tr>
     <td>  <div class="input-group has-feedback">
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
		<div class="input-group-addon">文化程度</div>
      <select name="culturalLevel" class="form-control">
         <option value="${culturalLevel }">${culturalLevel }</option>
         <option value="小学以下">小学以下</option>
         <option value="小学">小学</option>
         <option value="初中">初中</option>
         <option value="高中">高中</option>
         <option value="中专">中专</option>
         <option value="大专">大专</option>
         <option value="本科">本科</option>
         <option value="硕士">硕士</option>
         <option value="博士">博士</option>
         </select>
         </div>
      </td>
    </tr>
    <tr>
      <td>
        <div class="input-group has-feedback">
		<div class="input-group-addon">房间号码</div>
      <input type="text" name="room" value="${room }" class="form-control">
      </input>
      </div>
      </td>
       <td>
         <div class="input-group has-feedback">
		<div class="input-group-addon">婚姻状况</div>
       <select name="maritalStatus" class="form-control">
          <option value="${maritalStatus }">${maritalStatus }</option>
          <option value="未婚">未婚</option>
          <option value="已婚">已婚</option>
          <option value="离婚">离婚</option>
          <option value="丧婚">丧婚</option>
          <option value="其他">其他</option>
          </select>   
          </div>
       </td>
    </tr>
    <tr>
      <td>
        <div class="input-group has-feedback">
		<div class="input-group-addon">暂住地址</div>
      <div class="form-group has-feedback">
      	<input type="text" name="address" class="form-control" value="${address }" />
      </div>
      </div>
      </td>
      <td>
        <div class="input-group has-feedback">
		<div class="input-group-addon">出生日期</div>
      <input type="text" name="birthday" value="${birthday }" onfocus="WdatePicker()" class="form-control"/>
      </div>
      </td>
    </tr>
    <tr>
          <td>
        <div class="input-group has-feedback">
		<div class="input-group-addon">所在公司</div>
      <input type="text" name="workCompany" value="${workCompany }" class="form-control"/>
      </div>
      </td>
    </tr>
    <tr>
      <td><input type="submit" value="提交" class="btn btn-primary" style="float:right"/></td>
      <td colspan="2"><input type="reset" value="重置" class="btn btn-default"/></td>
    </tr>
  </table>
</form>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.9.1.min.js">
</script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/bootstrap.min.js">
</script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/WdatePicker.js"></script>
<script type="text/javascript">
	$(function (){
			$('a').tooltip();
			$("#form1").submit(function (){
			var flag = true;
			var inputArr = $("#form1 input:text");
			var selectArr = $("#form1 select");
			inputArr.each(function (){
				console.log("input:"+$(this).val());
			if($(this).val() == "" || $(this).val() == null)
				{
					$(this).parent().addClass("has-error");
					$(this).parent().append('<span class="glyphicon glyphicon-remove form-control-feedback"></span>');
					$(this).attr('placeholder','该项不允许为空！');
					flag = false;
				}
			})
			selectArr.each(function (){
				console.log("select:"+$(this).val());
				if($(this).val() == "" || $(this).val() == null)
				{
					$(this).parent().addClass("has-error");
					$(this).parent().append('<span class="glyphicon glyphicon-remove form-control-feedback"></span>');
					$(this).attr('placeholder','该项不允许为空！');
					flag = false;
				}
			})
			return flag;
			})
		});
</script>
</body>
</html>
