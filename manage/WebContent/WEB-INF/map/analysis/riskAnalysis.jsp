<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Matrix Admin</title>
<meta charset="UTF-8" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/matrix-style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/matrix-media.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800'
	rel='stylesheet' type='text/css'>
</head>
<body>


	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon"> <i class="icon-signal"></i>
						</span>
						<h5>案情分析中... ...</h5>
					</div>



					<div class="widget-content">
						<div id="placeholder2" style="width:100%"></div>
						<h4 id="progressTips">
						进度:1%
						</h4>
						<div class="progress">
							<div id="progress" class="progress-bar progress-bar-success progress-bar-striped active" style="width:1%;"></div>
					</div>
				</div>
			</div>
		</div>


	</div>
	</div>
	<!--end-Footer-part-->
	<script src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/jquery.flot.min.js"></script>
	<script type="text/javascript">
	function load()
	{
		var data = [], totalPoints = 300;
		function getRandomData() {
			if (data.length > 0)
				data = data.slice(1);

			// do a random walk
			while (data.length < totalPoints) {
				var prev = data.length > 0 ? data[data.length - 1] : 50;
				var y = prev + Math.random() * 10 - 5;
				if (y < 0)
					y = 0;
				if (y > 100)
					y = 100;
				data.push(y);
			}

			// zip the generated y values with the x values
			var res = [];
			for (var i = 0; i < data.length; ++i)
				res.push([ i, data[i] ])
			return res;
		}

		// setup control widget
		var updateInterval = 30;
		$("#updateInterval").val(updateInterval).change(function() {
			var v = $(this).val();
			if (v && !isNaN(+v)) {
				updateInterval = +v;
				if (updateInterval < 1)
					updateInterval = 1;
				if (updateInterval > 2000)
					updateInterval = 2000;
				$(this).val("" + updateInterval);
			}
		});

		// setup plot
		var options = {
			series : {
				shadowSize : 0
			}, // drawing is faster without shadows
			yaxis : {
				min : 0,
				max : 100
			},
			xaxis : {
				show : false
			}
		};
		var plot = $.plot($("#placeholder2"), [ getRandomData() ], options);


		function update() {
			plot.setData([ getRandomData() ]);
			// since the axes don't change, we don't need to call plot.setupGrid()
			plot.draw();

			setTimeout(update, updateInterval);
		}
		
		update();
		}




				
			
		
		$(function(){
	      setTimeout(function(){
				load();
		      }, 200);
			
			var url = "${pageContext.request.contextPath}/CaseinfoAction_riskAnalysis";
			var args = {"time" : new Date(),siteX:"${siteX}",siteY:"${siteY}"};
			$.getJSON(url, args, function(data){
				setTimeout(function (){
					window.location.href="${pageContext.request.contextPath}/CaseinfoAction_toRiskMessPage";
					},1000);
			});
			
			function lunxun(){
				var url = "${pageContext.request.contextPath}/CaseinfoAction_riskAnalysisListener";
				var args = {"time" : new Date()};
				$.getJSON(url, args, function(data){
					$("#progressTips").html("进度:"+data.percent);
					$("#progress").css({width:data.percent});
				});
			}
			var intervalId = setInterval(function(){
					lunxun();
				}, 1000);
		})
	</script>
</body>
</html>
