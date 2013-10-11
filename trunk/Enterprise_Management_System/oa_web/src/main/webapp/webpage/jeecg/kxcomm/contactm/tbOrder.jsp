<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>销售订单</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript">
  //初始化下标
	function resetTrNum(tableId) {
		$tbody = $("#"+tableId+"");
		$tbody.find('>tr').each(function(i){
			$(':input, select', this).each(function(){
				var $this = $(this), name = $this.attr('name'), val = $this.val();
				if(name!=null){
					if (name.indexOf("#index#") >= 0){
						$this.attr("name",name.replace('#index#',i));
					}else{
						var s = name.indexOf("[");
						var e = name.indexOf("]");
						var new_name = name.substring(s+1,e);
						$this.attr("name",name.replace(new_name,i));
					}
				}
			});
		});
	}
  
	
	    
	function getSum(object){
		 var kxOrderNo = $(object).val();
		 var tt = $("input[name='"+object.name+"']").parent().parent();
		 var price = $(tt.find("input")[3]).val();
		 var num = $(tt.find("input")[4]).val();
		 var totalprice = price*num;
		 $(object).val(totalprice);
		     
	}
	
	function check(){
		var kxOrderNo = $("#kxOrderNo").val();
		$.ajax({
	    	url:'tbOrderController.do?getOrderByKxOrderNo' , // 可以获取数据的接口
	    	dataType:"json",
	    	data:{'kxOrderNo':kxOrderNo},
	    	success:function(data) {
				if(data!=null){
					alert("订单号已存在");
					return false;
				}else{  	
					return true;
				}
	    	}
	    			 
	    });
	}
	    
 </script>
 </head>
 <body style="overflow-y: hidden" scroll="no">
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" tiptype="1" action="tbOrderController.do?save" >
			<input id="id" name="id" type="hidden" value="${tbOrderPage.id }">
			<input id="cno" name="cno" type="hidden" value="${tbOrderPage.tbContract.contractNo}">
			<table cellpadding="0" cellspacing="1" class="formtable">
			<tr>
			<td align="right"><label class="Validform_label">康讯订单号:</label></td>
			<td class="value">
				<input  nullmsg="请填写康讯订单号" errormsg="kxOrder格式不对" class="inputxt" onblur="check()" id="kxOrderNo" datatype="*" name="kxOrderNo" 
									   value="${tbOrderPage.kxOrderNo}">
								<span class="Validform_checktip"></span> 
			</td>
			<td align="right"><label class="Validform_label">项目名称:</label></td>
			<td class="value">
				<input  style="width:90%;" nullmsg="请填写项目名称" errormsg="project格式不对" class="inputxt" datatype="*" id="projectName" name="projectName" 
									   value="${tbOrderPage.projectName}">
								<span class="Validform_checktip"></span>
			</td>
			</tr>
			<tr>
			<td align="right"><label class="Validform_label">合同号:</label></td>
			<td class="value">
				<input nullmsg="请填写contrac" errormsg="contrac格式不对" class="inputxt" id="contractNo" name="contractNo" ignore="ignore"
									readonly="readonly"   value="${tbOrderPage.tbContract.contractNo}">
								<span class="Validform_checktip"></span>
			</td>
			<td align="right"><label class="Validform_label">客户名称:</label></td>
			<td class="value">
				<input style="width:90%;" nullmsg="请填写client" errormsg="client格式不对" class="inputxt" id="client" name="client" ignore="ignore"
									   value="${tbOrderPage.client}">
								<span class="Validform_checktip"></span>
			</td>
			</tr>
			<tr>
			<td align="right"><label class="Validform_label">最终客户:</label></td>
			<td class="value">
				<input style="width:90%;" nullmsg="请填写finalCl" errormsg="finalCl格式不对" class="inputxt" id="finalClient" name="finalClient" ignore="ignore"
									   value="${tbOrderPage.finalClient}">
								<span class="Validform_checktip"></span>
			</td>
			<td align="right"><label class="Validform_label">付款方式:</label></td>
			<td class="value">
				<input nullmsg="请填写payment" errormsg="payment格式不对" class="inputxt" id="payment" name="payment" ignore="ignore"
									   value="${tbOrderPage.payment}">
								<span class="Validform_checktip"></span>
			</td>
			</tr>
			<tr>
			<td align="right"><label class="Validform_label">项目负责人:</label></td>
			<td class="value">
				<input nullmsg="请填写项目负责人" errormsg="princip格式不对" class="inputxt" id="principal" name="principal" datatype="*"
									   value="${tbOrderPage.principal}">
								<span class="Validform_checktip"></span>
			</td>
			<td align="right"><label class="Validform_label">订单总价:</label></td>
			<td class="value">
				<input nullmsg="请填写订单总价" errormsg="格式不对" class="inputxt" id="totalPrice" name="totalPrice"
									   value="${tbOrderPage.totalPrice}">
								<span class="Validform_checktip"></span>
			</td>
			</tr>
			<tr>
				<td align="right"><label class="Validform_label">备注:</label></td>
				<td class="value" colspan="3">
					<textarea style="width:90%;" nullmsg="请填写remark" errormsg="remark格式不对" id="remark" name="remark" ignore="ignore">${tbOrderPage.remark}</textarea>
				<!--<input nullmsg="请填写remark" errormsg="remark格式不对" class="inputxt" id="remark" name="remark" ignore="ignore"
									   value="${tbOrderPage.remark}">-->
								<span class="Validform_checktip"></span>
								
				</td>
			</tr>
			</table>
			<div style="width: auto;height: 200px;">
				<%-- 增加一个div，用于调节页面大小，否则默认太小 --%>
				<div style="width:690px;height:1px;"></div>
				<t:tabs id="tt" iframe="false" tabPosition="top" fit="false">
				 <t:tab href="tbOrderController.do?tbOrderDetailList&id=${tbOrderPage.id}" icon="icon-search" title="产品明细" id="tbOrderDetail"></t:tab>
				</t:tabs>
			</div>
			</t:formvalid>
			<!-- 添加 产品明细 模版 -->
		<table style="display:none">
		<tbody id="add_tbOrderDetail_table_template">
			<tr>
			 <td align="center"><input style="width:20px;" type="checkbox" name="ck"/></td>
			 <td align="center"><input name="tbOrderDetailList[#index#].id" maxlength="85" type="hidden" style="width:120px;"></td>
				<td align="center"><select id="sel" name="tbOrderDetailList[#index#].name">
									<option value="服务器">服务器</option>
									<option value="存储">存储</option>
									<option value="交换机">交换机</option>
									<option value="操作系统">操作系统</option>
									<option value="笔记本">笔记本</option>
									<option value="台式机">台式机</option>
									<option value="服务">服务</option>
									<option value="配件">配件</option>
									<option value="存储配件">存储配件</option>
									<option value="服务器配件">服务器配件</option>
								</select>
							</td>
				 <td align="center"><input name="tbOrderDetailList[#index#].type" maxlength="85" type="text" style="width:120px;"></td>
				 <td align="center"><input name="tbOrderDetailList[#index#].price" maxlength="85" type="text" style="width:120px;"></td>
				 <td align="center"><input name="tbOrderDetailList[#index#].number" maxlength="85" type="text" style="width:120px;"></td>
				 <td align="center"><input name="tbOrderDetailList[#index#].totalprice" maxlength="85" type="text" readonly="readonly" style="width:120px;" onfocus="getSum(this);"></td>
			</tr>
		 </tbody>
		 
		</table>
 </body>