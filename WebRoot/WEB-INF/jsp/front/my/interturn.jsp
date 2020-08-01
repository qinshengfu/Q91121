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
<style>
    .layui-input {
        width: 60%;
    }
</style>
<body>
<div class="layui-container">
    <!--header-->
    <header>
        <a class="back" href="javascript:history.back(-1)"><i class="iconfont icon-zuo-"></i></i>
        </a>
        <h4>会员互转</h4></header>
    <!--信息输入-->
    <div class="mess-bg">
        <div class="apply-div">
            <label>对方账户</label>
            <input type="number" oninput="if(value.length>11) value=value.slice(0,11)"  id="phone" placeholder="对方账户"/>
        </div>
        <div class="apply-div">
            <label>转账数额</label>
            <input type="number" id="number" placeholder="转账数额"/>
        </div>
        <div class="apply-div">
            <label>交易密码</label>
            <input type="password" id="pass" placeholder="交易密码"/>
        </div>
    </div>
    <!--确认按钮-->
    <button type="button" class="btn">确认</button>
</div>
<script src="static/front/layui/layui.all.js" type="text/javascript" charset="utf-8"></script>
<script src="static/front/js/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
<script src="static/js/md5.js" type="text/javascript" charset="utf-8"></script>

<script>
    // 定义上传点击时间
    var lastClickTime;

    // 点击确认后
    $('.btn').click(function () {
        // 获取对方账号、数额、交易密码
        var phone = $('#phone').val();
        var number = $('#number').val();
        var pass = $('#pass').val();
        if (!isphone(phone)) {
            layer.tips('请输入确认手机号', '#phone', {
                tips: [1, '#3595CC'],
                time: 4000
            });
            return false;
        }
        if (number === '') {
            layer.tips('请输入【入场券数额】', '#number', {
                tips: [1, '#3595CC'],
                time: 4000
            });
            return false;
        }
        if (!isAmount(number)) {
            layer.tips('请输入大于0的正整数', '#number', {
                tips: [1, '#3595CC'],
                time: 4000
            });
            return false;
        }
        if (pass === '') {
            layer.tips('请输入交易密码', '#pass', {
                tips: [1, '#3595CC'],
                time: 4000
            });
            return false;
        }
        if (pass.length < 6) {
            layer.tips('密码最少6位数', '#pass', {
                tips: [1, '#3595CC'],
                time: 4000
            });
            return false;
        }
        // 存到数组中
        var record = [];
        record.push(phone);
        record.push(number);
        record.push(md5(pass));
        if (isFastDoubleClick()) {
            return false;
        }
        server_verification(record)
    });

    // 服务端校验
    function server_verification(record) {
        $.ajax({
            url: "front/transfer.do",
            type: "post",
            traditional: true, //传集合或者数组到后台service接收
            timeout: 10000, 	//超时时间设置为10秒；
            data: {record: record},
            success: function (data) { //回调函数
                if (data === "success") {
                    layer.msg('转账成功');
                    setTimeout(function () {
                        location.reload();
                    }, 1000);
                    return false;
                } else {
                    layer.confirm('原因：【' + data + '】', {
                        title: "转账失败",
                        btn: ['确认'] //按钮
                    }, function(index){
                        layer.close(index)
                    });
                }
            }
        })
    }

    // 正整数格式校验
    function isAmount(num) {
        //RegExp 对象表示正则表达式，它是对字符串执行模式匹配的强大工具。
        return (new RegExp(/^\+?[1-9][0-9]*$/).test(num));
    }

    // 手机号格式校验
    function isphone(phone) {
        //RegExp 对象表示正则表达式，它是对字符串执行模式匹配的强大工具。
        return (new RegExp(/^1[3|4|5|6|7|8|9][0-9]{9}$/).test(phone));
    }

    // md5加密
    function md5(param) {
        return hex_md5(param);
    }

    // 快速点击校验
    function isFastDoubleClick() {
        var time = new Date().getTime();
        var timeD = time - lastClickTime;
        if (0 < time && timeD < 2000) {
            return true;
        }
        lastClickTime = time;
        return false;
    }
</script>
</body>

</html>