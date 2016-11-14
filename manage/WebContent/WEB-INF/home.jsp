<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>基于WEBGIS社区管理系统</title>
	<link href="${pageContext.request.contextPath }/css/main_css.css" rel="stylesheet" type="text/css" />
	<link href="${pageContext.request.contextPath }/css/zTreeStyle.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.7.1.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.ztree.core-3.2.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/commonAll.js"></script>
	<script type="text/javascript">
		/**退出系统**/
		function logout(){
			if(confirm("您确定要退出本系统吗？")){
				window.location.href = "UserAction_logout";
			}
		}
		
		/**获得当前日期**/
		function  getDate01(){
			var time = new Date();
			var myYear = time.getFullYear();
			var myMonth = time.getMonth()+1;
			var myDay = time.getDate();
			if(myMonth < 10){
				myMonth = "0" + myMonth;
			}
			document.getElementById("yue_fen").innerHTML =  myYear + "." + myMonth;
			document.getElementById("day_day").innerHTML =  myYear + "." + myMonth + "." + myDay;
		}
		
		/**加入收藏夹**/
		function addfavorite(){
			var ua = navigator.userAgent.toLowerCase();
			 if (ua.indexOf("360se") > -1){
			  	art.dialog({icon:'error', title:'友情提示', drag:false, resize:false, content:'由于360浏览器功能限制，加入收藏夹功能失效', ok:true,});
			 }else if (ua.indexOf("msie 8") > -1){
			  	window.external.AddToFavoritesBar('${dynamicURL}/authority/loginInit.action','基于WEBGIS社区管理系统管理');//IE8
			 }else if (document.all){
			  	window.external.addFavorite('${dynamicURL}/authority/loginInit.action','基于WEBGIS社区管理系统管理');
			 }else{
			  	art.dialog({icon:'error', title:'友情提示', drag:false, resize:false, content:'添加失败，请用ctrl+D进行添加', ok:true,});
			 }
		} 
	</script>
	<script type="text/javascript">
		/* zTree插件加载目录的处理  */
		var zTree;
		
		var setting = {
				view: {
					dblClickExpand: false,
					showLine: false,
					expandSpeed: ($.browser.msie && parseInt($.browser.version)<=6)?"":"fast"
				},
				data: {
					key: {
						name: "resourceName"
					},
					simpleData: {
						enable:true,
						idKey: "resourceID",
						pIdKey: "parentID",
						rootPId: ""
					}
				},
				callback: {
	// 				beforeExpand: beforeExpand,
	// 				onExpand: onExpand,
					onClick: zTreeOnClick			
				}
		};
		 
		var curExpandNode = null;
		function beforeExpand(treeId, treeNode) {
			var pNode = curExpandNode ? curExpandNode.getParentNode():null;
			var treeNodeP = treeNode.parentTId ? treeNode.getParentNode():null;
			for(var i=0, l=!treeNodeP ? 0:treeNodeP.children.length; i<l; i++ ) {
				if (treeNode !== treeNodeP.children[i]) {
					zTree.expandNode(treeNodeP.children[i], false);
				}
			}
			while (pNode) {
				if (pNode === treeNode) {
					break;
				}
				pNode = pNode.getParentNode();
			}
			if (!pNode) {
				singlePath(treeNode);
			}
	
		}
		function singlePath(newNode) {
			if (newNode === curExpandNode) return;
			if (curExpandNode && curExpandNode.open==true) {
				if (newNode.parentTId === curExpandNode.parentTId) {
					zTree.expandNode(curExpandNode, false);
				} else {
					var newParents = [];
					while (newNode) {
						newNode = newNode.getParentNode();
						if (newNode === curExpandNode) {
							newParents = null;
							break;
						} else if (newNode) {
							newParents.push(newNode);
						}
					}
					if (newParents!=null) {
						var oldNode = curExpandNode;
						var oldParents = [];
						while (oldNode) {
							oldNode = oldNode.getParentNode();
							if (oldNode) {
								oldParents.push(oldNode);
							}
						}
						if (newParents.length>0) {
							for (var i = Math.min(newParents.length, oldParents.length)-1; i>=0; i--) {
								if (newParents[i] !== oldParents[i]) {
									zTree.expandNode(oldParents[i], false);
									break;
								}
							}
						}else {
							zTree.expandNode(oldParents[oldParents.length-1], false);
						}
					}
				}
			}
			curExpandNode = newNode;
		}
	
		function onExpand(event, treeId, treeNode) {
			curExpandNode = treeNode;
		}
		
		/** 用于捕获节点被点击的事件回调函数  **/
		function zTreeOnClick(event, treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("dleft_tab1");
			zTree.expandNode(treeNode, null, null, null, true);
	// 		zTree.expandNode(treeNode);
			// 规定：如果是父类节点，不允许单击操作
			if(treeNode.isParent){
	// 			alert("父类节点无法点击哦...");
				return false;
			}
			// 如果节点路径为空或者为"#"，不允许单击操作
			if(treeNode.accessPath=="" || treeNode.accessPath=="#"){
				//alert("节点路径为空或者为'#'哦...");
				return false;
			}
		    // 跳到该节点下对应的路径, 把当前资源ID(resourceID)传到后台，写进Session
		    rightMain(treeNode.accessPath);
		    
		    if( treeNode.isParent ){
			    $('#here_area').html('当前位置：'+treeNode.getParentNode().resourceName+'&nbsp;>&nbsp;<span style="color:#1A5CC6">'+treeNode.resourceName+'</span>');
		    }else{
			    $('#here_area').html('当前位置：系统&nbsp;>&nbsp;<span style="color:#1A5CC6">'+treeNode.resourceName+'</span>');
		    }
		};
		
		/* 上方菜单 */
		function switchTab(tabpage,tabid){
		var oItem = document.getElementById(tabpage).getElementsByTagName("li"); 
		    for(var i=0; i<oItem.length; i++){
		        var x = oItem[i];    
		        
		        
			}
			if('left_tab1' == tabid){
			
				$(document).ajaxStart(onStart).ajaxSuccess(onStop);
				// 异步加载"业务模块"下的菜单
			  	loadMenu('YEWUMOKUAI', 'dleft_tab1');
			}else  if('left_tab2' == tabid){
		
				$(document).ajaxStart(onStart).ajaxSuccess(onStop);
				// 异步加载"系统管理"下的菜单
				loadMenu2('XITONGMOKUAI', 'dleft_tab1');
			}else  if('left_tab3' == tabid){
				$(document).ajaxStart(onStart).ajaxSuccess(onStop);
				// 异步加载"其他"下的菜单
				loadMenu3('QITAMOKUAI', 'dleft_tab1');
			} 
		}
		
		
		$(document).ready(function(){
			$(document).ajaxStart(onStart).ajaxSuccess(onStop);
			/** 默认异步加载"业务模块"目录  **/
			loadMenu('YEWUMOKUAI', "dleft_tab1");
			// 默认展开所有节点
			if( zTree ){
				// 默认展开所有节点
				zTree.expandAll(false);
			}
		});
		
		function loadMenu(resourceType, treeObj){
		
            data = [
	            {"accessPath":"","checked":false,"delFlag":0,"parentID":1,"resourceCode":"","resourceDesc":"","resourceGrade":2,"resourceID":3,"resourceName":"信息查询管理","resourceOrder":0,"resourceType":""},
	            {"accessPath":"${pageContext.request.contextPath}/PersonAction_pagelist.action","checked":false,"delFlag":0,"parentID":3,"resourceCode":"","resourceDesc":"","resourceGrade":3,"resourceID":32,"resourceName":"人口信息管理","resourceOrder":0,"resourceType":""},
	            {"accessPath":"${pageContext.request.contextPath}/CaseinfoAction_pagelist.action","checked":false,"delFlag":0,"parentID":3,"resourceCode":"","resourceDesc":"","resourceGrade":3,"resourceID":9,"resourceName":"事件信息管理","resourceOrder":0,"resourceType":""},
	            {"accessPath":"${pageContext.request.contextPath}/CarAction_pagelist.action","checked":false,"delFlag":0,"parentID":3,"resourceCode":"","resourceDesc":"","resourceGrade":3,"resourceID":39,"resourceName":"车辆信息管理","resourceOrder":0,"resourceType":""},
	            {"accessPath":"${pageContext.request.contextPath}/ShopAction_shopList.action","checked":false,"delFlag":0,"parentID":3,"resourceCode":"","resourceDesc":"","resourceGrade":3,"resourceID":7,"resourceName":"周边商铺管理","resourceOrder":0,"resourceType":""},
	            {"accessPath":"${pageContext.request.contextPath}/introduce.html","checked":false,"delFlag":0,"parentID":37,"resourceCode":"","resourceDesc":"","resourceGrade":2,"resourceID":19,"resourceName":"产品介绍","resourceOrder":0,"resourceType":"XITONGMOKUAI"},
	            {"accessPath":"${pageContext.request.contextPath}/introduceOfUs.html","checked":false,"delFlag":0,"parentID":37,"resourceCode":"","resourceDesc":"","resourceGrade":2,"resourceID":20,"resourceName":"关于我们","resourceOrder":0,"resourceType":"XITONGMOKUAI"},
	            {"accessPath":"","checked":false,"delFlag":0,"parentID":1,"resourceCode":1,"resourceDesc":"","resourceGrade":2,"resourceID":37,"resourceName":"系统参数","resourceOrder":3,"resourceType":"XITONGMOKUAI"},
	        ]
            // 如果返回数据不为空，加载"业务模块"目录
            if(data != null){
                // 将返回的数据赋给zTree
                $.fn.zTree.init($("#"+treeObj), setting, data);
//              alert(treeObj);
                zTree = $.fn.zTree.getZTreeObj(treeObj);
                if( zTree ){
                    // 默认展开所有节点
                    zTree.expandAll(true);
                }
            }
		}
		
		
		
		
		function loadMenu2(resourceType, treeObj){
		
		
            data = [
				{"accessPath":"","checked":false,"delFlag":0,"parentID":1,"resourceCode":1,"resourceDesc":"","resourceGrade":2,"resourceID":99,"resourceName":"用户管理","resourceOrder":3,"resourceType":"XITONGMOKUAI"},
				{"accessPath":"${pageContext.request.contextPath}/UserAction_userList.action","checked":false,"delFlag":0,"parentID":99,"resourceCode":"","resourceDesc":"","resourceGrade":2,"resourceID":57,"resourceName":"用户信息管理","resourceOrder":0,"resourceType":""},
				{"accessPath":"","checked":false,"delFlag":0,"parentID":1,"resourceCode":1,"resourceDesc":"","resourceGrade":2,"resourceID":100,"resourceName":"角色与权限管理","resourceOrder":3,"resourceType":"XITONGMOKUAI"},
				{"accessPath":"${pageContext.request.contextPath}/UserAction_roleList.action","checked":false,"delFlag":0,"parentID":100,"resourceCode":"","resourceDesc":"","resourceGrade":2,"resourceID":57,"resourceName":"角色管理","resourceOrder":0,"resourceType":""},
				{"accessPath":"${pageContext.request.contextPath}/UserAction_rightList.action","checked":false,"delFlag":0,"parentID":100,"resourceCode":"","resourceDesc":"","resourceGrade":2,"resourceID":57,"resourceName":"权限管理","resourceOrder":0,"resourceType":""},
				{"accessPath":"${pageContext.request.contextPath}/LogAction_pageList.action","checked":false,"delFlag":0,"parentID":100,"resourceCode":"","resourceDesc":"","resourceGrade":2,"resourceID":57,"resourceName":"日志管理","resourceOrder":0,"resourceType":""},
			];
            // 如果返回数据不为空，加载"业务模块"目录
            if(data != null){
                // 将返回的数据赋给zTree
                $.fn.zTree.init($("#"+treeObj), setting, data);
//              alert(treeObj);
                zTree = $.fn.zTree.getZTreeObj(treeObj);
                if( zTree ){
                    // 默认展开所有节点
                    zTree.expandAll(true);
                }
            }
		}
		
		function loadMenu3(resourceType, treeObj){
			
			
            data = [
			//菜单一                    
            {"accessPath":"","checked":false,"delFlag":0,"resourceCode":"","resourceDesc":"","resourceGrade":1,"resourceID":30,"resourceName":"可视化地图查看与分析","resourceOrder":0,"resourceType":""},

            {"accessPath":"${pageContext.request.contextPath}/MapAction_to3DMapPage","checked":false,"delFlag":0,"parentID":30,"resourceCode":"","resourceDesc":"","resourceGrade":2,"resourceID":32,"resourceName":"三维地图模拟","resourceOrder":0,"resourceType":""},
            {"accessPath":"${pageContext.request.contextPath}/MapAction_toMessMapPage","checked":false,"delFlag":0,"parentID":30,"resourceCode":"","resourceDesc":"","resourceGrade":2,"resourceID":33,"resourceName":"地图案件查询","resourceOrder":0,"resourceType":""},
            //菜单二
            {"accessPath":"","checked":false,"delFlag":0,"resourceCode":"","resourceDesc":"","resourceGrade":1,"resourceID":31,"resourceName":"数据发散性分析与预测","resourceOrder":0,"resourceType":""},

            {"accessPath":"${pageContext.request.contextPath}/MapAction_toAnalyCaseSpread3DPage","checked":false,"delFlag":0,"parentID":31,"resourceCode":"","resourceDesc":"","resourceGrade":2,"resourceID":34,"resourceName":"三维案件分布模拟","resourceOrder":0,"resourceType":""},
            {"accessPath":"${pageContext.request.contextPath}/CaseinfoAction_returnPerTypeCaseInfoCount","checked":false,"delFlag":0,"parentID":31,"resourceCode":"","resourceDesc":"","resourceGrade":2,"resourceID":35,"resourceName":"案件频率类型分布","resourceOrder":0,"resourceType":""},
            {"accessPath":"${pageContext.request.contextPath}/MapAction_toAccidentTimeAnalysPage","checked":false,"delFlag":0,"parentID":31,"resourceCode":"","resourceDesc":"","resourceGrade":2,"resourceID":36,"resourceName":"点阵严重性分布图","resourceOrder":0,"resourceType":""},
            {"accessPath":"${pageContext.request.contextPath}/MapAction_toPicTimeDataPage","checked":false,"delFlag":0,"parentID":31,"resourceCode":"","resourceDesc":"","resourceGrade":2,"resourceID":37,"resourceName":"时间出警结案统计","resourceOrder":0,"resourceType":""},
            ];
            // 如果返回数据不为空，加载"业务模块"目录
            if(data != null){
                // 将返回的数据赋给zTree
                $.fn.zTree.init($("#"+treeObj), setting, data);
//              alert(treeObj);
                zTree = $.fn.zTree.getZTreeObj(treeObj);
                if( zTree ){
                    // 默认展开所有节点
                    zTree.expandAll(true);
                }
            }
		}
		
		
		//ajax start function
		function onStart(){
			$("#ajaxDialog").show();
		}
		
		//ajax stop function
		function onStop(){
	// 		$("#ajaxDialog").dialog("close");
			$("#ajaxDialog").hide();
		}
	</script>
