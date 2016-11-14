<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Highcharts Example</title>

<script type="text/javascript"
	src="http://cdn.hcharts.cn/jquery/jquery-1.8.3.min.js"></script>
<style type="text/css">
${demo.css}
</style>
<script type="text/javascript">
	$(function() {
		var arr = ${caseinfoCount};
		var maxnum = ${maxCaseinfoCount};
		var averCaseinfoSerious = ${averCaseinfoSerious};
		$('#container')
				.highcharts(
						{

							chart : {
								polar : true,
								type : 'line'
							},

							title : {
								text : '各种类事故发生次数及严重性分析',
								x : -80
							},

							pane : {
								size : '80%'
							},

							xAxis : {
								categories : [ '火灾地震等', '交通事故等','打架斗殴等', '抢劫偷盗等',
								        '贩毒强奸等','拐卖儿童等'],
								tickmarkPlacement : 'on',
								lineWidth : 0
							},

							yAxis : {
								gridLineInterpolation : 'polygon',
								lineWidth : 0,
								min : 0,
								max: maxnum
							},

							tooltip : {
								shared : true,
								pointFormat : '<span style="color:{series.color}">{series.name}: <b>{point.y:,.0f}</b><br/>'
							},

							legend : {
								align : 'right',
								verticalAlign : 'top',
								y : 70,
								layout : 'vertical'
							},

							series : [
									{
										name : '事故发生次数',
										data : arr,
										pointPlacement : 'on'
									},
									{
										name : '平均事故严重性',
										data : averCaseinfoSerious,
										pointPlacement : 'on'
									} ]

						});
	});
</script>
</head>
<body>
	<script src="http://cdn.hcharts.cn/highcharts/highcharts.js"></script>
	<script src="http://cdn.hcharts.cn/highcharts/highcharts-more.js"></script>
	<script src="http://cdn.hcharts.cn/highcharts/modules/exporting.js"></script>

	<div id="container"
		style="min-width: 400px; max-width: 600px; height: 400px; margin: 0 auto"></div>

</body>
</html>
