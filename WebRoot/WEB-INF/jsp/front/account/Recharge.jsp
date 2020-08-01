<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">

    <link rel="stylesheet" type="text/css" href="static/front/fonts/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="static/front/layui/css/layui.css"/>
    <link rel="stylesheet" type="text/css" href="static/front/css/style.css"/>
</head>
<body class="no-skin">
<div class="layui-container">
    <!--信息输入-->
    <div class="mess-bg">
        <div class="apply-div">
            <label>充值币种</label>
            <div class="layui-input-block">
                <select id="currency" name="currency" lay-verify="required">
                    <option value="DYNAMIC_WALLET">动态钱包</option>
                    <option value="STATIC_WALLET">静态钱包</option>
                    <option value="COUNT_BALANCE">算力账户</option>
                    <option value="TICKET">入场卷</option>
                </select>
            </div>
        </div>
        <div class="apply-div">
            <label>会员账号</label>
            <input type="number" id="phone" oninput="if(value.length>11) value=value.slice(0,11)" placeholder="这里输入会员账号"/>
        </div>
        <div class="apply-div">
            <label>充值数额</label>
            <input type="number" id="amount" placeholder="这里输入申请金额"/>
        </div>
        <div class="apply-div">
            <label>备注</label>
            <input type="text" id="remark" placeholder="这里输入备注"/>
        </div>

    </div>
    <!--确认按钮-->
    <button type="button" class="btn">确认</button>
</div>
<script src="static/front/layui/layui.all.js" type="text/javascript" charset="utf-8"></script>
<script src="static/front/js/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
<!-- 页面底部js¨ -->
<%@ include file="../../system/index/foot.jsp" %>


<script type="text/javascript">
    $(top.hangge());
</script>
<script>
    // 定义上次点击时间
    var lastClickTime;

    // 点击确认后
    $('.btn').click(function () {
        // 获取币种、账号、数额、备注
        var currency = $('#currency option:selected').val();
        var phone = $('#phone').val();
        var amount = $('#amount').val();
        var remark = $('#remark').val();
        if (phone === '') {
            layer.tips('请输入会员账号', '#phone', {
                tips: [1, '#3595CC'],
                time: 4000
            });
            return false;
        }
        if (amount === '') {
            layer.tips('请输入充值数额', '#amount', {
                tips: [1, '#3595CC'],
                time: 4000
            });
            return false;
        }
        // if (remark === '') {
        //     layer.tips('请输入备注', '#remark', {
        //         tips: [1, '#3595CC'],
        //         time: 4000
        //     });
        //     return false;
        // }
        // 存到数组中
        var record = [];
        record.push(currency);
        record.push(phone);
        record.push(amount);
        record.push(remark);
        if (isFastDoubleClick()) {
            return false;
        }
        server_verification(record)
    });

    // 服务端校验
    function server_verification(record) {
        $.ajax({
            url: "account/addMoney.do",
            type: "post",
            traditional: true, //传集合或者数组到后台service接收
            timeout: 10000, 	//超时时间设置为10秒；
            data: {record: record},
            success: function (data) { //回调函数
                if (data === "success") {
                    layer.confirm('充值成功', {
                        btn: ['确认'] //按钮
                    }, function(){
                        location.reload();
                    });
                } else {
                    layer.open({
                        title: [
                            '充值失败',
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