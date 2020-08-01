<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>

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
<body style="height:100%;">
<div class="layui-container">
    <!--header-->
    <header><a class="back" href="javascript:history.back(-1)"><i class="iconfont icon-zuo-"></i></i></a><h4>匹配列表</h4>
    </header>
    <!--信息输入-->
    <div class="jy-top">
        <p>订单号：${sell.ORDER_NUMBER}</p>
        <c:if test="${sell.RECEIVE_STATE == 1}">
            <p>状态：已匹配</p>
        </c:if>
        <c:if test="${sell.RECEIVE_STATE == 2}">
            <p>状态：待收款</p>
        </c:if>
        <c:if test="${sell.RECEIVE_STATE == 3}">
            <p>状态：已收款</p>
        </c:if>
        <c:if test="${sell.RECEIVE_STATE == 4}">
            <p>状态：交易完成</p>
        </c:if>
    </div>
    <%--循环开始--%>
    <C:forEach items="${match}" var="var" varStatus="vs">
        <div class="jy-list">
            <!--交易信息-->
            <ul class="jy-list-ul">
                <li>
                    <p>姓名：${var.NAME}</p>
                    <div><i class="iconfont icon-dianhua2"></i>${var.PHONE}</div>
                </li>
                <li>
                    <p>金额：${var.NUMBER}</p>
                    <div><i class="iconfont icon-youjiantou1"></i></div>
                    <span><i class="iconfont icon-shijian1"></i>${var.GMT_CREATE}</span>
                </li>
                <li>
                    <p>姓名：${user.NAME}</p>
                    <div><i class="iconfont icon-dianhua2"></i>${user.PHONE}</div>
                </li>

            </ul>
            <!--单号 状态-->
            <div class="jy-list-div1">
                <p>交易单号：${var.TRANSACTION_ORDER}</p>
                <div>订单状态：
                    <c:if test="${var.ORDER_STATE == 0}">
                        <button type="button" class="layui-btn  layui-btn-normal layui-btn-sm layui-btn-radius">待付款
                        </button>
                    </c:if>
                    <c:if test="${var.ORDER_STATE == 3}">
                        <button type="button" class="layui-btn  layui-btn-normal layui-btn-sm layui-btn-radius">已超时
                        </button>
                    </c:if>
                    <c:if test="${var.ORDER_STATE == 4}">
                        <button type="button" class="layui-btn layui-btn-sm layui-btn-radius">交易完成</button>
                    </c:if>
                    <c:if test="${var.ORDER_STATE == 2}">
                        <button type="button" class="layui-btn  layui-btn-normal layui-btn-sm layui-btn-radius">等待收款
                        </button>
                    </c:if>
                    <c:if test="${var.ORDER_STATE == 5}">
                        <button type="button" class="layui-btn  layui-btn-normal layui-btn-sm layui-btn-radius">等待收款,被投诉中
                        </button>
                    </c:if>
                    <c:if test="${var.ORDER_STATE == 7}">
                        <button type="button" class="layui-btn  layui-btn-normal layui-btn-sm layui-btn-radius">订单已回滚
                        </button>
                    </c:if>
                </div>
            </div>
            <!--剩余时间-->
            <c:if test="${var.ORDER_STATE == 0}">
                <!--剩余时间-->
                <div class="jy-list-div1 jy-list-div2">
                    <p><i class="iconfont icon-shijian"></i>剩余时间：</p>
                    <div><span id="endTime_${vs.index}">时间到</span></div>
                </div>
            </c:if>
            <!--确认收款-->
            <div class="jy-list-div3">
                <c:if test="${var.PIC_PATH != null }">
                    <img src="${var.PIC_PATH}" onclick="previewImg(this)"/>
                </c:if>
                <c:if test="${var.ORDER_STATE == 2}">
                    <div class="jy-list-div4">
                        <button type="button"
                                onclick="checking('${var.SMD_MATCH_ID}', '${var.BUY_ID}', '${var.SELL_ID}')"
                                class="layui-btn layui-btn-sm layui-btn-primary">确认收款
                        </button>
                        <button type="button" onclick="falseEvidence('${var.SMD_MATCH_ID}')" class="layui-btn layui-btn-sm layui-btn-danger">虚假凭证</button>
                    </div>
                </c:if>
            </div>
        </div>
    </C:forEach>
