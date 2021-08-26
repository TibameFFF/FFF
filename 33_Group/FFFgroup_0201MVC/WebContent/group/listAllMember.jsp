<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.group.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
    GroupService groupSvc = new GroupService();
    List<GroupVO> list = groupSvc.getAll();
    pageContext.setAttribute("list",list);
%>

<jsp:useBean id="typeSvc" scope="page" class="com.group.model.TypeService" />
<html>
<head>
<title>所有揪團資料 - listAllGroup.jsp</title>

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
	width: 800px;
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

<h4>此頁練習採用 EL 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>所有活動資料 - listAllGroup.jsp</h3>
		 <h4><a href="selectgroup_page.jsp">回首頁</a></h4>
	</td></tr>
</table>


<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table>
	<tr>
			<th>活動編號</th>
			<th>活動名稱</th>
			<th>活動類型編號</th>
			<th>活動介紹</th>			
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
	<%@ include file="page1.file" %> 
	<c:forEach var="groupVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr>
			<td>${groupVO.g_no}</td>
			<td>${groupVO.g_name}</td>
			
			<td><c:forEach var="typeVO" items="${typeSvc.all}">
                    <c:if test="${groupVO.g_type_no==typeVO.g_type_no}">
	                    ${typeVO.g_type}
                    </c:if>
                </c:forEach>
			</td>
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
			<td><img src=<%=request.getContextPath()%>/DBGifReader3?g_no=${groupVO.g_no} style="height:100;weight:100;"/></td>
			<td>${groupVO.g_url}</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/group/group.do" enctype="multipart/form-data"style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="g_no"  value="${groupVO.g_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/group/group.do" enctype="multipart/form-data" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="g_no"  value="${groupVO.g_no}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>