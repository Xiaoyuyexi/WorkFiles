<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*,com.shengdai.kpi.flow.valueobject.*" pageEncoding="GBK"%>
<%@ include file="/web/pub/flow.inc" %>
<%@ include file="/flow/secure.inc" %>
<html>
	<head>
		<title>���˿���</title>
		<%request.setAttribute("flowNodeExtList2", request
					.getAttribute("flowNodeExtList"));
			String tab = request.getParameter("tab");
			if (tab == null || tab.equals("")) {
				tab = "0";
			}
			int size = 0;

			%>
	</head>
	<script language="javascript">

//�ϴ�����
function upload(){
	window.open('attachment.htm','','height=300,width=420,top=200, left=200,toolbar =no, menubar=no, scrollbars=no, resizable=no, location=no, status=no')
}

function checkJs(){
/*if(checkSelectByName("flgHead",1,"�Ƿ����̷��𻷽�")) { 
 return true;
}*/

return true;
}

var rowsnum=<%=size%>;<%--��¼����--%>
var rindex="";
var rindex1="";
var tempRowNum = <%=size%>;
var ary = new Array();
<%
if(size==0){
out.println("ary[0] = 0;");
}
for(int i=0;i<size;i++){
out.println("ary["+i+"] = "+i+";");
}
%>
function addRow(){
  rowsnum++;
  var arow = tbl.insertRow(Number(tempRowNum));
   var td = arow.insertCell(0);
  td.innerHTML="<a href='#'><img id='remine' src='${ROOT}/web/flow/img/remine.gif' border='0' value='1'></a>";
  var td = arow.insertCell(1);
  td.innerHTML="ϵͳ����ʱ��ǰ<input type='text' name=\"fromHoure"+rowsnum+"\" class=editline size=2 value='' >Сʱ��<INPUT  type='text' name='toHoure"+rowsnum+"' class=editline size=2 value= >Сʱ��<select name='way"+rowsnum+"'><option value='0'>С��ͨ����</option><option value='1'>�ʼ�</option><option value='2'>ϵͳ����Ϣ</option></select>��ʽ����<select name='reminder"+rowsnum+"'><option value='0'>�߰���</option><option value='1'>������</option></select>��ÿ<INPUT type='text' name='frequency"+rowsnum+"' class=editline size=2 value= >��������һ��,��������Ϊ<INPUT type='text' name='remindContent"+rowsnum+"' class=editline size=40 value= >��";
  var td = arow.insertCell(2);
  td.innerHTML="<img src='${ROOT}/web/flow/img/delete_1.gif' border='0' onClick='javascript:deleteCurrentRow(this)'> ";
  tempRowNum++;
  var obj = document.all.rowsnum;
  obj.value = rowsnum;
  ary[parseInt(ary.length)]=rowsnum;
  
}

function deleteCurrentRow(obj)
{
	var rindex=obj.parentElement.parentElement.rowIndex;
	tbl.deleteRow(rindex);<%--ɾ����ǰ��--%>
	tempRowNum--;
	remove(ary,rindex)
	//alert(ary);
}

