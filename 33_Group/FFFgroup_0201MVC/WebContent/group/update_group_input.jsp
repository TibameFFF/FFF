<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.group.model.*"%>

<%
  GroupVO groupVO = (GroupVO) request.getAttribute("groupVO"); //GroupServlet.java (Concroller) 存入req的groupVO物件 (包括幫忙取出的groupVO, 也包括輸入資料錯誤時的groupVO物件)
%>
<%= groupVO==null %>--${groupVO.g_type_no}-- 
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>揪團資料修改 - update_group_input.jsp</title>

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
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>揪團資料修改 - update_group_input.jsp</h3>
		 <h4><a href="selectgroup_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="group.do" name="form1" enctype="multipart/form-data">
<table>
	<tr>
		<td>活動名稱:</td>
		<td><input type="TEXT" name="g_name" size="45"
			 value="<%=groupVO.getG_name()%>" /></td>
	</tr>
		<jsp:useBean id="typeSvc" scope="page" class="com.group.model.TypeService" />
	<tr>
		<td>活動類型編號:</td>
		<td><select size="1" name="g_type_no">
			<c:forEach var="typeVO" items="${typeSvc.all}">
				<option value="${typeVO.g_type_no}" ${(groupVO.g_type_no==typeVO.g_type_no)? 'selected':'' } >${typeVO.g_type}
			</c:forEach>
		</select></td>
	</tr>
	<tr>
		<td>活動介紹:</td>
		<td><input type="text" name="g_content" size="45"  
			 value="<%=groupVO.getG_content()%>" /></td>
	</tr>
	<tr>
		<td>活動開始時間:</td>
		<td><input name="g_start_time" id="start_time1" class="f_date1" type="text"
		 value="${groupVO.getG_start_time()}"></td>
	</tr>
	<tr>
		<td>活動結束時間:</td>
		<td><input name="g_end_time" class="f_date1" type="text"
		value="${groupVO.getG_end_time()}"></td>
	</tr>
	<tr>
		<td>報名開始時間:</td>
		<td><input name="apply_start_time"  class="f_date1" type="text"
		value="${groupVO.getApply_start_time()}"></td>
	</tr>
	<tr>
		<td>報名結束時間:</td>
		<td><input name="apply_end_time" class="f_date1" type="text"
		value="${groupVO.getApply_end_time()}"></td>
	</tr>
	<tr> 
		<td>地點:</td>
		<td><input type="TEXT" name="place" size="45" 
			 value="<%=groupVO.getPlace()%>" />
<!-- 		<div id="twzipcode" name="place" size="45" -->
<%-- 			 value="<%=groupVO.getPlace()%>"></div> --%>
		</td>
	</tr>
	<tr>
		<td>人數下限:</td>
		<td><input type="number" name="number_lower" size="45"
			 value="<%=groupVO.getNumber_lower()%>" /></td>
	</tr>
	<tr>
		<td>人數上限:</td>
		<td><input type="number" name="number_upper" size="45"
			 value="<%=groupVO.getNumber_upper()%>" /></td>
	</tr>
	<tr>
		<td>總人數:</td>
		<td><input type="number" name="number_total" size="45"
			 value="<%=groupVO.getNumber_total()%>" /></td>
	</tr>
	<tr>
		<td>開團者:</td>
		<td><input type="TEXT" name="user_id" size="45" 
			 value="<%=groupVO.getUser_id()%>" /></td>
	</tr>
	<tr>
		<td>開團者介紹:</td>
		<td><input type="TEXT" name="introduce" size="45" 
			 value="<%=groupVO.getIntroduce()%>"/></td>
	</tr>
	<tr>
		<td>開團者手機:</td>
		<td><input type="TEXT" name="phone" size="45"
			 value="<%=groupVO.getPhone()%>" /></td>
	</tr>
	<tr>
		<td>開團者email:</td>
		<td><input type="TEXT" name="email" size="45"
			 value="<%=groupVO.getEmail()%>" /></td>
	</tr>
	<tr>
		<td>開團狀態:</td>
		<td><input type="TEXT" name="state_no" size="45"
			 value="<%=groupVO.getState_no()%>" /></td>
	</tr>
	<tr>
		<td>流團原因:</td>
		<td><input type="TEXT" name="g_flow_cause" size="45"
			 value="<%=groupVO.getG_flow_cause()%>" /></td>
	</tr>
	
	<tr>
		<td>活動照片:</td>
		<td>
		<input type="file" name="photo" id="upload" onchange="loadImageFile(event)">
		<img id="image" src="<%=request.getContextPath()%>/DBGifReader3?g_no=${groupVO.g_no}" >
<!--          <div id="preview"> -->
<!--          <img src=/IBM_emp_0201MVC_Single-Table_mySQL8/DBGifReader3?g_no=${groupVO.g_no} class=preview_img> -->
<!--          <span class="text"></span> -->
<!--          <label class="file_label"><input type="file" id="p_file" name="photo"></label></div>  -->
		<td>
	</tr>

	<tr>
		<td>活動網址:</td>
		<td><input type="TEXT" name="g_url" size="45"
			 value="<%=groupVO.getG_url()%>" /></td>
	</tr>

</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="g_no" value="<%=groupVO.getG_no()%>">
<input type="submit" value="送出修改"></FORM>
</body>



<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>
<script>
	$.datetimepicker.setLocale('zh'); // kr ko ja en
	$('.f_date1').datetimepicker({
	   theme: '',          //theme: 'dark',
	   timepicker: true,   //timepicker: false,
	   step: 1,            //step: 60 (這是timepicker的預設間隔60分鐘)
	   format: 'Y-m-d H:i:s'
	});            
</script>
<script>
// 		var preview_el = document.getElementById("preview");
// 		var p_file_el = document.getElementById("p_file");
		
// 		var preview_img = function(file){
// 		    var img_node = document.createElement("img");
// 		    var reader = new FileReader(); // 用來讀取檔案 
// 		    reader.addEventListener("load", function () {
// 		      //console.log(reader.result);
// 		      let img_node = document.createElement("img");
// 		      img_node.setAttribute("src", reader.result); // <img src="abdafaewre">
// 		      img_node.setAttribute("class", "preview_img"); // <img src="abdafaewre" class="preview_img">
// 		      preview_el.innerHTML = '';
// 		      preview_el.append(img_node);
// 		    });
// 		    reader.readAsDataURL(file); // 讀取檔案
// 		  };
		
// 		  p_file_el.addEventListener("change", function(e){
// 			  if(this.files.length > 0){
// 				  preview_img(this.files[0]);
// 			else{
// 				preview_el.innerHTML = '<span class="text">預覽圖</span>';
// 			}
// 		  });
 		function loadImageFile(event){
			var image = document.getElementById('image');
			image.src = URL.createObjectURL(event.target.files[0]); 
			};  
</script>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
 <script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
 <script>$("#twzipcode").twzipcode();</script>
</html>