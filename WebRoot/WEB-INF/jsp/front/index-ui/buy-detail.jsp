<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

    <style>
        .upload_pic {
            height: 150px !important;
            width: 150px !important;
        }

        .preimg {
            position: absolute;
            top: 0;
            right: 0;
            width: 100%;
            height: 100%;
            opacity: 0;
        }

        .drop {
            position: relative;
            width: 150px;
            height: 150px;
            margin: 0 auto
        }
    </style>
</head>
<link rel="stylesheet" type="text/css" href="static/front/fonts/iconfont.css"/>
<link rel="stylesheet" type="text/css" href="static/front/layui/css/layui.css"/>
<link rel="stylesheet" type="text/css" href="static/front/css/style.css"/>
<body style="height:100%;>
<div class=" layui-container
">
<!--header-->
<header><a class="back" href="javascript:history.back(-1)"><i class="iconfont icon-zuo-"></i></a><h4>匹配列表</h4>
</header>
<!--信息输入-->
<div class="jy-top">
    <p>订单号：${buy.ORDER_NUMBER}</p>
    <c:if test="${buy.PAYMENT_STATE == 3}">
        <p>状态：待付款</p>
    </c:if>
    <c:if test="${buy.PAYMENT_STATE == 4}">
        <p>状态：等待收款</p>
    </c:if>
    <c:if test="${buy.PAYMENT_STATE == 5}">
        <p>状态：等待匹配</p>
    </c:if>
    <c:if test="${buy.PAYMENT_STATE == 6}">
        <p>状态：交易完成</p>
    </c:if>
    <c:if test="${buy.PAYMENT_STATE == 0}">
        <p>状态：已超时</p>
    </c:if>
</div>
<%--开始循环--%>
<c:forEach items="${match}" var="var" varStatus="vs">
    <div class="jy-list">
        <!--交易信息-->
        <ul class="jy-list-ul">
            <li>
                <p>姓名：${user.NAME}</p>
                <div><i class="iconfont icon-dianhua2"></i>${var.BUY_PHONE}</div>
                    <%--电话--%>
            </li>
            <li>
                <p>金额：${var.NUMBER}</p>
                <div><i class="iconfont icon-youjiantou1"></i></div>
                <span><i class="iconfont icon-shijian1"></i>${var.GMT_CREATE}</span>
            </li>
            <li>
                <p>姓名：${var.NAME}</p>
                <div><i class="iconfont icon-dianhua2"></i>${var.SELL_PHONE}</div>
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
                <c:if test="${var.ORDER_STATE == 2}">
                    <button type="button" class="layui-btn  layui-btn-normal layui-btn-sm layui-btn-radius">等待收款
                    </button>
                </c:if>
                <c:if test="${var.ORDER_STATE == 3}">
                    <button type="button" class="layui-btn  layui-btn-normal layui-btn-sm layui-btn-radius">已超时
                    </button>
                </c:if>
                <c:if test="${var.ORDER_STATE == 4}">
                    <button type="button" class="layui-btn layui-btn-sm layui-btn-radius">交易完成</button>
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
        <!--姓名、账号、地址等-->
        <c:if test="${var.ORDER_STATE != 3 && var.ORDER_STATE != 7}">
            <div class="jy-list-add">
                <i class="iconfont icon-yinhangqia3"></i>
                <div>
                    <p>对方姓名：${var.NAME}
                        <button data-clipboard-action="copy" data-clipboard-text="${var.NAME}" class="d_clip_button">
                            (复制)
                        </button>
                    </p>
                    <c:if test="${buy.MODE_PAYMENT == 1}">
                    <p>支付宝账号：${var.ALIPAY}
                        <button data-clipboard-action="copy" data-clipboard-text="${var.ALIPAY}" class="d_clip_button">
                            (复制)
                        </button>
                    </p>
                    <p>银行名称：${var.BANK_NAME}
                        <button data-clipboard-action="copy" data-clipboard-text="${var.BANK_NAME}"
                                class="d_clip_button">(复制)
                        </button>
                    </p>
                    <p>银行卡号：${var.BANK_NUMBER}
                        <button data-clipboard-action="copy" data-clipboard-text="${var.BANK_NUMBER}"
                                class="d_clip_button">(复制)
                        </button>
                    </p>
                    <p>开户地址：${var.BANK_ADDRESS}
                        <button data-clipboard-action="copy" data-clipboard-text="${var.BANK_ADDRESS}"
                                class="d_clip_button">(复制)
                        </button>
                    </p>
                    </c:if>
                    <c:if test="${buy.MODE_PAYMENT == 0}">
                    <p>ETH地址：${var.ETH_ADDRESS}
                        <button data-clipboard-action="copy" data-clipboard-text="${var.ETH_ADDRESS}"
                                class="d_clip_button">(复制)
                        </button>
                    </p>
                    </c:if>
                </div>
            </div>
        <c:if test="${buy.PAYMENT_STATE != 5}">
            <c:if test="${var.ORDER_STATE == 0 || var.ORDER_STATE == 3 }">
                <!--剩余时间-->
                <div class="jy-list-div1 jy-list-div2">
                    <p><i class="iconfont icon-shijian"></i>剩余时间：</p>
                    <div><span id="endTime_${vs.index}">时间到</span></div>
                </div>
            </c:if>
            <!--确认收款-->
            <div class="jy-list-div3">
                <c:if test="${var.ORDER_STATE != 0 && var.ORDER_STATE != 3}">
                    <img src="${var.PIC_PATH}" onclick="previewImg(this)"/>
                </c:if>
                <c:if test="${var.ORDER_STATE == 0}">
                    <%--上传支付凭证--%>
                    <!--accept="image/*" 表示只接收图片文件 -->
                    <input class="picPath" type="hidden" id="path${vs.index}" value=""/>
                    <div class="drop">
                        <img class="upload_pic" src="static/front/images/upload.png"/>
                        <input type="file" name="pictureFile" class="preimg" id="selectfile"/>
                    </div>

                    <div class="jy-list-div4">
                        <!--确认按钮-->
                        <button type="button"
                                onclick="checking('${var.SMD_MATCH_ID}', '${var.BUY_ID}', '${var.SELL_ID}', $('#path${vs.index}').val() )"
                                class="btn">确认打款
                            <button>

                                    <%-- <button type="button" class="layui-btn layui-btn-sm layui-btn-danger">虚假凭证</button>
                                    <button type="button"  class="layui-btn layui-btn-sm layui-btn-primary">确认打款</button>--%>
                    </div>
                </c:if>
            </div>
        </c:if>
        </c:if>
    </div>
