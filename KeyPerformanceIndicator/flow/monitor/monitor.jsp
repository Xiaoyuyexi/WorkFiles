<%@ page contentType="text/html;charset=utf-8" language="java" import="java.util.*" pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="com.shengdai.kpi.system.Globals" %>
<%@ include file="/web/pub/flow.inc"%>
<%@ include file="/flow/secure.inc" %>
<%
	//�������ҳ���޷�ˢ�µ�����
	response.setHeader("Cache-Control",""); //Forces caches to obtain a new copy of the page from the origin server
	response.setHeader("Cache-Control",""); //Directs caches not to store the page under any circumstance
	response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
  
	pageContext.setAttribute("FREQUENCY_YEAR",""+Globals.FREQUENCY_YEAR);
	pageContext.setAttribute("FREQUENCY_QUARTER",""+Globals.FREQUENCY_QUARTER);
	pageContext.setAttribute("FREQUENCY_MONTH",""+Globals.FREQUENCY_MONTH);
 %>
<html>
	<head>
		<title>�������μ�ر�</title>
	</head>
	<style type="text/css">
<!--
.bigbutton{
	width:200px;height:18px;font-size:12px;margin:1px;border:1px solid #A4B3C8;background-color:#DFE7EF;
}
-->
</style>
	<script src="${ROOT}/component/calendar/Calendar.js"></script>
	<script language="javascript">

function ev_detail(id){
var disp = document.getElementById(id).style.display;
if(disp=="none"){
document.all.detailButton.value="������ϸ";
document.getElementById(id).style.display = "";
}else{
document.all.detailButton.value="������ϸ";
document.getElementById(id).style.display = "none";
}
}

function startBatch(monitorId){
	var year = document.all.year.value;
	var type = document.all.scopeType.value;
	var value = "";
	if(year==""){
		alert("����ѡ����ݣ���");
		document.all.year.focus();
		return;
	}
	if(type==<%=Globals.FREQUENCY_MONTH%>){
		if(document.all.month.value==""){
			alert("����ѡ���·ݣ���");
			document.all.month.focus();
			return;
		}
		value = document.all.month.value;
	}
	if(type==<%=Globals.FREQUENCY_QUARTER%>){
		if(document.all.quarter.value==""){
			alert("����ѡ�񼾶ȣ���");
			document.all.quarter.focus();
			return;
		}
		value = document.all.quarter.value;
	}
	var url = "${ROOT}/nextRecBatchStart.do?id="+monitorId+"&type="+type+"&year="+year+"&month="+value+"&nocache="+Math.random()+urlPara;
	document.all.BATCH_ACTION_STARTING.style.display="";
	LoadAjaxContent(url,callBackMethod);
}

function callBackMethod(){
	document.all.BATCH_ACTION_STARTING.style.display="none";
	eval(this.request.responseText);
}

function viewDetail(obj){
	if(obj.value==""){
	    alert("��ѡ�񿼺�����!");
		return ;
	}
	var url = "${ROOT}/listWorklistForRecBatch.do?monitorId=<bean:write name="monitor" property="id"/>&id="+obj.value+"&nocache="+Math.random()+urlPara;
	document.all.form1.action = url;
	document.all.form1.submit();
}

function deleteRecBatch(id){
	if (confirm("��ȷ��Ҫɾ����¼��")) { 
		var url = "${ROOT}/deleteBatch.do?id=${recBatch.id}&monitorId=${monitor.id}"+urlPara;
		window.location = url;
	}
}

function batchSubmit(batchId,routeId){
	if (confirm("��ȷ��Ҫ�����ύ��·����")) { 
		var url = "${ROOT}/batchSubmitNext.do?batchId="+batchId+"&routeId="+routeId+"&nocache="+Math.random()+"&mid=<bean:write name="monitor" property="id" />"+urlPara;
		LoadAjaxContent(url,batchSubmitCallBackMethod);
	}
}

