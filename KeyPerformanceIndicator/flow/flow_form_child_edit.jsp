<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.*" pageEncoding="GBK"%>
<jsp:directive.page import="com.shengdai.kpi.system.SpringHelper"/>
<%@ page import="com.shengdai.kpi.system.Globals" %>
<jsp:directive.page import="com.shengdai.kpi.flow.valueobject.FlwRoute"/>
<jsp:directive.page import="com.shengdai.kpi.flow.valueobject.FlwFlow"/>
<jsp:directive.page import="com.shengdai.kpi.flow.valueobject.FlwNode"/>
<%@ include file="/web/pub/flow.inc" %>
<%@ include file="/flow/secure.inc" %>
<html> 
<head>
<%
	request.setAttribute("flowNodeExtList2",request.getAttribute("flowNodeExtList"));
	String flowCode = request.getParameter("flowCode");
	String tab = request.getParameter("tab");
	if(tab==null||tab.equals("")){
		tab = "0";
	}
	int size = ((List)request.getAttribute("nodeMineList")).size();
%>
</head>
<script>
<%if("1".equals(request.getParameter("save"))){%>
	parent.parent.topFrame.enableButtons();//�����ť���¼���
<%}%>

//�������༭ҵ�������������
function add_para(id){
	var returnValue = window.showModalDialog('${ROOT}/flow/flow_busi_param_add.jsp?id='+id,'','dialogHeight:450px;dialogWidth:470px;status=off')
    if(returnValue=="success"){
    	location.href = "${ROOT}/flowEditPage.do?flowCode=<%=request.getParameter("flowCode")%>&tab=2"+urlPara;   
    }
}

function editNodeExt(id){
	var returnValue = window.showModalDialog('${ROOT}/busiParamEditPage.do?busiParamId='+id,'','dialogHeight:380px;dialogWidth:470px;status=off')
    if(returnValue=="success"){
   		location.href = "${ROOT}/flowEditPage.do?flowCode=<%=request.getParameter("flowCode")%>&tab=2"+urlPara; 
    } 
}

function deleteNodeExt(id){
	if (confirm("��ȷ��Ҫɾ����¼��")) { 
		document.form1.action = "${ROOT}/deleteBusiParam.do?id="+id+"&tab=2&flowCode=<%=request.getParameter("flowCode")%>";
		document.form1.submit();
	}else{
		return;
	}
}

function flowSave(){
	var url = "${ROOT}/editFlow.do?remindIds="+ary+urlPara;
	form1.action = url;
	form1.submit();
}

