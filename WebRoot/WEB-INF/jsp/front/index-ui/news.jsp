<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
+ path + "/";
%>

<html>
<base href="<%=basePath%>">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title></title>
	</head>
	<link rel="stylesheet" type="text/css" href="static/front/fonts/iconfont.css"/>
	<link rel="stylesheet" type="text/css" href="static/front/layui/css/layui.css"/>
	<link rel="stylesheet" type="text/css" href="static/front/css/style.css"/>
	<body>
		<div class="layui-container">
			<!--header-->
			<header><a class="back" href="javascript:history.back(-1)"><i class="iconfont icon-zuo-"></i></i></a><h4>新闻公告</h4></header>
			<!--信息输入-->
			<div class="news-list">
				<ul>
					<%--开始循环--%>
					<c:forEach var="var" items="${newsList}" >
					<a href="front/to_newsDetails.do?SYS_NEWS_ID=${var.SYS_NEWS_ID}">
						<li>
							<div class="news-list-div">
								<i class="iconfont icon-gonggao6"></i>
								<div>
									<p>${var.TITLE}</p>
									<c:if test="${var.GMT_MODIFIED == ''}" >
									<p>${var.GMT_CREATE}</p>
									</c:if>
									<c:if test="${var.GMT_MODIFIED != ''}" >
										<p>${var.GMT_MODIFIED}</p>
									</c:if>
								</div>
							</div>
							<i class="iconfont icon-you-"></i>
						</li>
					</a>
					</c:forEach>
				</ul>
			</div>
		</div>
		<script src="static/front/layui/layui.all.js" type="text/javascript" charset="utf-8"></script>
		<script src="static/front/js/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
		
	
	</body>
</html>
