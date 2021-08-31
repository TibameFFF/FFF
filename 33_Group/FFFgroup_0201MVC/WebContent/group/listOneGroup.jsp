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
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        <link href="css/t33.css" rel="stylesheet" />

</head>
<body class="d-flex flex-column">
        <main class="flex-shrink-0">
            <!-- Navigation-->
            <script src="js/nav.js"></script>
            <!-- Page Content-->
		 <h3>揪團資料 - ListOneGroup.jsp</h3>
		 <h4><a href="selectgroup_page.jsp">回首頁</a></h4>

<section class="py-5">

<div class="table-responsive">
<table class="table align-middle">

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
			<td><img src="<%=request.getContextPath()%>/DBGifReader3?g_no=${groupVO.g_no}" style="height:200;weight:200;"></td>
			<td>${groupVO.g_url}</td>
	</tr>
</table>
</div>

</section>
</main>
        <footer class="bg-dark py-4 mt-auto">
            <div class="container px-5">
                <div class="row align-items-center justify-content-between flex-column flex-sm-row">
                    <div class="col-auto"><div class="small m-0 text-white">Copyright &copy; Your Website 2021</div></div>
                    <div class="col-auto">
                        <a class="link-light small" href="#!">Privacy</a>
                        <span class="text-white mx-1">&middot;</span>
                        <a class="link-light small" href="#!">Terms</a>
                        <span class="text-white mx-1">&middot;</span>
                        <a class="link-light small" href="#!">Contact</a>
                    </div>
                </div>
            </div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
</body>
</html>