<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<link href="${pageContext.request.contextPath }/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<head>
<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>


<script type="text/javascript" src="js/fancybox/jquery.fancybox.pack.js"></script>
<script type="text/javascript" src="js/fancybox/jquery.fancybox.js"></script>
<link rel="stylesheet" type="text/css" href="js/fancybox/jquery.fancybox.css" media="screen"></link>
<link href="${pageContext.request.contextPath }/js/skins/default.css" rel="stylesheet" type="text/css"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style type="text/css">
body, html, #allmap {
	width: 100%;
	height: 100%;
	margin: 0;
	font-family: "微软雅黑";
	overflow: visible;
}

#allmap {
	height: 90%;
	width: 90%;
	margin: 0 auto;
	display: block;
}
/* 隐藏百度logo */
.anchorBL {
	
}

.well {
	margin: 0px;
	margin-top: 5px;
}

.well a {
	margin-left: 10px;
}

ul, li {
	list-style: none;
	margin: 0;
	padding: 0;
	float: left;
}

html {
	height: 100%
}

body {
	height: 100%;
	margin: 0px;
	padding: 0px;
	font-family: "微软雅黑";
}
#container {
	height: 500px;
	width: 100%;
}

#r-result {
	position: absolute;
	bottom: 0px;
	width: 100%;
	height: 10%;
}
.popover{
	width:500px;
	z-index:0;
	position:absolute;
	overflow: visible;
}
</style>
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=6DAO5wVcMnMUI84bTfNyYs1UbGorRxwj"></script>
<script type="text/javascript"
	src="http://api.map.baidu.com/library/Heatmap/2.0/src/Heatmap_min.js"></script>