</head>
<body onload="getDate01()">
    <div id="top">
		<div id="top_logo">
			<img alt="logo" src="${pageContext.request.contextPath }/images/common/logo.png" width="274" height="49" style="vertical-align:middle;">
		</div>
		
		<div id="top_links">
			<div id="top_op">
				<ul>
					<li>
						<img alt="当前用户" src="${pageContext.request.contextPath }/images/common/user.jpg">：
						<span>${user.username }</span>
					</li>
					<li>
						<img alt="事务月份" src="${pageContext.request.contextPath }/images/common/month.jpg">：
						<span id="yue_fen"></span>
					</li>
					<li>
						<img alt="今天是" src="${pageContext.request.contextPath }/images/common/date.jpg">：
						<span id="day_day"></span>
					</li>
				</ul> 
			</div>
			<div id="top_close">
				<a href="javascript:void(0);" onclick="logout();" target="_parent">
					<img alt="退出系统" title="退出系统" src="${pageContext.request.contextPath }/images/common/close.jpg" style="position: relative; top: 10px; left: 25px;">
				</a>
			</div>
		</div>
	</div>
    <!-- side menu start -->
	<div id="side">
		<div id="left_menu">
		 	<ul id="TabPage2" style="height:200px; margin-top:50px;">
				<li id="left_tab1" class="selected" onClick="javascript:switchTab('TabPage2','left_tab1');" title="业务模块">
					<img alt="业务模块" title="业务模块" src="${pageContext.request.contextPath }/images/common/1_hover.jpg" width="33" height="31">
				</li>
				<li id="left_tab2" class="selected1" onClick="javascript:switchTab('TabPage2','left_tab2');" title="系统管理">
					<img alt="系统管理" title="系统管理" src="${pageContext.request.contextPath }/images/common/2.jpg" width="33" height="31">
				</li>		
				<li id="left_tab3"  class="selected2" onClick="javascript:switchTab('TabPage2','left_tab3');" title="其他">
					<img alt="其他" title="其他" src="${pageContext.request.contextPath }/images/common/3.jpg" width="33" height="31">
				</li>
			</ul>
			
			
			<div id="nav_show" style="position:absolute; bottom:0px; padding:10px;">
				<a href="javascript:;" id="show_hide_btn">
					<img alt="显示/隐藏" title="显示/隐藏" src="${pageContext.request.contextPath }/images/common/nav_hide.png" width="35" height="35">
				</a>
			</div>
		 </div>
		 <div id="left_menu_cnt">
		 	<div id="nav_module">
		 		<img src="${pageContext.request.contextPath }/images/common/module_1.png" width="210" height="58"/>
		 	</div>
		 	<div id="nav_resource">
		 		<ul id="dleft_tab1" class="ztree"></ul>
		 	</div>
		 </div>
	</div>
	<script type="text/javascript">
		$(function(){
			$('#TabPage2 li').click(function(){
				var index = $(this).index();
				$(this).find('img').attr('src', '${pageContext.request.contextPath }/images/common/'+ (index+1) +'_hover.jpg');
				$(this).css({background:'#fff'});
				$('#nav_module').find('img').attr('src', '${pageContext.request.contextPath }/images/common/module_'+ (index+1) +'.png');
				$('#TabPage2 li').each(function(i, ele){
					if( i!=index ){
						$(ele).find('img').attr('src', '${pageContext.request.contextPath }/images/common/'+ (i+1) +'.jpg');
						$(ele).css({background:'#044599'});
					}
				});
				// 显示侧边栏
				switchSysBar(true);
			});
			
			// 显示隐藏侧边栏
			$("#show_hide_btn").click(function() {
		        switchSysBar();
		    });
		});
		
		/**隐藏或者显示侧边栏**/
		function switchSysBar(flag){
			var side = $('#side');
	        var left_menu_cnt = $('#left_menu_cnt');
			if( flag==true ){	// flag==true
				left_menu_cnt.show(500, 'linear');
				side.css({width:'280px'});
				$('#top_nav').css({width:'77%', left:'304px'});
	        	$('#main').css({left:'280px'});
			}else{
		        if ( left_menu_cnt.is(":visible") ) {
					left_menu_cnt.hide(10, 'linear');
					side.css({width:'60px'});
		        	$('#top_nav').css({width:'100%', left:'60px', 'padding-left':'28px'});
		        	$('#main').css({left:'60px'});
		        	$("#show_hide_btn").find('img').attr('src', '${pageContext.request.contextPath }/images/common/nav_show.png');
		        } else {
					left_menu_cnt.show(500, 'linear');
					side.css({width:'280px'});
					$('#top_nav').css({width:'77%', left:'304px', 'padding-left':'0px'});
		        	$('#main').css({left:'280px'});
		        	$("#show_hide_btn").find('img').attr('src', '${pageContext.request.contextPath }/images/common/nav_hide.png');
		        }
			}
		}
	</script>
    <!-- side menu start -->
    <div id="top_nav">
	 	<span id="here_area">当前位置：系统&nbsp;>&nbsp;系统介绍</span>
	</div>
    <div id="main">
      	<iframe name="right" id="rightMain" src="welcome.jsp" frameborder="no" scrolling="auto" width="100%" height="100%" allowtransparency="true"></iframe>
    </div>
	<div id="footer" class="span12"> 2016 &copy; Power by aynu计算机与信息工程学院 中美联合实验室</a> </div>
</body>
</html>
