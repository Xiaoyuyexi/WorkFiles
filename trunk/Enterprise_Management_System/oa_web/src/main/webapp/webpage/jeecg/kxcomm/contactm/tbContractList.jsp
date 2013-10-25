<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:1px;">
  <t:datagrid name="tbContractList" fitColumns="true" title="销售合同" actionUrl="tbContractController.do?datagrid" idField="id" fit="true" onClick="contractDetail" queryMode="group">
   <t:dgCol title="编号" field="id" hidden="false"></t:dgCol>
   <t:dgCol title="合同编号" field="contractNo" query="true"></t:dgCol>
   <t:dgCol title="内部合同编号" field="contractNumber"></t:dgCol>
   <t:dgCol title="合同名称" field="contractName" ></t:dgCol>
   <t:dgCol title="客户名称" field="customer" ></t:dgCol>
   <t:dgCol title="合同金额" field="contractPrice" ></t:dgCol>
   <t:dgCol title="负责人" field="creatorId" ></t:dgCol>
   <t:dgCol title="合同签订日期" field="contractDate" ></t:dgCol>
   <t:dgCol title="已回款金额" field="backMoney" ></t:dgCol>
   <t:dgCol title="未回款金额" field="unbackMoney" ></t:dgCol>
   <t:dgCol title="备注" field="remark" ></t:dgCol>
  
   <t:dgToolBar title="录入" icon="icon-add" url="tbContractController.do?addorupdate" funname="add"  ></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="tbContractController.do?addorupdate" funname="update"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="tbContractController.do?addorupdate" funname="detail"></t:dgToolBar>
   <t:dgToolBar title="删除" icon="icon-remove"  url="tbContractController.do?del"  funname="delone"></t:dgToolBar>
  </t:datagrid>
  </div>
  
<!--   <div region="south"  style="height:200px;overflow: hidden;" split="true" border="false">
	<div class="easyui-panel" title="产品信息" style="padding:1px;" fit="true" border="false" id="contractDetailpanel">
		
  	</div>
  </div> -->
 </div>
<script type="text/javascript">
/*  function contractDetail(rowIndex, rowData)
 {
	 $('#contractDetailpanel').panel("refresh", "tbContractController.do?contractDetail&id="+rowData.id);
 } */
 /*
 $(function() {
		$('#tbContractList').datagrid({
			onClickRow:function(rowIndex, rowData){
				contractDetail(rowData.id);
			}
		});
		
		$('#tbContractList').datagrid({
			onDblClickRow:function(rowIndex, rowData){
				openwindow('编辑','tbContractController.do?addorupdate&id='+rowData.id);
			}
		});
	});
 */
 function delone(title,url, id) {
		var rowData = $('#'+id).datagrid('getSelected');
		if (!rowData) {
			tip('请选择要删除');
			return;
		}
		delObj('tbContractController.do?del&id='+ rowData.id,'tbContractList');
	}
</script>