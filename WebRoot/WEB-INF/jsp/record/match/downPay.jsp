<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <meta charset="utf-8">
    <title>预付款匹配</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="Author" content="larry">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">

    <!-- 下拉框 -->
    <link rel="stylesheet" href="static/ace/css/chosen.css" />
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/index/top.jsp"%>
    <!-- 日期框 -->
    <link rel="stylesheet" href="static/ace/css/datepicker.css" />

    <link rel="stylesheet" type="text/css" href="static/front/layui/css/modules/laydate/default/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="static/front/css/admin.css"/>
    <link rel="stylesheet" type="text/css" href="static/front/css/base.css"/>
    <link rel="stylesheet" type="text/css" href="static/front/layui/css/layui.css" media="all"/>
</head>
<style>
    .match {
        margin-top: -20px;
        text-align: center;
    }

    #select-in {
        margin-right: 20px;
    }

    #select-out {
        margin-left: 20px;
    }

    #select-in,
    #select-out {
        font-size: 22px;
        color: #ff0000bf;
    }

    .layui-table-cell .layui-form-checkbox[lay-skin=primary], .layui-table-cell .layui-form-radio[lay-skin=primary]{top:0}

</style>

<body class="larryms-system no-skin" >

<form action="match/downPaymentsList.do" method="post" name="Form" id="Form">

<!--头部-->
<div class="layui-row larryms-panel">
    <div class="larryms-panel-heading layui-col-lg12 layui-col-md12 layui-col-sm12 layui-col-xs12">
        <span class="panel-tit">预付款匹配</span>
    </div>

    <div class="larryms-panel-heading layui-col-lg12 layui-col-md12 layui-col-sm12 layui-col-xs12 match">
        <blockquote class="layui-elem-quote quoteBox" id="">

                <div class="layui-input-inline" style="height: 27px;line-height: 27px;">
                    <b id="select-in">0</b>
                </div>
                <div class="layui-input-inline" style="width: 120px;">
                    <input type="number" name="money" id="money" class="layui-input searchVal layui-inline larry-input"
                           placeholder="输入匹配金额" autocomplete="off">
                </div>
                <button class="layui-btn larryms-search" id="match" onclick="makeAll()" type="button">开始匹配</button>
                <div class="layui-input-inline" style="height: 27px;line-height: 27px;">
                    <b id="select-out">0</b>
                </div>
        </blockquote>
    </div>
</div>

<!--左边-->
<div class="larryms-panel-body layui-col-lg6 layui-col-md6 layui-col-sm12 layui-col-xs12">
    <blockquote class="layui-elem-quote quoteBox">
    <b style="font-size: 18px;">进场列表（所有未匹配总额：${buyCount})</b>
    <hr class="layui-bg-green">
    </blockquote>

    <%--导航栏--%>
    <table style="margin-top:5px;">
        <tr>
            <td>
                <div class="nav-search">
                        <span class="input-icon">
                            <input type="text" placeholder="这里输入关键词" class="nav-search-input" id="nav-search-input" autocomplete="off" name="keywords1" value="${pd.keywords1 }" placeholder="这里输入关键词"/>
                            <i class="ace-icon fa fa-search nav-search-icon"></i>
                        </span>
                </div>
            </td>
            <td style="padding-left:2px;"><input class="span10 date-picker" name="lastStart1" id="lastStart1"  value="${pd.lastStart1 }" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期" title="开始日期"/></td>
            <td style="padding-left:2px;"><input class="span10 date-picker" name="lastEnd1" id="lastEnd1"  value="${pd.lastEnd1 }" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期" title="结束日期"/></td>
            <c:if test="${QX.cha == 1 }">
                <td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
            </c:if>
        </tr>
    </table>
    <!-- 检索  -->
    <table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">
        <thead>
        <tr>
            <th class="center" style="width:35px;">
                <label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
            </th>
            <th class="center" style="width:50px;">序号</th>
            <th class="center">会员账号</th>
            <th class="center">排单金额</th>
            <th class="center">余额</th>
            <th class="center">订单号</th>
            <th class="center">状态</th>
            <th class="center">打款类型</th>
            <th class="center">申请时间</th>
        </tr>
        </thead>

        <tbody>
        <!-- 开始循环 -->
        <c:choose>
            <c:when test="${not empty buyList}">
                <c:if test="${QX.cha == 1 }">
                    <c:forEach items="${buyList}" var="var" varStatus="vs">
                        <tr>
                            <td class='center'>
                                <label class="pos-rel"><input type='checkbox' name='ids' value="${var.PURCHASE_SMD_ID}" onclick="checkboxOnclick(this)" class="ace" /><span class="lbl"></span></label>
                            </td>
                            <td class='center' style="width: 30px;">${vs.index+1}</td>
                            <td class='center'>${var.PHONE}</td>
                            <td class='center'>${var.NUMBER}</td>
                            <td id="BA_${var.PURCHASE_SMD_ID}" class='center balance'>${var.BALANCE}</td>
                            <td class='center'>${var.ORDER_NUMBER}</td>
                            <c:if test="${var.PAYMENT_STATE == '0'}">
                            <td class='center'>预付款已付</td>
                            </c:if>
                            <c:if test="${var.PAYMENT_STATE == '2'}">
                                <td class='center'>撤单</td>
                            </c:if>
                            <c:if test="${var.PAYMENT_STATE == '3'}">
                                <td class='center'>待付款</td>
                            </c:if>
                            <c:if test="${var.PAYMENT_STATE == '4'}">
                                <td class='center'>待收款</td>
                            </c:if>
                            <c:if test="${var.PAYMENT_STATE == '5'}">
                                <td class='center'>待匹配</td>
                            </c:if>
                            <c:if test="${var.MODE_PAYMENT == '1'}">
                                <td class='center'>人民币</td>
                            </c:if>
                            <c:if test="${var.MODE_PAYMENT == '0'}">
                                <td class='center'>ETH</td>
                            </c:if>
                            <td class='center'>${var.GMT_CREATE}</td>
                        </tr>

                    </c:forEach>
                </c:if>
                <c:if test="${QX.cha == 0 }">
                    <tr>
                        <td colspan="100" class="center">您无权查看</td>
                    </tr>
                </c:if>
            </c:when>
            <c:otherwise>
                <tr class="main_info">
                    <td colspan="100" class="center" >没有相关数据</td>
                </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
    <%--分页栏--%>
    <div class="page-header position-relative">
        <table style="width:100%;">
            <tr>
                <td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
            </tr>
        </table>
    </div>

