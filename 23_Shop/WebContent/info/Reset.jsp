<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>註冊</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="<%=request.getContextPath()%>/info/css/styles.css" rel="stylesheet" />
<link href="<%=request.getContextPath()%>/info/css/14.css" rel="stylesheet" />
</head>

<body class="d-flex flex-column">
	<main class="flex-shrink-0">
		<!-- About section one-->
		<section class="py-5" id="scroll-target">
			<div class="row justify-content-center">
				<div class="col-lg-6 col-md-9">
					<div class="card o-hidden border-0 shadow-lg my-5">
						<div class="card-body p-0">
							<div class="row">
								<div class="col-lg">
									<div class="p-5">
										<div class="text-center">
											<h1 class="h4 text-gray-900 mb-2">重製密碼!</h1>
										</div>
										<form class="user" method="post" action="<%=request.getContextPath()%>/Reset">
											<div class="form-group">
												<input type="text" class="form-control form-control-user" name="account" placeholder="輸入帳號">
												<br>
												<input type="password" class="form-control form-control-user" name="password" placeholder="輸入密碼">
												<br>
												<input type="password" class="form-control form-control-user" name="repassword"placeholder="再次輸入密碼">
											</div>
											<br> 
											<input class="btn btn-primary btn-user btn-block"
												id="login-btn" type="submit" value="重置密碼" >
										</form>
										<c:if test="${not empty errorMsgs}">
											<font style="color:red">請修正以下錯誤:</font>
											<ul>
											    <c:forEach var="message" items="${errorMsgs}">
													<li style="color:red">${message}</li>
												</c:forEach>
											</ul>
										</c:if>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
		<script src="<%=request.getContextPath()%>/info/jquery/jquery-3.6.0.min.js"></script>
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	</main>
</body>
</html>