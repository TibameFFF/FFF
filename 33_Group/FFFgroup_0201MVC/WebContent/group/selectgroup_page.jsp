<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>Group: Home</title>

<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
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

</head>
<body bgcolor='white'>

<table id="table-1">
   <tr><td><h3>FFF Group: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for FFF Group: Home</p>

<h3>資料查詢:</h3>
	
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='listAllGroup.jsp'>List</a> all Groups.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="group.do" enctype="multipart/form-data">
        <b>輸入揪團編號 (如1):</b>
        <input type="text" name="g_no">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="groupSvc" scope="page" class="com.group.model.GroupService" />
   
  <li>
     <FORM METHOD="post" ACTION="group.do" enctype="multipart/form-data" >
       <b>請選擇揪團編號:</b>
       <select size="1" name="g_no">
         <c:forEach var="groupVO" items="${groupSvc.all}" > 
          <option value="${groupVO.g_no}">${groupVO.g_no}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="group.do" enctype="multipart/form-data" >
       <b>選擇活動名稱:</b>
       <select size="1" name="g_no">
         <c:forEach var="groupVO" items="${groupSvc.all}" > 
          <option value="${groupVO.g_no}">${groupVO.g_name}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
     </FORM>
  </li>
</ul>


<h3>新增揪團</h3>

<ul>
  <li><a href='addGroup.jsp'>Add</a> a new Group.</li>
</ul>

</body>
</html>