</div>

<!--右边-->
<div class="larryms-panel-body layui-col-lg6 layui-col-md6 layui-col-sm12 layui-col-xs12">
    <blockquote class="layui-elem-quote quoteBox" id="articleBtn">
        出场列表（所有未匹配总额：<b style="font-size: 18px;">${sellCount}</b>）
        <hr class="layui-bg-green">
    </blockquote>

    <%--导航栏--%>
    <table style="margin-top:5px;">
        <tr>
            <td>
                <div class="nav-search">
                        <span class="input-icon">
                            <input type="text" placeholder="这里输入关键词" class="nav-search-input" id="nav-search-input2" autocomplete="off" name="keywords2" value="${pd.keywords2 }" placeholder="这里输入关键词"/>
                            <i class="ace-icon fa fa-search nav-search-icon"></i>
                        </span>
                </div>
            </td>
            <td style="padding-left:2px;"><input class="span10 date-picker" name="lastStart2" id="lastStart2"  value="${pd.lastStart2 }" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期" title="开始日期"/></td>
            <td style="padding-left:2px;"><input class="span10 date-picker" name="lastEnd2" id="lastEnd2"  value="${pd.lastEnd2 }" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期" title="结束日期"/></td>
            <c:if test="${QX.cha == 1 }">
                <td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon1" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
            </c:if>
        </tr>
    </table>
    <!-- 检索  -->
    <table id="simple-table1" class="table table-striped table-bordered table-hover" style="margin-top:5px;">
        <thead>
        <tr>
            <th class="center" style="width:35px;">
                <label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox1" /><span class="lbl"></span></label>
            </th>
            <th class="center" style="width:50px;">序号</th>
            <th class="center">钱包类型</th>
            <th class="center">会员账号</th>
            <th class="center">金额</th>
            <th class="center">余额</th>
            <th class="center">订单号</th>
            <th class="center">收款类型</th>
            <th class="center">提现时间</th>
        </tr>
        </thead>

        <tbody>
        <!-- 开始循环 -->
        <c:choose>
            <c:when test="${not empty sellList}">
                <c:if test="${QX.cha == 1 }">
                    <c:forEach items="${sellList}" var="var" varStatus="vs">
                        <tr>
                            <td class='center'>
                                <label class="pos-rel"><input type='checkbox' name='ids1' value="${var.SELL_SMD_ID}" onclick="checkboxOnclick1(this)" class="ace" /><span class="lbl"></span></label>
                            </td>
                            <td class='center' style="width: 30px;">${vs.index+1}</td>
                            <c:if test="${var.PURSE_TYPE == '0'}">
                                <td class='center'>静态钱包</td>
                            </c:if>
                            <c:if test="${var.PURSE_TYPE == '1'}">
                                <td class='center'>动态钱包</td>
                            </c:if>
                            <td class='center'>${var.PHONE}</td>
                            <td class='center'>${var.NUMBER}</td>
                            <td id="BAL_${var.SELL_SMD_ID}" class='center'>${var.BALANCE}</td>
                            <td class='center'>${var.ORDER_NUMBER}</td>
                            <c:if test="${var.RECEIVE_TYPE == '1'}">
                                <td class='center'>人民币</td>
                            </c:if>
                            <c:if test="${var.RECEIVE_TYPE == '0'}">
                                <td class='center'>ETH</td>
                            </c:if>
                            <td class='center'>${var.GMT_CREATE}</td>
                        </tr>

                    </c:forEach>
                </c:if>
                <c:if test="${QX.cha == 0 }">
                    <tr>
                        <td colspan="100" class="center">您无权查看</td>
                    </tr>
                </c:if>
            </c:when>
            <c:otherwise>
                <tr class="main_info">
                    <td colspan="100" class="center" >没有相关数据</td>
                </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
    <%--分页栏--%>
    <div class="page-header position-relative">
        <table style="width:100%;">
            <tr>
                <td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
            </tr>
        </table>
    </div>
