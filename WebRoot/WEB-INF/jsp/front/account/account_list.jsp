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
<style>
	.hover:hover{
		color: red!important;
		cursor:pointer;
	}
</style>
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
						<form action="account/list.do" method="post" name="Form" id="Form">
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
								<td style="padding-left:2px;"><input class="span10 date-picker" name="lastStart" id="lastStart"  value="${pd.lastStart }" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期" title="开始日期"/></td>
								<td style="padding-left:2px;"><input class="span10 date-picker" name="lastEnd" id="lastEnd"  value="${pd.lastEnd }" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期" title="结束日期"/></td>
								<td style="vertical-align:top;padding-left:2px;">
								 	<select class="chosen-select form-control" name="name" id="id" data-placeholder="请选择" style="vertical-align:top;width: 120px;">
									<option value=""></option>
									<option value="">全部</option>
									<option value="PHONE">手机号</option>
									<option value="NAME">姓名</option>
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
									<th class="center">注册时间</th>
									<th class="center">静态钱包余额</th>
									<th class="center">动态钱包余额</th>
									<th class="center">算力余额</th>
									<th class="center">入场券余额</th>
									<th class="center">手机号</th>
									<th class="center">推荐人数</th>
									<th class="center">推荐人</th>
									<th class="center">级别</th>
									<th class="center">状态</th>
									<th class="center">不给匹配天数</th>
									<th class="center">姓名</th>
									<th class="center">支付宝账号</th>
									<th class="center">银行名称</th>
									<th class="center">银行卡号</th>
									<th class="center">开户行地址</th>
									<th class="center">ETH钱包地址</th>
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
											<td class='center'>${var.STATIC_WALLET}</td>
											<td class='center'>${var.DYNAMIC_WALLET}</td>
											<td class='center'>${var.COUNT_BALANCE}</td>
											<td class='center'>${var.TICKET}</td>
											<td class='center hover' onclick="login('${var.PHONE}')" style="color: blue">${var.PHONE}</td>
											<td class='center'>${var.RECOMMENDED_NUMBER}</td>
											<td class='center'>${var.RECOMMENDER}</td>
											<c:if test="${var.USER_RANK == 0}">
												<td class='center'>普通会员</td>
											</c:if>
											<c:if test="${var.USER_RANK == 1}">
												<td class='center'>高级经理</td>
											</c:if>
											<c:if test="${var.USER_STATE == 1}">
												<td class='center'>账号冻结</td>
											</c:if>
											<c:if test="${var.USER_STATE == 0}">
												<td class='center'>资金冻结</td>
											</c:if>
											<c:if test="${var.USER_STATE == -1}">
												<td class='center'>正常</td>
											</c:if>
											<td class='center'>${var.REST_TIME}</td>
											<td class='center'>${var.NAME}</td>
											<td class='center'>${var.ALIPAY}</td>
											<td class='center'>${var.BANK_NAME}</td>
											<td class='center'>${var.BANK_NUMBER}</td>
											<td class='center'>${var.BANK_ADDRESS}</td>
											<td class='center'>${var.ETH_ADDRESS}</td>
											<td class="center">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													<c:if test="${QX.edit == 1 }">
                                                        <a class="btn btn-xs btn-success" title="编辑资产" onclick="edit('${var.ACCOUNT_ID}');">
                                                            <i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑资产"></i>
                                                        </a>
                                                        <a class="btn btn-xs btn-danger" title="设置高级经理" onclick="seniorManager('${var.PHONE}', '${var.USER_RANK}');">
															<i class="menu-icon fa fa-users blue" title="设置高级经理"></i>
														</a>
														<a class="btn btn-xs btn-success" title="修改密码和更改用户状态" onclick="updateState('${var.PHONE}');">
															<i class="menu-icon fa fa-cog black" title="修改密码和更改用户状态"></i>
														</a>
													</c:if>
												</div>
												<div class="hidden-md hidden-lg">
													<div class="inline pos-rel">
														<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
															<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
														</button>

														<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
															<c:if test="${QX.edit == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="edit('${var.ACCOUNT_ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
														</ul>
													</div>
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

		});

		// 修改密码和封号、解封账号
		function updateState(phone){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="更改密码和状态";
			 diag.URL = '<%=basePath%>account/goUpdateState.do?PHONE='+phone;
			 diag.Width = 450;
			 diag.Height = 355;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 tosearch();
					 }else{
						 tosearch();
					 }
				}
				diag.close();
			 };
			 diag.show();
		}

		// 点击登录用户
		function login(phone){
			bootbox.confirm("确定要登录【"+ phone +"】吗?", function(result) {
				if(result) {
					var url = "<%=basePath%>release/adminLogin.do?phone="+phone;
					$.get(url,function(data){
						if (data === "success") {
							window.open("<%=basePath%>front/to_index.do");
						}else{
							alert(data)
						}

					});
				}
			});
		}

		// 设置高级经理
		function seniorManager(phone, userRank){
			bootbox.confirm("确定要设置用户【"+phone+"】为高级经理吗?", function(result) {
				if(result) {
				    // 本地校验 判断是否已经是高级经理
                    if (userRank === "1") {
                    	bootbox.confirm("该用户已是高级经理", function(data) {
                    	  if (data) {
							  location.reload();
						  }
                    	})
                    }else {
						var url = "<%=basePath%>account/setSeniorManager.do?PHONE="+phone+"&tm="+new Date().getTime();
						$.get(url,function(data){
							if (data === "success") {
								bootbox.confirm("设置高级经理成功", function(data) {
									if (data) {
										location.reload();
									}
								})
							}
						});
					}
				}
			});
		}

		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>account/goEdit.do?ACCOUNT_ID='+Id;
			 diag.Width = 450;
			 diag.Height = 355;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = true;	//最大化按钮
		     diag.ShowMinButton = true;		//最小化按钮
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 tosearch();
				}
				diag.close();
			 };
			 diag.show();
		}

		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>account/excel.do';
		}
	</script>


</body>
</html>