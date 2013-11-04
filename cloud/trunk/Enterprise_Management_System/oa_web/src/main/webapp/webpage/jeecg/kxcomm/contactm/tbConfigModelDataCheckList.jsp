<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>

<div class="easyui-layout" fit="true">
  
   
  <div region="center" style="padding:1px;" title="配置单数据" >
    

	<div id="tabs" class="easyui-tabs" style="width:auto;height:550px;"  data-options="tools:'#t-tools'" >	
		<div title="基本配置单元" data-options="closable:false,cache:false">
		
	<c:if test="${fn:length(tbConfigModelDataPage)  > 0}">
		<c:forEach items="${tbConfigModelDataPage}" var="poVal" varStatus="stuts">
		<c:if test="${poVal.tbDataRecord.tbProductType.tbProductCategory.id ==1}">
			 <t:datagrid name="tbConfigModelDataCheckList${stuts.index }" actionUrl="tbConfigModelDataController.do?datagrid&configId=${configId }&tbProductCategoryId=1" idField="id" fit="true" >
			   <t:dgCol title="编号" field="id" hidden="false"></t:dgCol>
			   <t:dgCol title="产品订货号" field="tbDataRecord_productorderno" width="70"></t:dgCol>
			   <t:dgCol title="产品名称" field="tbDataRecord_tbProductType_producttypename" width="70"></t:dgCol>
			   <t:dgCol title="产品描述" field="tbDataRecord_productdesc" width="80"></t:dgCol>
			   <t:dgCol title="数量" field="quantity" width="50"></t:dgCol>
			   <t:dgCol title="目录单价" field="tbDataRecord_unitprice" width="70"></t:dgCol>
			   <t:dgCol title="目录合价" field="catalogPrice" width="70"></t:dgCol>
			   <t:dgCol title="折扣率" field="discountrate" width="50"></t:dgCol>   
			   <t:dgCol title="折扣后价格" field="discountedPrice" width="70"></t:dgCol>
			   <t:dgCol title="运保及其他费率" field="tbDataRecord_otherrates" width="70"></t:dgCol>
			   <t:dgCol title="折扣后现场价" field="discountedAfterPrice" width="70"></t:dgCol>
			   <t:dgCol title="综合汇率" field="exchangeRate" width="50"></t:dgCol>
			   <t:dgCol title="安装服务费" field="installservicecharge" width="70"></t:dgCol>
			   <t:dgCol title="第一年保修期费用" field="firstYear" width="70"></t:dgCol>
			   <t:dgCol title="第二年保修期费用" field="secondYear" width="70"></t:dgCol>
			   <t:dgCol title="第三年保修期费用" field="thirdYear" width="70"></t:dgCol>
			   <t:dgCol title="合计" field="totalPrice" width="70"></t:dgCol>
			</t:datagrid>
		 
		  </c:if>
		 </c:forEach>
		</c:if>
		</div>
		<div title="同系列通用单元" data-options="closable:false,cache:false">
	  <c:if test="${fn:length(tbConfigModelDataPage)  > 0}">
		<c:forEach items="${tbConfigModelDataPage}" var="poVal" varStatus="stuts">
		 <c:if test="${poVal.tbDataRecord.tbProductType.tbProductCategory.id ==2}">
			   <t:datagrid name="tbConfigModelDataCheckList${stuts.index }" actionUrl="tbConfigModelDataController.do?datagrid&configId=${configId }&tbProductCategoryId=2" idField="id" fit="true" >
			   <t:dgCol title="编号" field="id" hidden="false"></t:dgCol>
			   <t:dgCol title="产品订货号" field="tbDataRecord_productorderno" width="70"></t:dgCol>
			   <t:dgCol title="产品名称" field="tbDataRecord_tbProductType_producttypename" width="70"></t:dgCol>
			   <t:dgCol title="产品描述" field="tbDataRecord_productdesc" width="80"></t:dgCol>
			   <t:dgCol title="数量" field="quantity" width="50"></t:dgCol>
			   <t:dgCol title="目录单价" field="tbDataRecord_unitprice" width="70"></t:dgCol>
			   <t:dgCol title="目录合价" field="catalogPrice" width="70"></t:dgCol>
			   <t:dgCol title="折扣率" field="discountrate" width="50"></t:dgCol>   
			   <t:dgCol title="折扣后价格" field="discountedPrice" width="70"></t:dgCol>
			   <t:dgCol title="运保及其他费率" field="tbDataRecord_otherrates" width="70"></t:dgCol>
			   <t:dgCol title="折扣后现场价" field="discountedAfterPrice" width="70"></t:dgCol>
			   <t:dgCol title="综合汇率" field="exchangeRate" width="50"></t:dgCol>
			   <t:dgCol title="安装服务费" field="installservicecharge" width="70"></t:dgCol>
			   <t:dgCol title="第一年保修期费用" field="firstYear" width="70"></t:dgCol>
			   <t:dgCol title="第二年保修期费用" field="secondYear" width="70"></t:dgCol>
			   <t:dgCol title="第三年保修期费用" field="thirdYear" width="70"></t:dgCol>
			   <t:dgCol title="合计" field="totalPrice" width="70"></t:dgCol>
			</t:datagrid>
		  </c:if>
		 </c:forEach>
		</c:if>
		</div>
		<div title="全通用单元" data-options="closable:false,cache:false">
		<c:if test="${fn:length(tbConfigModelDataPage)  > 0}">
			<c:forEach items="${tbConfigModelDataPage}" var="poVal" varStatus="stuts">
			  <c:if test="${poVal.tbDataRecord.tbProductType.tbProductCategory.id ==3}">
			   <t:datagrid name="tbConfigModelDataCheckList${stuts.index }" actionUrl="tbConfigModelDataController.do?datagrid&configId=${configId }&tbProductCategoryId=3" idField="id" fit="true" >
			  <t:dgCol title="编号" field="id" hidden="false"></t:dgCol>
			   <t:dgCol title="产品订货号" field="tbDataRecord_productorderno" width="70"></t:dgCol>
			   <t:dgCol title="产品名称" field="tbDataRecord_tbProductType_producttypename" width="70"></t:dgCol>
			   <t:dgCol title="产品描述" field="tbDataRecord_productdesc" width="80"></t:dgCol>
			   <t:dgCol title="数量" field="quantity" width="50"></t:dgCol>
			   <t:dgCol title="目录单价" field="tbDataRecord_unitprice" width="70"></t:dgCol>
			   <t:dgCol title="目录合价" field="catalogPrice" width="70"></t:dgCol>
			   <t:dgCol title="折扣率" field="discountrate" width="50"></t:dgCol>   
			   <t:dgCol title="折扣后价格" field="discountedPrice" width="70"></t:dgCol>
			   <t:dgCol title="运保及其他费率" field="tbDataRecord_otherrates" width="70"></t:dgCol>
			   <t:dgCol title="折扣后现场价" field="discountedAfterPrice" width="70"></t:dgCol>
			   <t:dgCol title="综合汇率" field="exchangeRate" width="50"></t:dgCol>
			   <t:dgCol title="安装服务费" field="installservicecharge" width="70"></t:dgCol>
			   <t:dgCol title="第一年保修期费用" field="firstYear" width="70"></t:dgCol>
			   <t:dgCol title="第二年保修期费用" field="secondYear" width="70"></t:dgCol>
			   <t:dgCol title="第三年保修期费用" field="thirdYear" width="70"></t:dgCol>
			   <t:dgCol title="合计" field="totalPrice" width="70"></t:dgCol>
			</t:datagrid>
		  </c:if>
		 </c:forEach>
		</c:if>
		</div>
	</div>
	<div id="t-tools" style="margin-right: 30px;">
		<a href="javascript:void(0)" onClick="back();" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-undo'" >返回</a>
	</div> 
		 
  </div>
 </div>
 <script type="text/javascript">
 
 	function back(){
 		var configId='${configId}';
 		$('#quotationsCheck').panel("refresh", "tbConfigModelDataController.do?checkBack&configId="+configId);
 	}
 	
 	
 </script>