function batchSubmitCallBackMethod(){
	eval(this.request.responseText);
}

function saveRecBatchLimit(){
	if(document.all.id.value==""){
		alert("��ѡ��һ�������ڣ�");
		return;
	}
	if(confirm("���޸ĵ�·��ʱ��Ҫ������")){
	form1.action = "${ROOT}/addRecBatchLimit.do";
	form1.submit();
}
}
function unLoadSave(){
	if(document.all.limitChange.value=="1"){
		saveRecBatchLimit();
	}
}

function changeRecLimit(){
	document.all.limitChange.value = "1";
}

function linkToWorklistDetailInfo(flwCode,recBatchId,flwNodeCode,status){
	location.href = "${ROOT}/listFlowNodeDetailForDelegate.do?monitorId=<%=request.getParameter("monitorId")%>&flwCode="+flwCode+"&recBatchId="+recBatchId+"&flwNodeCode="+flwNodeCode+"&status="+status+urlPara;
}

function viewFreeFlowMonitor(flowCode,batchId,type){
	parent.location.href = "${ROOT}/listFreeFlowMonitor.do?monitorId=<%=request.getParameter("monitorId")%>&batchId="+batchId+"&parentFlowCode="+flowCode+"&type="+type+urlPara;
}

function hiddenLimitContent(){
	var value = document.all.limitContent.style.display;
	if(value=="none"){
		document.all.limitContent.style.display = "";
		document.all.limitHidden.value="����ʱ��";
	}else{
		document.all.limitContent.style.display = "none";
		document.all.limitHidden.value="��ʾʱ��";
	}
}

function hiddenStyle(){
	var type = document.all.scopeType.value;
	if(type==<%=Globals.FREQUENCY_YEAR%>){
		document.all.freq_moq_text.innerHTML = "";
		document.all.month.style.display = "none";
		document.all.quarter.style.display = "none";
	}
	if(type==<%=Globals.FREQUENCY_QUARTER%>){
		document.all.freq_moq_text.innerHTML = "����";
		document.all.month.style.display = "none";
		document.all.quarter.style.display = "";
	}
	if(type==<%=Globals.FREQUENCY_MONTH%>){
		document.all.freq_moq_text.innerHTML = "�·�";
		document.all.month.style.display = "";
		document.all.quarter.style.display = "none";
	}
}

function listStartSingleFlow(){
	window.location = "${ROOT}/listFlowSingle.do?batchId=${recBatch.id}&monitorId=${monitor.id}&fid=${monitor.flow.id}"+urlPara;
}

function listAllRecInfos(){
	window.location = "${ROOT}/listbosInBatch.do?batchId=${recBatch.id}&monitorId=${monitor.id}&fid=${monitor.flow.id}"+urlPara;
}

function ev_onload(){
	if(document.all.id.value!=""){
			/**document.getElementById("batchDelete").disabled=false;
			document.getElementById("listSingleFlowCreate").disabled=false;
			document.getElementById("listSingleFlowDelete").disabled=false;	
			**/			
	}
}
function openWin(batchId){
	var url = "${ROOT}/monitorStartOrgVoLog.do?batchId=${recBatch.id}&monitorId=${monitor.id}";
	window.location = url;
}
window.onload = function(){
	ev_onload();
}
</script>
<body>
	  <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" >
	  <%--
        <tr>
          <td class="dialog-titlebg"><div class="dialog-title">&nbsp;
             <input id='listSingleFlowCreate' type="button" class="button4" value="��������" onclick="listStartSingleFlow('create');" ${recBatch.id==null?"disabled='true'":""}/> 
             <input id='listSingleFlowDelete' type="button" class="button4" value="����ɾ��" onclick="listAllRecInfos();" ${recBatch.id==null?"disabled='true'":""}/>
             <input id='batchDelete' type="button" class="button4" value="����ɾ��" onclick="deleteRecBatch('${recBatch.id}');" ${recBatch.id==null?"disabled='true'":""}/>
            </div></td>
        </tr>
         --%><tr>
          <td class="dialog-titlebg"><div class="dialog-title">&nbsp;
          <c:forEach items="${resourceList}" var="o" varStatus="idx">
             <input id='listSingleFlowCreate' type="button" class="button4" value="${o.name}" onclick="${o.url}" ${recBatch.id==null?"disabled='true'":""}/> 
            </c:forEach>
            </div></td>
        </tr>
        <tr>
          <td>
