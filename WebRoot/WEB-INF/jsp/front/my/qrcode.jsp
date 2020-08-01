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
	<link rel="stylesheet" type="text/css" href="static/front/fonts/iconfont.css" />
	<link rel="stylesheet" type="text/css" href="static/front/layui/css/layui.css" />
	<link rel="stylesheet" type="text/css" href="static/front/css/style.css" />
	<body>
		<div class="layui-container">
			<!--header-->
			<header>
				<a class="back" href="javascript:history.back(-1)"><i class="iconfont icon-zuo-"></i></i>
				</a>
				<h4>推广二维码</h4></header>
			<!--信息-->
			<div class="qr-pic">
				<img id="code" src="static/front/images/ewm.png"/>
				<!--按钮-->
				<p id="extend_href">http://192.168.100.16:8020/q91121/interface/my/qrcode.html</p>
				<button type="button" class="btn" data-clipboard-action="copy" data-clipboard-text="http://192.168.100.16:8020/q91121/interface/my/qrcode.html" id="d_clip_button">复制链接</button>
			</div>
		</div>
		<script src="static/front/layui/layui.all.js" type="text/javascript" charset="utf-8"></script>
		<script src="static/front/js/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="static/front/js/clipboard.min.js" type="text/javascript" charset="utf-8"></script>
		<script>
			$(document).ready(function() {
			    var clipboard = new ClipboardJS('#d_clip_button');
			    clipboard.on('success', function(e) {
			         layer.msg("复制成功");
			        e.clearSelection();
			    });
			});

			// 二维码和链接
			$(function() {
				var context = "<%=basePath%>"+"release/toRegister.do?tag=" + ${user.PHONE} ;
				$("#code").attr("src", "front/qr_code.do?phone=" + ${user.PHONE});
				$("#extend_href").html("<%=basePath%>fish/toRegister.do?phone=" + ${user.PHONE});
				$(".btn").attr("data-clipboard-text",context);

			})

		</script>
	</body>

</html>