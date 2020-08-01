<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">

<!-- jsp文件头和头部 -->
<%@ include file="../index/top.jsp"%>
<!-- 百度echarts -->
<script src="plugins/echarts/echarts.min.js"></script>
<script type="text/javascript">
setTimeout("top.hangge()",500);
</script>
	<style>
		.chart{
			width: 300px;
			height:300px;
			float:left;
		}
	</style>
</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="hr hr-18 dotted hr-double"></div>
					<div class="row">
						<div class="col-xs-12">

							<div class="alert alert-block alert-success">
								<button type="button" class="close" data-dismiss="alert">
									<i class="ace-icon fa fa-times"></i>
								</button>
								<i class="ace-icon fa fa-check green"></i>
								欢迎使用 MSD区块链基金交易平台  后台管理&nbsp;&nbsp;
								<strong class="green">
									&nbsp;
									<a href="" target="_blank"><small></small></a>
								</strong>
							</div>
							<%-- 所有用户统计--%>
							<div id="userCount" class="chart"></div>
							<%-- 今日用户统计--%>
							<div id="dayUserCount" class="chart"></div>

							<%--累积排单金额统计--%>
							<div id="buyCount" class="chart"></div>
							<%--今日排单金额统计--%>
							<div id="dayBuyCount" class="chart"></div>

							<div style="clear: both"></div>
							<%--提现金额统计--%>
							<div id="sellCount" class="chart"></div>
							<%--今日金额统计--%>
							<div id="daySellCount" class="chart"></div>

							<%--累积匹配金额统计--%>
							<div id="matchCount" class="chart" ></div>
							<%--今日匹配金额统计--%>
							<div id="dayMatchCount" class="chart" ></div>

						</div>
						<%--系统运行时间--%>
						<p id="run_time" style="color: #fd7286;font-size: large;font-weight: bolder">
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->


		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- inline scripts related to this page -->
	<script type="text/javascript">
		$(top.hangge());


		// 基于准备好的dom，初始化echarts实例
		var userCount = echarts.init(document.getElementById('userCount'));
		var dayUserCount = echarts.init(document.getElementById('dayUserCount'));

		var buyCount = echarts.init(document.getElementById('buyCount'));
		var dayBuyCount = echarts.init(document.getElementById('dayBuyCount'));

		var sellCount = echarts.init(document.getElementById('sellCount'));
		var daySellCount = echarts.init(document.getElementById('daySellCount'));

		var matchCount = echarts.init(document.getElementById('matchCount'));
		var dayMatchCount = echarts.init(document.getElementById('dayMatchCount'));

		// 指定图表的配置项和数据
		// 所有用户统计
		var userCountOption = {
			title: {
				text: '所有用户'
			},
			tooltip: {},
			xAxis: {
				data: ["所有用户"]
			},
			yAxis: {},
			series: [
				{
					name: '',
					type: 'bar',
					data: [${pd.appUserCount}],
					itemStyle: {
						normal: {
							color: function(params) {
								// build a color map as your need.
								var colorList = ['#FF9900'];
								return colorList[params.dataIndex];
							}
						}
					}
				}
			]
		};
		// 今日用户统计
		var dayUserCountOption = {
			title: {
				text: '今日用户'
			},
			tooltip: {},
			xAxis: {
				data: ["今日用户"]
			},
			yAxis: {},
			series: [
				{
					name: '',
					type: 'bar',
					data: [${pd.appDayUserCount}],
					itemStyle: {
						normal: {
							color: function(params) {
								// build a color map as your need.
								var colorList = ['#6FB3E0'];
								return colorList[params.dataIndex];
							}
						}
					}
				}
			]
		};

		// 累积排单金额图
		var buyCountOption = {
			title: {
				text: '累积排单金额'
			},
			tooltip: {},
			xAxis: {
				data: ["累积排单"]
			},
			yAxis: {},
			series: [
				{
					name: '',
					type: 'bar',
					data: [${pd.buyCount}],
					itemStyle: {
						normal: {
							color: function(params) {
								// build a color map as your need.
								var colorList = ['#FF0033'];
								return colorList[params.dataIndex];
							}
						}
					}
				}
			]
		};
		// 今日排单金额图
		var dayBuyCountOption = {
			title: {
				text: '今日排单金额'
			},
			tooltip: {},
			xAxis: {
				data: ["今日排单"]
			},
			yAxis: {},
			series: [
				{
					name: '',
					type: 'bar',
					data: [${pd.dayBuyCount}],
					itemStyle: {
						normal: {
							color: function(params) {
								// build a color map as your need.
								var colorList = ['#6FB3E0'];
								return colorList[params.dataIndex];
							}
						}
					}
				}
			]
		};

		// 累积提现金额图
		var sellCountOption = {
			title: {
				text: '累积提现金额'
			},
			tooltip: {},
			xAxis: {
				data: ["累积提现"]
			},
			yAxis: {},
			series: [
				{
					name: '',
					type: 'bar',
					data: [${pd.sellCount}],
					itemStyle: {
						normal: {
							color: function(params) {
								// build a color map as your need.
								var colorList = ['#CC3333'];
								return colorList[params.dataIndex];
							}
						}
					}
				}
			]
		};
		// 今日提现金额图
		var daySellCountOption = {
			title: {
				text: '今日提现金额'
			},
			tooltip: {},
			xAxis: {
				data: ["今日提现"]
			},
			yAxis: {},
			series: [
				{
					name: '',
					type: 'bar',
					data: [${pd.daySellCount}],
					itemStyle: {
						normal: {
							color: function(params) {
								// build a color map as your need.
								var colorList = ['#87B87F'];
								return colorList[params.dataIndex];
							}
						}
					}
				}
			]
		};

		// 累积匹配金额图
		var matchCountOption = {
			title: {
				text: '累积匹配金额'
			},
			tooltip: {},
			xAxis: {
				data: ["累积匹配"]
			},
			yAxis: {},
			series: [
				{
					name: '',
					type: 'bar',
					data: [${pd.matchCount}],
					itemStyle: {
						normal: {
							color: function(params) {
								// build a color map as your need.
								var colorList = ['#333399'];
								return colorList[params.dataIndex];
							}
						}
					}
				}
			]
		};
		// 今日匹配金额图
		var dayMatchCountOption = {
			title: {
				text: '今日匹配金额'
			},
			tooltip: {},
			xAxis: {
				data: ["今日匹配"]
			},
			yAxis: {},
			series: [
				{
					name: '',
					type: 'bar',
					data: [${pd.dayMatchCount}],
					itemStyle: {
						normal: {
							color: function(params) {
								// build a color map as your need.
								var colorList = ['#87B87F'];
								return colorList[params.dataIndex];
							}
						}
					}
				}
			]
		};

		// 使用刚指定的配置项和数据显示图表。
		userCount.setOption(userCountOption);
		dayUserCount.setOption(dayUserCountOption);

		buyCount.setOption(buyCountOption);
		dayBuyCount.setOption(dayBuyCountOption);

		sellCount.setOption(sellCountOption);
		daySellCount.setOption(daySellCountOption);

		matchCount.setOption(matchCountOption);
		dayMatchCount.setOption(dayMatchCountOption);


		// 系统运行时间统计
		function show_date_time() {
			// 每隔一秒调用一次函数
			window.setTimeout("show_date_time()", 1000);
			// 开始时间
			var start_time = '${par.SYSTEM_START_TIME}';
			BirthDay = new Date(start_time);
			// 现在时间
			today = new Date();
			// 得到相差多少毫秒
			timeold = (today.getTime() - BirthDay.getTime());
			// 毫秒转换单位为 秒
			sectimeold = timeold / 1000;
			// 去掉小数，向下取整
			secondsold = Math.floor(sectimeold);
			msPerDay = 24 * 60 * 60 * 1000;
			// 计算相差多少天数
			e_daysold = timeold / msPerDay;
			daysold = Math.floor(e_daysold);
			// 计算相差多少小时
			e_hrsold = (e_daysold - daysold) * 24;
			hrsold = Math.floor(e_hrsold);
			// 计算相差多少分
			e_minsold = (e_hrsold - hrsold) * 60;
			minsold = Math.floor((e_hrsold - hrsold) * 60);
			// 计算相差多少秒
			seconds = Math.floor((e_minsold - minsold) * 60);
			// 根据ID 输出HTML文本
			run_time.innerHTML = "本站已运行: " + daysold + " 天 " + hrsold + " 小时 " + minsold + " 分 " + seconds + " 秒 ";
		}
		// 调用方法
		show_date_time();






	</script>
<script type="text/javascript" src="static/ace/js/jquery.js"></script>



</body>
</html>