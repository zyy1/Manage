<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="cn.aynu.manage.vo.Person"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
<title>增加人口信息</title>
<link href="common.css" rel="stylesheet" type="text/css"/>
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
      .strong {font-weight: bold}
      .hand {cursor: pointer; color: #3879d9}
   </style>
   <script type="text/javascript">
      var DatePicker = function () {
      var $ = function (i) {return document.getElementById(i)},
      addEvent = function (o, e, f) {o.addEventListener ? o.addEventListener(e, f, false) : o.attachEvent('on'+e, function(){f.call(o)})},
      getPos = function (el) {
      for (var pos = {x:0, y:0}; el; el = el.offsetParent) {
      pos.x += el.offsetLeft;
      pos.y += el.offsetTop;
      }
      return pos;
      }
      var init = function (n, config) {
      window[n] = this;
      Date.prototype._fd = function () {var d = new Date(this); d.setDate(1); return d.getDay()};
      Date.prototype._fc = function () {var d1 = new Date(this), d2 = new Date(this); d1.setDate(1); d2.setDate(1); d2.setMonth(d2.getMonth()+1); return (d2-d1)/86400000;};
      this.n = n;
      this.config = config;
      this.D = new Date;
      this.el = $(config.inputId);
      this.el.title = this.n+'DatePicker';
      this.update();
      this.bind();
      }
      init.prototype = {
      update : function (y, m) {
      var con = [], week = ['Su','Mo','Tu','We','Th','Fr','Sa'], D = this.D, _this = this;
      fn = function (a, b) {return '<td title="'+_this.n+'DatePicker" class="noborder hand" onclick="'+_this.n+'.update('+a+')">'+b+'</td>'},
      _html = '<table cellpadding=0 cellspacing=2>';
      y && D.setYear(D.getFullYear() + y);
      m && D.setMonth(D.getMonth() + m);
      var year = D.getFullYear(), month = D.getMonth() + 1, date = D.getDate();
      for (var i=0; i<week.length; i++) con.push('<td title="'+this.n+'DatePicker" class="noborder">'+week[i]+'</td>');
      for (var i=0; i<D._fd(); i++ ) con.push('<td title="'+this.n+'DatePicker" class="noborder"> </td>');
      for (var i=0; i<D._fc(); i++ ) con.push('<td class="hand" onclick="'+this.n+'.fillInput('+year+', '+month+', '+(i+1)+')">'+(i+1)+'</td>');
      var toend = con.length%7;
      if (toend != 0) for (var i=0; i<7-toend; i++) con.push('<td class="noborder"> </td>');
      _html += '<tr>'+fn("-1, null", "<<")+fn("null, -1", "<")+'<td title="'+this.n+'DatePicker" colspan=3 class="strong">'+year+'/'+month+'/'+date+'</td>'+fn("null, 1", ">")+fn("1, null", ">>")+'</tr>';
      for (var i=0; i<con.length; i++) _html += (i==0 ? '<tr>' : i%7==0 ? '</tr><tr>' : '') + con[i] + (i == con.length-1 ? '</tr>' : '');
      !!this.box ? this.box.innerHTML = _html : this.createBox(_html);
      },
      fillInput : function (y, m, d) {
      var s = this.config.seprator || '/';
      this.el.value = y + s + m + s + d;
      this.box.style.display = 'none';
      },
      show : function () {
      var s = this.box.style, is = this.mask.style;
      s['left'] = is['left'] = getPos(this.el).x + 'px';
      s['top'] = is['top'] = getPos(this.el).y + this.el.offsetHeight + 'px';
      s['display'] = is['display'] = 'block';
      is['width'] = this.box.offsetWidth - 2 + 'px';
      is['height'] = this.box.offsetHeight - 2 + 'px';
      },
      hide : function () {
      this.box.style.display = 'none';
      this.mask.style.display = 'none';
      },
      bind : function () {
      var _this = this;
      addEvent(document, 'click', function (e) {
      e = e || window.event;
      var t = e.target || e.srcElement;
      if (t.title != _this.n+'DatePicker') {_this.hide()} else {_this.show()}
      })
      },
      createBox : function (html) {
      var box = this.box = document.createElement('div'), mask = this.mask = document.createElement('iframe');
      box.className = this.config.className || 'datepicker';
      mask.src = 'javascript:false';
      mask.frameBorder = 0;
      box.style.cssText = 'position:absolute;display:none;z-index:9999';
      mask.style.cssText = 'position:absolute;display:none;z-index:9998';
      box.title = this.n+'DatePicker';
      box.innerHTML = html;
      document.body.appendChild(box);
      document.body.appendChild(mask);
      return box;
      }
      }
      return init;
      }();
      onload = function () {
      new DatePicker('_DatePicker_demo', {
      inputId: 'date-input',
      className: 'date-picker-wp',
      seprator: '-'
      });
      new DatePicker('_demo2', {inputId: 'demo2', className: 'date-picker-wp'})
      }
  </script>
</head>

<body>
<% 
    Person p=(Person)request.getAttribute("person");
%>
<form id="form1" name="form1" method="post" action="Person_updateperson" >
  <table border="1" align="center" cellpadding="3" cellspacing="0" bordercolor="#CCCCCC" bgcolor="#f0f8ff">
    <tr>
      <td colspan="4" align="center" valign="center"><h4>增加人口信息<br />
      </h4></td>
    </tr>
    <tr>
      <td width="76" valign="center">编&nbsp;&nbsp;&nbsp;&nbsp;号</td>
      <td width="87"><input type="text" name="person.number" value="<%=p.getNumber()%>"/></td>
      <td width="87">职&nbsp;&nbsp;&nbsp;&nbsp;业</td>
      <td width="174"><input type="text" name="person.professional" value="<%=p.getProfessional()%>" /></td>
    </tr>
    <tr>
      <td valign="center">姓&nbsp;&nbsp;&nbsp;&nbsp;名</td>
      <td><input type="text" name="person.name" value="<%=p.getName()%>"/></td>
      <td>电&nbsp;&nbsp;&nbsp;&nbsp;话</td>
      <td><input type="text" name="person.tel" value="<%=p.getTel()%>" /></td>
    </tr>
    <tr>
      <td valign="center">性&nbsp;&nbsp;&nbsp;&nbsp;别</td>
      <td><select name="person.sex">
          <option value=""><%=p.getSex()%></option>
          <option value="男">男</option>
          <option value="女">女</option>
          </td>
      <td>居住事由：</td>
      <td><select name="person.liveReason">
          <option value=""><%=p.getLiveReason()%></option>
          <option value="常住人员">常住人员</option>
          <option value="上学">上学</option>
          <option value="工作">工作</option>
          <option value="其他">其他</option>
          </select>
      </td>
    </tr>
    <tr>
      <td valign="center">身份证号</td>
      <td><input type="text" name="person.idCard" value="<%=p.getIdCard()%>"/></td>
      <td>户籍地址：</td>
      <td><input type="text" name="person.household" value="<%=p.getHousehold()%>" /></td>
    </tr>
    <tr>
      <td valign="center">居住类型</td>
      <td><select name="person.type">
         <option value=""><%=p.getType()%></option>
         <option value="暂时居住">暂时居住</option>
         <option value="长期居住">长期居住</option>
         </select>
      </td>
      <td>户口类型：</td>
      <td><select name="person.householdType">
         <option value=""><%=p.getHouseholdType()%></option>
         <option value="城镇">城镇</option>
         <option value="农村">农村</option>
         </select>
      </td>
    </tr>
    <tr>
      <td valign="center">楼&nbsp;&nbsp;&nbsp;&nbsp;号：</td>
      <td><input type="text" name="person.unit" value="<%=p.getUnit()%>" /></td>
      <td>民&nbsp;&nbsp;&nbsp;&nbsp;族：</td>
     <td><select name="person.national">
          <option value=""><%=p.getNational()%></option>
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
      </td>
    </tr>
    <tr>
      <td valign="center">楼&nbsp;&nbsp;&nbsp;&nbsp;层：</td>
     <td><select name="person.floor">
         <option value=""><%=p.getFloor()%></option>
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
      </td>
      <td>文化程度：</td>
      <td><select name="person.culturalLevel">
         <option value=""><%=p.getCulturalLevel()%></option>
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
      </td>
    </tr>
    <tr>
      <td valign="center">房&nbsp;间&nbsp;号：</td>
      <td><input  type="text" name="person.room" value="<%=p.getRoom()%>"/></td>
      <td>婚姻状况：</td>
       <td><select name="person.maritalStatus">
          <option value=""><%=p.getMaritalStatus()%></option>
          <option value="未婚">未婚</option>
          <option value="已婚">已婚</option>
          <option value="离婚">离婚</option>
          <option value="丧婚">丧婚</option>
          <option value="其他">其他</option>
          </select>   
       </td>
    </tr>
    <tr>
      <td valign="center">暂住地址：</td>
      <td><input type="text" name="person.address" value="<%=p.getAddress()%>"/></td>
      <td>出生日期：</td>
      <td><input type="text" name="person.birthday" id="date-input" value="<%=p.getBirthday()%>" /></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="submit" value="提交" /></td>
      <td colspan="2"><input type="reset" value="重置" /></td>
    </tr>
  </table>
</form>
<p>&nbsp;</p>
</body>
</html>
