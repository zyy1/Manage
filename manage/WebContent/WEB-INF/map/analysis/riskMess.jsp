<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>Highcharts Example</title>

		<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui.js"></script>
		<script type="text/javascript" src="js/artDialog.js?skin=default"></script>
		<link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
		<style type="text/css">
		.tips{
			position: absolute;
			z-index: -99;
			top:280px;
			left:380px;
		}
		.tip{
			 background: red;
		}		
		.bar{
			width:10px;
			height:10px;
			background:black;
		}
		#count-number{
			display: inline;
		}
		.message-left{
			position: absolute;
			top:10px;
			left:10px;
		}
		.message-right{
			position: absolute;
			top:10px;
			right:10px;
		}
		.menu{
			width:100%;
		}
		.elseData{
			display: none;
		}
		.content a{
			line-height: 16px;
		}
		.contentTitle{
			text-align: center;
			border:1px solid #dcdcdc;
			display: inline-block;
			width:50%;
			white-space: nowrap;
			overflow: hidden;
			text-overflow:ellipsis;
			line-height: 16px;
			height:16px;
		}
		</style>
		<script type="text/javascript">
$(function () {

    // Uncomment to style it like Apple Watch
    /*
    if (!Highcharts.theme) {
        Highcharts.setOptions({
            chart: {
                backgroundColor: 'black'
            },            colors: ['#F62366', '#9DFF02', '#0CCDD6'],
            title: {
                style: {
                    color: 'silver'
                }
            },
            tooltip: {
                style: {
                    color: 'silver'
                }
            }
        });
    }
    // */

    Highcharts.chart('container', {

        chart: {
            type: 'solidgauge',
            marginTop: 50
        },

        title: {
            text: '风险分析预览',
            style: {
                fontSize: '24px'
            }
        },

        tooltip: {
            borderWidth: 0,
            backgroundColor: 'none',
            shadow: true,
            zIndex:10,
            style: {
                fontSize: '16px'
            },
            pointFormat: '{series.name}<br><span style="font-size:2em; color: {point.color}; font-weight: bold">{point.y}%</span>',
            positioner: function (labelWidth, labelHeight) {
                return {
                    x: 400 - labelWidth / 2,
                    y: 280
                };
            }
        },

        pane: {
            startAngle: 0,
            endAngle: 360,
            background: [{ // Track for Move
                outerRadius: '105%',
                innerRadius: '95%',
                backgroundColor: Highcharts.Color(Highcharts.getOptions().colors[4]).setOpacity(0.3).get(),
                borderWidth: 0
            }, { // Track for Exercise
                outerRadius: '90%',
                innerRadius: '80%',
                backgroundColor: Highcharts.Color(Highcharts.getOptions().colors[3]).setOpacity(0.3).get(),
                borderWidth: 0
            }, { // Track for Stand
                outerRadius: '75%',
                innerRadius: '65%',
                backgroundColor: Highcharts.Color(Highcharts.getOptions().colors[2]).setOpacity(0.3).get(),
                borderWidth: 0
            },
            { // Track for Stand
                outerRadius: '60%',
                innerRadius: '50%',
                backgroundColor: Highcharts.Color(Highcharts.getOptions().colors[1]).setOpacity(0.3).get(),
                borderWidth: 0
            },
            {
                outerRadius: '45%',
                innerRadius: '35%',
                backgroundColor: Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0.3).get(),
                borderWidth: 0
            },
            {
                outerRadius: '45%',
                innerRadius: '0%',
                backgroundColor: Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0.3).get(),
                borderWidth: 0,
                
            },

            ]
        },

        yAxis: {
            min: 0,
            max: 100,
            lineWidth: 0,
            tickPositions: []
        },

        plotOptions: {
            solidgauge: {
                borderWidth: '30px',
                dataLabels: {
                    enabled: false
                },
                linecap: 'round',
                stickyTracking: false
            }
        },

        series: [
        {
            name: '20~25km',
            borderColor: Highcharts.getOptions().colors[4],
            data: [{
                color: Highcharts.getOptions().colors[4],
                radius: '100%',
                innerRadius: '100%',
                y:  parseInt('${riskSerious[4]}')
            }]
        }, 
        {
            name: '15~20km',
            borderColor: Highcharts.getOptions().colors[3],
            data: [{
                color: Highcharts.getOptions().colors[3],
                radius: '85%',
                innerRadius: '85%',
                y: parseInt('${riskSerious[3]}')
            }]
        }, 
        {
            name: '10~15km',
            borderColor: Highcharts.getOptions().colors[2],
            data: [{
                color: Highcharts.getOptions().colors[2],
                radius: '70%',
                innerRadius: '70%',
                y:  parseInt('${riskSerious[2]}')
            }]
        }, 
        {
            name: '5~10km',
            borderColor: Highcharts.getOptions().colors[1],
            data: [{
                color: Highcharts.getOptions().colors[1],
                radius: '55%',
                innerRadius: '55%',
                y: parseInt('${riskSerious[1]}')
            }]
        },
        {
            name: '0~5km',            borderColor: Highcharts.getOptions().colors[0],
            data: [{
                color: Highcharts.getOptions().colors[0],
                radius: '40%',
                innerRadius: '40%',
                y: parseInt('${riskSerious[0]}')
            }
		]
        }


        ]
    },

    /**
     * In the chart load callback, add icons on top of the circular shapes
     */
    function callback() {
    	  // Move icon
       
    });


});

		</script>
	</head>
	<body>
