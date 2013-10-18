<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<div class="easyui-layout" fit="true">

  <div data-options="region:'center'" title="数据详情" style="overflow:hidden;">	
	  <div id="myTabs" title="数据源详情" class="easyui-tabs" style="width:aotu;height:700px;">
		  <div title="基本配置单元" data-options="closable:false,cache:false">
	<c:if test="${fn:length(volist)  > 0}">
		<c:forEach items="${volist}" var="poVal" varStatus="stuts">
		<c:if test="${poVal.param ==1}">
		  <div class="easyui-panel" data-options="collapsible:true" title="${poVal.name}" style="overflow:hidden;height:300px;">
			   <t:datagrid name="tbDataRecordEntityList${stuts.index }"  actionUrl="${poVal.url}" idField="id" fit="true">
			   <t:dgCol title="编号" field="id" hidden="false"></t:dgCol>
			   <t:dgCol title="产品订货号" field="productorderno" ></t:dgCol>
			   <t:dgCol title="产品描述" field="productdesc" ></t:dgCol>
			   <t:dgCol title="数量" field="quantity" ></t:dgCol>
			   <t:dgCol title="目录单价" field="unitprice" ></t:dgCol>
			   <t:dgCol title="折扣率" field="discountrate" ></t:dgCol>
			   <t:dgCol title="运保及其他费率" field="otherrates" ></t:dgCol>
			   <t:dgCol title="安装服务费" field="installservicecharge" ></t:dgCol>
			   <t:dgCol title="第一年保修复" field="firstyear" ></t:dgCol>
			   <t:dgCol title="第二年保修费" field="secondyear" ></t:dgCol>
			   <t:dgCol title="第三年保修费" field="thirdyear" ></t:dgCol>
			   <t:dgCol title="备注" field="remark" ></t:dgCol>
		  </t:datagrid>
		  </div>
		  </c:if>
		 </c:forEach>
		</c:if>
		  </div>
		  <div title="同系列通用单元" data-options="closable:false,cache:false">
	<c:if test="${fn:length(volist)  > 0}">
		<c:forEach items="${volist}" var="poVal" varStatus="stuts">
		<c:if test="${poVal.param ==2}">
		  <div class="easyui-panel" data-options="collapsible:true" title="${poVal.name}" style="overflow:hidden;height:300px;">
			   <t:datagrid name="tbDataRecordEntityListTwo${stuts.index }"  actionUrl="${poVal.url}" idField="id" fit="true">
			   <t:dgCol title="编号" field="id" hidden="false"></t:dgCol>
			   <t:dgCol title="产品订货号" field="productorderno" ></t:dgCol>
			   <t:dgCol title="产品描述" field="productdesc" ></t:dgCol>
			   <t:dgCol title="数量" field="quantity" ></t:dgCol>
			   <t:dgCol title="目录单价" field="unitprice" ></t:dgCol>
			   <t:dgCol title="折扣率" field="discountrate" ></t:dgCol>
			   <t:dgCol title="运保及其他费率" field="otherrates" ></t:dgCol>
			   <t:dgCol title="安装服务费" field="installservicecharge" ></t:dgCol>
			   <t:dgCol title="第一年保修复" field="firstyear" ></t:dgCol>
			   <t:dgCol title="第二年保修费" field="secondyear" ></t:dgCol>
			   <t:dgCol title="第三年保修费" field="thirdyear" ></t:dgCol>
			   <t:dgCol title="备注" field="remark" ></t:dgCol>
		  </t:datagrid>
		  </div>
		  </c:if>
		  </c:forEach>
		  </c:if>
		  </div>
		 <div title="全通用单元" data-options="closable:false,cache:false">
	<c:if test="${fn:length(volist)  > 0}">
		<c:forEach items="${volist}" var="poVal" varStatus="stuts">
		<c:if test="${poVal.param ==3}">
		  <div class="easyui-panel" data-options="collapsible:true" title="${poVal.name}" style="overflow:hidden;height:300px;">
		  
			   <t:datagrid name="tbDataRecordEntityListThree${stuts.index }"  actionUrl="${poVal.url}" idField="id" fit="true">
			   <t:dgCol title="编号" field="id" hidden="false"></t:dgCol>
			   <t:dgCol title="产品订货号" field="productorderno" ></t:dgCol>
			   <t:dgCol title="产品描述" field="productdesc" ></t:dgCol>
			   <t:dgCol title="数量" field="quantity" ></t:dgCol>
			   <t:dgCol title="目录单价" field="unitprice" ></t:dgCol>
			   <t:dgCol title="折扣率" field="discountrate" ></t:dgCol>
			   <t:dgCol title="运保及其他费率" field="otherrates" ></t:dgCol>
			   <t:dgCol title="安装服务费" field="installservicecharge" ></t:dgCol>
			   <t:dgCol title="第一年保修复" field="firstyear" ></t:dgCol>
			   <t:dgCol title="第二年保修费" field="secondyear" ></t:dgCol>
			   <t:dgCol title="第三年保修费" field="thirdyear" ></t:dgCol>
			   <t:dgCol title="备注" field="remark" ></t:dgCol>
		  </t:datagrid>
		  </div>
		  </c:if>
		  </c:forEach>
		  </c:if>
		  </div>
	  	  
	  </div>
  </div>
 </div>