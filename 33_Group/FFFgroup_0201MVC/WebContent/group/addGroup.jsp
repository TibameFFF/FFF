<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.group.model.*"%>

<%
  GroupVO groupVO = (GroupVO) request.getAttribute("groupVO");
%>
<%= groupVO==null %>--${groupVO.g_type_no}-- 
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>���θ�Ʒs�W - addGroup.jsp</title>

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
    textarea{
    resize: none;
  }
  
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>���θ�Ʒs�W - addGroup.jsp</h3></td><td>
		 <h4><a href="selectgroup_page.jsp"><img src="images/tomcat.png" width="100" height="100" border="0">�^����</a></h4>
	</td></tr>
</table>

<h3>��Ʒs�W:</h3>

���~��C
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="group.do" name="form1" enctype="multipart/form-data">
<table>
	<tr>
		<td>���ʦW��:</td>
		<td><input type="TEXT" name="g_name" size="45"
			 value="<%= (groupVO==null)? "" : groupVO.getG_name()%>" /></td>
	</tr>
		<jsp:useBean id="typeSvc" scope="page" class="com.group.model.TypeService" />
	<tr>
		<td>���������s��:</td>
		<td><select size="1" name="g_type_no">
			<c:forEach var="typeVO" items="${typeSvc.all}">
				<option value="${typeVO.g_type_no}" ${(groupVO.g_type_no==typeVO.g_type_no)? 'selected':'' } >${typeVO.g_type}
			</c:forEach>
		</select></td>
	</tr>
	<tr>
		<td>���ʤ���:</td>
		<td><input type="text" name="g_content" size="45"  
			 value="<%= (groupVO==null)? "a" : groupVO.getG_content()%>" /></td>
	</tr>
	<tr>
		<td>���ʶ}�l�ɶ�:</td>
		<td><input name="g_start_time" class="f_date1" type="text"></td>
	</tr>
	<tr>
		<td>���ʵ����ɶ�:</td>
		<td><input name="g_end_time" class="f_date1" type="text"></td>
	</tr>
	<tr>
		<td>���W�}�l�ɶ�:</td>
		<td><input name="apply_start_time" class="f_date1" type="text"></td>
	</tr>
	<tr>
		<td>���W�����ɶ�:</td>
		<td><input name="apply_end_time" class="f_date1" type="text"></td>
	</tr>
	<tr> 
		<td>�a�I:</td>
			<td><input type="text" name="place" size="45"  
			 value="<%= (groupVO==null)? "" : groupVO.getPlace()%>"/></td>	
<!-- 		<div id="twzipcode" name="place" size="45"></div>  -->
	</tr>
	<tr>
		<td>�H�ƤU��:</td>
		<td><input type="number" name="number_lower" size="45"
			 value="<%= (groupVO==null)? "1" : groupVO.getNumber_lower()%>" /></td>
	</tr>
	<tr>
		<td>�H�ƤW��:</td>
		<td><input type="number" name="number_upper" size="45"
			 value="<%= (groupVO==null)? "" : groupVO.getNumber_upper()%>" /></td>
	</tr>
	<tr>
		<td>�`�H��:</td>
		<td><input type="TEXT" name="number_total" size="45"
			 value="<%= (groupVO==null)? "100" : groupVO.getNumber_total()%>" /></td>
	</tr>
	<tr>
		<td>�}�Ϊ�:</td>
		<td><input type="TEXT" name="user_id" size="45" 
			 value="<%= (groupVO==null)? "" : groupVO.getUser_id()%>" /></td>
	</tr>
	<tr>
		<td>�}�Ϊ̤���:</td>
		<td><input type="TEXT" name="introduce" size="45" 
			 value="<%= (groupVO==null)? "" : groupVO.getIntroduce()%>"/></td>
	</tr>

	<tr>
		<td>�}�Ϊ�email:</td>
		<td><input type="TEXT" name="email" size="45"
			 value="<%= (groupVO==null)? "" : groupVO.getEmail()%>" /></td>
	</tr>
		<tr>
		<td>�}�Ϊ̤��:</td>
		<td><input type="TEXT" name="phone" size="45"
			 value="<%= (groupVO==null)? "09" : groupVO.getPhone()%>" /></td>
	</tr>
	<tr>
		<td>�}�Ϊ��A:</td>
		<td><input type="TEXT" name="state_no" size="45"
			 value="<%= (groupVO==null)? "" : groupVO.getState_no()%>" /></td>
	</tr>
	<tr>
		<td>�y�έ�]:</td>
		<td><input type="TEXT" name="g_flow_cause" size="45"
			 value="<%= (groupVO==null)? "" : groupVO.getG_flow_cause()%>" /></td>
	</tr>
	
	<tr>
		<td>���ʷӤ�:</td>
		<td>
		
		<input type="file" name="photo" id="upload" onchange="loadImageFile(event)">
		<img id="image" src="" >
<!--          <div id="preview"> -->
<!--          <span class="text"></span> -->
<!--          <label class="file_label"><input type="file" id="p_file" name="photo"></label></div>  -->
		<td>

	</tr>

	<tr>
		<td>���ʺ��}:</td>
		<td><input type="TEXT" name="url" size="45"
			 value="<%= (groupVO==null)? "" : groupVO.getG_url()%>" /></td>
	</tr>

</table>

<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="�e�X�s�W"></FORM>
</body>



<!-- =========================================�H�U�� datetimepicker �������]�w========================================== -->


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
	   step: 1,            //step: 60 (�o�Otimepicker���w�]���j60����)
	   format: 'Y-m-d H:i:s',
	   value: new Date(),
	   //disabledDates:    ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
	   //startDate:	        '2017/07/10',  // �_�l��
	   //minDate:           '-1970-01-01', // �h������(���t)���e
	   //maxDate:           '+1970-01-01'  // �h������(���t)����
	});            
</script>
<script>
		function loadImageFile(event){
			var image = document.getElementById('image');
			image.src = URL.createObjectURL(event.target.files[0]); 
			};  
</script>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
 <script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
 <script>$("#twzipcode").twzipcode();</script>
</html>