<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.*,com.shengdai.kpi.flow.valueobject.*" pageEncoding="GBK"%>
<%@ include file="/web/pub/flow.inc" %>
<%@ include file="/flow/secure.inc" %>
<%
	String nodeCode = request.getParameter("nodeCode");
 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>���˿���</title>
		<%request.setAttribute("flowNodeExtList2", request
					.getAttribute("flowNodeExtList"));
			String tab = request.getParameter("tab");
			if (tab == null || tab.equals("")) {
				tab = "0";
			}
			int size = ((List)request.getAttribute("nodeMineList")).size();

			%>
	</head>
<script language="javascript">

//�������༭ҵ�������������
function add_para(id){
	var returnValue = window.showModalDialog('${ROOT}/flow/flow_busi_param_add.jsp?id='+id,'','dialogHeight:380px;dialogWidth:470px;status=off')
     if(returnValue=="success"){
    location.href = "${ROOT}/nodeEditPage.do?nodeCode=<%=nodeCode%>&tab=3"+urlPara;   
    }
}

function editNodeExt(id){
var returnValue = window.showModalDialog('${ROOT}/busiParamEditPage.do?busiParamId='+id,'','dialogHeight:380px;dialogWidth:470px;status=off')
    if(returnValue=="success"){
    location.href = "${ROOT}/nodeEditPage.do?nodeCode=<%=nodeCode%>&tab=3"+urlPara;  
   }
}

function deleteNodeExt(id){
if (confirm("��ȷ��Ҫɾ����¼��")) { 
document.form2.action = "${ROOT}/deleteBusiParam.do?nodeCode=<%=nodeCode%>&type=nodeEdit&id="+id;
document.form2.submit();
}else{
return;
}
}

function checkJs(){
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
  var tbl = document.getElementById("remineTbl");
  rowsnum++;
  var arow = tbl.insertRow(Number(tempRowNum));
   var td = arow.insertCell(0);
  td.innerHTML="<a href='#'><img id='remine' src='${ROOT}/web/flow/img/remine.gif' border='0' value='1'></a>";
  var td = arow.insertCell(1);
  td.innerHTML="ϵͳ���ڴ��������<input type='hidden' name=\"fromHoure"+rowsnum+"\" class=editline size=2 value='0' >"+
  		"<INPUT  type='hidden' name='toHoure"+rowsnum+"' class=editline size=2 value='0' >����"+
  		"<input type='hidden' name='way"+rowsnum+"' value='1'>�ʼ�"+
  		"��ʽ����<input type='hidden' name='reminder"+rowsnum+"'value='1'>�����ˣ�"+
  		"ÿ<INPUT type='text' name='frequency"+rowsnum+"' class=editline size=2 value='' check=\"notBlank();isInt('0+');setNumber(0,999)\" required='true'>"+
  		"&nbsp;<select name='frequencyUnit"+rowsnum+"'><option value='1'>Сʱ</option><option value='2' selected>��</option></select>"+
  		"����һ��,��������Ϊ<INPUT type='text' name='remindContent"+rowsnum+"' class=editline size=70 value='' check=\"isString('#',50)\" required='true'>��";
  		
  var td = arow.insertCell(2);
  td.innerHTML="<img src='${ROOT}/web/flow/img/delete_1.gif' title='ɾ����ǰ������' border='0' onClick='javascript:deleteCurrentRow(this)'> ";
  tempRowNum++;
  var obj = document.all.rowsnum;
  obj.value = rowsnum;
  ary[parseInt(ary.length)]=rowsnum;
  
}

function deleteCurrentRow(obj,id)
{
	if(id!=""&&id!=undefined){
		if(confirm("��ȷ��Ҫɾ����¼��")){
			var nodeMinedeleteurl = "${ROOT}/deleteNodeMine.do?id="+id+"&nodeCode=<%=nodeCode%>&tab=1&noCache="+Math.random()+urlPara;
			LoadAjaxContent(nodeMinedeleteurl,deleteNodeMinecallBackMethod);
		}else{
			return;
		}
	}
	var tbl = document.getElementById("remineTbl");
	var rindex=obj.parentElement.parentElement.rowIndex;
	tbl.deleteRow(rindex);<%--ɾ����ǰ��--%>
	tempRowNum--;
	remove(ary,rindex)
	//alert(ary);
}