function remove(array,index)
{
    if(isNaN(index)||index>array.length){return false;}
    for(var i=0,n=0;i<array.length;i++)
    {
        if(array[i]!=array[index])
        {
            array[n++]=array[i]
        }
    }
   if(array.length!=0){
    array.length-=1
    }
}
/**���ӻ���*/
function addFlowNode(flowCode){
	var url = "";
	if(${addNodeAuto}==0){
		url = "${ROOT}/addNode.do?flowCode="+flowCode+"&remindIds="+ary+urlPara;
	}else if(confirm("����Ҫ�Զ������һ���ڵ�·����")){
		url = "${ROOT}/addNode.do?flowCode="+flowCode+"&remindIds="+ary+"&autoRoute=autoRoute"+urlPara;
	}else{
		url = "${ROOT}/addNode.do?flowCode="+flowCode+"&remindIds="+ary+urlPara;
	}
	form1.action = url;
	form1.submit();
}
/**
function changetState(){
	var value = document.all.handleWay.value;
	if(value==12){
		document.all.methodAlert.innerText="��ÿ��ָ�����ô�����,��������/���˱����ÿ��˹�ϵ;";
		document.all.nodeHandlerTr.style.display = "none";
	}else if(value==11){
		document.all.methodAlert.innerText="������ָ������������,��������/���˱����ÿ��˹�ϵ;";
		document.all.nodeHandlerTr.style.display = "none";
	}else if(value==13){
		document.all.methodAlert.innerText="";//����ȴ���ʽ;
		document.all.nodeHandlerTr.style.display = "none";
	}else if(value==1){
		document.all.methodAlert.innerText="��������˰�˳����д���,��һ���˴����,�ڶ����˲����յ�����;";
		document.all.nodeHandlerTr.style.display = "";
	}else if(value==2){
		document.all.methodAlert.innerText="������ô�����,һ���˴���������˲�������;";
		document.all.nodeHandlerTr.style.display = "";
	}else if(value==3){
		document.all.methodAlert.innerText="������ô�����,����ÿ���˴��������ύ����һ����,ͬʱ�յ�����;";
		document.all.nodeHandlerTr.style.display = "";
	}else if(value==7){
		document.all.methodAlert.innerHTML="����������е��������̶��ߵ��˻��ڲ����ύ����һ����,<br/>һ���˴���������˲�������;";
		document.all.nodeHandlerTr.style.display = "";
	}else if(value==15){
		document.all.methodAlert.innerHTML="�ʾ������ô�����(��ǩ��ʽ�ύ);";
		document.all.nodeHandlerTr.style.display = "none";
	}else if(value==""){
		document.all.methodAlert.innerText="��ѡ����ʽ;";
		document.all.nodeHandlerTr.style.display = "none";
	}else if(value==16){				//add by dkm 08-03-26
		document.all.methodAlert.innerText="������ô�����,����ÿ���˴��������ύ����һ����,ͬʱ�յ�����;";
		document.all.nodeHandlerTr.style.display = "";
	}else if(value==17){
		document.all.methodAlert.innerText="������ô�����,����ÿ���˴��������ύ����һ����,ͬʱ�յ�����;";
		document.all.nodeHandlerTr.style.display = "";
	}else if(value==18){
		document.all.methodAlert.innerText="������ô�����,����ÿ���˴��������ύ����һ����,ͬʱ�յ�����;";
		document.all.nodeHandlerTr.style.display = "";
	}else if(value==19){
		document.all.methodAlert.innerText="������ô�����,����ÿ���˴��������ύ����һ����,ͬʱ�յ�����;";
		document.all.nodeHandlerTr.style.display = "";
	}
	
    document.all.viewName.value = "";
    document.all.viewId.value = "";
    //document.all.spreadUrl.value = "";
    //document.all.doneUrl.value = "";  
}**/
var ways = new Array();
function way(id, tip, flgNeedHandler){
	this.id = id;
	this.tip = tip;
	this.flgNeedHandler = flgNeedHandler;	
}
<logic:iterate id="way" name="handleTypewayList" indexId="index" >
	var way<%=index%> = new way();
	way<%=index%>.id='<bean:write name="way" property="id" />';
	way<%=index%>.tip='<bean:write name="way" property="pageRemark" />';
	way<%=index%>.flgNeedHandler='<bean:write name="way" property="flgNeedHandler" />';
	ways[<%=index%>]=way<%=index%>;
</logic:iterate>
function changetState(flag){
	var value = document.all.handleWay.value;
	if(value==""){
		document.all.methodAlert.innerText="��ѡ����ʽ;";
		document.all.nodeHandlerTr.style.display = "none";
	}else{
		for(var i=0; i<ways.length; i++){
			var way = ways[i];
			if(way.id==value){
				document.all.methodAlert.innerText=way.tip;
				if(way.flgNeedHandler=='1')
					document.all.nodeHandlerTr.style.display = "";
				else
					document.all.nodeHandlerTr.style.display = "none";
			}
		}
	} 	
	
	if(flag==1){
	    document.all.viewName.value = "";
	    document.all.viewId.value = "";
    }
}
function selectView(){
var handleWay = document.all.handleWay.value;
if(handleWay.length==0){
	alert("��ѡ����ʽ!");
	return ;
}
//alert("handleWay:"+handleWay);
var url = "${ROOT}/selectDefaultViewPage.do?flowCode=<%=request.getParameter("flowCode")%>&nodeCode=<%=request.getParameter("nodeCode")%>&handleWay="+handleWay;
var temps = document.all.viewId.value;
var obj = new Object();
obj.defaultView = temps;
var returnValue = window.showModalDialog(url,obj,"dialogHeight:450px;dialogWidth:700px;status=no");
    if(returnValue!=""&&returnValue!=undefined){
    var returnTemps = returnValue.split(":");
   document.all.viewName.value = returnTemps[0];
   document.all.viewId.value = returnTemps[1];
   }
}

