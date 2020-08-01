<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
	<style>
		.hover:hover {
			color: red !important;
			cursor: pointer;
		}

		html, body {
			margin: 0px;
			padding: 0px;
			width: 100%;
			height: 100%;
			overflow: hidden;
			font-family: Helvetica;
		}

		#tree {
			width: 100%;
			height: 100%;
		}

	</style>
</head>
<body class="no-skin">
<%--树形图--%>
<div id="tree"></div>

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<%--组织架构图--%>
	<script src="static/front/js/orgchart.js" type="text/javascript" charset="utf-8"></script>

	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态


		window.onload = function () {
			//接收后台传过来的集合
			//防止数字出错，用单引号括起来
			var nodes = [{
				id: '${user.ACCOUNT_ID}',
				昵称: '${user.NAME}',
				电话: '${user.PHONE}',
				img: "https://balkangraph.com/js/img/1.jpg"
			},
				<c:forEach var="item" items="${userList}" varStatus="s">
				{
					id: '${item.ACCOUNT_ID}',
					pid: '${item.RECOMMENDER_ID}',
					昵称: '${item.NAME}',
					电话: '${item.PHONE}',
					img: "https://balkangraph.com/js/img/2.jpg"
				},
				</c:forEach>
			];

			for (var i = 0; i < nodes.length; i++) {
				nodes[i].field_number_children = childCount(nodes[i].id);
			}

			function childCount(id) {
				let count = 0;
				for (var i = 0; i < nodes.length; i++) {
					if (nodes[i].pid == id) {
						count++;
						count += childCount(nodes[i].id);
					}
				}

				return count;
			}

			OrgChart.templates.rony.field_number_children = '<circle cx="60" cy="110" r="15" fill="#F57C00"></circle><text fill="#ffffff" x="60" y="115" text-anchor="middle">{val}</text>';

			var chart = new OrgChart(document.getElementById("tree"), {
				template: "rony",
				collapse: {
					level: 3
				},
				nodeBinding: {
					field_0: "昵称",
					field_2: "电话",
					img_0: "img",
					field_number_children: "field_number_children"
				},
				nodes: nodes
			});
		};


	</script>


</body>
</html>