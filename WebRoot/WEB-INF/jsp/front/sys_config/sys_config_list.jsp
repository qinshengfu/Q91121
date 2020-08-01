<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <!-- 下拉框 -->
    <link rel="stylesheet" href="static/ace/css/chosen.css"/>
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/index/top.jsp" %>
    <!-- 日期框 -->
    <link rel="stylesheet" href="static/ace/css/datepicker.css"/>
</head>
<body class="no-skin">

<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
    <!-- /section:basics/sidebar -->
    <div class="main-content">
        <div class="main-content-inner">
            <div class="page-content">
                <div class="row">
                    <div class="col-xs-12">

                        <!-- 检索  -->
                        <form action="sys_config/list.do" method="post" name="Form" id="Form">
                            <table class="table table-striped table-bordered table-hover">

                                <c:if test="${QX.cha == 1 }">

                                <th style="width: 10%; text-align: left; padding-top: 13px;">基础设置：</th>

                                <tr>
                                    <td>1、客服微信：
                                        <input type="text" name="QQ" id="QQ" value="${pd.QQ}" style="width: 15%;"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>2、客服QQ：
                                        <input type="text" name="WECHAT" id="WECHAT" value="${pd.WECHAT}"
                                               style="width: 15%;"/>
                                    </td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <th class='center'>系统开始运行时间：</th>
                                    <td><input class="span10 date-picker" name="SYSTEM_START_TIME"
                                               id="SYSTEM_START_TIME" value="${pd.SYSTEM_START_TIME}" type="text"
                                               data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="系统开始运行时间"
                                               title="系统开始运行时间" style="width:98%;"/></td>
                                </tr>
                            </table>
                            <br>
                            <table class="table table-striped table-bordered table-hover">
                                <tr>
                                    <th class='center'>每天提现次数：</th>
                                    <td><input class="forminput" type="number" name="WITHDRAW_TODAY" id="WITHDRAW_TODAY"
                                               value="${pd.WITHDRAW_TODAY}" maxlength="32"
                                               placeholder="请输入每天提现次数" style="width:50%;"/> 次
                                    </td>
                                    <th class='center'>提现倍数：</th>
                                    <td><input class="forminput" type="number" name="CASH_MULTIPLIER"
                                               id="CASH_MULTIPLIER"
                                               value="${pd.CASH_MULTIPLIER}" maxlength="32"
                                               placeholder="请输入提现倍数" style="width:50%;"/> 次
                                    </td>
                                    <th class='center'>静态钱包提现额度：</th>
                                    <td><input class="forminput" type="number" name="STATIC_WALLET"
                                               id="STATIC_WALLET"
                                               value="${pd.STATIC_WALLET}" maxlength="32"
                                               placeholder="请输入静态钱包提现额度" style="width:98%;"/></td>
                                    <th class='center'>动态钱包提现额度：</th>
                                    <td><input class="forminput" type="number" name="DYNAMIC_WALLET" id="DYNAMIC_WALLET"
                                               value="${pd.DYNAMIC_WALLET}" maxlength="32"
                                               placeholder="请输入动态钱包提现额度" style="width:98%;"/></td>
                                </tr>

                                <tr>
                                    <th class='center'>打款倍数：</th>
                                    <td><input class="forminput" type="number" name="PAY_MULTIPLE"
                                               id="PAY_MULTIPLE"
                                               value="${pd.PAY_MULTIPLE}" maxlength="32"
                                               placeholder="请输入打款倍数" style="width:98%;"/></td>
                                    <th class='center'>最低打款：</th>
                                    <td><input class="forminput" type="number" name="PAY_MIN" id="PAY_MIN"
                                               value="${pd.PAY_MIN}" maxlength="32"
                                               placeholder="请输入最低打款" style="width:98%;"/></td>
                                    <th class='center'>最高打款：</th>
                                    <td><input class="forminput" type="number" name="PAY_MAX" id="PAY_MAX"
                                               value="${pd.PAY_MAX}" maxlength="32"
                                               placeholder="请输入最高打款" style="width:98%;"/></td>

                                </tr>

                                <tr>
                                    <th class='center'>预付款：</th>
                                    <td><input class="forminput" type="number" name="ADVANCE_CHARGE" id="ADVANCE_CHARGE" oninput="tailCount(this.value)"
                                               value="${pd.ADVANCE_CHARGE}" maxlength="32"
                                               placeholder="请输入预付款" style="width:50%;"/> %
                                    </td>
                                    <th class='center'>尾款：</th>
                                    <td><input class="forminput" readonly type="number" name="TAIL_MONEY"
                                               id="TAIL_MONEY"
                                               value="${pd.TAIL_MONEY}" maxlength="32"
                                               placeholder="请输入尾款" style="width:50%;"/> %
                                    </td>
                                    <th class='center'>预付款结算利息（每日）：</th>
                                    <td><input class="forminput" type="number" name="ADVANCE_CHARGE_INTEREST"
                                               id="ADVANCE_CHARGE_INTEREST"
                                               value="${pd.ADVANCE_CHARGE_INTEREST}" maxlength="32"
                                               placeholder="预付款结算利息" style="width:50%;"/> %
                                    </td>
                                </tr>

                                <tr>
                                    <th> 排单设置：</th>
                                </tr>
                                <tr>
                                    <th class='center'>利息周期1：</th>
                                    <td><input class="forminput" type="number" name="INTEREST_CYCLE1"
                                               id="INTEREST_CYCLE1"
                                               value="${pd.INTEREST_CYCLE1}" maxlength="32"
                                               placeholder="请输入利息周期1" style="width:50%;"/> 天
                                    </td>
                                    <th class='center'>获得利息：</th>
                                    <td><input class="forminput" type="number" name="INTEREST_7" id="INTEREST_7"
                                               value="${pd.INTEREST_7}" maxlength="32"
                                               placeholder="请输入获得利息" style="width:50%;"/> %
                                    </td>
                                </tr>

                                <tr>
                                    <th class='center'>利息周期2：</th>
                                    <td><input class="forminput" type="number" name="INTEREST_CYCLE2"
                                               id="INTEREST_CYCLE2"
                                               value="${pd.INTEREST_CYCLE2}" maxlength="32"
                                               placeholder="请输入利息周期2" style="width:50%;"/> 天
                                    </td>
                                    <th class='center'>获得利息：</th>
                                    <td><input class="forminput" type="number" name="INTEREST_15" id="INTEREST_15"
                                               value="${pd.INTEREST_15}" maxlength="32"
                                               placeholder="请输入获得利息" style="width:50%;"/> %
                                    </td>
                                </tr>

                                <tr>
                                    <th class='center'>利息周期3：</th>
                                    <td><input class="forminput" type="number" name="INTEREST_CYCLE3"
                                               id="INTEREST_CYCLE3"
                                               value="${pd.INTEREST_CYCLE3}" maxlength="32"
                                               placeholder="请输入利息周期3" style="width:50%;"/> 天
                                    </td>
                                    <th class='center'>获得利息：</th>
                                    <td><input class="forminput" type="number" name="INTEREST_30" id="INTEREST_30"
                                               value="${pd.INTEREST_30}" maxlength="32"
                                               placeholder="请输入获得利息" style="width:50%;"/> %
                                    </td>
                                </tr>

                                <tr>
                                    <th> 动静态奖金设置：</th>
                                </tr>
                                <tr>
                                    <th class='center'>第二代动态奖冻结：</th>
                                    <td><input class="forminput" type="number" name="DYNAMIC_FREEZE2"
                                               id="DYNAMIC_FREEZE2"
                                               value="${pd.DYNAMIC_FREEZE2}" maxlength="32"
                                               placeholder="请输入冻结天数" style="width:50%;"/> 天
                                    </td>
                                    <th class='center'>第三代及以后动态奖冻结：</th>
                                    <td><input class="forminput" type="number" name="DYNAMIC_FREEZE3"
                                               id="DYNAMIC_FREEZE3"
                                               value="${pd.DYNAMIC_FREEZE3}" maxlength="32"
                                               placeholder="请输入冻结天数" style="width:50%;"/> 天
                                    </td>
                                </tr>

                                <tr>
                                    <th class='center'>普通会员拿N代奖励：</th>
                                    <td><input class="forminput" type="number" name="ORDINARY_ALGEBRA"
                                               id="ORDINARY_ALGEBRA"
                                               value="${pd.ORDINARY_ALGEBRA}" maxlength="32"
                                               placeholder="请输入多少代" style="width:50%;"/> 代
                                    </td>
                                </tr>

                                <tr>
                                    <th class='center'>普通1代奖励：</th>
                                    <td><input class="forminput" type="number" name="ORDINARY_1_REWARD"
                                               id="ORDINARY_1_REWARD"
                                               value="${pd.ORDINARY_1_REWARD}" maxlength="32"
                                               placeholder="请输入1代奖励" style="width:50%;"/> %
                                    </td>
                                    <th class='center'>普通2代奖励：</th>
                                    <td><input class="forminput" type="number" name="ORDINARY_2_REWARD"
                                               id="ORDINARY_2_REWARD"
                                               value="${pd.ORDINARY_2_REWARD}" maxlength="32"
                                               placeholder="请输入2代奖励" style="width:50%;"/> %
                                    </td>
                                    <th class='center'>普通3~N代奖励：</th>
                                    <td><input class="forminput" type="number" name="ORDINARY_3_REWARD"
                                               id="ORDINARY_3_REWARD"
                                               value="${pd.ORDINARY_3_REWARD}" maxlength="32"
                                               placeholder="请输入3~N代奖励" style="width:50%;"/> %
                                    </td>
                                </tr>

                                <tr>
                                    <th class='center'>首单上级获得算力：</th>
                                    <td><input class="forminput" type="number" name="FIRST_POWER"
                                               id="FIRST_POWER"
                                               value="${pd.FIRST_POWER}" maxlength="32"
                                               placeholder="请输入首单上级获得算力" style="width:90%;"/>
                                    </td>
                                    <th class='center'>自己每次排单获取算力：</th>
                                    <td><input class="forminput" type="number" name="MY_POWER"
                                               id="MY_POWER"
                                               value="${pd.MY_POWER}" maxlength="32"
                                               placeholder="请输入自己排单获取算力" style="width:90%;"/>
                                    </td>
                                </tr>

                                <tr>
                                    <th> 高级经理奖励：</th>
                                </tr>
                                <tr>
                                    <th class='center'>高级1代奖励：</th>
                                    <td><input class="forminput" type="number" name="SENIOR_1_REWARD"
                                               id="SENIOR_1_REWARD"
                                               value="${pd.SENIOR_1_REWARD}" maxlength="32"
                                               placeholder="请输入1代奖励" style="width:50%;"/> %
                                    </td>
                                    <th class='center'>高级2代奖励：</th>
                                    <td><input class="forminput" type="number" name="SENIOR_2_REWARD"
                                               id="SENIOR_2_REWARD"
                                               value="${pd.SENIOR_2_REWARD}" maxlength="32"
                                               placeholder="请输入2代奖励" style="width:50%;"/> %
                                    </td>
                                    <th class='center'>高级3代奖励：</th>
                                    <td><input class="forminput" type="number" name="SENIOR_3_REWARD"
                                               id="SENIOR_3_REWARD"
                                               value="${pd.SENIOR_3_REWARD}" maxlength="32"
                                               placeholder="请输入3代奖励" style="width:50%;"/> %
                                    </td>
                                    <th class='center'>高级4代奖励：</th>
                                    <td><input class="forminput" type="number" name="SENIOR_4_REWARD"
                                               id="SENIOR_4_REWARD"
                                               value="${pd.SENIOR_4_REWARD}" maxlength="32"
                                               placeholder="请输入4代奖励" style="width:50%;"/> %
                                    </td>
                                </tr>

                                <tr>
                                    <th class='center'>高级5代奖励：</th>
                                    <td><input class="forminput" type="number" name="SENIOR_5_REWARD"
                                               id="SENIOR_5_REWARD"
                                               value="${pd.SENIOR_5_REWARD}" maxlength="32"
                                               placeholder="请输入5代奖励" style="width:50%;"/> %
                                    </td>
                                    <th class='center'>高级6代奖励：</th>
                                    <td><input class="forminput" type="number" name="SENIOR_6_REWARD"
                                               id="SENIOR_6_REWARD"
                                               value="${pd.SENIOR_6_REWARD}" maxlength="32"
                                               placeholder="请输入6代奖励" style="width:50%;"/> %
                                    </td>
                                    <th class='center'>高级7代奖励：</th>
                                    <td><input class="forminput" type="number" name="SENIOR_7_REWARD"
                                               id="SENIOR_7_REWARD"
                                               value="${pd.SENIOR_7_REWARD}" maxlength="32"
                                               placeholder="请输入7代奖励" style="width:50%;"/> %
                                    </td>
                                    <th class='center'>高级8~N代奖励：</th>
                                    <td><input class="forminput" type="number" name="SENIOR_8_REWARD"
                                               id="SENIOR_8_REWARD"
                                               value="${pd.SENIOR_8_REWARD}" maxlength="32"
                                               placeholder="请输入8~N代奖励" style="width:50%;"/> %
                                    </td>
                                </tr>

                                <tr>
                                    <th> 匹配参数：</th>
                                </tr>
                                <tr>
                                    <th class='center'>每单间隔时间：</th>
                                    <td><input class="forminput" type="number" name="INTERVAL_TIME" id="INTERVAL_TIME"
                                               value="${pd.INTERVAL_TIME}" maxlength="32"
                                               placeholder="请输入每单间隔时间" style="width:50%;"/> 小时
                                    </td>
                                    <th class='center'>打款时间：</th>
                                    <td><input class="forminput" type="number" name="PAYMENT_TIME" id="PAYMENT_TIME"
                                               value="${pd.PAYMENT_TIME}" maxlength="32"
                                               placeholder="请输入打款时间" style="width:50%;"/> 小时
                                    </td>
                                    <th class='center'>匹配后打款时间：</th>
                                    <td><input class="forminput" type="number" name="PAY_TIME_MATCHING"
                                               id="PAY_TIME_MATCHING"
                                               value="${pd.PAY_TIME_MATCHING}" maxlength="32"
                                               placeholder="请输入匹配后打款时间" style="width:50%;"/> 小时
                                    </td>
                                    <th class='center'>额外奖励挂单利息：</th>
                                    <td><input class="forminput" type="number" name="INCENTIVE_INTEREST"
                                               id="INCENTIVE_INTEREST"
                                               value="${pd.INCENTIVE_INTEREST}" maxlength="32"
                                               placeholder="请输入额外奖励挂单利息" style="width:50%;"/> %
                                    </td>
                                </tr>

                                </c:if>
                                <c:if test="${QX.cha == 0 }">
                                    <tr>
                                        <td colspan="100" class="center">您无权查看</td>
                                    </tr>
                                </c:if>
                            </table>

                            <div class="page-header position-relative">
                                <table style="width:100%;">
                                    <tr>
                                        <td style="vertical-align:top;" class="center" colspan="6">
                                            <c:if test="${QX.edit == 1 }">
                                                <a class="btn btn-mini btn-primary" onclick="edit();">保存</a>
                                                <a class="btn btn-mini btn-success" onclick="formReset()">取消</a>
                                                <a class="btn btn-mini btn-danger" onclick="wipeData();">清空数据</a>
                                            </c:if>

                                        </td>
                                    </tr>
                                </table>
                            </div>

                        </form>

                    </div>
                    <!-- /.col -->
                </div>
                <!-- /.row -->
            </div>
            <!-- /.page-content -->
        </div>
    </div>
    <!-- /.main-content -->

    <!-- 返回顶部 -->
    <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
        <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
    </a>