</div>
<script src="static/front/layui/layui.all.js" type="text/javascript" charset="utf-8"></script>
<script src="static/front/js/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
<script src="static/front/js/front.js" type="text/javascript" charset="utf-8"></script>

<script>

    $(function () {

        // 限N小时内打款
        var paymentTime = ${par.PAYMENT_TIME};
        <c:forEach items="${match}" var="var" varStatus="vs">
        <c:if test="${var.ORDER_STATE == 0}">
        // js写入付款倒计时
        var id = 'endTime_' + ${vs.index};
        var endDateStr = '${var.GMT_MODIFIED}';
        //结束时间
        var endDate = new Date(endDateStr);
        //当前时间
        var nowDate = new Date();
        if (endDate >= nowDate) {
            $('#' + id).text('时间到')
        } else {
            TimeDown(id, endDateStr, paymentTime);
        }
        </c:if>
        </c:forEach>

    });


    //显示大图片
    function previewImg(obj) {
        var img = new Image();
        img.src = obj.src;
        var imgHtml = "<img class='show' src='" + obj.src + "' />";
        //弹出层
        layer.open({
            type: 1,
            area: ['80%', 'auto'],
            shadeClose: true,//点击外围关闭弹窗
            title: "", //不显示标题
            closeBtn: 0,
            content: imgHtml, //捕获的元素，注意：最好该指定的元素要存放在body最外层，否则可能被其它的相对元素所影响
            cancel: function () {

            }
        });
    }

    // 当确认被点击时调用此方法，进行参数校验
    function checking(matchId, buyId, sellId) {
        // 传匹配订单ID、申购订单ID、赎回订单Id、
        console.log(matchId + "::::" + buyId + "::::" + sellId);

        // 校验通过，封装数组
        var record = [];
        record.push(matchId);
        record.push(buyId);
        record.push(sellId);
        layer.confirm('确定收到付款了吗？', {
            title: [
                '提示',
                'background-color:#09C1FF; color:#fff;'
            ],
            btn: ['确定', '取消'] //按钮
        }, function () {
            // 点击确认后回调
            server_verification(record)
        });
    }

    // 服务端校验
    function server_verification(record) {
        $.ajax({
            url: "front/sellConfirmReceipt.do",
            type: "post",
            traditional: true, //传集合或者数组到后台service接收
            timeout: 10000, 	//超时时间设置为10秒；
            data: {record: record},
            success: function (data) { //回调函数
                if (data === "success") {
                    layer.msg('交易成功！');
                    setTimeout(function () {
                        location.reload();
                    }, 800);
                    return false;
                } else {
                    layer.open({
                        title: [
                            '收款失败',
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


</script>

<script>

    // 当点击虚假凭证时调用
    function falseEvidence (id) {
        layer.confirm('确认要投诉对方吗？', {
            btn: ['确认', '取消'] //按钮
        }, function(){
            // 确认的调用
            server_verification1(id)

        }, function(){
            // 取消的调用
            layer.close()
        });

    }

    // 服务端校验
    function server_verification1(id) {
        $.ajax({
            url: "front/complain.do",
            type: "post",
            traditional: true, //传集合或者数组到后台service接收
            timeout: 10000, 	//超时时间设置为10秒；
            data: {orderId: id},
            success: function (data) { //回调函数
                if (data === "success") {
                    layer.msg('已投诉！等待后台处理');
                    setTimeout(function () {
                        location.reload();
                    }, 1000);
                }
            }
        })
    }

</script>

</body>
</html>
