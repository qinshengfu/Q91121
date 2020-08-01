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
<link rel="stylesheet" type="text/css" href="static/front/js/swiper/swiper.min.css"/>
<body>
<div class="layui-container">
    <!--轮播图-->
    <div class="swiper-container">
        <div class="swiper-wrapper">
            <c:forEach var="var" items="${chartList}">
                <div class="swiper-slide"><img src="${var.PIC_PATH}"/></div>
            </c:forEach>
        </div>
        <!-- 如果需要分页器 -->
        <div class="swiper-pagination"></div>
    </div>
    <!--账户信息 公告-->
    <div class="index-notice">
        <div class="index-notice-div1">账户信息
            <c:if test="${pd.USER_RANK == 0 }">
            <span class="layui-btn layui-btn-sm layui-btn-radius">普通会员</span>
            </c:if>
            <c:if test="${pd.USER_RANK == 1 }">
                <span class="layui-btn layui-btn-sm layui-btn-radius">高级经理</span>
            </c:if>
        </div>
        <!--公告-->
        <div class="index-notice-div2">
            <i class="iconfont icon-tongzhigonggao1"></i>
            <marquee behavior="" direction="">${newsList[0].TITLE}</marquee>
            <a href="front/to_news.do">更多</a>
        </div>
    </div>
    <!--申购、赎回-->
    <ul class="index-ul">
        <a href="front/to_apply.do">
            <li>申购SMD</li>
        </a>
        <a href="front/to_redeem.do">
            <li>赎回SMD</li>
        </a>
    </ul>
    <!--系统运行时间-->
    <div class="index-time">系统运行时间：<span id="showInterval"></span></div>
    <!--买入、卖出记录-->
    <div class="index-recode">
        <!--nav-->
        <ul class="index-recode-nav">
            <li class="index-recode-nav-active">买入记录</li>
            <li>卖出记录</li>
        </ul>
        <!--list-->
        <div class="index-recode-list-all">
            <!--买入记录-->
            <div class="index-recode-list">
                <c:forEach items="${buyList}" var="var">
                    <div class="index-recode-list-div">
                        <div>
                            <p>订单编号:${var.ORDER_NUMBER}</p>
                            <c:if test="${var.ORDER_TYPE == '1'}">
                            <p>金额:${var.NUMBER} (预付款)</p>
                            </c:if>
                            <c:if test="${var.ORDER_TYPE == '2'}">
                                <p>金额:${var.NUMBER} (尾款)</p>
                            </c:if>
                            <p>时间:${var.GMT_CREATE}</p>
                        </div>
                        <%--状态--%>
                        <div>
                            <c:if test="${var.PAYMENT_STATE == '5'}">
                            <button type="button" class="layui-btn-warm">等待匹配</button>
                            <button type="button" class="layui-btn-danger">等待中</button>
                            </c:if>
                            <c:if test="${var.PAYMENT_STATE == '4'}">
                                <button type="button" class="layui-btn-warm">等待收款</button>
                                <button type="button"  onclick="see_detail(0, ${var.PURCHASE_SMD_ID}, ${var.ORDER_TYPE})"  class="layui-btn-danger">查看</button>
                            </c:if>
                            <c:if test="${var.PAYMENT_STATE == '3'}">
                                <button type="button" class="layui-btn-warm">等待付款</button>
                                <button type="button"  onclick="see_detail(0, ${var.PURCHASE_SMD_ID}, ${var.ORDER_TYPE})"  class="layui-btn-danger">查看</button>
                            </c:if>
                            <c:if test="${var.PAYMENT_STATE == '2'}">
                                <button type="button" class="layui-btn-warm">撤单</button>
                                <button type="button"  onclick="see_detail(0, ${var.PURCHASE_SMD_ID}, ${var.ORDER_TYPE})"  class="layui-btn-danger">查看</button>
                            </c:if>
                            <c:if test="${var.PAYMENT_STATE == '6'}">
                                <button type="button" class="layui-btn layui-btn-sm layui-btn-radius">交易完成</button>
                                <button type="button"  onclick="see_detail(0, ${var.PURCHASE_SMD_ID}, ${var.ORDER_TYPE})"  class="layui-btn-danger">查看</button>
                            </c:if>
                            <c:if test="${var.PAYMENT_STATE == '0'}">
                                <button type="button" class="layui-btn layui-btn-sm layui-btn-radius">超时未打款</button>
                                <button type="button"  onclick="see_detail(0, ${var.PURCHASE_SMD_ID}, ${var.ORDER_TYPE})"  class="layui-btn-danger">查看</button>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <!--卖出记录-->
            <div class="index-recode-list" style="display: none;">
                <%--循环开始--%>
                    <c:forEach items="${sellList}" var="var">
                        <div class="index-recode-list-div">
                            <div>
                                <p>订单编号:${var.ORDER_NUMBER}</p>
                                <p>金额:${var.NUMBER}</p>
                                <p>时间:${var.GMT_CREATE}</p>
                                <c:if test="${var.PURSE_TYPE == 0}">
                                    <p>静态钱包</p>
                                </c:if>
                                <c:if test="${var.PURSE_TYPE == 1}">
                                    <p>动态钱包</p>
                                </c:if>
                            </div>
                            <div>
                                <c:if test="${var.RECEIVE_STATE == 0}">
                                    <button type="button" class="layui-btn-warm">未匹配</button>
                                </c:if>
                                <c:if test="${var.RECEIVE_STATE == 1}">
                                    <button type="button" class="layui-btn-warm">已匹配</button>
                                    <button type="button" onclick="see_detail(1, ${var.SELL_SMD_ID}, 0)" class="layui-btn-danger">查看</button>
                                </c:if>
                                <c:if test="${var.RECEIVE_STATE == 2}">
                                    <button type="button" class="layui-btn-warm">待收款</button>
                                    <button type="button" onclick="see_detail(1, ${var.SELL_SMD_ID}, 0)" class="layui-btn-danger">查看</button>
                                </c:if>
                                <c:if test="${var.RECEIVE_STATE == 3}">
                                    <button type="button" class="layui-btn-warm">已收款</button>
                                    <button type="button" onclick="see_detail(1, ${var.SELL_SMD_ID}, 0)" class="layui-btn-danger">查看</button>
                                </c:if>
                                <c:if test="${var.RECEIVE_STATE == 4}">
                                    <button type="button" class="layui-btn layui-btn-sm layui-btn-radius">交易完成</button>
                                    <button type="button" onclick="see_detail(1, ${var.SELL_SMD_ID}, 0)" class="layui-btn-danger">查看</button>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
            </div>
        </div>

    </div>
