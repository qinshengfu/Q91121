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
<link rel="stylesheet" type="text/css" href="static/front/css/login.css"/>
<link rel="stylesheet" type="text/css" href="static/front/fonts/iconfont.css"/>
<link rel="stylesheet" type="text/css" href="static/front/layui/css/layui.css"/>
<body>
<!--header-->
<header>
    <a class="back" href="javascript:history.back(-1)"><i class="iconfont icon-zuo-"></i></i>
    </a>
    <h4>注册新用户</h4>
</header>

<div class="login-input">
    <div class="login-input-div">
        <input type="number" id="Re_phone" oninput="if(value.length>11) value=value.slice(0,11)" placeholder="请输入推荐人"/>
    </div>
    <div class="login-input-div">
        <input type="number" id="phone" oninput="if(value.length>11) value=value.slice(0,11)" placeholder="请输入手机号"/>
    </div>
    <div class="login-input-div">
        <input type="password" oninput="if(value.length>6) value=value.slice(0,6)" id="login_password"
               placeholder="请输入登录密码（最少6位数）"/>
    </div>
    <div class="login-input-div">
        <input type="password" oninput="if(value.length>6) value=value.slice(0,6)" id="login_password1"
               placeholder="请确认登录密码"/>
    </div>
    <div class="login-input-div">
        <input type="password" oninput="if(value.length>6) value=value.slice(0,6)" id="transac_password"
               placeholder="请输入交易密码（最少6位数）"/>
    </div>
    <div class="login-input-div">
        <input type="password" oninput="if(value.length>6) value=value.slice(0,6)" id="transac_password1"
               placeholder="请确认交易密码"/>
    </div>
</div>
<input type="submit" value="确认注册" class="btn"/>


<script src="static/js/md5.js" type="text/javascript" charset="utf-8"></script>
<script src="static/js/jquery-3.4.1.js" type="text/javascript" charset="utf-8"></script>
<script src="static/front/layui/layui.all.js" type="text/javascript" charset="utf-8"></script>
</body>
<script type="text/javascript">

    $(function() {
        var tag = '${tag}';
        if (tag !== '') {
            $('#Re_phone').val(tag);
            // $('#Re_phone').attr('readonly','readonly');
        }
    });


    // 当注册按钮被点击后
    $(".btn").click(function register() {
        // 获取推荐人、手机号、密码、确认密码、交易密码、确认交易密码
        var re_phone = $("#Re_phone").val();
        var phone = $("#phone").val();
        var login_password = $("#login_password").val();
        var login_password1 = $("#login_password1").val();
        var transac_password = $("#transac_password").val();
        var transac_password1 = $("#transac_password1").val();
        if (re_phone === "" || !isphone(re_phone)) {
            layer.msg("请输入正确的推荐人~");
            return false;
        }
        if (phone === "" || !isphone(phone)) {
            layer.msg("请输入正确的手机号~");
            return false;
        }
        if (login_password === "") {
            layer.msg("请输入登录密码~");
            return false;
        }
        if (login_password1 === "") {
            layer.msg("请输入确认登录密码~");
            return false;
        }
        if (login_password.length < 6 || login_password1.length < 6) {
            layer.msg('密码最少6位数');
            return false;
        }
        if (login_password !== login_password1) {
            layer.msg("登录密码不一致~");
            return false;
        }
        if (transac_password === "") {
            layer.msg("请输入交易密码~");
            return false;
        }
        if (transac_password1 === "") {
            layer.msg("请输入交易密码~");
            return false;
        }
        if (transac_password.length < 6 || transac_password1.length < 6) {
            layer.msg('密码最少6位数');
            return false;
        }
        if (transac_password !== transac_password1) {
            layer.msg("交易密码不一致~");
            return false;
        }

        // 把数据封装到数组中
        var record = [];
        record.push(re_phone);
        record.push(phone);
        record.push(md5(login_password));
        record.push(md5(login_password1));
        record.push(md5(transac_password));
        record.push(md5(transac_password1));
        server_verification(record)
    });

    // 服务端校验
    function server_verification(record) {
        $.ajax({
            url: "release/register.do",
            type: "post",
            traditional: true, //传集合或者数组到后台service接收
            timeout: 10000, 	//超时时间设置为10秒；
            data: {record: record},
            success: function (data) { //回调函数
                if (data === "success") {
                    layer.open({
                        content: '注册成功'
                        , btn: '确认'
                        , skin: 'footer'
                        , yes: function (index) {
                            window.location.href = "release/toLogin";
                        }
                    });
                    return false;
                }
                if (data === "1") {
                    layer.open({
                        content: '不允许留空'
                        , btn: '确认'
                    });
                    return false;
                }
                if (data === "6") {
                    layer.open({
                        content: '推荐人不存在'
                        , btn: '确认'
                    });
                    return false;
                }
                if (data === "2") {
                    layer.open({
                        content: '手机号格式错误'
                        , btn: '确认'
                    });
                    return false;
                }
                if (data === "3") {
                    layer.open({
                        content: '该手机号已被注册请检查'
                        , btn: '确认'
                    });
                    return false;
                }
                if (data === "4") {
                    layer.open({
                        content: '登录密码不一致请检查'
                        , btn: '确认'
                    });
                    return false;
                }
                if (data === "5") {
                    layer.open({
                        content: '交易密码不一致请检查'
                        , btn: '确认'
                    });
                    return false;
                }
            }
        })
    }

    //手机号格式校验
    function isphone(phone) {
        //RegExp 对象表示正则表达式，它是对字符串执行模式匹配的强大工具。
        return (new RegExp(/^1[3|4|5|6|7|8|9][0-9]{9}$/).test(phone));
    }

    // md5加密
    function md5(param) {
        return hex_md5(param);
    }

</script>

</html>