</div>
<!-- /.main-container -->

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
<script type="text/javascript">
    $(top.hangge());//关闭加载状态
    //检索
    function tosearch() {
        top.jzts();
        $("#Form").submit();
    }

    $(function () {
        //日期框
        $('.date-picker').datepicker({autoclose: true, todayHighlight: true});
    });

    // 计算尾款
    function tailCount(downPayments) {
        $('#TAIL_MONEY').val(100 - downPayments);
    }

    //清空数据
    function wipeData() {
        bootbox.confirm("确定要清空数据吗?", function (result) {
            if (result) {
                top.jzts();
                var url = "sys_config/wipeAllData.do";
                $.get(url, function (data) {
                    if (data === "success") {
                        alert("清空数据成功！")
                        location.reload(); //刷新页面
                    }
                });
            }
        });
    }

    //复位
    function formReset() {
        document.getElementById("Form").reset();
    }

    //判断不能为空
    function check() {  //Form是表单的ID
        for (var i = 0; i < document.Form.elements.length - 1; i++) {
            if (document.Form.elements[i].value === "") {
                alert("当前表单不能有空项");
                document.Form.elements[i].focus();
                return false;
            }
        }
        var downPayments = $('#ADVANCE_CHARGE').val();
        if (downPayments <= 0 || downPayments >= 100) {
            $("#ADVANCE_CHARGE").tips({
                side: 2,
                msg: '请输入1~99的预付款',
                bg: '#AE81FF',
                time: 2
            });
            return false;
        }
        return true;
    }

    //获取from表单数据并传到后台
    function edit() {
        //取表单值
        finalRes = $("#Form").serializeArray().reduce(function (result, item) {
            result[item.name] = item.value;
            return result;
        }, {});
        //打印控制台查看数据是否符合
       // console.log(finalRes)

        //通过ajax传到后台
        if (check()) {
            $.ajax({
                url: "sys_config/edit.do",
                type: "post",
                data: finalRes,
                timeout: 10000, //超时时间设置为10秒
                success: function (data) { //回调函数
                    console.log("aaa" + data)
                    if (data === "success") {
                        alert("参数更改成功~");
                        location.reload(); //刷新页面
                    } else {
                        alert("参数更改失败~");
                        location.reload(); //刷新页面
                    }
                }
            });
        }
    }


</script>


</body>
</html>