function checkJs(){
	/*if(checkSelectByName("isFree",1,"�Ƿ�������")&&checkSelectByName("waitMethod",1,"���췽ʽ")){
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
  		td.innerHTML="ϵͳ����ʱ��ǰ<input type='text' name=\"fromHoure"+rowsnum+"\" class=editline size=2 value='' >"+
  		"Сʱ��<INPUT  type='text' name='toHoure"+rowsnum+"' class=editline size=2 value= >Сʱ��"+
  		"<select name='way"+rowsnum+"'><option value='-1'>ȫ��</option><option value='0'>С��ͨ����</option><option value='1'>�ʼ�</option></select>"+
  		"��ʽ����<select name='reminder"+rowsnum+"'><option value='1'>������</option></select>��"+
  		"ÿ<INPUT type='text' name='frequency"+rowsnum+"' class=editline size=2 value= >"+
  		"<select name='frequencyUnit"+rowsnum+"'><option value='0'>����</option><option value='1'>Сʱ</option><option value='2'>��</option></select>"+
  		"����һ��,��������Ϊ<INPUT type='text' name='remindContent"+rowsnum+"' class=editline size=40 value= >��";
  	var td = arow.insertCell(2);
  	td.innerHTML="<img src='${ROOT}/web/flow/img/delete_1.gif' border='0' onClick='javascript:deleteCurrentRow(this)'> ";
  	tempRowNum++;
  	var obj = document.all.rowsnum;
  	obj.value = rowsnum;
  	ary[parseInt(ary.length)]=rowsnum;
}

function deleteCurrentRow(obj,id){
	if(id!=""&&id!=undefined){
		if(confirm("��ȷ��Ҫɾ����¼��")){
			var nodeMinedeleteurl = "${ROOT}/deleteNodeMine.do?id="+id+"&nodeCode=<%=request.getParameter("nodeCode")%>&tab=1&noCache="+Math.random();
			LoadAjaxContent(nodeMinedeleteurl,deleteNodeMinecallBackMethod);
		}else{
			return;
		}
	}
	var rindex=obj.parentElement.parentElement.rowIndex;
	tbl.deleteRow(rindex);<%--ɾ����ǰ��--%>
	tempRowNum--;
	remove(ary,rindex)
	//alert(ary);
}

function deleteNodeMinecallBackMethod(){
	eval(this.request.responseText);
}

function remove(array,index){
	if(isNaN(index)||index>array.length){return false;}
    for(var i=0,n=0;i<array.length;i++){
    	if(array[i]!=array[index]){
            array[n++]=array[i]
        }
    }
   	if(array.length!=0){
    	array.length-=1
    }
}

//���·����Ϣ
function routeInfo(id, relate){
    this.id=id;
    this.relate=relate;
}
var routes = new Array();
<logic:iterate id="route" name="flwFlow" property="nodeSet" indexId="index">
routes[<bean:write name="index" />] = new routeInfo("<bean:write name="route" property="nodeCode" />","<bean:write name="route" property="timelimitRelate" />");
</logic:iterate>

//����id����·����Ϣ
function findRouteInfo(id){
	for(var j=0; j<routes.length; j++){
		var route = routes[j];
		if(route.id==id){
			return route;
		}
	}
}

//��ѡ��ͬƵ�ȵ�ʱ��ҳ���ϱ仯
function ev_changeFrequency(){
	var frequency = document.all("frequency").value;
	var yearSpan = document.getElementById("yearSpan");
	var quarterSpan = document.getElementById("quarterSpan");
	var monthSpan = document.getElementById("monthSpan");
	if(frequency==4){
		yearSpan.style.display = '';
		quarterSpan.style.display = 'none';
		monthSpan.style.display = 'none';
	}else if(frequency==2){
		yearSpan.style.display = 'none';
		quarterSpan.style.display = '';
		monthSpan.style.display = 'none';
	}else{
		yearSpan.style.display = 'none';
		quarterSpan.style.display = 'none';
		monthSpan.style.display = '';
	}
}
function isTimeNum(tCon,type){
    if(!isFFInt(tCon))
    	return ;
    var num = parseInt(tCon.value);
	if(type==1){//�ж�ÿ�µ�������1-31
		if(num<1||num>31){
			alert("������1-31");
			tCon.focus();
			return false;
		}
	}else if(type==2){//�ж�Сʱ����0-23
		if(num<0||num>23){
			alert("������0-23");
			tCon.focus();
			return false;
		}
	}else if(type==3){//�жϷ�����0-59
		if(num<0||num>59){
			alert("������0-59");
			tCon.focus();
			return false;
		}
	}else if(type==4){//�ж�������0-59
		if(num<0||num>59){
			alert("������0-59");
			tCon.focus();
			return false;
		}
	}else if(type==5){
		if(num<1||num>3){
			alert("������1-3");
			tCon.focus();
			return false;
		}
	}else if(type==6){
		if(num<1||num>12){
			alert("������1-12");
			tCon.focus();
			return false;
		}
	}
	return true;
}


function isTimeNum1(tCon,type){
    if(!isFFInt(tCon))
    	return ;
    var num = parseInt(tCon.value);
	if(type==1){//�ж�ÿ�µ�������1-31
		if(num<0||num>31){
			alert("������1-31");
			tCon.focus();
			return false;
		}
	}else if(type==2){//�ж�Сʱ����0-23
		if(num<0||num>23){
			alert("������0-23");
			tCon.focus();
			return false;
		}
	}else if(type==3){//�жϷ�����0-59
		if(num<0||num>59){
			alert("������0-59");
			tCon.focus();
			return false;
		}
	}else if(type==4){//�ж�������0-59
		if(num<0||num>59){
			alert("������0-59");
			tCon.focus();
			return false;
		}
	}
	return true;
}
function setCheckValue(id){
	if(document.getElementById(id).checked){
		document.getElementById(id).value=1;
	}else{
		document.getElementById(id).value=0;
	}
}

function FF_ShowJobs(){
	openWin("${ROOT}/listJobFlowByMonitor.do?monitorId=${monitor.id}",{showCenter:true,width:850,height:500});
}
</script>
<body>
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="define-box1">
  <tr>
    <td height="100%" width="100%" valign="top" class="define-text-bg"><div style="overflow-y:auto;height:100%" class="scroll-net">

	  <form id="form1" name="form1" method="post" action="">     
	  <input type="hidden" name="flgFree" value="${flwFlow.flgFree }"/>
	  <table cellSpacing=0 cellPadding=0 width=600 align=center border=0>
	    <tr>
    	  <td>
    	    <br/>
	        <DIV class=tab-pane id=tabPane1>
              <SCRIPT type=text/javascript>
		        tp1 = new WebFXTabPane( document.getElementById( "tabPane1" ) );
		        tp1.selectedIndex =<%=tab%>;
			  </SCRIPT>
		      <DIV class=tab-page id=tabPage1>
    			<H2 class=tab>��������</H2>
			    <SCRIPT type=text/javascript>tp1.addTabPage( document.getElementById( "tabPage1" ) );</SCRIPT>
				<!-- ����Ƕ�����̻������� -->
				<input name="flowCode" type="hidden" value="<bean:write name="flwFlow" property="flowCode"/>""/>
		    	<table class=box border=0 style="FONT-SIZE: 9pt" cellSpacing=1 cellPadding=5 width="100%" border=0>
			  	  <TBODY>
			        <TR>
			          <TD align=right width="28%" height=35><font color="red">*</font>�������ƣ�</TD>
			          <TD width="72%" height=25><INPUT class=editline size=60 value="<bean:write name="flwFlow" property="flowName"/>" name="flowName"  check="notBlank" showName="��������" required="true" maxlength="50" > </TD>
			        </TR>
			  	    <TR>
			          <TD align=right width="28%" height=35>����˵����</TD>
        			  <TD width="72%" height=25><INPUT class=editline size=60 value="<bean:write name="flwFlow" property="memo"/>" name="memo" maxlength="500"> </TD>
        			</TR>
	  				<TR>
        			  <TD align=right width="28%" height=35><font color="red">*</font>�������</TD>
        			  <TD width="72%" height=25>
        				<INPUT type="hidden" name="busiType" value="<bean:write name="flwFlow" property="commBusi.id"/>">
        				<bean:write name="flwFlow" property="commBusi.busiName"/>
        			  </TD>
        			</TR>
 					<!-- <TR>
        			  <TD align=right width="28%" height=35><font color="red">*</font>���̰󶨷������ڣ�</TD>
        			  <TD width="72%" height=25>
        				<kpi:dictionary-select  name='assessmentType' type='ASS_CYCLE_TYPE' style="width:30px;" selected="${flwFlow.cycleType}" htmlType="radio"/>
        			  </TD>
        			</TR> -->
        			<c:if test="${fn:length(parentFlows)>0}">
        			 <TR>
        			  <TD align=right width="28%" height=35>���������̣�</TD>
        			  <TD width="72%" height=25>
        			    	<select name="parentFlowId" id="parentFlowId">
        			    		<option value="">--��ѡ��--</option>
        			    		<c:forEach var="o" items="${parentFlows}">
        			    			<option value="${o.flowCode}" ${o.flowCode==flwFlow.parentFlow.flowCode?'selected':''}>${o.flowName}</option>
        			    		</c:forEach>
        			    	</select>
					  </TD>
					</TR>      
					</c:if>			
        			<!-- <TR>
        			  <TD align=right width="28%" height=35>�Ѱ�ģ�壺</TD><bean:size id="length" name="flwFlow" property="templetSet" scope="request"/>
        			  <TD width="72%" height=25>
        			    <textarea class="area" readonly rows="4" cols="50" name="bindtemp"><logic:iterate id="templet" name="flwFlow" property="templetSet" indexId="index"><bean:write name="templet" property="typeName"/><%Integer leng = (Integer)length;Integer intd = (Integer) index;if((leng.intValue()-1)!=intd.intValue()) out.print(",");%></logic:iterate></textarea>
						<INPUT type="hidden" name="dbTemp" value="${flwTempletStrForTempletId}"/>"/>
					    <INPUT type="hidden" name="tempType" value="${flwTempletStrForTempletId}"/>
						<INPUT type="button" name="selectTemp" value="ѡ��ģ��" onclick="javascript:selectTemp111()" class="button" style="display: none">
					  </TD>
					</TR> -->
	  				<tr>
	  				  <td colspan="2" align="left">
	  				    <font color="#0099FF">˵�������ǣ�</font><font color="red">*</font><font color="#0099FF">������Ϊ��</font>
	  				  	<br/>
						<c:if test="${flwFlow.commBusi.id=='YGKH' }">
							<font color="#0099FF">
								�������Ƹ�ʽ:
								<br/>
								�����ܹ�+�����ܹ�+���ţ��ɿգ�+Ա��+����Ƶ�Σ��¶�/����/��ȣ�+��Ч��������
								<br/>
								��:���ݷ�خ�ۺϲ�Ա���¶ȼ�Ч��������
							</font>
						</c:if>
						<c:if test="${flwFlow.commBusi.id=='BMKH' }">
							<font color="#0099FF">
								�������Ƹ�ʽ:
								<br/>
								�����ܹ�+�����ܹ�+���ţ��ɿգ�+��֯+����Ƶ�Σ��¶�/����/��ȣ�+��Ч��������
								<br/>
								��:���ݷ�خXX������֯��ȼ�Ч��������
							</font>
						</c:if>
	  				  </td>
	  				</tr>
				  </table>
				</DIV>						
				<DIV class=tab-page id=tabPage6>
			      <H2 class=tab>����ʱ��Ƶ��</H2>
		     	  <SCRIPT type=text/javascript>tp1.addTabPage( document.getElementById( "tabPage6" ) );</SCRIPT>
		     	  
	  			  <table class=box style="FONT-SIZE: 9pt" cellSpacing=1 cellPadding=5 width="100%" border=0>
	     			<TR>
	        		  <TD align=right width="28%" height=35><font color="red">*</font>Ƶ�ȣ�</TD>
	        		  <TD width="72%" height=25>
	        			<input type="hidden" name="mid" value="<bean:write name="monitor" property="id"/>">
	        			<html:select name="monitor" property="frequency" onchange="ev_changeFrequency();">
					      <html:option value="1">�¶�</html:option>
					      <html:option value="2">����</html:option>
					      <html:option value="4">���</html:option>
					    </html:select>
	        		  </TD>
	        		</TR>
				    <TR>
			          <TD align=right width="28%" height=35>�Զ�����</TD>
			          <TD width="72%" height=25>
				        <html:radio name="monitor" property="flgAuto" value="1">��</html:radio>&nbsp;
			       		<html:radio name="monitor" property="flgAuto" value="0">��</html:radio>
			          </TD>	        
			        </TR>
					<TR>
				      <TD align=right width="28%" height=35>�Զ�����ʱ�䣺</TD>
				      <TD width="72%" height=25>
				      <html:select name="monitor" property="autoYear" >
						   	<html:option value="0">��</html:option>
						   	<html:option value="1">��</html:option>
					  </html:select>
				        <span id="yearSpan" style="display:'${monitor.frequency==4?'':'none'}'">
				          ��ȵ�<input type='text' class='editline' name='autoMonth' size='2' maxlength='2' value='${monitor.autoMonth}' onblur="isTimeNum(this,6)"/>
				        </span>
				          <span id="quarterSpan" style="display:'${monitor.frequency==2?'':'none'}'">
				           ���ȵ�<input type='text' class='editline' name='autoMonth' size='2' maxlength='2' value='${monitor.autoMonth}' onblur="isTimeNum(this,5)"/>
				        </span>
				        <span id="monthSpan" style="display:'${monitor.frequency==1?'':'none'}'">�¶�</span>
				        <input type="text" class="editline" name="autoDate" size="2" maxlength="2" value="${monitor.autoDate}" onblur="isTimeNum(this,1)"/>��&nbsp;
						<input type="text" class="editline" name="autoHour" size="2" maxlength="2" value="${monitor.autoHour}" onblur="isTimeNum(this,2)"/>ʱ&nbsp;
						<input type="text" class="editline" name="autoMinitue" size="2" maxlength="2" value="${monitor.autoMinitue}" onblur="isTimeNum(this,3)"/>��&nbsp;
				      </TD>
				    </TR>
				    <TR>
			          <TD align=right width="28%" height=35>�Զ�������־��</TD>
			          <TD width="72%" height=25><a href="#" onclick="FF_ShowJobs();return false;">�鿴</a></TD>	        
			        </TR>
			        <TR>
			      	  <TD colspan="2">
	      				<font color="red">
							  	����ʱ��˵�� :<br>
							  	��:���������뵱ǰ����ϵͳʱ����ͬһ���ڡ� <br>
								��:��������Ϊ��ǰ����ϵͳʱ�����һ�����ڡ� <br>
								������ <br>
								��ǰʱ����2008��1��20�� <br>
								2008��1�µĿ���������Ҫ��2008��2��3�շ�����Ӧ���趨"����3��0ʱ0��"�� <br>
								2008��1�µĿ���������Ҫ��2008��1��28�շ�����Ӧ�趨"����28��0ʱ0��"�� 
						</font>
	      				</TD>  	
	      			  </TR>
				</table>	  	
			</DIV>
							
				  <DIV class=tab-page id=tabPage5>
				    <H2 class=tab>ҵ���������</H2>
				    <SCRIPT type=text/javascript>tp1.addTabPage( document.getElementById( "tabPage5" ) );</SCRIPT>
				    <!-- ����Ƕ��ҵ��������� -->
				    <table class=box border=0 style="FONT-SIZE: 9pt" cellSpacing=1 cellPadding=5 width="100%" border=0>
				      <tr><td width="100%">
				  		<jsp:include flush="true" page="flow_ext_config.jsp" >
				  			<jsp:param name="mainId" value="<%=flowCode%>" />	  	
				  		</jsp:include>
				  	  </td></tr>
				    </table>
				  </DIV>
				<!-- 
				<DIV class=tab-page id=tabPage7 style="display:none">
				    <H2 class=tab>��ʱ����</H2>
				    <SCRIPT type=text/javascript>tp1.addTabPage( document.getElementById( "tabPage7" ) );</SCRIPT>
				    <!-- ����Ƕ��ҵ��������� -->
				  <!--    <table class=box border=0 style="FONT-SIZE: 9pt" cellSpacing=1 cellPadding=5 width="100%" border=0>
				     
				        
				    <tr style="display:none">
				    	<td colspan=2>
				    	<br/>
				     		<table class=listtable bordercolor=#B3BBC8 bordercolordark=#ffffff align="center" bordercolorlight=#B3BBC8 border=1 cellpadding="2" cellspacing="0" width="90%">
				     			<TR>
						          <TD align="left" colspan="2" height=30><b>���̴����Զ��ύ</b>&nbsp;[���������л��ڵĴ��쵽ָ��ʱ��� �Զ��ύ]<br></TD>        
						        </TR>
							    <TR>
						          <TD align="center" width="28%" height=22>�Ƿ��Զ��ύ��<br></TD>
						          <TD height=25>
							        <html:radio name="flwFlow" property="flg_AutoSubmitTodo" value="1">��</html:radio>&nbsp;
						       		<html:radio name="flwFlow" property="flg_AutoSubmitTodo" value="0">��</html:radio>
						         <br></TD>	        
						        </TR>
								<TR>
							      <TD align="center" width="28%" height=25>�Զ��ύʱ�䣺<br></TD>
							      <TD height=25>
							      
							        <div id="autoYear" style="float:left">
							          <html:select name="flwFlow" property="submitTodoMonth" >
							            <html:option value="-1" >�����</html:option>
									   	<html:option value="0" >����</html:option>
									   	<html:option value="1" >����</html:option>
									  </html:select>
							        </div>
							        
							        <input type="text" class="editline" name="submitTodoDate" size="2" maxlength="2" value="<bean:write name="flwFlow" property="submitTodoDate"/>" onblur="isTimeNum1(this,1)"/>��&nbsp;
									<input type="text" class="editline" name="submitTodoHour" size="2" maxlength="2" value="<bean:write name="flwFlow" property="submitTodoHour"/>" onblur="isTimeNum1(this,2)"/>ʱ&nbsp;
									<input type="text" class="editline" name="submitTodoMinute" size="2" maxlength="2" value="<bean:write name="flwFlow" property="submitTodoMinute"/>" onblur="isTimeNum1(this,3)"/>��&nbsp;
							      <br></TD>
							    </TR>
				    		</table><br/>
				    	<br></td>
				    </tr>
				    <tr>
				    	<td colspan=2>&nbsp;
				    	
				    	<table class=listtable bordercolor=#B3BBC8 bordercolordark=#ffffff align="center" bordercolorlight=#B3BBC8 border=1 cellpadding="2" cellspacing="0" width="90%">
				    		<TR>
						          <TD align="left" colspan="3" height=30><b>���ڴ����Զ��ύ</b>&nbsp;[ָ�����ڵĴ��쵽ָ��ʱ��� �Զ��ύ]</TD>        
						    </TR>
						    
					  	  <tr>
							<td class=title-header align="center" width="28%" height="22">����</td>  
							<td class=title-header align="center" >ʱ��</td>
							<td class=title-header align="center" width="20%">�Ƿ��Զ��ύ</td>
					  	  </tr>
					  	  <%----
					  	  FlwFlow flwFlow = (FlwFlow)request.getAttribute("flwFlow");
					  	  String previousNodeCode = "";
					  	  for(Iterator iterNodes=flwFlow.getNodeSet().iterator(); iterNodes.hasNext(); ){
					  	  	FlwNode flwNode = (FlwNode)iterNodes.next();
					  	  	if(flwNode.getFlgRoot()==1) continue;
					  	  --%>
					  	  <tr>
					  	  	<td align="center" height="22" >
					  	  		<%--=flwNode.getNodeName()%></td>
							<td align="left" >
							
							  <select name="submitType_<%--=flwNode.getNodeCode()%>">
							      <option value="-1" <%=flwNode.getSubmitType()==-1?"selected":"" %> >�����</option>
								  <option value=0 <%=flwNode.getSubmitType()==0?"selected":"" %> >����</option>
								  <option value=1 <%=flwNode.getSubmitType()==1?"selected":"" %> >����</option>
							  </select>
							    
							  <input type=text class=editline size=2 name="submitDate_<%=flwNode.getNodeCode()%>"
									value="<%=flwNode.getSubmitDate()%>" onblur="isTimeNum1(this,1)"/>�յ�
							  <input type=text class=editline size=2 name="submitHour_<%=flwNode.getNodeCode()%>" 
									maxlength="2" value="<%=flwNode.getSubmitHour()%>" onblur="isTimeNum1(this,2)"/>ʱ
							  <input type=text class=editline size=2 name="submitMinute_<%=flwNode.getNodeCode()%>" 
									maxlength="2"  value="<%=flwNode.getSubmitMinute()%>" onblur="isTimeNum1(this,3)" />��
							</td>
							<td align="center" >
								<input type=checkbox name="flwNodeApply_<%=flwNode.getNodeCode()%>" value=<%=flwNode.getTimelimitFlgApply()%>  <%=flwNode.getTimelimitFlgApply()==1?"checked":"" %> 
								onclick="setCheckValue('flwNodeApply_<%=flwNode.getNodeCode()%>');"
								/>
							</td>
					  	  </tr>
					  	  <%}--%>
		  	 			</table><br/> -->  
				    	</td>
				    	
				    </tr>
				    </table>
				  </DIV>
			</DIV><!-- 	����TAB���� -->
		      </td>
			</tr>
		  </table>
		</form>
	  </div>
    </td>
  </tr>
</table>
</body>
</html>