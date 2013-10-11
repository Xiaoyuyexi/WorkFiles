<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:1px;">
  <t:datagrid name="tbPurchaseContractList" fitColumns="true" title="采购合同" actionUrl="tbPurchaseContractController.do?datagrid" idField="id" fit="true">
   <t:dgCol title="编号" field="id" hidden="false"></t:dgCol>
   <t:dgCol title="采购合同编号" field="contractNo" ></t:dgCol>
   <t:dgCol title="采购合同总价" field="contractPrice" ></t:dgCol>
   <t:dgCol title="备注" field="remark" ></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgFunOpt funname="detail(id)" title="明细"></t:dgFunOpt>
   <t:dgDelOpt title="删除" url="tbPurchaseContractController.do?del&id={id}" />
   <t:dgToolBar title="录入" icon="icon-add" url="tbPurchaseContractController.do?addorupdate" funname="add"></t:dgToolBar>
   <%--<t:dgToolBar title="编辑" icon="icon-edit" url="tbPurchaseContractController.do?addorupdate" funname="update"></t:dgToolBar>--%>
  </t:datagrid>
  </div>
  
  <div region="east"  style="width:900px;overflow: hidden;" split="true" border="false">
		<div class="easyui-panel" title="采购合同明细" style="padding:1px;" fit="true" border="false" id="detailpanel">
  		</div>
	</div>
 </div>
 <script type="text/javascript">
 function detail(id)
 {
	 $('#detailpanel').panel("refresh", "tbPurchaseContractController.do?detail&id=" +id);
 }
</script>