function deleteNodeMinecallBackMethod(){
eval(this.request.responseText);
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

function updateFlwNode(){
form2.action = "${ROOT}/editNode.do?flowCode=<%=request.getParameter("flowCode") %>&nodeCode=<%=nodeCode %>&remindIds="+ary+urlPara;
form2.submit();
}

function updateFlwNodeForRoot(){
form2.action = "${ROOT}/editNodeForRoot.do?flowCode=<%=request.getParameter("flowCode") %>&nodeCode=<%=nodeCode %>"+urlPara;
form2.submit();
}

<%-------------------------------- ���´��뿪ʼ����ͬ����ʽҳ��ķ�Ӧ ------------------------------------------%>
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

<%-------------------------------------- <<<<<<<<<<<<<<<<   >>>>>>>>>>>>>>>>> -------------------------------------%>

function selectView(){
var handleWay = document.all.handleWay.value;
if(handleWay.length==0){
	alert("��ѡ����ʽ!");
	return ;
}
var url = "${ROOT}/selectDefaultViewPage.do?nodeCode=${flwNode.nodeCode}&handleWay="+handleWay+urlPara;
var temps = document.all.viewId.value;
var obj = new Object();
obj.defaultView = temps;
var returnValue = window.showModalDialog(url,obj,"dialogHeight:450px;dialogWidth:700px;status=no");
    if(returnValue!=""&&returnValue!=undefined){
    var returnTemps = returnValue.split(":");
    //alert(returnValue);
   document.all.viewName.value = returnTemps[0];
   document.all.viewId.value = returnTemps[1];
   }
}

function addVariable(){
	form2.msgTitle.value=form2.msgTitle.value+form2.variable.value;
}

function ev_handler(){
	var url="${ROOT}/flow/select_handler.jsp";
	window.showModalDialog(url,'',"dialogHeight:550px;dialogWidth:750px;status=no");
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
	<body style="OVERFLOW: auto" text=#000000 bgColor=#f0f0f0 leftMargin=0 topMargin=3 >
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="define-box1">
  <tr>
    <td height="100%" width="100%" valign="top" class="define-text-bg"><div style="overflow-y:auto;height:100%" class="scroll-net">
		<br>
		<form id="form2" name="form2" method="post" action="">
		<% FlwNode node = (FlwNode)request.getAttribute("flwNode");%>
			<table cellSpacing=0 cellPadding=0 width=600 align=center border=0>
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
									<input name="flowCode" type="hidden" value="" />
									<input name="nodeCode" type="hidden" value="<bean:write name="flwNode" property="nodeCode"/>" />
									<TBODY>
									
										<TR>
											<td width="8%" align="right">
												<font color="red">*</font>
											</td>
											<TD align=left width="20%" height=35>
												�������ƣ�
											</TD>
											<TD width="72%" height=25>
												<INPUT class=editline size=30 value="<bean:write name="flwNode" property="nodeName"/>" name="nodeName" check="notBlank" showName="��������" required="true" maxlength="50"/>
											</TD>
										</TR>
										<TR>
											<td align="right"></td>
											<TD align=left height=35>
												����˵����
											</TD>
											<TD height=25>
												<INPUT class=editline size=30 value="<bean:write name="flwNode" property="memo"/>" name="memo" maxlength="50">
											</TD>
										</TR>
										<logic:equal name="flwNode" property="flgRoot" value="0">
										<TR>
											<td align="right"></td>
											<TD align=left height=35>
												��ʾ˳��
											</TD>
											<TD height=25>
												<bean:write name="flwNode" property="priority" />
											</TD>
										</TR>
										<TR>
											<td align="right">
												<font color="red" >*</font>
											</td>
											<TD align=left height=35>
												����ʽ��
											</TD>
											<TD height=25 nowrap="nowrap">
											<html:select name="nodeForm" property="handleWay" onchange="changetState(1)">
											<option value="">--��ѡ����ʽ--</option>
											<html:optionsCollection name="handleTypewayList" value="id" label="selectLable"/>
											</html:select>
											<br/>
											<font color="red" id="methodAlert"></font>
											</TD>
										</TR>
										<TR id="nodeHandlerTr">
											<td align="right">
												
											</td>
											<TD align=left height=35>
												���ڴ����ˣ�
											</TD>
											<TD height=25>
											<input type="hidden" name="nodeHandler" value="<%=node.getNodeHandler()==null?"":node.getNodeHandler().getId() %>"/>
											<INPUT type="hidden" name="nodeProcessorValue" value="<%=node.getNodeHandler()==null?"":node.getNodeHandler().getValue() %>"/>
											<INPUT id="nodeProcessorText" class=editline size=35 value="<%=node.getNodeHandler()==null?"":node.getNodeHandler().getText() %>" name="nodeProecessorText" readonly="readonly">
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
											
											  <INPUT class=editline size=30 value="${flwNode.viewName }" name="viewName" check="notBlank" showName="������ʾ��ʽ" required="true" readonly="readonly">
											  <INPUT type="hidden" name="viewId" value="${flwNode.viewId }">
											  <INPUT type="button" name="selectTemp" value="ѡ��" onclick="javascript:selectView()" class="button">
											  <br><html:checkbox name="flwNode" property="flgFullScreen" value="1">ȫ���򿪴���</html:checkbox>  
											</TD>
										</TR>
										<TR  id="spreadMethod">
											<td align="right">
												<font color="red">*</font>
											</td>
											<TD align=left height=35>
												�Ƿ���
											</TD>
											<TD height=25>
												<html:radio name="flwNode" property="flgSpread" value="1"  onclick="changetSpreadPersonStatus(1)"/>
												��&nbsp;
												<html:radio name="flwNode" property="flgSpread" value="0"  onclick="changetSpreadPersonStatus(0)"/>
												��
											</TD>
										</TR>
										<TR  id="spreadPerson" <logic:equal name="flwNode" property="flgSpread" value="0" >style="display:none"</logic:equal> >
											<td align="right">												
											</td>
											<TD align=left height=35>
												������
											</TD>
											<TD align=left height=35 colspan="2">
											<input type="hidden" name="spreadHandler" value="<%=node.getSpreadHandler()==null?"":node.getSpreadHandler().getId() %>"/>
											<INPUT type="hidden" name="spreadProcessorValue" value="<%=node.getSpreadHandler()==null?"":node.getSpreadHandler().getValue() %>"/>
											<INPUT id="spreadProcessorText" class=editline size=35 value="<%=node.getSpreadHandler()==null?"":node.getSpreadHandler().getText()%>" name="spreadProecessorText" readonly="readonly">
											<input type='button' id='b1' value='ѡ��' class="button"
											  onclick="javascript:getAddressList('10;20','n','1','spreadProcessorText','spreadProcessorValue');" >
											</TD>
										</TR>
										</logic:equal>										
										<tr>
											<td colspan="3" align="left">
												<font color="#0099FF">˵�������ǣ�</font><font color="red">*</font><font color="#0099FF">������Ϊ��</font>
											</td>
										</tr>
								</table>
							</DIV>
							<logic:equal name="flwNode" property="flgRoot" value="0">
							<DIV class=tab-page id=tabPage2>
								<H2 class=tab>
									��չ����
								</H2>
								<SCRIPT type=text/javascript>tp1.addTabPage( document.getElementById( "tabPage2" ) );</SCRIPT>
								<!-- ����Ƕ�����̸��� -->
								<INPUT type="hidden" name="rowsnum" value="">
								<table id="tbl" class=box style="FONT-SIZE: 9pt" cellSpacing=1 cellPadding=5 width="100%" border=0>
								<tr>
									<td>
										<FIELDSET align=center style="width:96%;">
	       							<LEGEND>��������</LEGEND>
	       							<input type='button' name='addRemine' onclick="addRow();return false;" value='����' class="button">
	       							<table id="remineTbl" cellSpacing=1 cellPadding=5 width="100%" border=0>
									<logic:iterate id="nodeMine" name="nodeMineList" indexId="index">
									<input type="hidden" name="id<bean:write name="index"/>" value="<bean:write name="nodeMine" property="id"/>"/>
									<input type="hidden" name="srcId<bean:write name="index"/>" value="<bean:write name="nodeMine" property="srcId"/>"/>
									<tr>
									<td>
									<a href='#'><img id='remine' src='${ROOT}/web/flow/img/remine.gif' border='0' value='1'></a>
									</td>
									<%
										String maxValue = Integer.MAX_VALUE+"";
										pageContext.setAttribute("maxValue",maxValue);
									%>
									<td>
									ϵͳ���ڴ��������<input type="hidden" name="fromHoure<bean:write name="index"/>" class=editline size=2 value='<bean:write name="nodeMine" property="formHoure"/>' >
									<INPUT  type='hidden' name='toHoure<bean:write name="index"/>' class=editline size=2 value='<logic:notEqual name="nodeMine" property="toHoure" value="${maxValue }"><bean:write name="nodeMine" property="toHoure"/></logic:notEqual>' >
									����
									<input type='hidden' name='way<bean:write name="index"/>' value='1'>									
									�ʼ�
									��ʽ����
									<input type='hidden' name='reminder<bean:write name="index"/>' value='1'>
									������
									
									��ÿ<INPUT type='text' name='frequency<bean:write name="index"/>' class=editline size=2 value='<bean:write name="nodeMine" property="frequency"/>' check="notBlank();isInt('0+');setNumber(0,999)" required='true'>
									<select name='frequencyUnit<bean:write name="index"/>'>									
									<option value='1' <logic:equal name="nodeMine" property="frequencyUnit" value="1">selected</logic:equal>>Сʱ</option>
									<option value='2' <logic:equal name="nodeMine" property="frequencyUnit" value="2">selected</logic:equal>>��</option>
									</select>
									����һ��,��������Ϊ<INPUT type='text' name='remindContent<bean:write name="index"/>' class=editline size=70 value='<bean:write name="nodeMine" property="remineContent"/>' check="isString('#',50)" required='true'>��
									</td>
									<td>
									<img src='${ROOT}/web/flow/img/delete_1.gif' border='0' title="ɾ������������" onClick='javascript:deleteCurrentRow(this,"<bean:write name="nodeMine" property="id"/>")'> 
									</td>
									</tr>
									</logic:iterate>
										<tr>																			
											<td colspan="2">
												<font color="red">*</font>˵����</br>
												����ÿ�������ʱ������һ�δ����ˣ���ϵͳ���ڴ�������Ժ����ʼ���ʽ����
												�����ˣ�ÿ��1�����졿����һ�Σ���������Ϊ��******����</br>
												ע��ʱ��������Ϊ���ҷ�ΧΪ0~999����������Ϊ0ʱϵͳֻ����һ�δ�����;��������������50�������ڣ�
												Ϊ��ʱĬ��Ϊ�����ã����ļ�Чϵͳ�������Ĵ��죬������ʱ������
											</td>
										</tr>
	       							</table>
	       						</FIELDSET>
									</td>
								</tr>
								</table>
							</DIV>
							<DIV class=tab-page id=tabPage4>
								<H2 class=tab>
									ҵ���������
								</H2>
								<SCRIPT>tp1.addTabPage( document.getElementById( "tabPage4" ) );</SCRIPT>
								<!-- ����Ƕ��ҵ��������� -->
								<jsp:include flush="true" page="flow_ext_use.jsp" >
								<jsp:param name="mainId" value="<%=nodeCode%>" />
	  							</jsp:include>
							</DIV>
							<%--IUserService userService = (IUserService)SpringHelper.getBean("userService");
							User currentUser = userService.findUserById(CommonLoginUser.getCurrentUserId());
							if(currentUser.isSARole()){ --%>
							<DIV class=tab-page id=tabPage5>
								<H2 class=tab>
									ҵ���������
								</H2>
								<SCRIPT>tp1.addTabPage( document.getElementById( "tabPage5" ) );</SCRIPT>
								<!-- ����Ƕ��ҵ��������� -->
							<table class=box border=0 style="FONT-SIZE: 9pt" cellSpacing=1 cellPadding=5 width="100%" border=0>
	  						<tr><td width="100%">
								<jsp:include flush="true" page="flow_ext_config.jsp" >
								<jsp:param name="mainId" value="<%=nodeCode%>" />
	  							</jsp:include>
	  						</td></tr> 
							</table>
							</DIV><%--} --%>
<%-- �ȴ�������� zyf
							
							<DIV class=tab-page id=tabPage3>
								<H2 class=tab>
									���̸���
								</H2>
								<SCRIPT type=text/javascript>tp1.addTabPage( document.getElementById( "tabPage3" ) );</SCRIPT>
								<!-- ����Ƕ�����̸��� -->
								<%String url = request.getContextPath()
					+ "/nodeEditPage.do?nodeCode="
					+ request.getParameter("nodeCode") + "&tab=1";

			%>
								<jsp:include page="/common/upload/attachList.jsp" flush="true">
									<jsp:param name="id" value="<%=request.getParameter("nodeCode")%>" />
									<jsp:param name="delete" value="false" />
									<jsp:param name="url" value="<%=url%>" />
								</jsp:include>
							</DIV>
							

							
--%></logic:equal>
						</DIV>
						<!-- 	����TAB���� -->
					</td>
				</tr>
			</table>
		</form>
</div></td></tr></table>
	</body>
<script>
<logic:equal name="flwNode" property="flgRoot" value="0">
	changetState();	
</logic:equal>
</script>
</html>
