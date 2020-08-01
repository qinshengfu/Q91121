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
    <!--头像-->
    <div class="mine-toux">
        <img src="static/front/images/toux.png" alt=""/>
        <div>${user.NAME}</div>
    </div>
    <!--钱包-->
    <ul class="mine-packet">
        <li>
            <p>静态钱包</p>
            <p>${user.STATIC_WALLET}</p>
        </li>
        <li>
            <p>动态钱包</p>
            <p>${user.DYNAMIC_WALLET}</p>
        </li>
        <li>
            <p>算力</p>
            <p>${user.COUNT_BALANCE}</p>
        </li>
        <li>
            <p>入场券</p>
            <p>${user.TICKET}</p>
        </li>
    </ul>
    <!--九宫格-->
    <ol class="mine-grid">
        <a href="front/to_personalData.do">
            <li><i class="iconfont icon-gerenziliao1"></i>
                <p>个人资料</p></li>
        </a>
        <a href="release/toRegister.do?tag=${user.PHONE}">
            <li><i class="iconfont icon-huiyuan1"></i>
                <p>添加会员</p></li>
        </a>
        <a href="front/to_team.do">
            <li><i class="iconfont icon-tuandui_keshi"></i>
                <p>我的团队</p></li>
        </a>
        <a href="front/to_frozen.do">
            <li><i class="iconfont icon-dongjie2"></i>
                <p>冻结明细</p></li>
        </a>
        <a href="front/to_profit.do">
            <li><i class="iconfont icon-shouzhimingxicaifuhongbaoyue1"></i>
                <p>收益明细</p></li>
        </a>
        <a href="front/to_interturn.do">
            <li><i class="iconfont icon-zhuanzhang1"></i>
                <p>会员互转</p></li>
        </a>
        <a href="front/to_changedPassword.do">
            <li><i class="iconfont icon-xiugaimima4"></i>
                <p>密码修改</p></li>
        </a>
        <a href="front/to_qrcode.do">
            <li><i class="iconfont icon-erweima1"></i>
                <p>推广二维码</p></li>
        </a>
        <a onclick="outLogin()">
            <li><i class="iconfont icon-tuichu14"></i>
                <p>安全退出</p></li>
        </a>
        <%--<span onclick="add()">
            <li><i class="iconfont icon-tuichu15"></i>
                <p>添加定时任务</p></li>
        </span>
        <span onclick="rem()">
            <li><i class="iconfont icon-xiugaimima3"></i>
                <p>移除定时任务</p></li>
        </span>--%>
    </ol>
</div>
<!--footer-->
<footer>
    <a href="front/to_index.do">
        <i class="iconfont icon-shouye1"></i>
        <p>首页</p>
    </a>
    <a href="javascript:layer.msg('开发中...')">
        <i class="iconfont icon-jinbi2"></i>
        <p>算力</p>
    </a>
    <a href="javascript:layer.msg('开发中...')">
        <i class="iconfont icon-shouye4"></i>
        <p>商城广告</p>
    </a>
    <a href="front/to_mine.do" class="color-active">
        <i class="iconfont icon-wode-hui"></i>
        <p>我的</p>
    </a>
</footer>
<script src="static/front/layui/layui.all.js" type="text/javascript" charset="utf-8"></script>
<script src="static/front/js/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
</body>


<script type="text/javascript">

    // 退出登录
    function outLogin() {
        //询问框
        layer.open({
            content: '您确定要退出吗？'
            , btn: ['确认', '取消']
            , yes: function (index) {
                $.get('front/outLogin.do', function (data) {
                    if ("success" === data) {
                        // 询问框
                        layer.open({
                            content: '已安全退出！'
                            , btn: ['确认']
                            , yes: function (index) {
                                window.location.href = 'release/toLogin.do';
                                layer.close(index);
                            }
                        });
                    }
                });
            }
        });

    }

    function add () {
        $.get('front/addscheduledtask.do', function(data) {
            layer.msg('添加')
            if (data === "success") {
                layer.msg('定时任务添加成功！')
            }
        })
    }

    function rem () {
        $.get('front/removescheduledtasks.do', function(data) {
            layer.msg('移除')
            if (data === "success") {
                layer.msg('定时任务移除成功！')
            }
        })
    }


</script>


</html>
