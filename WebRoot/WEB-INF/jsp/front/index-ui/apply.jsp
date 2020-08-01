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
    <header><a class="back" href="javascript:history.back(-1)"><i class="iconfont icon-zuo-"></i></i></a><h4>申购SMD</h4>
    </header>
    <!--信息输入-->
    <div class="mess-bg">
        <div class="apply-div">
            <label>可申请区间</label>
            <input type="text" disabled value="${par.PAY_MIN}≈${par.PAY_MAX}"/>
        </div>
        <div class="apply-div">
            <label>申请金额</label>
            <input type="number" id="number" placeholder="申请金额"/>
        </div>
        <div class="apply-div">
            <label>交易密码</label>
            <input type="password" id="pass" placeholder="交易密码"/>
        </div>
        <div class="apply-div">
            <label>利息周期</label>
            <div class="layui-input-block">
                <select id="cycle" name="city" lay-verify="required">
                    <option value="${par.INTEREST_CYCLE1}">${par.INTEREST_CYCLE1} 天 / ${par.INTEREST_7} %</option>
                    <option value="${par.INTEREST_CYCLE2}">${par.INTEREST_CYCLE2} 天 / ${par.INTEREST_15} %</option>
                    <option value="${par.INTEREST_CYCLE3}">${par.INTEREST_CYCLE3} 天 / ${par.INTEREST_30} %</option>
                </select>
            </div>
        </div>
        <div class="apply-div">
            <label>打款方式</label>
            <div class="layui-input-block">
                <select id="mode" name="city" lay-verify="required">
                    <option value="1">人民币</option>
                    <option value="0">ETH</option>
                </select>
            </div>
        </div>
    </div>
    <!--确认按钮-->
    <button type="button" class="btn">确认</button>
</div>
<script src="static/front/layui/layui.all.js" type="text/javascript" charset="utf-8"></script>
<script src="static/front/js/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
<script src="static/js/md5.js" type="text/javascript" charset="utf-8"></script>

<script>
    // 定义上次点击时间
    var lastClickTime;

    // 最低、最高金额、倍数
    var min = ${par.PAY_MIN};
    var max = ${par.PAY_MAX};
    var multiple = ${par.PAY_MULTIPLE};

    // 点击确认后
    $('.btn').click(function () {
        // 获取数额、密码、利息周期、打款方式
        var number = $('#number').val();
        var pass = $('#pass').val();
        var cycle = $('#cycle option:selected').val();
        var payMode = $('#mode option:selected').val();
        var lock = isAmount(number);
        if (!lock) {
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
        record.push(number);
        record.push(md5(pass));
        record.push(cycle);
        record.push(payMode);
        if (isFastDoubleClick()) {
            return false;
        }
        server_verification(record)
    });

    // 服务端校验
    function server_verification(record) {
        $.ajax({
            url: "front/buySmd.do",
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

    // 金额校验
    function isAmount(num) {
        if (num === '') {
            layer.tips('请输入申请数额', '#number', {
                tips: [1, '#3595CC'],
                time: 4000
            });
            return false;
        }
        if (num < min) {
            layer.tips("最少申请【" + min + "】的数额", '#number', {
                tips: [1, '#3595CC'],
                time: 4000
            });
            return false;
        }
        if (num > max) {
            layer.tips("最多申请【" + max + "】的数额", '#number', {
                tips: [1, '#3595CC'],
                time: 4000
            });
            return false;
        }
        if (num % multiple !== 0) {
            layer.tips("只能申请【" + multiple + "】的倍数", '#number', {
                tips: [1, '#3595CC'],
                time: 4000
            });
            return false
        }
        return true;
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