</c:forEach>
</div>
<script src="static/front/layui/layui.all.js" type="text/javascript" charset="utf-8"></script>
<script src="static/front/js/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
<script src="static/front/js/front.js" type="text/javascript" charset="utf-8"></script>
<%--复制js--%>
<script src="static/front/js/clipboard.min.js" type="text/javascript" charset="utf-8"></script>

<%--图片压缩上传--%>
<script type="text/javascript" src="static/js/lrz.bundle.js"></script>

<script>

    $(function () {

        // 限N小时内打款
        var paymentTime = ${par.PAYMENT_TIME};
        // js写入付款倒计时
        <c:forEach items="${match}" var="var" varStatus="vs">
            <c:if test="${var.ORDER_STATE == 0}">
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
    function checking(matchId, buyId, sellId, picPath) {
        // 传匹配订单ID、申购订单ID、赎回订单Id、支付凭证
        console.log(matchId + "::::" + buyId + "::::" + sellId + "::::" + picPath);

        if (picPath === '') {
            layer.msg('请上传支付凭证');
            return false;
        }

        // 校验通过，封装数组
        var record = [];
        record.push(matchId);
        record.push(buyId);
        record.push(sellId);
        record.push(picPath);
        layer.confirm('确定已经支付了吗？', {
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
            url: "front/buyPayment.do",
            type: "post",
            traditional: true, //传集合或者数组到后台service接收
            timeout: 10000, 	//超时时间设置为10秒；
            data: {record: record},
            success: function (data) { //回调函数
                if (data === "success") {
                    layer.msg('等待对方确认收款！');
                    setTimeout(function () {
                        location.reload();
                    }, 800);
                    return false;
                } else {
                    layer.open({
                        title: [
                            '打款失败',
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
<%--图片压缩上传--%>
<script>
    //声明一个formdata 用来上传
    var UForm;
    // 定义图片原始大小、压缩后的大小
    var oldfilesize, newfilesize;
    // 当上传按钮内容发送改变后 获取文件并调用压缩图片的方法
    var $file = $("#selectfile");
    $file.on("change", function () {
        UForm = new FormData();
        GetFile($file.get(0).files);
        // 上传到服务器
        DoUp();
    });


    // GetFile 处理获取到的file对象，并对它进行压缩处理：
    function GetFile(files) {
        // 用三目运算符频道文件是否存在
        var file = files ? files[0] : false;
        if (!file) {
            return;
        }
        if (file) {
            oldfilesize = Math.floor((file.size / 1024) * 100) / 100;
            // 如果图片少于2M 则不进行压缩
            if (oldfilesize < 2000) {
                UForm.append("files", file);
                ShowFile(file);
                return;
            }
            lrz(file, {
                width: 2048, //设置压缩后的最大宽
                height: 1080,
                quality: 0.8 //图片压缩质量，取值 0 - 1，默认为0.7
            }).then(function (rst) {
                newfilesize = Math.floor((rst.file.size / 1024) * 100) / 100;
                console.log("图片压缩成功，原为：" + oldfilesize + "KB,压缩后为：" + newfilesize + "KB");
                // 把压缩后的图片文件存入 formData中，这样用ajax传到后台才能接收
                UForm.append("files", rst.file);
                ShowFile(rst.file);
            }).catch(function (err) {
                console.log(err);
                alert("压缩图片时出错,请上传图片文件！");
                return false;
            });
        }
    }

    // ShowFile 把处理后的图片显示出来，实现图片的预览功能：
    function ShowFile(file) {
        // 使用fileReader对文件对象进行操作
        var reader = new FileReader();
        reader.onload = function (e) {
            var img = new Image();
            img.src = e.target.result;
            // console.log(img)
            // 图片本地回显
            $('.upload_pic').attr({src: img.src})
            location.href
        };
        reader.onerror = function (e, b, c) {
            //error
        };
        // 读取为数据url
        reader.readAsDataURL(file);
    }


    // 使用AJAX上传数据到后台
    function DoUp() {
        $.ajax({
            url: "release/addPic",
            type: "POST",
            data: UForm,
            contentType: false,//禁止修改编码
            processData: false,//不要把data转化为字符
            success: function (data) {
                layer.msg('上传成功!');
                // 上传成功 返回图片路径
                picture_path = (data + "").trim();
                var sta = picture_path;
                $("input[class=picPath]").attr({value: sta});
            },
            error: function (e) {
                layer.msg('上传出错!请检查是否选择了图片');
            }
        });
    }
</script>
<%--复制按钮--%>
<script>
    $(document).ready(function () {
        var clipboard = new ClipboardJS('.d_clip_button');
        clipboard.on('success', function (e) {
            layer.msg("复制成功");
            e.clearSelection();
        });
    });
</script>

</body>
</html>