<script src="http://cdn.hcharts.cn/highcharts/highcharts.js"></script>
<script src="http://cdn.hcharts.cn/highcharts/highcharts-more.js"></script>
<script src="http://cdn.hcharts.cn/highcharts/modules/solid-gauge.js"></script>

<div id="container" style="width: 800px; height: 600px; margin: 0 auto">
</div>

<div class="message-left">
<div class="well">
<h4><span class="glyphicon glyphicon-exclamation-sign"></span>风险指数:</h4> 
<h2 class="timer count-title" id="count-number" data-to="${totalRiskSerious}" data-speed="5000">${totalRiskSerious}</h2>%
<div class="bar"></div>
</div>

<div class="well">
<h4><span class="glyphicon glyphicon-fire"></span>附近案件:</h4>
<div class="panel panel-default">
<s:iterator value="#session.caseinfoRisk" var="caseinfos" status="st">
<s:if test="#st.index < 2">
	<div class="panel-heading">
	<div class="panel-title">
	<button class="btn btn-default menu menu<s:property value="#st.index+1" />"><h4><s:property value="#st.index*5" />~<s:property value="(#st.index+1)*5" />km内</h4></button>
	</div>
	</div>
	<div class="panel-body data<s:property value="#st.index+1" />">
	<s:if test="#caseinfos.size == 0">
		<div class="content">无案件</div>
	</s:if>
	<s:else>
	<s:iterator value="#caseinfos" status="st">
			<div class="content">
			<s:if test="smallContent == null || smallContent == ''">
				<div class="contentTitle" title="没有为该案件设置标题">（空）</div>
			</s:if>
			<s:else>
			<div class="contentTitle" title="${smallContent }">${smallContent}</div>
			</s:else>
			<a  number="${number }" 
				calltype="${calltype }"
				callper = "${callper }" 
				calltime="${calltime }" 
				smallContent="${smallContent }" 
				content="${content }" 	
				address="${address }"
				caseType ="${caseType }"
				phone="${phone }"
				receive="${receive }" 
				outtime="${outtime }"
				outper= "${outper }"
				outcar="${outcar }"
				dealwith="${dealwith }"
				sugge="${sugge }"
				serious="${serious }"
				dealper="${dealper }"	
			 href="javascript:void(0)" onclick="showMess(this)">点击查看</a>
			 </div>
	</s:iterator>
	</s:else>
	</div>
</s:if>
</s:iterator>
</div>
</div>
</div>
<div class="message-right">
	<div class="well">
