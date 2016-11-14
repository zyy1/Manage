<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>全天事故发生时间分布统计</title>

<script type="text/javascript"
	src="http://cdn.hcharts.cn/jquery/jquery-1.8.3.min.js"></script>
<style type="text/css">
${demo.css}
</style>
</head>
<body>
	<script src="http://cdn.hcharts.cn/highcharts/highcharts.js"></script>
	<script src="http://cdn.hcharts.cn/highcharts/modules/exporting.js"></script>

	<div id="container"
		style="min-width: 310px; height: 400px; max-width: 800px; margin: 0 auto"></div>
<script type="text/javascript">
var url = "MapAction_accidentTimeAnalys";
var args = {"time" : new Date()};
$.getJSON(url, args, function(data) {
	$('#container').highcharts(
			{
				chart : {
					type : 'scatter',
					zoomType : 'xy'
				},
				title : {
					text : '全天事故发生时间分布统计'
				},
				subtitle : {
					text : '数据源:所有历史事故'
				},
				xAxis : {
					title : {
						enabled : true,
						text : 'Time (h)'
					},
					startOnTick : true,
					endOnTick : true,
					showLastLabel : true,
					min:0,
					max:24,
					categories:[0]
				},
				yAxis : {
					title : {
						text : 'Serious(严重性)'
					}
				},
				legend : {
					layout : 'vertical',
					align : 'left',
					verticalAlign : 'top',
					x : 100,
					y : 70,
					floating : true,
					backgroundColor : (Highcharts.theme && Highcharts.theme.legendBackgroundColor)
							|| '#FFFFFF',
					borderWidth : 1
				},
				plotOptions : {
					scatter : {
						marker : {
							radius : 5,
							states : {
								hover : {
									enabled : true,
									lineColor : 'rgb(100,100,100)'
								}
							}
						},
						states : {
							hover : {
								marker : {
									enabled : false
								}
							}
						},
						tooltip : {
							headerFormat : '<b>{series.name}</b><br>',
							pointFormat : '{point.x} .00左右, 严重指数:{point.y} '
						}
					}
				},
				series : [ {
					name : '事故',
					color : 'rgba(223, 83, 83, .5)',
					data : data
				} ]
			});
});
</script>
</body>
</html>