<form id="form1" name="form1" method="post" action="">
			<table border="0" align="center" valign="top" width="90%">
				<tr>
					<td nowrap="nowrap" colspan="5">
						<center>
							<br/><font size="3pt" color="#666666"><b><u>���̼��</u></b></font>
						</center>
					</td>
				</tr>
				<tr>
					<td>
						<table width="100%" border="1" cellpadding="1" cellspacing="1" bordercolorlight="#B5CAFF" bordercolordark="#F4F5FF">
							<tr>
								<td nowrap="nowrap" width="15%">
									<b>��������:</b>
								</td>
								<td nowrap="nowrap" width="35%">
									<bean:write name="monitor" property="flow.flowName" />
									<INPUT type="hidden" name="limitChange" value="0"/>
								</td>
								<td nowrap="nowrap" width="15%">
									<b>Ƶ��:</b>
								</td>
								<td nowrap="nowrap" width="35%">
								${recBatch.bacthTypeToDesc }
								</td>
							</tr>
							<tr>
								<td nowrap="nowrap">
									<b>��ǰ��������:</b>
								</td>
								<td nowrap="nowrap">
									<html:select name="monitorForm" property="id" onchange="viewDetail(this)">
										<OPTION value="">
											--��ѡ��--
										</OPTION>
										<logic:notEmpty name="monitorList">
											<html:optionsCollection name="monitorList" value="id" label="batchName" />
										</logic:notEmpty>
									</html:select>&nbsp;									
								</td>
								<td nowrap="nowrap">
									<b>�������ʱ��:</b>
								</td>
								<td nowrap="nowrap">
								<fmt:formatDate value="${recBatch.genDate}" pattern="yyyy-MM-dd HH:mm"/>&nbsp;	
								</td>
							</tr>
							<c:if test="${recBatch!=null&&recBatch.id!=null }">
							<tr>
								<td nowrap="nowrap">
									<b>����״̬:</b>
								</td>
								<td nowrap="nowrap">
									${recBatch.statusName }
								</td>
								<td nowrap="nowrap">
									<b>������־:</b>
								</td>
								<td nowrap="nowrap">
									<a href="javascript:openWin('${recBatch.id }');">�鿴</a>
								</td>
							</tr>
							</c:if>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="5">
						<input type="button" class="button4" name="detailButton" value="������ϸ" onclick="ev_detail('detail');"/>
					</td>
				</tr>

				<tr id="detail">
					<td colspan="5" width="100%">
						<table id="tb1" width="100%" border="1" cellpadding="1" cellspacing="1" bordercolorlight="#B5CAFF" bordercolordark="#F4F5FF">
							<tr>
								<td class="title-header" align="center" width="20%" height="20">
									����
								</td>
								<td class="title-header" align="center" width="20%">
									δ����
								</td>
								<td class="title-header" align="center" width="20%" nowrap>
									�Ѵ���
								</td>
								<td class="title-header" align="center" width="20%" nowrap>
									��ʱδ����
								</td>
								<td class="title-header" align="center" width="20%">
									��ʱ�Ѵ���
								</td>
							</tr>
							<logic:notEmpty name="WorkListHtml">
								<bean:write name="WorkListHtml" filter="false" />
							</logic:notEmpty>
						</table>
					</td>
				</tr>
				</table>
			<hr width="89%" align="center"/>
		</form>

         </td>
        </tr>
      </table>
</body>
</html>
