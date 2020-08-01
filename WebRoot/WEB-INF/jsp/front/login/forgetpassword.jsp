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
    <h4>找回密码</h4>
</header>

<div class="login-input">
    <div class="login-input-div">
        <input type="number" id="phone" oninput="if(value.length>11) value=value.slice(0,11)" placeholder="请输入手机号码"/>
    </div>
    <div class="login-input-div">
        <div class="login-input-div-1">
            <input type="text" class="yzmCode" placeholder="请输入短信验证码"/>
        </div>
        <button type="button" class="yanzm">获取验证码</button>
    </div>
    <div class="login-input-div">
        <input type="password" class="newPass" placeholder="请输入新密码"/>
    </div>
    <div class="login-input-div">
        <input type="password" class="confirm" placeholder="请确认新密码"/>
    </div>

</div>
<input type="submit" value="确认" class="btn"/>


<script src="static/front/js/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
<script src="static/front/layui/layui.all.js" type="text/javascript" charset="utf-8"></script>
<script src="static/js/md5.js" type="text/javascript" charset="utf-8"></script>

<script>

    // 参数验证,返回数组
    function parameterCalibration(tag) {
        // 获取手机号、新密码、确认密码、验证码
        var phone = $('#phone').val();
        var newPass = $('.newPass').val();
        var confirm = $('.confirm').val();
        var yzm = $('.yzmCode').val();
        // 存到数组中
        var record = [];
        record.push(phone);
        record.push(md5(newPass));
        record.push(md5(confirm));
        record.push(yzm);
        if (phone === '' || !isphone(phone)) {
            layer.tips('请输入正确手机号', '#phone', {
                tips: [1, '#3595CC'],
                time: 4000
            });
            return false;
        }
        if (tag === "1") {
            if (newPass === '') {
                layer.tips('请输入新密码', '.newPass', {
                    tips: [1, '#3595CC'],
                    time: 4000
                });
                return false;
            }
            if (newPass.length < 6) {
                layer.tips('密码最少6位数', '.newPass', {
                    tips: [1, '#3595CC'],
                    time: 4000
                });
                return false;
            }
            if (confirm === '') {
                layer.tips('请输入确认密码', '.confirm', {
                    tips: [1, '#3595CC'],
                    time: 4000
                });
                return false;
            }
            if (confirm.length < 6) {
                layer.tips('密码最少6位数', '.confirm', {
                    tips: [1, '#3595CC'],
                    time: 4000
                });
                return false;
            }
            if (record[1] !== record[2]) {
                layer.msg('密码不一致！');
                return false;
            }

            if (record[1] === '' || yzm.length < 3) {
                layer.tips('请输入正确验证码', '.yzm', {
                    tips: [1, '#3595CC'],
                    time: 4000
                });
                return false;
            }
        }
        return record;
    }

    // 点击确认修改后调用
    $('.btn').click(function () {
        var record = parameterCalibration("1");
        if (!record) {
            return false;
        }
        // 调用服务端校验
        server_verification(record);

    });

    // 服务端校验
    function server_verification(record) {
        $.ajax({
            url: "release/retrievePassword.do",
            type: "post",
            traditional: true, //传集合或者数组到后台service接收
            timeout: 10000, 	//超时时间设置为10秒；
            data: {record: record},
            success: function (data) { //回调函数
                if (data === "success") {
                    layer.open({
                        content: '修改成功！'
                        , btn: '确认'
                        , skin: 'footer'
                        , yes: function (index) {
                            window.location.href = "release/toLogin.do";
                        }
                    });
                    return false;
                }
                if (data === "1") {
                    layer.msg('不允许为空');
                    return false;
                }
                if (data === "2") {
                    layer.msg('密码不一致');
                    return false;
                }
                if (data === "3") {
                    layer.msg('验证码错误');
                    return false;
                }
                if (data === "4") {
                    layer.msg('手机号不符合！');
                    return false;
                }
                if (data === "5") {
                    layer.msg('验证码失效！请重新发送');
                    return false;
                }
            }
        })
    }

    // md5加密
    function md5(param) {
        return hex_md5(param);
    }

    // 获取短信验证码
    $('.yanzm').click(function () {
        var record = parameterCalibration(0);
        if (!record) {
            return false;
        }
        sendyzm($('.yanzm'), record)
    });

    //用ajax提交到后台的发送短信接口
    function sendyzm(obj, record) {
        $.post("release/sendPhoneSms.do", {PHONE:record[0]}, function (data) {
            if (data === "success") {
                layer.msg('验证码发送成功');
                setTime(obj);//开始倒计时
            } else {
                layer.open({
                    title: [
                        '验证码发送失败',
                        'background-color:#09C1FF; color:#fff;'
                    ],
                    content: '原因：【' + data + '】 请联系管理员！'
                    , btn: '确认'
                    , skin: 'footer'
                    , yes: function (index) {
                        layer.close(index);
                    }
                });
            }
        });
    }

    //60s倒计时实现逻辑
    var countdown = 60;

    function setTime(obj) {
        if (countdown === 0) {
            obj.prop('disabled', false);
            obj.text("点击获取验证码");
            countdown = 60;//60秒过后button上的文字初始化,计时器初始化;
            return;
        } else {
            obj.prop('disabled', true);
            obj.text("(" + countdown + "s)后重新发送");
            countdown--;
        }
        setTimeout(function () {
            setTime(obj)
        }, 1000) //每1000毫秒执行一次
    }

    //手机号格式校验
    function isphone(phone) {
        //RegExp 对象表示正则表达式，它是对字符串执行模式匹配的强大工具。
        return (new RegExp(/^1[3|4|5|6|7|8|9][0-9]{9}$/).test(phone));
    }


</script>

</body>
</html>