<h4><span class="glyphicon glyphicon-fire"></span>附近案件:</h4>
<div class="panel panel-default">
<s:iterator value="#session.caseinfoRisk" var="caseinfos" status="st">
<s:if test="#st.index > 1">
	<div class="panel-heading">
	<div class="panel-title">
	<button class="btn btn-default menu menu<s:property value="#st.index+1" />"><h4><s:property value="#st.index*5" />~<s:property value="(#st.index+1)*5" />km内</h4></button>
	</div>
	</div>
	<div class="panel-body data<s:property value="#st.index+1" />">
	<s:if test="#caseinfos.size == 0">
		<div class="content">无案件</div>
	</s:if>
	<s:else>
	<s:iterator value="#caseinfos" status="st">
			<div class="content">
			<s:if test="smallContent == null || smallContent == ''">
				<div class="contentTitle" title="没有为该案件设置标题">（空）</div>
			</s:if>
			<s:else>
			<div class="contentTitle" title="${smallContent }">${smallContent}</div>
			</s:else>
			<a  number="${number }" 
				calltype="${calltype }"
				callper = "${callper }" 
				calltime="${calltime }" 
				smallContent="${smallContent }" 
				content="${content }" 	
				address="${address }"
				caseType ="${caseType }"
				phone="${phone }"
				receive="${receive }" 
				outtime="${outtime }"
				outper= "${outper }"
				outcar="${outcar }"
				dealwith="${dealwith }"
				sugge="${sugge }"
				serious="${serious }"
				dealper="${dealper }"	
			 href="javascript:void(0)" onclick="showMess(this)">点击查看</a>
			 </div>
	</s:iterator>
	</s:else>
	</div>
</s:if>
</s:iterator>
</div>
</div>
</div>
<script>
$(function (){
	var colors = ["#5BC1DF","#5CB95C","#F0AF4D","#DA524E"];
	var index = parseInt(parseInt("${totalRiskSerious}")/25);
	$(".bar").animate({"backgroundColor":colors[index],width:(index+1)*36+"px"},5000);

	$(".menu1").click(function (){
		$(".data1").slideToggle();
	});
	$(".menu2").click(function (){
		$(".data2").slideToggle();
	});
	$(".menu3").click(function (){
		$(".data3").slideToggle();
	});
	$(".menu4").click(function (){
		$(".data4").slideToggle();
	});
	$(".menu5").click(function (){
		$(".data5").slideToggle();
	});
});
function showMess(obj)
{
	var $obj = $(obj);
	art.dialog({
		icon: 'face-smile',
		ok: true,
		padding: 0,
		title: "案件详细信息",
		
		content: '<table class="table table-striped table-hover table-bordered">'
			+'<tr><th>编号</th><th>报警方式</th><th>报警人员</th><th>报警时间</th><th>摘　　要</th><th>报警内容</th><th>案发地点</th><th>案件类型</th><th>报警者电话</th></tr>'
			+'<tr><td>'+$obj.attr("number")+'</td><td>'+$obj.attr("calltype")+'</td><td>'+$obj.attr("callper")+'</td><td>'
			+$obj.attr("calltime")+'</td><td>'+$obj.attr("smallContent")+'</td><td>'+$obj.attr("content")+'</td><td>'+$obj.attr("address")+'</td><td>'+$obj.attr("caseType")+'</td><td>'+$obj.attr("phone")+'</td></tr>'
			+'<tr><th>接警人员</th><th>出警时间</th><th>出警人员</th><th>出警车辆</th><th colspan="2">处置情况</th><th>处置意见</th><th>严重指数</th><th>处理警员</th></tr>'
			+'<tr><td>'+$obj.attr("receive")+'</td><td>'+$obj.attr("outtime")+'</td><td>'+$obj.attr("outper")+'</td><td>'+$obj.attr("outcar")+'</td><td colspan="2">'+$obj.attr("dealwith")+'</td><td>'+$obj.attr("sugge")+'</td>'
			+'<td>'+$obj.attr("serious")+'</td><td>'+$obj.attr("dealper")+'</td></tr>'
			+'</table>',
		lock: true
	

	})
}
</script>

<script type="text/javascript" src="js/number.js"></script>
	</body>
</html>
