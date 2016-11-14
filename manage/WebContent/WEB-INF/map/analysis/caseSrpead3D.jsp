<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
	<head>
		<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>Highcharts Example</title>

		<script type="text/javascript" src="http://cdn.hcharts.cn/jquery/jquery-1.8.3.min.js"></script>
		<style type="text/css">
#container {
    height: 400px; 
    min-width: 310px; 
    max-width: 800px;
    margin: 0 auto;
}
		</style>
		<script type="text/javascript">
$(function () {
	var url = "${pageContext.request.contextPath}/CaseinfoAction_returnSpreadData";
	var args = {"time":new Date()};
	$.getJSON(url,args,function(data){
	    Highcharts.getOptions().colors = $.map(Highcharts.getOptions().colors, function (color) {
	        return {
	            radialGradient: {
	                cx: 0.4,
	                cy: 0.3,
	                r: 0.5
	            },
	            stops: [
	                [0, color],
	                [1, Highcharts.Color(color).brighten(-0.2).get('rgb')]
	            ]
	        };
	    });

	    // Set up the chart
	    var chart = new Highcharts.Chart({
	        chart: {
	            renderTo: 'container',
	            margin: 100,
	            type: 'scatter',
	            options3d: {
	                enabled: true,
	                alpha: 10,
	                beta: 30,
	                depth: 250,
	                viewDistance: 5,
	                fitToPlot: false,
	                frame: {
	                    bottom: { size: 1, color: 'rgba(0,0,0,0.02)' },
	                    back: { size: 1, color: 'rgba(0,0,0,0.04)' },
	                    side: { size: 1, color: 'rgba(0,0,0,0.06)' }
	                }
	            }
	        },
	        title: {
	            text: '案件分布及严重情况3D效果图'
	        },
	        subtitle: {
	            text: '点击表格或者圆点拖拽即可旋转视角'
	        },
	           //配置数据点提示框
            tooltip:
			{
                crosshairs:true,
                shared:true,
                formatter:function(){
                    console.log(this);
                    return "<strong>案例简介</strong>:"+this.series.name+"<br><br><strong>地址:</strong>"+"<i>"+this.series.address+"</i>";
                }
            },
	        
	        plotOptions: {
	            scatter: {
	                width: 10,
	                height: 10,
	                depth: 10,
	            },

		         
	        },
	        yAxis: {
	            min: 0,
	            max: 100,
	            title: "案件严重程度",
		           
	        },
	        xAxis: {
	            min: 114.3,
	            max: 114.5,
	            gridLineWidth: 1,
	        },
	        zAxis: {
	            min: 36,
	            max: 36.2,
	            showFirstLabel: false,
	        },
	        legend: {
	            enabled: false
	        },
	        series: data
	    });


	    // Add mouse events for rotation
	    $(chart.container).bind('mousedown.hc touchstart.hc', function (eStart) {
	        eStart = chart.pointer.normalize(eStart);

	        var posX = eStart.pageX,
	            posY = eStart.pageY,
	            alpha = chart.options.chart.options3d.alpha,
	            beta = chart.options.chart.options3d.beta,
	            newAlpha,
	            newBeta,
	            sensitivity = 5; // lower is more sensitive

	        $(document).bind({
	            'mousemove.hc touchdrag.hc': function (e) {
	                // Run beta
	                newBeta = beta + (posX - e.pageX) / sensitivity;
	                chart.options.chart.options3d.beta = newBeta;

	                // Run alpha
	                newAlpha = alpha + (e.pageY - posY) / sensitivity;
	                chart.options.chart.options3d.alpha = newAlpha;

	                chart.redraw(false);
	            },
	            'mouseup touchend': function () {
	                $(document).unbind('.hc');
	            }
	        });
	    });

	});
		
	});
   
		</script>
	</head>
	<body>

<script src="${pageContext.request.contextPath }/js/highcharts/highcharts.js"></script>
<script src="${pageContext.request.contextPath }/js/highcharts/highcharts-3d.js"></script>
<script src="${pageContext.request.contextPath }/js/highcharts/modules/exporting.js"></script>

<div id="container" style="height: 400px"></div>
	</body>
</html>
