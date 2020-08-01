<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<html>
<base href="<%=basePath%>">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <title></title>
</head>
<link rel="stylesheet" type="text/css" href="static/front/fonts/iconfont.css"/>
<link rel="stylesheet" type="text/css" href="static/front/layui/css/layui.css"/>
<link rel="stylesheet" type="text/css" href="static/front/css/style.css"/>
<body>
<div class="layui-container">
    <!--header-->
    <header><a class="back" href="javascript:history.back(-1)"><i class="iconfont icon-zuo-"></i></i></a><h4>新闻详情</h4>
    </header>
    <!--信息输入-->
    <div class="news-details">
        <div class="news-details-div1">
            <%--标题--%>
            <h4>${news.TITLE}</h4>
            <%--时间--%>
            <c:if test="${news.GMT_MODIFIED == ''}">
                <p><i class="iconfont icon-shijian3"></i>${news.GMT_CREATE}</p>
            </c:if>
            <c:if test="${news.GMT_MODIFIED != ''}">
                <p><i class="iconfont icon-shijian3"></i>${news.GMT_CREATE}</p>
            </c:if>
        </div>
        <%--内容--%>
        <div class="news-details-div2">
            <p>${news.CONTENT}</p>
        </div>
    </div>
</div>
<script src="static/front/layui/layui.all.js" type="text/javascript" charset="utf-8"></script>
<script src="static/front/js/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>


</body>
</html>