function changetSpreadPersonStatus(flgSpread){
if(flgSpread==1){
document.all.spreadPerson.style.display="";
}
if(flgSpread==0){
document.all.spreadPerson.style.display="none";
}
}
</script>
	<body style="OVERFLOW: auto" text=#000000 bgColor=#f0f0f0 leftMargin=0 topMargin=3>
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="define-box1">
  <tr>
    <td height="100%" width="100%" valign="top" class="define-text-bg"><div style="overflow-y:auto;height:100%" class="scroll-net">
		<br>
		<form name="form1" method="post" action="" id="form1">
			<table cellSpacing=0 cellPadding=0 width=500 align=center border=0>
				<tr>
					<td>
						<br>
						<DIV class=tab-pane id=tabPane1>
							<SCRIPT type=text/javascript>
	tp1 = new WebFXTabPane( document.getElementById( "tabPane1" ) );
	tp1.selectedIndex =<%=tab%>;
	</SCRIPT>



							<DIV class=tab-page id=tabPage1>
								<H2 class=tab>
									��������
								</H2>
								<SCRIPT type=text/javascript>tp1.addTabPage( document.getElementById( "tabPage1" ) );</SCRIPT>
								<!-- ����Ƕ�����̻������� -->
								<table class=box style="FONT-SIZE: 9pt" cellSpacing=1 cellPadding=5 width="100%" border=0>
									<TBODY>
										<TR>
											<td width="8%" align="right">
												<font color="red">*</font>
											</td>
											<TD align=left width="20%" height=35>
												�������ƣ�
											</TD>
											<TD width="72%" height=25>
												<INPUT class=editline size=30 value="" name="nodeName" check="notBlank" showName="��������" required="true" maxlength="50"/>
											</TD>
										</TR>
										<TR>
											<td align="right"></td>
											<TD align=left height=35>
												����˵����
											</TD>
											<TD height=25>
												<INPUT class=editline size=30 value="" name="memo" maxlength="50"/>
											</TD>
										</TR>
										<TR>
											<td align="right">
												<font color="red">*</font>
											</td>
											<TD align=left height=35>
												����ʽ��
											</TD>
											<TD height=25 nowrap="nowrap">
											<html:select name="nodeForm" property="handleWay" onchange="changetState(1);">
											<option value="">--��ѡ��--</option>
											<html:optionsCollection name="handleTypewayList" value="id" label="selectLable"/>
											</html:select><br/>
											<font color="red" id="methodAlert">��ѡ����ʽ;</font>
											</TD>
										</TR>
										<TR  id="nodeHandlerTr" style="display:none">
											<td align="right">
												
											</td>
											<TD align=left height=35>
												���ڴ����ˣ�
											</TD>
											<TD height=25>
											<INPUT type="hidden" name="nodeProcessorValue" />
											<INPUT id="nodeProcessorText" class=editline size=35 readonly="readonly">
											<input type='button' id='b1' value='ѡ��' class="button"
											  onclick="javascript:getAddressList('10;40;20;100','n','1;10;','nodeProcessorText','nodeProcessorValue');" >
											</TD>
										</TR>
										<TR>
											<td align="right">
												<font color="red">*</font>
											</td>
											<TD align=left height=35>
												������ʾ��ʽ��
											</TD>
											<TD height=25>
											  <INPUT class=editline size=30 value="" name="viewName" readonly="readonly" check="notBlank" showName="������ʾ��ʽ" required="true">
											  <INPUT type="hidden" name="viewId" value="">
											  <INPUT type="button" name="selectTemp" value="ѡ��" onclick="javascript:selectView()" class="button">
											  <br><input type="checkbox" name="flgFullScreen" value="1">ȫ���򿪴��� 
											</TD>
										</TR>
										<TR id="spreadMethod">
											<td align="right">
												<font color="red">*</font>
											</td>
											<TD align=left height=35>
												�Ƿ���
											</TD>
											<TD height=25>
												<input type="radio" name="flgSpread" value="1" onclick="changetSpreadPersonStatus(1)"/>
												��&nbsp;
												<input type="radio" name="flgSpread" value="0" onclick="changetSpreadPersonStatus(0)" checked="checked"/>
												��
											</TD>
										</TR>
										<TR id="spreadPerson" style="display: none;">
											<td align="right">												
											</td>
											<TD align=left height=35>
												������
											</TD>
											<TD align=left height=35 colspan="2">
											<INPUT type="hidden" name="spreadProcessorValue" />
											<INPUT id="spreadProcessorText" class=editline size=35  name="spreadProecessorText" readonly="readonly">
											<input type='button' id='b1' value='ѡ��' class="button"
											  onclick="javascript:getAddressList('0;10;20','n','1','spreadProcessorText','spreadProcessorValue');" >
											</TD>
										</TR>
										<!-- �ڵ�Ȩ��,��ʱ��ע�� add by zyf 
										<TR id="nodePermisson" >
											<td align="right"></td>
											<TD align=left height=35>
												�ڵ�Ȩ��:
											</TD>
											<TD height=25>
												<input type="checkbox" name="flgModify" value="1">
												���޸����� 
											</TD>
										</TR>
										 -->
										<tr>
											<td colspan="3" align="left">
												<font color="#0099FF">˵�������ǣ�</font><font color="red">*</font><font color="#0099FF">������Ϊ��</font>
											</td>
										</tr>
								</table>
							</DIV>

						</DIV>
						<!-- 	����TAB���� -->
					</td>
				</tr>
			</table>
		</form>
</div></td></tr></table>
	</body>
</html>
