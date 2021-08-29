<%@page import="com.info.model.InfoVO"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.shop.service.*"%>
<%@ page import="com.shop.model.*"%>
<%-- �����m�߱ĥ� EL ���g�k���� --%>

<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	Object obj = session.getAttribute("infoVO");
	if (obj == null) {
		response.sendRedirect(request.getContextPath() + "/info/Login.jsp"); //*�u�@2 : �и�user�h�n�J����(login.html) , �i��n�J
		return;
	}
	Integer id = ((InfoVO) obj).getUser_id();
	String login = (String) session.getAttribute("login");
	HashMap photo = (HashMap) session.getAttribute("photo");
	String str64 = photo.get("photo").toString().replaceAll("[\\s*\t\n\r]", "");
	OrderService orderSvc = new OrderService();
	List<Order> list = orderSvc.getOneByUserId(id);
	pageContext.setAttribute("list", list);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>�n�J</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="<%=request.getContextPath()%>/info/css/styles.css"
	rel="stylesheet" />
<link href="<%=request.getContextPath()%>/info/css/14.css"
	rel="stylesheet" />
</head>

<body class="d-flex flex-column">
	<main class="flex-shrink-0">
		<!-- Navigation -->
		<nav class="navbar navbar-expand-md navbar-dark bg-dark"
			aria-label="Fourth navbar example">
			<div class="container-fluid">
				<a class="navbar-brand" href="#">Fun Friend</a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarsExample04"
					aria-controls="navbarsExample04" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse" id="navbarsExample04">
					<ul class="navbar-nav me-auto mb-2 mb-md-0">
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#" id="dropdown04"
							data-bs-toggle="dropdown" aria-expanded="false">�׾�</a>
							<ul class="dropdown-menu" aria-labelledby="dropdown04">
								<li><a class="dropdown-item" href="#">aaaaaaa</a></li>
								<li><a class="dropdown-item" href="#">bbbbbbb</a></li>
								<li><a class="dropdown-item" href="#">ccccccc</a></li>
							</ul></li>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#" id="dropdown04"
							data-bs-toggle="dropdown" aria-expanded="false">���</a>
							<ul class="dropdown-menu" aria-labelledby="dropdown04">
								<li><a class="dropdown-item" href="#">aaaaaaa</a></li>
								<li><a class="dropdown-item" href="#">bbbbbbb</a></li>
								<li><a class="dropdown-item" href="#">ccccccc</a></li>
							</ul></li>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#" id="dropdown04"
							data-bs-toggle="dropdown" aria-expanded="false">�ӫ�</a>
							<ul class="dropdown-menu" aria-labelledby="dropdown04">
								<li><a class="dropdown-item" href="#">aaaaaaa</a></li>
								<li><a class="dropdown-item" href="#">bbbbbbb</a></li>
								<li><a class="dropdown-item" href="#">ccccccc</a></li>
							</ul></li>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#" id="dropdown04"
							data-bs-toggle="dropdown" aria-expanded="false">����</a>
							<ul class="dropdown-menu" aria-labelledby="dropdown04">
								<li><a class="dropdown-item" href="#">aaaaaaa</a></li>
								<li><a class="dropdown-item" href="#">bbbbbbb</a></li>
								<li><a class="dropdown-item" href="#">ccccccc</a></li>
							</ul>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#" id="dropdown04"
							data-bs-toggle="dropdown" aria-expanded="false">��ѫ�</a>
							<ul class="dropdown-menu" aria-labelledby="dropdown04">
								<li><a class="dropdown-item" href="#">aaaaaaa</a></li>
								<li><a class="dropdown-item" href="#">bbbbbbb</a></li>
								<li><a class="dropdown-item" href="#">ccccccc</a></li>
							</ul></li>
					</ul>
					<div class="flex-shrink-0 dropdown islogin">
						<a href="<%=request.getContextPath()%>/info/Login.jsp"
							class="d-block link-light text-decoration-none" target="_blank">
							�n�J/���U </a>
					</div>
					<div class="flex-shrink-0 dropdown islogin none">
						<a href="#"
							class="d-block link-light text-decoration-none dropdown-toggle"
							id="dropdownUser2" data-bs-toggle="dropdown"
							aria-expanded="false"> <img
							src="<%=request.getContextPath()%>/info/img/123.jpg" alt="mdo"
							width="32" height="32" class="rounded-circle">
						</a>
						<ul class="dropdown-menu text-small shadow"
							aria-labelledby="dropdownUser2" id="dropdownUserImg">
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/info/Info.jsp"
								target="_blank">�|�����</a></li>
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/info/Mapping.jsp"
								target="_blank">�t��]�w</a></li>
							<li><a class="dropdown-item" href="#">���|�^��</a></li>
							<li><a class="dropdown-item" href="#">���ά���</a></li>
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/info/Order.jsp">�ӫ�����</a></li>
							<li><a class="dropdown-item" href="#">�׾¬���</a></li>
							<li><hr class="dropdown-divider"></li>
							<li>
								<form method="post"
									action="<%=request.getContextPath()%>/Logout">
									<button class="dropdown-item" id="logout-btn">�n�X</button>
								</form>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</nav>
		<!-- About section one-->
		<section class="py-5" id="scroll-target">

			<div class="row justify-content-center">
				<div class="col-8">
					<div class="card o-hidden border-0 shadow-lg my-5">
						<div class="card-body p-0">
							<div class="row ">
								<div class="">
									<table class="d-flex justify-content-center">
										<div class="p-5">
											<div class="text-center">
												<h1 class="h4 text-gray-900 mb-4">�ӫ��q�����</h1>
											</div>
											<tr>
												<th>�q��s��</th>
												<th>�ʶR�ɶ�</th>
												<th>�q�檬�A</th>
												<th>�q���`���B</th>
												<th>�B�e�覡</th>
												<th>�d�ݧ����T</th>
											</tr>
											<%@ include file="pages/page1.file"%>
											<c:forEach var="Order" items="${list}" begin="<%=pageIndex%>"
												end="<%=pageIndex+rowsPerPage-1%>">
												<tr>
													<td>${Order.ord_no}</td>
													<td>${Order.ord_time}</td>
													<td>${Order.ord_status}</td>
													<td>${Order.ord_total}</td>
													<td>${Order.ship_method}</td>
													<td>
													<form method="post" action="<%=request.getContextPath()%>/ShowEachOrderServlet">
														<input type="hidden" name="order"  value="${Order.ord_no}">
														<button class="search" type="submit">
															<img
																src="<%=request.getContextPath()%>/info/img/search.svg"
																width="26" height="26" alt="">
														</button>
													</form>
													</td>
												</tr>
											</c:forEach>
										</div>
									</table>
									<br>
									<div class="d-flex justify-content-center">
										<%@ include file="pages/page2.file"%>
									</div>


								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>

		<!-- Footer-->
		<footer class="bg-dark py-4 mt-auto">
			<div class="container px-5">
				<div
					class="row align-items-center justify-content-between flex-column flex-sm-row">
					<div class="col-auto">
						<div class="small m-0 text-white">Copyright &copy; Fun
							Friends 2021</div>
					</div>
					<div class="col-auto">
						<a class="link-light small" href="#!">Privacy</a> <span
							class="text-white mx-1">&middot;</span> <a
							class="link-light small" href="#!">Terms</a> <span
							class="text-white mx-1">&middot;</span> <a
							class="link-light small" href="#!">Contact</a>
					</div>
				</div>
			</div>
		</footer>
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
		<script
			src="<%=request.getContextPath()%>/info/jquery/jquery-3.6.0.min.js"></script>
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		<script>
		$(document).ready(function(){ 
			if("OK" == "${sessionScope.login}"){
				$(".islogin").toggleClass("none");
				var photo = "data:image/jpeg;base64," + "<%=str64%>";
					//document.getElementByClassName("myImage").src="hackanm.gif";
					$(".rounded-circle").attr("src", photo);
				}
			});
		</script>
	</main>
</body>
</html>