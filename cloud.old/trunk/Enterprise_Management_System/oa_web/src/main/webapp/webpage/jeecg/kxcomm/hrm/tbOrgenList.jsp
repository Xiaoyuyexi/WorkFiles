<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:1px;">
  <t:datagrid name="tbOrgenList" title="机构表" actionUrl="tbOrgenController.do?datagrid" idField="id" fit="true">
   <t:dgCol title="编号" field="id" hidden="false"></t:dgCol>
   <t:dgCol title="机构名称" field="permName" ></t:dgCol>
   <t:dgCol title="联系电话" field="orgenPhone" ></t:dgCol>
   <t:dgCol title="地址" field="place" ></t:dgCol>
   <t:dgCol title="类型" field="type" replace="总公司_1,分公司_2,办事处_3"></t:dgCol>
   <t:dgCol title="成立时间" field="createTime" formatter="yyyy-MM-dd"></t:dgCol>
   <t:dgCol title="上级机构" field="parentOrgen"  hidden="false"></t:dgCol>
   <t:dgCol title="组织机构代码" field="number" ></t:dgCol>
   <t:dgCol title="手机号码" field="tellPhone" ></t:dgCol>
   <t:dgCol title="税务登记证" field="businessLicenseNo" ></t:dgCol>
   <t:dgCol title="开户行名称" field="bankName" ></t:dgCol>
   <t:dgCol title="营业执照" field="taxRegistrationCertificate" ></t:dgCol>
   <t:dgToolBar title="录入" icon="icon-add" url="tbOrgenController.do?addorupdate" funname="add"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="tbOrgenController.do?addorupdate" funname="update"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="tbOrgenController.do?addorupdate" funname="detail"></t:dgToolBar>
   <t:dgToolBar title="删除" icon="icon-remove" url="tbOrgenController.do?del" funname="delone"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
<script type="text/javascript">
  function delone(title,url, id) {
 	var rowData = $('#'+id).datagrid('getSelected');
 	if (!rowData) {
 		tip('请选择删除项目');
 		return;
 	}
 	
 	url += '&id='+rowData.id;
 	delObj(url,id);
 	
 }
</script>