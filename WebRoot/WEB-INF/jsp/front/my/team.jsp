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
    <style>
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
            height: 80%;
        }
    </style>
</head>
<link rel="stylesheet" type="text/css" href="static/front/fonts/iconfont.css"/>
<link rel="stylesheet" type="text/css" href="static/front/layui/css/layui.css"/>
<link rel="stylesheet" type="text/css" href="static/front/css/style.css"/>

<body>
<div class="layui-container">
    <!--header-->
    <header>
        <a class="back" href="javascript:history.back(-1)"><i class="iconfont icon-zuo-"></i></i>
        </a>
        <h4>我的团队</h4></header>
    <!--信息-->
    <div class="team-top">
        <ul>
            <li>直推会员: <span>${reCount}</span></li>
            <li>团队人数: <span>${teamCount}</span></li>
        </ul>
    </div>
    <!--团队列表-->

    <div id="tree"> </div>

</div>
<script src="static/front/layui/layui.all.js" type="text/javascript" charset="utf-8"></script>
<script src="static/front/js/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
<%--组织架构图--%>
<script src="static/front/js/orgchart.js" type="text/javascript" charset="utf-8"></script>

</body>

<script>

    window.onload = function () {
        //接收后台传过来的集合
        //防止数字出错，用单引号括起来
        var nodes = [{
            id: '${user.ACCOUNT_ID}',
            昵称: '${user.NAME}',
            电话: '${user.PHONE}',
            img: "static/front/images/top.jpg"
        },
            <c:forEach var="item" items="${userList}" varStatus="s">
            {
                id: '${item.ACCOUNT_ID}',
                pid: '${item.RECOMMENDER_ID}',
                昵称: '${item.NAME}',
                电话: '${item.PHONE}',
                img: "static/front/images/sub.jpeg"
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

        // 树形图主方法
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

</html>