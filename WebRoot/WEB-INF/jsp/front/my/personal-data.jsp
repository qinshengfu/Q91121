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
        <a class="back" href="javascript:history.back(-1)"><i class="iconfont icon-zuo-"></i>
        </a>
        <h4>个人资料</h4></header>
    <!--信息输入-->
    <div class="layui-form data-bg">
        <ul>
            <li>
                <label>手机号</label>
                <input type="number" readonly value="${user.PHONE}"/>
            </li>
            <li>
                <label>真实姓名</label>
                <input type="text" id="name" value="${user.NAME}"/>
            </li>
            <li>
                <label>支付宝账号</label>
                <input type="text" id="altpay" value="${user.ALIPAY}"/>
            </li>
            <li>
                <label>银行名称</label>
                <input type="text" id="bankName" value="${user.BANK_NAME}"/>
            </li>
            <li>
                <label>银行卡号</label>
                <input type="number" id="bankNumber" oninput="if(value.length>20) value=value.slice(0,20)" value="${user.BANK_NUMBER}"/>
            </li>
            <li>
                <label>开户行地址</label>
                <input type="text" id="bankAdderss" value="${user.BANK_ADDRESS}"/>
            </li>
            <li>
                <label>ETH钱包地址</label>
                <input type="text" id="ETH" value="${user.ETH_ADDRESS}"/>
            </li>
        </ul>
    </div>

    <!--确认按钮-->
    <button type="button" class="btn">保存</button>
</div>
<script src="static/front/layui/layui.all.js" type="text/javascript" charset="utf-8"></script>
<script src="static/front/js/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
</body>

<script>

    // 参数验证,返回数组
    function parameterCalibration() {
        // 获取姓名、支付宝、银行名称、银行卡号、开户行地址、ETH钱包地址
        var name = $('#name').val();
        var altpay = $('#altpay').val();
        var bankName = $('#bankName').val();
        var bankNumber = $('#bankNumber').val();
        var bankAdderss = $('#bankAdderss').val();
        var ETH = $('#ETH').val();

        // 存到数组中
        var record = [];
        record.push(name);
        record.push(altpay);
        record.push(bankName);
        record.push(bankNumber);
        record.push(bankAdderss);
        record.push(ETH);
        if (name === '') {
            layer.tips('请输入真实姓名', '#name', {
                tips: [1, '#3595CC'],
                time: 4000
            });
            return false;
        }
        if (altpay === '') {
            layer.tips('请输入支付宝账号', '#altpay', {
                tips: [1, '#3595CC'],
                time: 4000
            });
            return false;
        }
        if (bankName === '') {
            layer.tips('请输入银行名称', '#bankName', {
                tips: [1, '#3595CC'],
                time: 4000
            });
            return false;
        }
        if (bankNumber === '' || !isBankNumber(bankNumber)) {
            layer.tips('请输入正确的银行卡号', '#bankNumber', {
                tips: [1, '#3595CC'],
                time: 4000
            });
            return false;
        }
        if (bankAdderss === '') {
            layer.tips('请输入开户行地址', '#bankAdderss', {
                tips: [1, '#3595CC'],
                time: 4000
            });
            return false;
        }
        if (ETH === '') {
            layer.tips('请输入ETF钱包地址', '#ETH', {
                tips: [1, '#3595CC'],
                time: 4000
            });
            return false;
        }
        return record;
    }

    // 点击确认修改后调用
    $('.btn').click(function () {
        var record = parameterCalibration();
        if (!record) {
            return false;
        }
        // 调用服务端校验
        server_verification(record);

    });

    // 服务端校验
    function server_verification(record) {
        $.ajax({
            url: "front/myInfo.do",
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
                            location.reload()
                        }
                    });
                    return false;
                } else {
                    layer.open({
                        title: [
                            '修改失败',
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

    // 银行卡号校验
    function isBankNumber(num) {
        var pattern = /^[0-9]{16,19}$/;
        return pattern.test(num)
    }

</script>


</html>