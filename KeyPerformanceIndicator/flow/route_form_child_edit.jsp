<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" pageEncoding="GBK"%>
<%@ include file="/web/pub/flow.inc" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>���˿���</title>

		<LINK rel="stylesheet" type="text/css" href="${ROOT}/styleSheet/kpi_style.css">
		<!-- ϵͳͨ�õķ�� -->

		<LINK href="${ROOT}/styleSheet/stylehm.css" type=text/css rel=stylesheet />
		<!-- tabʹ�õķ�� -->
		<LINK href="${ROOT}/styleSheet/tab/tab.css" type=text/css rel=stylesheet />
		<!-- tabʹ�õķ�� -->
		<SCRIPT src="${ROOT}/styleSheet/tab/cb2.js" type=text/javascript></SCRIPT>
		<SCRIPT src="${ROOT}/styleSheet/tab/tabpane.js" type=text/javascript></SCRIPT>
<script type="text/javascript" src="${ROOT}/common/js/Check.js"></script>
	</head>
	<script language="javascript">

//ѡ��·����չ
function routeExt(){
	window.open('exts.htm','','height=300,width=500,top=200, left=200,toolbar =no, menubar=no, scrollbars=auto, resizable=no, location=no, status=no')
}
</script>
	<body style="OVERFLOW: auto" text=#000000 bgColor=#f0f0f0 leftMargin=0 topMargin=3>
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="define-box1">
  <tr>
    <td height="100%" width="100%" valign="top" class="define-text-bg"><div style="overflow-y:auto;height:100%" class="scroll-net">
		<br>
		<form id="form1" name="form1" method="post" action="">
			<table cellSpacing=0 cellPadding=0 width=500 align=center border=0>
				<tr>
					<td>
						<br>
						<DIV class=tab-pane id=tabPane1>
							<SCRIPT type=text/javascript>
	tp1 = new WebFXTabPane( document.getElementById( "tabPane1" ) );
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
												·�����ƣ�
											</TD>
											<TD width="72%" height=25>
												<INPUT  class=editline size=30 value="<bean:write name="flwRoute" property="routeFlag"/>" name="routeFlag" check="notBlank" showName="·������" required="true" maxlength="128"/>
											</TD>
										</TR>
										<TR>
											<td align="right"></td>
											<TD align=left height=35>
												·��˵����
											</TD>
											<TD height=25>
												<INPUT class=editline size=30 value="<bean:write name="flwRoute" property="routeDesc"/>" name="routeDesc" maxlength="500"/>
											</TD>
										</TR>
										
										
										<TR>
											<td align="right"></td>
											<TD align=left height=35>
												·������:
											</TD>
											<TD height=25>
												<kpi:dictionary-select  name='flgAttribute' type='ROUTE_FLG_ATTRIBUTE' style="width:30px;" selected="${flwRoute.flgAttribute}" htmlType="radio"/>
											</TD>
										</TR>
										<TR>
											<td align="right">
												<font color="red">*</font>
											</td>
											<TD align=left height=35>
												Ŀ�껷�ڣ�
											</TD>
											<TD height=25>
												<html:select name="routeForm" property="nextNodeCode">
													<html:optionsCollection name="nodeList" value="nodeCode" label="nodeName" />
												</html:select>
											</TD>
										</TR>
										<TR>
											<td align="right">
												<font color="red">*</font>
											</td>
											<TD align=left height=35>
												����ţ�
											</TD>
											<TD height=25>
												<INPUT class=editline size=30 value="<bean:write name="flwRoute" property="priority"/>" name="priority" check="notBlank;isInt('0+')" showName="�����" required="true"/>
											</TD>
										</TR>
										<%-- �°汾���޴��ֶ�,�ݲ�ʹ��
										<TR>
											<td align="right"><font color="red">*</font></td>
											<TD align=left height=35>
												�ύ��ť����:
											</TD>
											<TD height=25>
												<INPUT class=editline size=30 value="<bean:write name="flwRoute" property="menuName"/>" name="menuName">
											</TD>
										</TR>
										<TR>
											<td align="right"></td>
											<TD align=left height=35>
												��Ӧ��js������
											</TD>
											<TD height=25>
												<INPUT class=editline size=30 value="<bean:write name="flwRoute" property="jsFunction"/>" name="jsFunction">
											</TD>
										</TR>
										--%>
										<!--<TR>
											<td align="right"></td>
											<TD align=left height=35>
												ȷ����ʾ��Ϣ��
											</TD>
											<TD height=25>
												<INPUT class=editline size=30 value="" name="<bean:write name="flwRoute" property="confirmTip"/>">
											</TD>
										</TR>
										<TR>
											<td align="right"></td>
											<TD align=left height=35>
												·����չ����
											</TD>
											<TD height=25>
												<INPUT class=editline size=30 value="Ĭ����һ���ڷ�;�ҿ����ŵ÷�;" name=flowName>
												<input type='button' name='add_attach_button' onclick='javascript:routeExt();' value='ѡ��' class="button">
											</TD>
										</TR>
										<TR>
											<td align="right"></td>
											<td colspan="2">
												<font color="red">��չ������ʾ������չ�����������Զ�����м��÷ֺŷָ�</font>
											</td>
										</tr>
										<TR>
											<td align="right"></td>
											<TD align=left height=35>
												�Ƿ���Ҫ�����ύ��
											</TD>
											<TD height=25>
												<html:radio name="flwRoute" property="flgBatchSubmit" value="y" />
												��&nbsp;
												<html:radio name="flwRoute" property="flgBatchSubmit" value="n" />
												��
											</TD>
										</TR>
								--></table>

							</DIV>
							<!-- 	����TAB���� -->
					</td>
				</tr>
			</table>
		</form>
</div></td></tr></table>
	</body>
</html>
