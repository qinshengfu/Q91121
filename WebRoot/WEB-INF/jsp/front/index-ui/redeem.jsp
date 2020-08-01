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
    <header>
        <a class="back" href="javascript:history.back(-1)"><i class="iconfont icon-zuo-"></i></i>
        </a>
        <h4>赎回SMD</h4></header>
    <!--信息输入-->
    <form class="layui-form" action="">
        <div class="mess-bg">
            <div class="apply-div">
                <label>申请类型</label>
                <div class="layui-input-block">
                    <select name="city" id="type" lay-verify="required">
                        <option value="0">静态钱包(余额: ${user.STATIC_WALLET})</option>
                        <option value="1">动态钱包(余额: ${user.DYNAMIC_WALLET})</option>
                    </select>
                </div>
            </div>
            <div class="apply-div">
                <label>申请金额</label>
                <input type="number" oninput="if(value.length>20) value=value.slice(0,20)" id="number"
                       placeholder="申请金额"/>
            </div>
            <div class="apply-div">
                <label>交易密码</label>
                <input type="password" oninput="if(value.length>20) value=value.slice(0,20)" id="password"
                       placeholder="交易密码"/>
            </div>
            <div class="apply-div">
                <label>收款方式</label>
                <div class="layui-input-block">
                    <select name="city" id="receiveType" lay-verify="required">
                        <option value="1">人民币</option>
                        <option value="0">ETH</option>
                    </select>
                </div>
            </div>
        </div>
    </form>
    <!--确认按钮-->
    <button type="button" class="btn">确认</button>
</div>
<script src="static/front/layui/layui.all.js" type="text/javascript" charset="utf-8"></script>
<script src="static/front/js/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
<script src="static/js/md5.js" type="text/javascript" charset="utf-8"></script>

</body>


<script type="text/javascript">
    // 定义上传点击时间
    var lastClickTime;

    // 获取动、静态钱包余额、今日提现次数
    var dynamicWallet = ${user.DYNAMIC_WALLET};
    var staticWallet = ${user.STATIC_WALLET};
    var cashCount = ${user.IS_WITHDRAW};
    // 获取动、静态钱包提现额度及倍数，每天可提现次数
    var dynamicCash = ${par.DYNAMIC_WALLET};
    var staticCash = ${par.STATIC_WALLET};
    var multiple = ${par.CASH_MULTIPLIER};
    var withdrawToday = ${par.WITHDRAW_TODAY};


    // 参数验证,返回数组
    function parameterCalibration() {
        // 获取钱包类型、金额、交易密码、收款方式
        var type = $('#type option:selected').val();
        var number = $('#number').val();
        var password = $('#password').val();
        var receiveType = $('#receiveType').val();
        // 存到数组中
        var record = [];
        record.push(type);
        record.push(number);
        record.push(md5(password));
        record.push(receiveType);
        // 如果今天提现次数 少于 可提现次数
        if (cashCount < withdrawToday) {
            if (number === '') {
                layer.tips('请输入申请金额', '#number', {
                    tips: [1, '#3595CC'],
                    time: 4000
                });
                return false;
            }
            if (number < 0) {
                layer.tips('请输入大于 0 的数额', '#number', {
                    tips: [1, '#3595CC'],
                    time: 4000
                });
                return false;
            }
            if (number % multiple !== 0) {
                layer.tips('只能申请【' + multiple + '】的倍数', '#number', {
                    tips: [1, '#3595CC'],
                    time: 4000
                });
                return false;
            }
            if (type === '0') {
                if (number > staticCash && number < staticWallet) {
                    layer.tips('静态钱包每次最大可申请 ' + staticCash, '#number', {
                        tips: [1, '#3595CC'],
                        time: 4000
                    });
                    return false;
                }
                if (number > 0 && staticWallet < number) {
                    layer.tips('静态钱包余额不足', '#number', {
                        tips: [1, '#3595CC'],
                        time: 4000
                    });
                    return false;
                }
            }
            if (type === '1') {
                if (number > dynamicCash && number < dynamicWallet) {
                    layer.tips('动态钱包最大可申请 ' + dynamicCash, '#number', {
                        tips: [1, '#3595CC'],
                        time: 4000
                    });
                    return false;
                }
                if (number > 0 && dynamicWallet < number) {
                    layer.tips('动态态钱包余额不足', '#number', {
                        tips: [1, '#3595CC'],
                        time: 4000
                    });
                    return false;
                }
            }
            if (password === '') {
                layer.tips('请输入交易密码', '#number', {
                    tips: [1, '#3595CC'],
                    time: 4000
                });
                return false;
            }
        } else {
            layer.msg('今天提现已上限！');
            return false;
        }
        return record;
    }


    // 点击确认后
    $('.btn').click(function () {
        var record = parameterCalibration();
        if (!record) {
            return false;
        }
        if (isFastDoubleClick()) {
            return false;
        }
        server_verification(record)

    });

    // 服务端校验
    function server_verification(record) {
        $.ajax({
            url: "front/redeemSMD.do",
            type: "post",
            traditional: true, //传集合或者数组到后台service接收
            timeout: 10000, 	//超时时间设置为10秒；
            data: {record: record},
            success: function (data) { //回调函数
                if (data === "success") {
                    layer.msg('申请成功');
                    setTimeout(function () {
                        location.reload();
                    }, 1000);
                    return false;
                } else {
                    layer.open({
                        title: [
                            '申请失败',
                            'background-color:#09C1FF; color:#fff;'
                        ],
                        content: '原因：【' + data + '】'
                        , btn: '确认'
                        , skin: 'footer'
                        , yes: function (index) {
                            layer.close(index);
                        }
                    });
                }
            }
        })
    }

    // md5加密
    function md5(param) {
        return hex_md5(param);
    }

    // 快速点击校验
    function isFastDoubleClick() {
        var time = new Date().getTime();
        var timeD = time - lastClickTime;
        if (0 < time && timeD < 3000) {
            return true;
        }
        lastClickTime = time;
        return false;
    }

</script>


</html>