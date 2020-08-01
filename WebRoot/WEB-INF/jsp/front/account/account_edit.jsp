<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
<body class="no-skin">
<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
	<!-- /section:basics/sidebar -->
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">
					
					<form action="account/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="ACCOUNT_ID" id="ACCOUNT_ID" value="${pd.ACCOUNT_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">静态钱包余额:</td>
								<td><input type="number" name="STATIC_WALLET" id="STATIC_WALLET" value="${pd.STATIC_WALLET}" maxlength="32" placeholder="这里输入静态钱包余额" title="静态钱包余额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">动态钱包余额:</td>
								<td><input type="number" name="DYNAMIC_WALLET" id="DYNAMIC_WALLET" value="${pd.DYNAMIC_WALLET}" maxlength="32" placeholder="这里输入动态钱包余额" title="动态钱包余额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">算力余额:</td>
								<td><input type="number" name="COUNT_BALANCE" id="COUNT_BALANCE" value="${pd.COUNT_BALANCE}" maxlength="32" placeholder="这里输入算力余额" title="算力余额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">入场券余额:</td>
								<td><input type="number" name="TICKET" id="TICKET" value="${pd.TICKET}" maxlength="32" placeholder="这里输入入场券余额" title="入场券余额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">限制匹配天数:</td>
								<td><input type="number" name="REST_TIME" id="REST_TIME" value="${pd.REST_TIME}" maxlength="32" placeholder="这里输入限制匹配天数" title="限制匹配天数" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
						</table>
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
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
</div>
<!-- /.main-container -->


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			if($("#STATIC_WALLET").val()==""){
				$("#STATIC_WALLET").tips({
					side:3,
		            msg:'请输入静态钱包余额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#STATIC_WALLET").focus();
			return false;
			}
			if($("#DYNAMIC_WALLET").val()==""){
				$("#DYNAMIC_WALLET").tips({
					side:3,
		            msg:'请输入动态钱包余额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DYNAMIC_WALLET").focus();
			return false;
			}
			if($("#COUNT_BALANCE").val()==""){
				$("#COUNT_BALANCE").tips({
					side:3,
		            msg:'请输入算力余额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#COUNT_BALANCE").focus();
			return false;
			}
			if($("#TICKET").val()==""){
				$("#TICKET").tips({
					side:3,
		            msg:'请输入入场券余额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TICKET").focus();
			return false;
			}
			if($("#REST_TIME").val()==""){
				$("#REST_TIME").tips({
					side:3,
					msg:'请输入禁止匹配天数',
					bg:'#AE81FF',
					time:2
				});
				$("#REST_TIME").focus();
				return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
</body>
</html>