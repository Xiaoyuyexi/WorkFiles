<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>采购合同</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript">
//提交表单前，获得所选择的复选框。
	function wantSelections() {
		
		var end = null;
		var ids = "";
		$("#checkstabel input:checkbox").each(function(){
			end = $(this).attr("checked");
			if("checked" == end) {
				var tt = $(this).parent().parent();
				var id = $(tt.find("input")[3]).val();
	 			ids += id+",";
	 		}
		});
		ids = ids.substring(0,ids.length-1);
		$("#hiddenids").val(ids);
	}
	
	function check(){
		var contractNo = $("#contractNo").val();
		$.ajax({
	    	url:'tbPurchaseContractController.do?getPurchaseContractByContractNo' , // 可以获取数据的接口
	    	dataType:"json",
	    	data:{'contractNo':contractNo},
	    	success:function(data) {
				if(data!=null){
					return false;
				}
	    	}
	    			 
	    });
	}
 </script>
 </head>
 <body style="overflow-y: hidden" scroll="no">
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" tiptype="1" action="tbPurchaseContractController.do?save" beforeSubmit="wantSelections();" >
			<input id="id" name="id" type="hidden" value="${tbPurchaseContractPage.id }">
			
			<table cellpadding="0" cellspacing="1" class="formtable">
			<tr>
			<td align="right"><label class="Validform_label">采购合同编号</label></td>
			<td class="value">
			<c:if test="${tbPurchaseContractPage.contractNo!=null }">
			<input nullmsg="请填写采购合同编号" errormsg="contrac格式不对" class="inputxt" onblur="check()" id="contractNo" name="contractNo" datatype="*"
									   value="${tbPurchaseContractPage.contractNo}" readonly="readonly">
								<span class="Validform_checktip"></span>
			</c:if>
			<c:if test="${tbPurchaseContractPage.contractNo==null }">
				<input nullmsg="请填写采购合同编号" errormsg="contrac格式不对" class="inputxt" onblur="check()" id="contractNo" name="contractNo" datatype="*"
									   value="${tbPurchaseContractPage.contractNo}">
								<span class="Validform_checktip"></span>
			</c:if>
			</td>
			<td align="right"><label class="Validform_label">采购合同总价:</label></td>
			<td class="value">
				<input nullmsg="请填写采购合同总价" errormsg="contrac格式不对" class="inputxt" id="contractPrice" name="contractPrice" datatype="*"
									   value="${tbPurchaseContractPage.contractPrice}">
								<span class="Validform_checktip"></span>
			</td>
			</tr>
			<tr>
			<td align="right"><label class="Validform_label">备注:</label></td>
			<td class="value" colspan="3">
				<textarea style="width:90%;" nullmsg="请填写remark" errormsg="remark格式不对" id="remark" name="remark" ignore="ignore">${tbPurchaseContractPage.remark}</textarea>
				<!--  <input nullmsg="请填写remark" errormsg="remark格式不对" class="inputxt" id="remark" name="remark" ignore="ignore"
									   value="${tbPurchaseContractPage.remark}">-->
								<span class="Validform_checktip"></span>
			</td>
			</tr>
			</table>
			<div id="myTabs" class="easyui-tabs" style="height:30px;">
				<div title="采购订单" ></div>
			</div>
			<div  style="width: 800px;height: 300px;overflow-y:scroll;overflow-x:scroll;">
			<table id="checkstabel">
			<input id="hiddenids" name="ids" style="display: none;" >
			<tr bgcolor="#E6E6E6">
		<td align="center" bgcolor="#EEEEEE">序号</td>
		<td align="center" bgcolor="#EEEEEE">康讯订单号</td>
				  <td align="center" bgcolor="#EEEEEE">区域</td>
				  <td></td>
				  <td align="center" bgcolor="#EEEEEE">供应商</td>
				  <td align="center" bgcolor="#EEEEEE">商品名称</td>
				  <td align="center" bgcolor="#EEEEEE">型号</td>
				  <td align="center" bgcolor="#EEEEEE">数量</td>
				  <td align="center" bgcolor="#EEEEEE">采购单价</td>
				  <td align="center" bgcolor="#EEEEEE">采购总价</td>
				  <td align="center" bgcolor="#EEEEEE">采购人</td>
				  <td align="center" bgcolor="#EEEEEE">预计到货日期</td>
				  <td align="center" bgcolor="#EEEEEE">下单日期</td>
				  <td align="center" bgcolor="#EEEEEE">发票日期</td>
				  <td align="center" bgcolor="#EEEEEE">发票备注</td>
				  <td align="center" bgcolor="#EEEEEE">付款日期</td>
				  <td align="center" bgcolor="#EEEEEE">查询单号</td>
				  <td align="center" bgcolor="#EEEEEE">机型服务编号</td>
				  <td align="center" bgcolor="#EEEEEE">备注</td>
	</tr>
	<c:if test="${fn:length(tbPurchaseList)  > 0 }">
		<c:forEach items="${tbPurchaseList}" var="poVal" varStatus="stuts">
			<tr>
				<td align="center"><input style="width:20px;"  type="checkbox" name="ck"  /></td>
				<td align="left"><input name="tbPurchaseList[${stuts.index }].kxOrderNo" maxlength="16" value="${poVal.tbOrderDetail.tbOrder.kxOrderNo}" type="text" style="width:120px;" readonly="readonly"></td>
				   <td align="left"><input name="tbPurchaseList[${stuts.index }].area" maxlength="16" value="${poVal.area }" type="text" style="width:120px;" readonly="readonly"></td>
				   <td><input name="tbPurchaseList[${stuts.index }].id" value="${poVal.id }" type="hidden"/></td>
				   
				   <td align="left"><input name="tbPurchaseList[${stuts.index }].supplier" maxlength="16" value="${poVal.supplier }" type="text" style="width:120px;" readonly="readonly"></td>
				   <td align="left"><input name="tbPurchaseList[${stuts.index }].productName" maxlength="16" value="${poVal.productName }" type="text" style="width:120px;" readonly="readonly"></td>
				   <td align="left"><input name="tbPurchaseList[${stuts.index }].model" maxlength="16" value="${poVal.model }" type="text" style="width:120px;" readonly="readonly"></td>
				   <td align="left"><input name="tbPurchaseList[${stuts.index }].number" maxlength="16" value="${poVal.number }" type="text" style="width:120px;" readonly="readonly"></td>
				   <td align="left"><input name="tbPurchaseList[${stuts.index }].unitPrice" maxlength="16" value="${poVal.unitPrice }" type="text" style="width:120px;" readonly="readonly"></td>
				   <td align="left"><input name="tbPurchaseList[${stuts.index }].totalPrice" maxlength="16" value="${poVal.totalPrice }" type="text" style="width:120px;" readonly="readonly"></td>
				   <td align="left"><input name="tbPurchaseList[${stuts.index }].purchaser" maxlength="85" value="${poVal.purchaser }" type="text" style="width:120px;" readonly="readonly"></td>
				   <td align="left"><input name="tbPurchaseList[${stuts.index }].predictArrivalDate" maxlength="" value="${poVal.predictArrivalDate }" type="text" style="width:120px;" readonly="readonly"></td>
				   <td align="left"><input name="tbPurchaseList[${stuts.index }].placeOrderDate" maxlength="" value="${poVal.placeOrderDate }" type="text" style="width:120px;" readonly="readonly"></td>
				   <td align="left"><input name="tbPurchaseList[${stuts.index }].invoiceDate" maxlength="" value="${poVal.invoiceDate }" type="text" style="width:120px;" readonly="readonly"></td>
				   <td align="left"><input name="tbPurchaseList[${stuts.index }].invoiceRemark" maxlength="16" value="${poVal.invoiceRemark }" type="text" style="width:120px;" readonly="readonly"></td>
				   <td align="left"><input name="tbPurchaseList[${stuts.index }].paymentDate" maxlength="" value="${poVal.paymentDate }" type="text" style="width:120px;" readonly="readonly"></td>
				   <td align="left"><input name="tbPurchaseList[${stuts.index }].inquireNo" maxlength="16" value="${poVal.inquireNo }" type="text" style="width:120px;" readonly="readonly"></td>
				   <td align="left"><input name="tbPurchaseList[${stuts.index }].typeServiceNo" maxlength="16" value="${poVal.typeServiceNo }" type="text" style="width:120px;" readonly="readonly"></td>
				   <td align="left"><input name="tbPurchaseList[${stuts.index }].remark" maxlength="33" value="${poVal.remark }" type="text" style="width:120px;" readonly="readonly"></td>
   			</tr>
		</c:forEach>
	</c:if>	</table>
				<%-- 增加一个div，用于调节页面大小，否则默认太小 --%>
				<%--<div style="width:690px;height:1px;"></div>--%>
				<%--<t:tabs id="tt" iframe="false" tabPosition="top" fit="false">
				 <t:tab href="tbPurchaseContractController.do?tbPurchaseList&id=${tbPurchaseContractPage.id}" icon="icon-search" title="采购订单" id="tbPurchaseCopy"></t:tab>
				</t:tabs>--%>
			</div>
			</t:formvalid>
			<!-- 添加 明细 模版 -->
		<table style="display:none">
		<tbody id="add_tbPurchaseCopy_table_template">
			<tr>
			 <td align="center"><input style="width:20px;" type="checkbox"  checked="checked" name="ck"/></td>
				  <td align="left"><input name="tbPurchaseList[#index#].area" maxlength="16" type="text" style="width:120px;" ></td>
				  <td align="left"><input name="tbPurchaseList[#index#].purchaseContractNo" maxlength="16" type="text" style="width:120px;"></td>
				  <td align="left"><input name="tbPurchaseList[#index#].supplier" maxlength="16" type="text" style="width:120px;"></td>
				  <td align="left"><input name="tbPurchaseList[#index#].productName" maxlength="16" type="text" style="width:120px;"></td>
				  <td align="left"><input name="tbPurchaseList[#index#].model" maxlength="16" type="text" style="width:120px;"></td>
				  <td align="left"><input name="tbPurchaseList[#index#].number" maxlength="16" type="text" style="width:120px;"></td>
				  <td align="left"><input name="tbPurchaseList[#index#].unitPrice" maxlength="16" type="text" style="width:120px;"></td>
				  <td align="left"><input name="tbPurchaseList[#index#].totalPrice" maxlength="16" type="text" style="width:120px;"></td>
				  <td align="left"><input name="tbPurchaseList[#index#].purchaser" maxlength="85" type="text" style="width:120px;"></td>
				  <td align="left"><input name="tbPurchaseList[#index#].predictArrivalDate" maxlength="" type="text" style="width:120px;"></td>
				  <td align="left"><input name="tbPurchaseList[#index#].placeOrderDate" maxlength="" type="text" style="width:120px;"></td>
				  <td align="left"><input name="tbPurchaseList[#index#].invoiceDate" maxlength="" type="text" style="width:120px;"></td>
				  <td align="left"><input name="tbPurchaseList[#index#].invoiceRemark" maxlength="16" type="text" style="width:120px;"></td>
				  <td align="left"><input name="tbPurchaseList[#index#].paymentDate" maxlength="" type="text" style="width:120px;"></td>
				  <td align="left"><input name="tbPurchaseList[#index#].inquireNo" maxlength="16" type="text" style="width:120px;"></td>
				  <td align="left"><input name="tbPurchaseList[#index#].typeServiceNo" maxlength="16" type="text" style="width:120px;"></td>
				  <td align="left"><input name="tbPurchaseList[#index#].remark" maxlength="33" type="text" style="width:120px;"></td>
			</tr>
		 </tbody>
		</table>
 </body>