</div>

<!--footer-->
<footer>
    <a href="front/to_index.do" class="color-active">
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
    <a href="front/to_mine.do">
        <i class="iconfont icon-wode-hui"></i>
        <p>我的</p>
    </a>
</footer>
<script src="static/front/layui/layui.all.js" type="text/javascript" charset="utf-8"></script>
<script src="static/front/js/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
<script src="static/front/js/swiper/swiper.min.js" type="text/javascript" charset="utf-8"></script>
<script>
    //轮播图
    var mySwiper = new Swiper('.swiper-container', {
        direction: 'horizontal', // vertical垂直切换选项  //horizontal 横向
        loop: true, // 循环模式选项
        autoplay: true, //自动轮播
        // 如果需要分页器
        pagination: {
            el: '.swiper-pagination',
        },
    })

    $(function () {
        /*单机切换*/
        $(".index-recode-nav li").click(
            function () {
                /*每个li下属的div*/
                var divShow = $(".index-recode-list-all").children(".index-recode-list");
                /*利用selected进行判断*/
                if (!$(this).hasClass("jy-ul-active")) {
                    /*li标签的顺序和div的顺序是对应的，获取索引*/
                    var index = $(this).index();
                    /*当前对象设置class属性*/
                    $(this).addClass("index-recode-nav-active");
                    /*移除其他同级元素属性*/
                    $(this).siblings("li").removeClass("index-recode-nav-active");
                    /*展示当前li对应的div内容,利用方法显示和隐藏*/
                    $(divShow[index]).show();
                    /*隐藏同级元素*/
                    $(divShow[index]).siblings(".index-recode-list").hide();
                }
            }
        )
    })
</script>

<script type="text/javascript">

    // 查看订单详情
    function see_detail (tag, id, type) {
        if (tag === 0 ){
            window.location.href="front/toBuyDetail.do?TAG=" + tag + '&OrderId=' + id + '&ORDER_TYPE=' + type;
            return false;
        }
        if (tag === 1){
            window.location.href="front/toSellDetail.do?TAG=" + tag + '&OrderId=' + id + '&ORDER_TYPE=' + type;
        }

    }

    // 系统运行时间统计
    function show_date_time() {
        // 每隔一秒调用一次函数
        window.setTimeout("show_date_time()", 1000);
        // 开始时间
        var start_time = '${par.SYSTEM_START_TIME}';
        BirthDay = new Date(start_time);
        // 现在时间
        today = new Date();
        // 得到相差多少毫秒
        timeold = (today.getTime() - BirthDay.getTime());
        // 毫秒转换单位为 秒
        sectimeold = timeold / 1000;
        // 去掉小数，向下取整
        secondsold = Math.floor(sectimeold);
        msPerDay = 24 * 60 * 60 * 1000;
        // 计算相差多少天数
        e_daysold = timeold / msPerDay;
        daysold = Math.floor(e_daysold);
        // 计算相差多少小时
        e_hrsold = (e_daysold - daysold) * 24;
        hrsold = Math.floor(e_hrsold);
        // 计算相差多少分
        e_minsold = (e_hrsold - hrsold) * 60;
        minsold = Math.floor((e_hrsold - hrsold) * 60);
        // 计算相差多少秒
        seconds = Math.floor((e_minsold - minsold) * 60);
        // 根据ID 输出HTML文本
        showInterval.innerHTML = daysold + " 天 " + hrsold + " 小时 " + minsold + " 分 " + seconds + " 秒 ";
    }
    // 调用方法
    show_date_time();

</script>

</body>
</html>
