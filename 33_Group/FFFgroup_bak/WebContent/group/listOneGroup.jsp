<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.group.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  GroupVO groupVO = (GroupVO) request.getAttribute("groupVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
%>
<jsp:useBean id="typeSvc" scope="page" class="com.group.model.TypeService" />
<html>
<head>
<title>揪團資料 - listOneGroup.jsp</title>

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

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>揪團資料 - ListOneGroup.jsp</h3>
		 <h4><a href="selectgroup_page.jsp">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
			<th>活動編號</th>
			<th>活動名稱</th>
			<th>活動介紹</th>
			<th>活動類型編號</th>
			<th>活動開始時間</th>
			<th>活動結束時間</th>
			<th>報名開始時間</th>
			<th>報名結束時間</th>
			<th>地點</th>
			<th>人數下限</th>
			<th>人數上限</th>
			<th>總人數</th>
			<th>開團者</th>
			<th>開團者自我介紹</th>
			<th>開團者手機</th>
			<th>開團者EMAIL</th>
			<th>狀態</th>
			<th>流團原因</th>
			<th>活動照片</th>
			<th>活動網址</th>
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