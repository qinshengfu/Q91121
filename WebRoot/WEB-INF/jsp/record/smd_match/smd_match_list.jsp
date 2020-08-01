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
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
</head>
<style type="text/css">
	.yulantu{
		z-index: 9999999999999999;
		position:absolute;
		border:3px solid #438EB9;
		display: none;
	}
</style>
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
						<form action="smd_match/list.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" placeholder="这里输入关键词" class="nav-search-input" id="nav-search-input" autocomplete="off" name="keywords" value="${pd.keywords }" placeholder="这里输入关键词"/>
											<i class="ace-icon fa fa-search nav-search-icon"></i>
										</span>
									</div>
								</td>
								<td style="padding-left:2px;"><input class="span10 date-picker" name="lastStart" id="lastStart"  value="" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期" title="开始日期"/></td>
								<td style="padding-left:2px;"><input class="span10 date-picker" name="lastEnd" id="lastEnd"  value="" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期" title="结束日期"/></td>
								<td style="vertical-align:top;padding-left:2px;">
								 	<select class="chosen-select form-control" name="name" id="id" data-placeholder="请选择" style="vertical-align:top;width: 120px;">
									<option value=""></option>
									<option value="">全部</option>
									<option value="">1</option>
									<option value="">2</option>
								  	</select>
								</td>
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								</c:if>
								<c:if test="${QX.toExcel == 1 }"><td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a></td></c:if>
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:50px;">序号</th>
									<th class="center">创建时间</th>
									<th class="center">更新时间</th>
									<th class="center">数量</th>
									<th class="center">申购订单号</th>
									<th class="center">提现订单号</th>
									<th class="center">状态</th>
									<th class="center">交易订单号</th>
									<th class="center">支付凭证</th>
									<th class="center">操作</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class='center'>${var.GMT_CREATE}</td>
											<td class='center'>${var.GMT_MODIFIED}</td>
											<td class='center'>${var.NUMBER}</td>
											<td class='center'>${var.BUY_ORDER}</td>
											<td class='center'>${var.SELL_ORDER}</td>
											<c:if test="${var.ORDER_STATE == 0}">
											<td class='center'>待打款</td>
											</c:if>
											<c:if test="${var.ORDER_STATE == 2}">
												<td class='center'>待收款</td>
											</c:if>
											<c:if test="${var.ORDER_STATE == 3}">
												<td class='center'>已超时</td>
											</c:if>
											<c:if test="${var.ORDER_STATE == 4}">
												<td class='center'>交易完成</td>
											</c:if>
											<c:if test="${var.ORDER_STATE == 5}">
												<td class='center'>等待收款，被投诉中</td>
											</c:if>
											<c:if test="${var.ORDER_STATE == 6}">
												<td class='center'>订单已撤销</td>
											</c:if>
											<c:if test="${var.ORDER_STATE == 7}">
												<td class='center'>订单已回滚</td>
											</c:if>
											<td class='center'>${var.TRANSACTION_ORDER}</td>
											<td class='center'>
												<img style="margin-top: -3px;" alt="" src="static/images/extension/tupian.png">
													${var.PIC_PATH}
												<a style="cursor:pointer;" onmouseover="showTU('${var.PIC_PATH}','yulantu${vs.index+1}');" onmouseout="hideTU('yulantu${vs.index+1}');">[预览]</a>
												<div class="yulantu" id="yulantu${vs.index+1}"></div>
											</td>
											<td class="center">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
													<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													<c:if test="${var.ORDER_STATE == 5}">
														<c:if test="${QX.edit == 1 }">
															<a class="btn btn-xs btn-success" title="确认收款" onclick="confirmReceipt('${var.SMD_MATCH_ID}'
																	, '${var.BUY_ID}', '${var.SELL_ID}');">
																确认收款
															</a>
															<a class="btn btn-xs btn-danger" onclick="revoke('${var.SMD_MATCH_ID}'
																	, '${var.BUY_ID}', '${var.SELL_ID}', '${var.NUMBER}');">
																撤销投诉
															</a>
														</c:if>
													</c:if>
													<c:if test="${var.ORDER_STATE == 3}">
														<a class="btn btn-xs btn-danger" onclick="rollBack('${var.SMD_MATCH_ID}'
																, '${var.BUY_ID}', '${var.SELL_ID}', '${var.NUMBER}');">
															回滚订单
														</a>
													</c:if>
												</div>
											</td>
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
						<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
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
	<%@ include file="../../system/index/foot.jsp"%>
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
		function tosearch(){
			top.jzts();
			$("#Form").submit();
		}
		$(function() {
		
			//日期框
			$('.date-picker').datepicker({
				autoclose: true,
				todayHighlight: true
			});
			
			//下拉框
			if(!ace.vars['touch']) {
				$('.chosen-select').chosen({allow_single_deselect:true}); 
				$(window)
				.off('resize.chosen')
				.on('resize.chosen', function() {
					$('.chosen-select').each(function() {
						 var $this = $(this);
						 $this.next().css({'width': $this.parent().width()});
					});
				}).trigger('resize.chosen');
				$(document).on('settings.ace.chosen', function(e, event_name, event_val) {
					if(event_name != 'sidebar_collapsed') return;
					$('.chosen-select').each(function() {
						 var $this = $(this);
						 $this.next().css({'width': $this.parent().width()});
					});
				});
				$('#chosen-multiple-style .btn').on('click', function(e){
					var target = $(this).find('input[type=radio]');
					var which = parseInt(target.val());
					if(which == 2) $('#form-field-select-4').addClass('tag-input-style');
					 else $('#form-field-select-4').removeClass('tag-input-style');
				});
			}
			
			
			//复选框全选控制
			var active_class = 'active';
			$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
				var th_checked = this.checked;//checkbox inside "TH" table header
				$(this).closest('table').find('tbody > tr').each(function(){
					var row = this;
					if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
					else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
				});
			});
		});

		//显示图片
		function showTU(path,TPID){
			$("#"+TPID).html('<img width="400" src="'+path+'">');
			$("#"+TPID).show();
		}

		//隐藏图片
		function hideTU(TPID){
			$("#"+TPID).hide();
		}

		// 确认收款
		function confirmReceipt(matchId, buyId, sellId) {
			// 封装数组
			var record = [];
			record.push(matchId);
			record.push(buyId);
			record.push(sellId);
			bootbox.confirm("确定直接完成交易吗?", function(result) {
				if(result) {

					$.ajax({
						url: "front/sellConfirmReceipt.do",
						type: "post",
						traditional: true, //传集合或者数组到后台service接收
						timeout: 10000, 	//超时时间设置为10秒；
						data: {record: record},
						success: function (data) { //回调函数
							if (data === "success") {
							    bootbox.confirm("交易成功", function(data) {
							        if(data){
                                        location.reload();
                                    }
							    });
							}
						}
					})
				}
			});
		}

		// 撤销投诉
		function revoke(matchId, buyId, sellId, amount) {
			// 封装数组
			var record = [];
			record.push(matchId);
			record.push(buyId);
			record.push(sellId);
			record.push(amount);
			bootbox.confirm("确定要撤销投诉吗?", function(result) {
				if(result) {
					$.ajax({
						url: "front/revoke.do",
						type: "post",
						traditional: true, //传集合或者数组到后台service接收
						timeout: 10000, 	//超时时间设置为10秒；
						data: {record: record},
						success: function (data) { //回调函数
							if (data === "success") {
								bootbox.confirm("撤销成功", function(data) {
									if(data){
										location.reload();
									}
								});
							}
						}
					})
				}
			});
		}

		// 回滚订单
		function rollBack (matchId, buyId, sellId, amount) {
			// 封装数组
			var record = [];
			record.push(matchId);
			record.push(buyId);
			record.push(sellId);
			record.push(amount);
			bootbox.confirm("确定要回滚订单吗?", function(result) {
				if(result) {
					$.ajax({
						url: "front/rollBackOrder.do",
						type: "post",
						traditional: true, //传集合或者数组到后台service接收
						timeout: 10000, 	//超时时间设置为10秒；
						data: {record: record},
						success: function (data) { //回调函数
							if (data === "success") {
								bootbox.confirm("回滚订单成功", function(data) {
									if(data){
										location.reload();
									}
								});
							}
						}
					})
				}
			});
		}
		
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>smd_match/excel.do';
		}
	</script>


</body>
</html>