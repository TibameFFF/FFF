<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.group.model.*"%>
<%-- �����Ƚm�߱ĥ� Script ���g�k���� --%>

<%
  GroupVO groupVO = (GroupVO) request.getAttribute("groupVO"); //EmpServlet.java(Concroller), �s�Jreq��empVO����
%>
<jsp:useBean id="typeSvc" scope="page" class="com.group.model.TypeService" />
<html>
<head>
<title>���θ�� - listOneGroup.jsp</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 600px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>

<h4>�����Ƚm�߱ĥ� Script ���g�k����:</h4>
<table id="table-1">
	<tr><td>
		 <h3>���θ�� - ListOneGroup.jsp</h3>
		 <h4><a href="selectgroup_page.jsp">�^����</a></h4>
	</td></tr>
</table>

<table>
	<tr>
			<th>���ʽs��</th>
			<th>���ʦW��</th>
			<th>���ʤ���</th>
			<th>���������s��</th>
			<th>���ʶ}�l�ɶ�</th>
			<th>���ʵ����ɶ�</th>
			<th>���W�}�l�ɶ�</th>
			<th>���W�����ɶ�</th>
			<th>�a�I</th>
			<th>�H�ƤU��</th>
			<th>�H�ƤW��</th>
			<th>�`�H��</th>
			<th>�}�Ϊ�</th>
			<th>�}�Ϊ̦ۧڤ���</th>
			<th>�}�Ϊ̤��</th>
			<th>�}�Ϊ�EMAIL</th>
			<th>���A</th>
			<th>�y�έ�]</th>
			<th>���ʷӤ�</th>
			<th>���ʺ��}</th>
	</tr>
	<tr>
			<td>${groupVO.g_no}</td>
			<td>${groupVO.g_name}</td>
			<td>${typeSvc.getOneType(groupVO.g_type_no).g_type}</td>
			<td>${groupVO.g_content}</td>
			<td>${groupVO.g_start_time}</td>
			<td>${groupVO.g_end_time}</td>
			<td>${groupVO.apply_start_time}</td>
			<td>${groupVO.apply_end_time}</td>
			<td>${groupVO.place}</td>
			<td>${groupVO.number_lower}</td>
			<td>${groupVO.number_upper}</td>
			<td>${groupVO.number_total}</td>
			<td>${groupVO.user_id}</td>
			<td>${groupVO.introduce}</td>
			<td>${groupVO.phone}</td>
			<td>${groupVO.email}</td>
			<td>${groupVO.state_no}</td>
			<td>${groupVO.g_flow_cause}</td>
			<td><img src=/IBM_emp_0201MVC_Single-Table_mySQL8/DBGifReader3?g_no=${groupVO.g_no}></td>
			<td>${groupVO.g_url}</td>
	</tr>
</table>

</body>
</html>