<title>个性化地图</title>
</head>
<body>
	<div id="allmap"></div>
	<!--模态框声明-->
	<div class="modal fade" id="myModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content"></div>
		</div>
	</div>
	<div id="container"></div>
	<div id="r-result">
		<input type="button" class="btn btn-primary" onclick="openHeatmap();"
			value="显示热力图" /> <input type="button" class="btn btn-default"
			onclick="closeHeatmap();" value="关闭热力图" /> <input type="button"
			class="btn btn-primary" onclick="openOverlay();" value="开启海量星" /> <input
			type="button" class="btn btn-default" onclick="closeOverlay();"
			value="关闭海量星" />
	</div>
	
	<script type="text/javascript">
		var map = new BMap.Map('allmap', {
			//BMAP_NORMAL_MAP : 默认
			//BMAP_SATELLITE_MAP:卫星
			//BMAP_PERSPECTIVE_MAP : 三维
			//BMAP_HYBRID_MAP : 混合
			mapType : BMAP_NORMAL_MAP
		});
		//地图初始化
		function mapInit() {
			var mapStyle = {
				features : [ "road", "building", "water", "land" ],//隐藏地图上的poi
				style : "dark" //设置地图风格为高端黑
			}
			map.addControl(new BMap.MapTypeControl());
			map.setMapStyle(mapStyle);
			map.centerAndZoom("安阳", 15); // 初始化地图,用城市名设置地图中心点
			var point = new BMap.Point(116.418261, 39.921984);
			map.centerAndZoom(point, 15); // 初始化地图，设置中心点坐标和地图级别
			map.enableScrollWheelZoom(); // 允许滚轮缩放
		}


		//显示修改位置窗口
		function showChangeSiteWindow(obj) {
			//开启吸取地址模式
			startExtractAddress();
			var opts = {
					width : 300, // 信息窗口宽度
					height : 210, // 信息窗口高度
					title : "<span style='font-size:16px' class='title'><span class='glyphicon glyphicon-list-alt'></span>原地址："+$(obj).attr("address")+"</span>", // 信息窗口标题
				}
			var infoWindow = new BMap.InfoWindow(
					"<div class='well'>" 
							+ "<div class=input-group><div class=input-group-addon>新的地址</div><input type=text onclick=autoComplete('suggestId2') id=suggestId2 siteX= siteY= title= name=outCarPlace class=form-control placeholder=在此输入新地址  /></div>"
							+"<div class=input-group><div class=input-group-addon>经　　度</div><input type=text id=sugSiteX2 class=form-control placeholder=横坐标  /></div>"
							+"<div class=input-group><div class=input-group-addon>纬　　度</div><input type=text id=sugSiteY2 class=form-control placeholder=纵坐标  /></div>"
							+ "<div id=searchResultPanel style=z-index:999999;width:150px;height:auto;display:none;></div>"
							+ "</div>"
							+ "<button id='"+$(obj).attr("id")+"' class=btn-primary style=float:right;margin-top:10px;margin-bottom:10px; onclick=changeSite(this)"
							+ ">修改</button>"
							+ "</div>",
					opts); // 创建信息窗口对象
			map.openInfoWindow(infoWindow, new BMap.Point($(obj).attr("siteX"),
					$(obj).attr("siteY"))); //开启信息窗口 
		}
		
		//修改位置
		function changeSite(obj){
			var id = $(obj).attr("id");
			var newSiteX = $("#sugSiteX2").val();
			var newSiteY = $("#sugSiteY2").val();
			var url = "CaseinfoAction_changeSite";
			var args = {"time" : new Date(), "siteX" : newSiteX, "siteY" : newSiteY, "id" : id};
			$.getJSON(url, args , function(data){
				window.location.href="MapAction_toMessMapPage";
			});
		}
		//展示百度地图自带apiWindow
		function showBaiDuWindow(e,result)
		{
			var opts = {
					width : 300, // 信息窗口宽度
					height : 250, // 信息窗口高度
					title : "<span style='font-size:16px' class='title'><span class='glyphicon glyphicon-list-alt'></span>　案情简介:"
							+ e.point.smallContent
							+ "</span>", // 信息窗口标题
				}
				var infoWindow = new BMap.InfoWindow(
						"<div class='panel panel-default'>"
								+"<div class='well' style='margin:0;'>"
								+ "<a href='${pageContext.request.contextPath}/CaseinfoAction_toUpdatePage?id="+e.point.id+"' class='fancybox fancybox.iframe'><span class='glyphicon glyphicon-search'></span>案件详情</a>"
								+ "<a href='#' id='"+e.point.id+"' onclick='deleteCaseinfo(this)'><span class='glyphicon glyphicon-remove'></span>删除案件</a>"
								+ "<a href='${pageContext.request.contextPath}/CaseinfoAction_toAddCaseinfoPage?address="+encodeURI(encodeURI(result.address))+"&siteX="+e.point.lng+"&siteY="+e.point.lat+"' class='fancybox'><span class='glyphicon glyphicon-plus'></span>添加案件</a></div>"
								+ "<div class='well'><a href='#' onclick='showChangeSiteWindow(this)' id='"+e.point.id+"' address='"+result.address+"' siteX='"+e.point.lng+"' siteY='"+e.point.lat+"'><span class='glyphicon glyphicon-exclamation-sign'></span>修改位置</a></div>"
								/* + "<div class='well'><a href='#'><span class='glyphicon glyphicon-exclamation-sign'></span>风险指数</a>　<span class='glyphicon glyphicon-star'></span><span class='glyphicon glyphicon-star'></span><span class='glyphicon glyphicon-star'></span></div>" */
								+ "<div class='well'><a class='fancybox' href='${pageContext.request.contextPath}/CaseinfoAction_toRiskAnalysisPage?siteX="+e.point.lng+"&siteY="+e.point.lat+"'><span class='glyphicon glyphicon-exclamation-sign'></span>风险分析</a></div>"
								+ "<div class='panel-footer'><span class='glyphicon glyphicon-map-marker'></span>地址 : "+result.address+"</div>"
								+"</div>",
						opts); // 创建信息窗口对象
				map
						.openInfoWindow(
								infoWindow,
								new BMap.Point(
										e.point.lng,
										e.point.lat)); //开启信息窗口
				setTimeout(function (){
					$(".fancybox").click(function (){
						$.fancybox.open({
							href : this.href,
							type : 'iframe',
							padding : 5,
							width:1000,
						});
						return false;
					});
					}, 200);
				
		}
		
		//热力图初始化
		var pointCollection;
		function hotMapInit(points) {
			if (!isSupportCanvas()) {
				alert('热力图目前只支持有canvas支持的浏览器,您所使用的浏览器不能使用热力图功能~')
			}
			heatmapOverlay = new BMapLib.HeatmapOverlay({
				"radius" : 20
			});
			map.addOverlay(heatmapOverlay);
			heatmapOverlay.setDataSet({
				data : points,
				max : 100
			});

			var options = {
				size : BMAP_POINT_SIZE_SMALL,
				shape : BMAP_POINT_SHAPE_CIRCLE,
				color : '#d340c3',
			}
			//添加 案件 信息点 		
			pointCollection = new BMap.PointCollection(points, options); // 初始化PointCollection
			map.addOverlay(pointCollection); // 添加Overlay
			pointCollection
					.addEventListener(
							'mouseover',
							mouseoverWindow);
		}
		function mouseoverWindow(e)
		{
			if(extractAddressFlag)
				{
					return ;
				}
			else{
			//根据坐标得到地址 
			var myGeo = new BMap.Geocoder();
			myGeo.getLocation(
							new BMap.Point(e.point.lng,e.point.lat),
							function(result) {
								showBaiDuWindow(e,result);
							});
			}
		}

		function checkhHtml5() {
			if (typeof (Worker) === "undefined") {
				if (navigator.userAgent.indexOf("MSIE 9.0") <= 0) {
					alert("定制个性地图示例：IE9以下不兼容，推荐使用百度浏览器、chrome、firefox、safari、IE10");
				}
			}
		}
		checkhHtml5();
		function showInfo(e) {
			//抽取地址 模式
			if(extractAddressFlag)
				{
					console.log(extractAddressFlag);
					if(e.domEvent.button == 2)
						{
							alert("选定，退出抽取地址模式");
							closeExtractAddress();
						}
					return ;
				}
		
			else{		
			//移除查询路线窗体
			$(".popover").remove();
			if(e.domEvent.button == 2)
			{
				//单机右键
				// 创建地理编码服务实例 
				var myGeo = new BMap.Geocoder();
				// 根据坐标得到地址描述 
				myGeo
						.getLocation(
								new BMap.Point(e.point.lng, e.point.lat),
								function(result) {
									if (result) {
										var opts = {
											width : 300, // 信息窗口宽度
											height : 220, // 信息窗口高度
											title : "<span style='font-size:16px' class='title'><span class='glyphicon glyphicon-map-marker'></span>　"
													+ result.address + "</span>", // 信息窗口标题
										}
										var infoWindow = new BMap.InfoWindow(
												"<div class='well'>"
												+ "<a href='#' address='"
												+ result.address
												+ "' siteX='"
												+ e.point.lng
												+ "' siteY='"
												+ e.point.lat
												+ "' onclick='showAddWindow(this)'>"
												+ "<span class='glyphicon glyphicon-plus'></span>添加案件</a>　"
												+ "<a href='#' title='选择最佳出警路线' data-container='body' data-html='true' data-content='<div class=input-group name=outCarPlace><div class=input-group-addon>出警地址</div>"
												+ "<input type=text onclick=autoComplete(suggestId) id=suggestId siteX= siteY= name=outCarPlace class=form-control value=公安局  />"
												+ "<div id=searchResultPanel style=z-index:999999;width:150px;height:auto;display:none;></div>"
												+ "</div>"
												+ "<div class=input-group name=outCarType><div class=input-group-addon>出警类型</div><select class=form-control name=outCarType><option value=0>最少时间</option><option value=1>最短距离</option><option value=2>避开高速</option></select></div><button class=btn-primary style=float:right;margin-top:10px;margin-bottom:10px; onclick=showRoad(this) address="
												+ result.address
												+ " siteX="
												+ e.point.lng
												+ " siteY="
												+ e.point.lat
												+ ">查询</button>' data-toggle='popover' address='"
												+ result.address
												+ "' id='start' siteX='"
												+ e.point.lng
												+ "' siteY='"
												+ e.point.lat
												+ "'>"
												+ "<span class='glyphicon glyphicon-plus'></span>出警路线</a>"
												//<div class='input-group has-feedback' id='startDiv'><div class='input-group-addon'>出警位置</div><input type='text' size=1 class='form-control' id='start' value='公安局'></div>
												+ "</div>"
												+ "<div class='well'><a href='#' onclick='showChangeSiteWindow(this)' id='"+e.point.id+"' address='"+result.address+"' siteX='"+e.point.lng+"' siteY='"+e.point.lat+"'><span class='glyphicon glyphicon-exclamation-sign'></span>修改位置</a></div>"
												+ "<div class='well'><a class='fancybox' href='${pageContext.request.contextPath}/CaseinfoAction_toRiskAnalysisPage?siteX="+e.point.lng+"&siteY="+e.point.lat+"'><span class='glyphicon glyphicon-exclamation-sign'></span>风险分析</a></div>",
												opts); // 创建信息窗口对象
										map.openInfoWindow(infoWindow,
												new BMap.Point(e.point.lng,
														e.point.lat)); //开启信息窗口 

										setTimeout(function (){
											$("#start").popover();
											$(".fancybox").click(function (){
												$.fancybox.open({
													href : this.href,
													type : 'iframe',
													padding : 5,
													width:1000,
												});
												return false;
											});
											//初始化
											

										},200);
									}


								});
				

			}
			}
			}
							
		
		//显示出警路线
		function showRoad(obj)
		{
			var startObj = $(obj).parent().children("div[name='outCarPlace']").children("input[name='outCarPlace']");
			var start = new BMap.Point(startObj.attr("siteX"),startObj.attr("siteY"));
			
			var outType = $(obj).parent().children("div[name='outCarType']").children("input[name='outCarType']").val();
			//得到目标点 和 目标地址 
			var siteX = $(obj).attr("siteX");
			var siteY = $(obj).attr("siteY");

			var end = new BMap.Point(siteX,siteY);



			var routePolicy = [BMAP_DRIVING_POLICY_LEAST_TIME,BMAP_DRIVING_POLICY_LEAST_DISTANCE,BMAP_DRIVING_POLICY_AVOID_HIGHWAYS];
			map.clearOverlays(); 
			search(start,end,routePolicy[outType]); 
			function search(start,end,route){ 
				var driving = new BMap.DrivingRoute(map, {renderOptions:{map: map, autoViewport: true},policy: route});
				driving.search(start,end);
			}
			
		}
		map.addEventListener("mousedown", showInfo);

		
		function showAddWindow(obj)
		{
			var address = encodeURI($(obj).attr("address"));
			var siteX = $(obj).attr("siteX");
			var siteY = $(obj).attr("siteY");
			$('#myModal').modal({
				show : true,
				backdrop : true,
				keyboard : true,
				remote : '${pageContext.request.contextPath}/CaseinfoAction_toAddCaseinfoPage?address='+encodeURI(address)+'&siteX='+siteX+'&siteY='+siteY
				});
		}
		function deleteCaseinfo(obj){
			var id = $(obj).attr("id");
			art.dialog({
			    id: 'testID',
			    content: '确认删除吗？',
			    lock:true,
			    button: [
			        {
			            name: '确认',
			            callback: function () {
			                $.getJSON("${pageContext.request.contextPath}/CaseinfoAction_ajaxDel?id="+id,{"time":new Date()},function(data){
			                	if(data == true)
								{
									art.dialog({icon:'succeed', lock:true,title:'友情提示', drag:true, resize:false, content:'删除成功', ok:true,});
									setTimeout("window.location.reload()", 1000);
								}
			                	else{
			                		art.dialog({icon:'error',lock:true, title:'友情提示', drag:true, resize:false, content:'删除失败', ok:true,});
				                }
				                })
			                return true;
			            },
			            focus: true
			        },
			        {
			            name: '取消',
			            callback: function () {
			                alert('你不同意')
			            }
			        },
			    ]
			});
			
		}

			function showFancyBoxWindow(obj)
			{

			     return false;
			}

			$(function (){
				
			})

		
		function G(id) {
			return document.getElementById(id);
		}
		function autoComplete(str)
		{
			var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
					{"input" : str
					,"location" : map
				});
			//alert("a");
				ac.addEventListener("onhighlight", function(e) {  //鼠标放在下拉列表上的事件
				var str = "";
					var _value = e.fromitem.value;
					var value = "";
					if (e.fromitem.index > -1) {
						value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
					}    
					str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;
					
					value = "";
					if (e.toitem.index > -1) {
						_value = e.toitem.value;
						value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
					}    
					str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;
					G("searchResultPanel").innerHTML = str;
				});

				var myValue;
				ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
				var _value = e.item.value;
					myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
					G("searchResultPanel").innerHTML ="onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;
					
					setPlace();
				});
				function setPlace(){
					//map.clearOverlays();    //清除地图上所有覆盖物
					function myFun(){
						var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
						$("#"+str).attr("siteX",pp.lng);
						$("#"+str).attr("siteY",pp.lat);
						if(str == "suggestId2")
							{
								$("#sugSiteX2").val(pp.lng);
								$("#sugSiteX2").val(pp.lat);
							}
					}
					var local = new BMap.LocalSearch(map, { //智能搜索
					  onSearchComplete: myFun
					});
					local.search(myValue);
				}
		}

		var extractAddressFlag = false;

		function mousemoveAddress(e)
		{
			$("#sugSiteX2").val(e.point.lng);
			$("#sugSiteY2").val(e.point.lat);
			//console.log(e);
			var myGeo = new BMap.Geocoder();
			myGeo.getLocation(
							new BMap.Point(e.point.lng,e.point.lat),
							function(result) {
								//alert(result);
								$("#suggestId2").val(result.address);
								$("#suggestId2").attr("title",result.address);
							});
		
			
		}
		
		//开启抽取地址模式
		function startExtractAddress()
		{
			extractAddressFlag = true;
			map.addEventListener("mousemove",mousemoveAddress);
		}
		
		//关闭抽取地址模式
		function closeExtractAddress()
		{
			extractAddressFlag = false;
			map.removeEventListener("mousemove",mousemoveAddress);
		}

		
		$(function (){
			var url = "${pageContext.request.contextPath}/CaseinfoAction_returnAllHeatMapSites";
			var args = {
				"time" : new Date()
			};
			//var points ;
			$.getJSON(url, args, function(data) {
				var points = data;
				mapInit();
				hotMapInit(points);


				


				
			});
			

			
			
		})
		

		//详细的参数,可以查看heatmap.js的文档 https://github.com/pa7/heatmap.js/blob/master/README.md
		//参数说明如下:
		/* visible 热力图是否显示,默认为true
		 * opacity 热力的透明度,1-100
		 * radius 势力图的每个点的半径大小   
		 * gradient  {JSON} 热力图的渐变区间 . gradient如下所示
		 *	{
				.2:'rgb(0, 255, 255)',
				.5:'rgb(0, 110, 255)',
				.8:'rgb(100, 0, 255)'
			}
			其中 key 表示插值的位置, 0~1. 
			    value 为颜色值. 
		 */

		//是否开启海量星 （事件覆盖）
		function openOverlay() {
			if(!pointCollection.Pa){
				pointCollection.show();
				pointCollection.addEventListener('mouseover',mouseoverWindow);
			}
		}
		function closeOverlay() {
			if(pointCollection.Pa)
			{
				pointCollection.removeEventListener('mouseover',mouseoverWindow);
				pointCollection.hide();
			}
			console.log(pointCollection);

		}
		//是否显示热力图
		function openHeatmap() {
			heatmapOverlay.show();
		}
		function closeHeatmap() {
			heatmapOverlay.hide();
		}
		openHeatmap();
		function setGradient() {
			/*格式如下所示:
			{
				0:'rgb(102, 255, 0)',
			 	.5:'rgb(255, 170, 0)',
			 	1:'rgb(255, 0, 0)'
			}*/
			var gradient = {};
			var colors = document.querySelectorAll("input[type='color']");
			colors = [].slice.call(colors, 0);
			colors.forEach(function(ele) {
				gradient[ele.getAttribute("data-key")] = ele.value;
			});
			heatmapOverlay.setOptions({
				"gradient" : gradient
			});
		}

		//判断浏览区是否支持canvas
		function isSupportCanvas() {
			var elem = document.createElement('canvas');
			return !!(elem.getContext && elem.getContext('2d'));
		}
	</script>
	<script>
	$(function (){
			$(".aaa").fancybox({
				href : 'http://www.baidu.com',
				type : 'iframe',
				padding : 5,
		});
	})
	</script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/js/artDialog.js"></script>
</body>
</html>