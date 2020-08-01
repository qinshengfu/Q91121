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

<!--logo-->

<%--<img src="static/front/images/logo.png" alt="" class="logo"/>--%>
<p class="logo">MSD</p>

<div class="login-input">
    <div class="login-input-div">
        <i class="iconfont icon-shouji3"></i>
        <input type="number" oninput="if(value.length>11) value=value.slice(0,11)" id="phone" placeholder="请输入您的账号"/>
    </div>
    <div class="login-input-div">
        <i class="iconfont icon-mima11"></i>
        <input type="password" oninput="if(value.length>6) value=value.slice(0,6)" id="login_password"
               placeholder="请输入密码"/>
    </div>
    <div class="login-input-div">
        <div class="login-input-div-1">
            <i class="iconfont icon-yanzhengma2"></i>
            <input type="text" id="code" placeholder="验证码"/>
        </div>
        <img class="yanzm" id="codeImg" alt="点击更换" title="点击更换" src=""/>
    </div>
</div>
<input type="submit" value="登录" class="btn"/>
<div class="login-bot">
    <a href="release/toRegister.do">立即注册</a>
    <a href="release/forgetpassword.do">忘记密码?</a>
<%--    <div style="float:right;padding-right:10%;">
        <div style="float: left;margin-top:3px;margin-right:2px;">
            <font color="white">记住密码</font>
        </div>
        <div style="float: left;">
            <input name="form-field-checkbox" id="saveid" type="checkbox"
                   onclick="savePaw();" style="padding-top:0px;" />
        </div>
    </div>--%>
</div>

<script src="static/js/md5.js" type="text/javascript" charset="utf-8"></script>
<script src="static/front/js/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
<script src="static/front/layui/layui.all.js" type="text/javascript" charset="utf-8"></script>
<script src="static/js/jquery.cookie.js" type="text/javascript" charset="utf-8"></script>

</body>

<script type="text/javascript">

    // 页面加载就执行
    $(function () {
        changeCode1();
        //点击后跟换验证码
        $("#codeImg").bind("click", changeCode1);
        $('#phone').focus();
    });


    //客户端校验
    $('.btn').click(function () {
        var phone = $('#phone').val();
        var login_password = $('#login_password').val();
        var code = $('#code').val();

        if (phone === "" || !isphone(phone)) {
            layer.tips('请输入正确的手机号', '#phone', {
                tips: [1, '#3595CC'],
                time: 4000
            });
            return false;
        }
        if (login_password === "") {
            layer.tips('请输入登录密码', '#login_password', {
                tips: [1, '#3595CC'],
                time: 4000
            });
            return false;
        }
        if (login_password.length < 6) {
            layer.tips('密码最少6位数', '#login_password', {
                tips: [1, '#3595CC'],
                time: 4000
            });
            return false;
        }
        /*if (code === "" || code.length < 4) {
            layer.tips('请输入正确的验证码', '#code', {
                tips: [1, '#3595CC'],
                time: 4000
            });
            return false;
        }*/
        // 把数据封装到数组中
        var record = [];
        record.push(phone);
        record.push(md5(login_password));
        record.push(code);
        server_verification(record)

    });

    // 服务端校验
    function server_verification(record) {
        $.ajax({
            url: "release/login.do",
            type: "post",
            traditional: true, //传集合或者数组到后台service接收
            timeout: 10000, 	//超时时间设置为10秒；
            data: {record: record},
            success: function (data) { //回调函数
                if (data === "success") {
                    layer.msg('登录成功');
                    window.location.href = "front/to_index.do";
                    return false;
                }
                if (data === "1") {
                    layer.open({
                        content: '不允许留空'
                        , btn: '确认'
                    });
                    return false;
                }
                if (data === "2") {
                    layer.tips('手机号格式错误', '#phone', {
                        tips: [1, '#3595CC'],
                        time: 4000
                    });
                    return false;
                }
                if (data === "3") {
                    layer.tips('账号未注册！请检查', '#phone', {
                        tips: [1, '#3595CC'],
                        time: 4000
                    });
                    return false;
                }
                if (data === "6") {
                    layer.tips('账号已冻结', '#phone', {
                        tips: [1, '#3595CC'],
                        time: 4000
                    });
                    return false;
                }
                if (data === "4") {
                    layer.tips('登录密码错误', '#login_password', {
                        tips: [1, '#3595CC'],
                        time: 4000
                    });
                    return false;
                }
                if (data === "5") {
                    layer.tips('验证码错误', '#code', {
                        tips: [1, '#3595CC'],
                        time: 4000
                    });
                    changeCode1();
                    return false;
                }

            }
        })
    }


    // md5加密
    function md5(param) {
        return hex_md5(param);
    }


    //手机号格式校验
    function isphone(phone) {
        //RegExp 对象表示正则表达式，它是对字符串执行模式匹配的强大工具。
        return (new RegExp(/^1[3|4|5|6|7|8|9][0-9]{9}$/).test(phone));
    }

    //获取时间戳
    function genTimestamp() {
        var time = new Date();
        return time.getTime();
    }

    //后台生成的验证码
    function changeCode1() {
        $("#codeImg").attr("src", "code.do?t=" + genTimestamp());
    }

</script>

<%--<script type="text/javascript">

    // 点击记住密码时调用
    function savePaw() {
        if (!$("#saveid").attr("checked")) {
            $.cookie('loginname', '', {
                expires : -1
            });
            $.cookie('password', '', {
                expires : -1
            });
            $("#phone").val('');
            $("#login_password").val('');
        }
    }

    // 存入cookie
    function saveCookie() {
        if ($("#saveid").attr("checked")) {
            $.cookie('loginname', $("#phone").val(), {
                expires : 7
            });
            $.cookie('password',$("#login_password").val() , {
                expires : 7
            });
        }
    }

    // 页面加载就执行
    $(function () {

         // 记住密码功能
         var loginname = $.cookie('loginname');
         var password = $.cookie('password');
         if (typeof(loginname) != "undefined"
             && typeof(password) != "undefined") {
             $("#phone").val(loginname);
             $("#login_password").val(password);
             $("#saveid").attr("checked", true);
             $("#code").focus();
         } else {
             $("#phone").focus();
         }

    });

</script>--%>

</html>