</div>

</form>
</body>

<!-- basic scripts -->
<!-- 页面底部js¨ -->
<%@ include file="../../system/index/foot.jsp" %>
<!-- 删除时确认窗口 -->
<script src="static/ace/js/bootbox.js"></script>
<!-- ace scripts -->
<script src="static/ace/js/ace/ace.js"></script>
<!-- 下拉框 -->
<script src="static/ace/js/chosen.jquery.js"></script>
<!-- 日期框 -->
<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>

<script src="static/front/layui/layui.all.js" type="text/javascript" charset="utf-8"></script>

<script>
    $(top.hangge());//关闭加载状态

    //检索
    function tosearch() {
        top.jzts();
        $("#Form").submit();
    }

    $(function () {
        //下拉框
        if (!ace.vars['touch']) {
            $('.chosen-select').chosen({allow_single_deselect: true});
            $(window)
                .off('resize.chosen')
                .on('resize.chosen', function () {
                    $('.chosen-select').each(function () {
                        var $this = $(this);
                        $this.next().css({'width': $this.parent().width()});
                    });
                }).trigger('resize.chosen');
            $(document).on('settings.ace.chosen', function (e, event_name, event_val) {
                if (event_name != 'sidebar_collapsed') return;
                $('.chosen-select').each(function () {
                    var $this = $(this);
                    $this.next().css({'width': $this.parent().width()});
                });
            });
            $('#chosen-multiple-style .btn').on('click', function (e) {
                var target = $(this).find('input[type=radio]');
                var which = parseInt(target.val());
                if (which == 2) $('#form-field-select-4').addClass('tag-input-style');
                else $('#form-field-select-4').removeClass('tag-input-style');
            });
        }

        //日期框
        $('.date-picker').datepicker({
            autoclose: true,
            todayHighlight: true
        });

        // 左边复选框全选控制
        var active_class = 'active';
        $('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function () {
            var th_checked = this.checked;//checkbox inside "TH" table header
            $(this).closest('table').find('tbody > tr').each(function () {
                var row = this;
                if (th_checked){
                    $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
                    $('#select-in').text(${buyCount1})
                    isMax()
                }  else {
                    $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
                    $('#select-in').text(0)
                    isMax()
                }

            });
        });
        // 右边复选框全选控制
        $('#simple-table1 > thead > tr > th input[type=checkbox]').eq(0).on('click', function () {
            var th_checked = this.checked;//checkbox inside "TH" table header
            $(this).closest('table').find('tbody > tr').each(function () {
                var row = this;
                if (th_checked){
                    $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
                    $('#select-out').text(${sellCount})
                    isMax()
                } else {
                    $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
                    $('#select-out').text(0)
                    isMax()
                }
            });
        });

    });

    // 监听左边那个复选框被选中
    function checkboxOnclick(checkbox) {
        var i = $(checkbox).val();
        // 获取被选中的余额
        var number = $('#BA_'+i).text();
        number = parseFloat(number);
        // 获取上面匹配数额
        var sum = $('#select-in').text();
        sum = parseFloat(sum);
        // 判断选中还是取消
        if (checkbox.checked) {
            // 计算数额
            sum += number;
            // 通过jq写上去
            $('#select-in').text(sum);
        } else {
            // 计算数额
            sum -= number;
            // 通过jq写上去
            $('#select-in').text(sum);
        }
        isMax()
    }

    // 监听右边边那个复选框被选中
    function checkboxOnclick1(checkbox) {
        var i = $(checkbox).val();
        // 获取被选中的余额
        var number = $('#BAL_'+i).text();
        number = parseFloat(number);
        // 获取上面匹配数额
        var sum = $('#select-out').text();
        sum = parseFloat(sum);
        // 判断选中还是取消
        if (checkbox.checked) {
            // 计算数额
            sum += number;
            // 通过jq写上去
            $('#select-out').text(sum);
        } else {
            // 计算数额
            sum -= number;
            // 通过jq写上去
            $('#select-out').text(sum);
        }
        isMax()
    }

    // 监听左右两边数额那个大就写入中间的匹配数额里
    function isMax() {
        // 获取左右两边的数额，并转为浮点型
        var L = $('#select-in').text();
        var R = $('#select-out').text();
        L = parseFloat(L);
        R = parseFloat(R);
        if (L >= R) {
            $('#money').val(R);
        } else {
            $('#money').val(L);
        }
    }

    // 获取左右两边是否选择了数据
    function makeAll(){
        bootbox.confirm('确认要匹配选中的订单吗？', function(result) {
            if(result) {
                var strLeft = '';
                var strRight = '';
                // 查找左边选中的数据，并根据【，】号分割
                for(var i=0;i < $('input[name = ids]').length;i++){
                    if($('input[name = ids]')[i].checked){
                        if(strLeft === '') {
                            strLeft += $('input[name = ids]')[i].value;
                        } else {
                            strLeft += ',' + $('input[name = ids]')[i].value;
                        }
                    }
                }
                // 查找右边选中的数据，并根据【，】号分割
                for(var j=0;j < $('input[name = ids1]').length;j++){
                    if($('input[name = ids1]')[j].checked){
                        if(strRight === '') {
                            strRight += $('input[name = ids1]')[j].value;
                        } else {
                            strRight += ',' + $('input[name = ids1]')[j].value;
                        }
                    }
                }
                if(strLeft === '' && strRight === ''){
                    bootbox.dialog({
                        message: "<span class='bigger-110'>您没有选择任何内容!</span>",
                        buttons:
                            { "button":{ "label":"确定", "className":"btn-sm btn-success"}}
                    });
                    $("#zcheckbox").tips({
                        side:1,
                        msg:'点这里全选',
                        bg:'#AE81FF',
                        time:8
                    });
                    $("#zcheckbox1").tips({
                        side:1,
                        msg:'点这里全选',
                        bg:'#AE81FF',
                        time:8
                    });
                    return;
                }
                if(strRight === ''){
                    bootbox.dialog({
                        message: "<span class='bigger-110'>您没有选择出场列表!</span>",
                        buttons:
                            { "button":{ "label":"确定", "className":"btn-sm btn-success"}}
                    });
                    $("#zcheckbox1").tips({
                        side:1,
                        msg:'点这里全选',
                        bg:'#AE81FF',
                        time:8
                    });
                    return;
                }
                if(strLeft === ''){
                    bootbox.dialog({
                        message: "<span class='bigger-110'>您没有选择进场列表!</span>",
                        buttons:
                            { "button":{ "label":"确定", "className":"btn-sm btn-success"}}
                    });
                    $("#zcheckbox").tips({
                        side:1,
                        msg:'点这里全选',
                        bg:'#AE81FF',
                        time:8
                    });
                    return;
                }
                // 匹配校验
                var money = ismoney();
                if (!money) {
                    return;
                }
                // 服务端校验
                server_verification(strLeft, strRight, money)
            }
        });
    }

    // 判断匹配金额是否符合,并且返回数额
    function ismoney() {
        // 获取左右两边的数额及要匹配的数额，并转为浮点型
        var L = $('#select-in').text();
        var R = $('#select-out').text();
        var money = $('#money').val();
        L = parseFloat(L);
        R = parseFloat(R);
        money = parseFloat(money);
        if (money <= 0) {
            $("#money").tips({
                side:1,
                msg:'请输入大于【 '+ 0 +' 】的数额',
                bg:'#AE81FF',
                time:8
            });
            return false;
        }
        if (L >= R && money <= R) {
            return money;
        }
        if (L < R && money <= L) {
            return money;
        }
        if (L >= R && money >= R) {
            $("#money").tips({
                side:1,
                msg:'最大可匹配【 '+ R +' 】',
                bg:'#AE81FF',
                time:8
            });
            return false;
        }
        if (L < R && money >= L) {
            $("#money").tips({
                side:1,
                msg:'最大可匹配【 '+ L +' 】',
                bg:'#AE81FF',
                time:8
            });
            return false;
        }

    }

    // 服务端校验
    function server_verification(Left, Right, money) {
        $.ajax({
            url: "match/startMatch.do",
            type: "post",
            data: {Left: Left, Right: Right, Money: money, tag : "1"},
            timeout: 10000, 	//超时时间设置为10秒；
            cache: false,
            success: function (data) { //回调函数
                if (data === "success") {
                    layer.confirm('匹配成功', {
                        btn: ['确认'] //按钮
                    }, function(){
                        location.reload();
                    });
                } else {
                    layer.confirm('原因：【' + data + '】', {
                        title: "匹配失败",
                        btn: ['确认'] //按钮
                    }, function(){
                        location.reload();
                    });
                }
            }
        })
    }

</script>

</html>