<%@page import="com.info.model.InfoVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	Object obj = session.getAttribute("infoVO");
	if(obj == null){
		response.sendRedirect(request.getContextPath()+"/info/Login.jsp");   //*工作2 : 請該user去登入網頁(login.html) , 進行登入
	    return;
	}
	InfoVO infoVO = (InfoVO) obj;
	String login = (String) session.getAttribute("login");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>會員資料</title>
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<link href="<%=request.getContextPath()%>/info/css/styles.css"
	rel="stylesheet" />
<link href="<%=request.getContextPath()%>/info/css/14.css"
	rel="stylesheet" />
</head>

<body class="d-flex flex-column">
	<main class="flex-shrink-0">
		<!-- header -->
		<nav class="navbar navbar-expand-md navbar-dark bg-dark "
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
							data-bs-toggle="dropdown" aria-expanded="false">論壇</a>
							<ul class="dropdown-menu" aria-labelledby="dropdown04">
								<li><a class="dropdown-item" href="#">aaaaaaa</a></li>
								<li><a class="dropdown-item" href="#">bbbbbbb</a></li>
								<li><a class="dropdown-item" href="#">ccccccc</a></li>
							</ul></li>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#" id="dropdown04"
							data-bs-toggle="dropdown" aria-expanded="false">交友</a>
							<ul class="dropdown-menu" aria-labelledby="dropdown04">
								<li><a class="dropdown-item" href="#">aaaaaaa</a></li>
								<li><a class="dropdown-item" href="#">bbbbbbb</a></li>
								<li><a class="dropdown-item" href="#">ccccccc</a></li>
							</ul></li>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#" id="dropdown04"
							data-bs-toggle="dropdown" aria-expanded="false">商城</a>
							<ul class="dropdown-menu" aria-labelledby="dropdown04">
								<li><a class="dropdown-item" href="#">aaaaaaa</a></li>
								<li><a class="dropdown-item" href="#">bbbbbbb</a></li>
								<li><a class="dropdown-item" href="#">ccccccc</a></li>
							</ul></li>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#" id="dropdown04"
							data-bs-toggle="dropdown" aria-expanded="false">揪團</a>
							<ul class="dropdown-menu" aria-labelledby="dropdown04">
								<li><a class="dropdown-item" href="#">aaaaaaa</a></li>
								<li><a class="dropdown-item" href="#">bbbbbbb</a></li>
								<li><a class="dropdown-item" href="#">ccccccc</a></li>
							</ul></li>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#" id="dropdown04"
							data-bs-toggle="dropdown" aria-expanded="false">聊天室</a>
							<ul class="dropdown-menu" aria-labelledby="dropdown04">
								<li><a class="dropdown-item" href="#">aaaaaaa</a></li>
								<li><a class="dropdown-item" href="#">bbbbbbb</a></li>
								<li><a class="dropdown-item" href="#">ccccccc</a></li>
							</ul></li>
					</ul>
					<div class="flex-shrink-0 dropdown islogin">
						<a href="<%=request.getContextPath()%>/info/Login.jsp"
							class="d-block link-light text-decoration-none" target="_blank">
							登入/註冊 </a>
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
							<li><a class="dropdown-item" href="<%=request.getContextPath()%>/info/Info.jsp"
								target="_blank" id="info">會員資料</a></li>
							<li><a class="dropdown-item" href="<%=request.getContextPath()%>/info/Mapping.jsp"
								target="_blank" id="mapping">配對設定</a></li>
							<li><a class="dropdown-item" href="#">檢舉回覆</a></li>
							<li><a class="dropdown-item" href="#">揪團紀錄</a></li>
							<li><a class="dropdown-item" href="<%=request.getContextPath()%>/info/Order.jsp">商城紀錄</a></li>
							<li><a class="dropdown-item" href="#">論壇紀錄</a></li>
							<li><hr class="dropdown-divider"></li>
							<li>
								<form method="post" action="<%=request.getContextPath()%>/Logout">
									<button class="dropdown-item" id="logout-btn" >登出</button>
								</form>
							</li>

						</ul>
					</div>
				</div>
			</div>
		</nav>

		<!-- section -->
		<section class="py-5" id="scroll-target">
			<div class="container px-5 my-5">
				<div class="row gx-5 align-items-center info">
					<div class="col-lg"></div>
					<div class="col-lg-2 user-center">
						<img src="<%=request.getContextPath()%>/info/img/123.jpg"
							alt="mdo" width="100" height="100" class="rounded-circle"
							id="user-photo">
					</div>
					<div class="col-lg"></div>
				</div>
				<div class="row gx-5 align-items-center info">
					<div class="col-lg"></div>
					<div class="col-lg-2 img-btn">
						<button class="img-update">
							<input class="img-update-input" type="file" style="position: absolute; opacity: 0;"> 
							<img class="img-updat-img" src="<%=request.getContextPath()%>/info/img/camera-fill.svg" width="26" height="26" alt="">
						</button>
					</div>
					<div class="col-lg"></div>
				</div>


				<div class="row gx-5 align-items-center info">
					<div class="col-lg"></div>
					<div class="col-lg-8 account">
						<p>帳號</p>
					</div>
					<div class="col-lg-2"></div>
					<div class="col-lg"></div>
				</div>
				<div class="row gx-5 align-items-center info">
					<div class="col-lg"></div>
					<div class="col-lg-8 account-v">
						<p class="para"></p>
					</div>
					<div class="col-lg-2"></div>
					<div class="col-lg"></div>
				</div>


				<div class="row gx-5 align-items-center info">
					<div class="col-lg"></div>
					<div class="col-lg-8 email">
						<p>電子信箱</p>
					</div>
					<div class="col-lg-2"></div>
					<div class="col-lg"></div>
				</div>
				<div class="row gx-5 align-items-center info">
					<div class="col-lg"></div>
					<div class="col-lg-8 email-v">
						<p class="para"></p>
					</div>
					<div class="col-lg-2"></div>
					<div class="col-lg"></div>
				</div>


				<div class="row gx-5 align-items-center info">
					<div class="col-lg"></div>
					<div class="col-lg-8 birthday">
						<p>出生年月日</p>
					</div>
					<div class="col-lg-2"></div>
					<div class="col-lg"></div>
				</div>
				<div class="row gx-5 align-items-center info">
					<div class="col-lg"></div>
					<div class="col-lg-8 birthday-v">
						<p class="para"></p>
					</div>
					<div class="col-lg-2"></div>
					<div class="col-lg-1"></div>
				</div>


				<div class="row gx-5 align-items-center info">
					<div class="col-lg"></div>
					<div class="col-lg-8 nikename">
						<p>暱稱</p>
					</div>
					<div class="col-lg-2 nikename-btn">
						<button class="nikename-edit">
							<img
								src="<%=request.getContextPath()%>/info/img/pencil-square.svg"
								width="26" height="26" alt="">
						</button>
						<button class="nikename-save none">
							<img src="<%=request.getContextPath()%>/info/img/check.svg"
								width="26" height="26" alt="">
						</button>
					</div>
					<div class="col-lg"></div>
				</div>
				<div class="row gx-5 align-items-center info">
					<div class="col-lg"></div>
					<div class="col-lg-8 nikename-v">
						<p class="para"></p>
						<input type="text" class="nikename-update none"
							placeholder="更新暱稱..." value="">
					</div>
					<div class="col-lg-2"></div>
					<div class="col-lg"></div>
				</div>


				<div class="row gx-5 align-items-center info">
					<div class="col-lg"></div>
					<div class="col-lg-8 name">
						<p>姓名(僅商城交易使用)</p>
					</div>
					<div class="col-lg-2 name-btn">
						<button class="name-edit">
							<img
								src="<%=request.getContextPath()%>/info/img/pencil-square.svg"
								width="26" height="26" alt="">
						</button>
						<button class="name-save none">
							<img src="<%=request.getContextPath()%>/info/img/check.svg"
								width="26" height="26" alt="">
						</button>
					</div>
					<div class="col-lg"></div>
				</div>
				<div class="row gx-5 align-items-center info">
					<div class="col-lg"></div>
					<div class="col-lg-8 name-v">
						<p class="para"></p>
						<input type="text" class="name-update none" placeholder="更新姓名..."
							value="">
					</div>
					<div class="col-lg-2"></div>
					<div class="col-lg"></div>
				</div>


				<div class="row gx-5 align-items-center info">
					<div class="col-lg"></div>
					<div class="col-lg-8 pswd">
						<p>密碼</p>
					</div>
					<div class="col-lg-2 pswd-btn">
						<button class="pswd-edit">
							<img
								src="<%=request.getContextPath()%>/info/img/pencil-square.svg"
								width="26" height="26" alt="">
						</button>
						<button class="pswd-save none">
							<img src="<%=request.getContextPath()%>/info/img/check.svg"
								width="26" height="26" alt="">
						</button>
					</div>
					<div class="col-lg"></div>
				</div>
				<div class="row gx-5 align-items-center info">
					<div class="col-lg"></div>
					<div class="col-lg-8 pswd-v">
						<p class="para"></p>
						<input type="password" class="pswd-update none"
							placeholder="更新密碼..." value="123456">
					</div>
					<div class="col-lg-2"></div>
					<div class="col-lg"></div>
				</div>
				<div class="row gx-5 align-items-center info">
					<div class="col-lg"></div>
					<div class="col-lg-8 submit">
						<button class="btn btn-primary btn-user btn-block" id="submit-btn">提交</button>
					</div>
					<div class="col-lg-2"></div>
					<div class="col-lg"></div>
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
				<p></p>
			</div>
		</footer>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
		<script src="<%=request.getContextPath()%>/info/jquery/jquery-3.6.0.min.js"></script>
		<script>
			//按編輯按鈕
			$(".nikename-edit").on("click", function() {
				$(".nikename-save").toggleClass("none");
				$(".nikename-v").find(".para").toggleClass("none");
				$(".nikename-update").toggleClass("none");
			});

			$(".name-edit").on("click", function() {
				$(".name-save").toggleClass("none");
				$(".name-v").find(".para").toggleClass("none");
				$(".name-update").toggleClass("none");
			});

			$(".pswd-edit").on("click", function() {
				$(".pswd-save").toggleClass("none");
				$(".pswd-v").find(".para").toggleClass("none");
				$(".pswd-update").toggleClass("none");
			});

			//按儲存按鈕
			$(".nikename-save").on("click", function() {
				let nikename = $(".nikename-update").val().trim()
				if (nikename == "") {
					alert("請輸入要更新的暱稱...");
				} else {
					$(".nikename-save").toggleClass("none");
					$(".nikename-v").find(".para").html(nikename);
					$(".nikename-v").find(".para").toggleClass("none");
					$(".nikename-update").toggleClass("none");
				}
			});

			$(".name-save").on("click", function() {
				let name = $(".name-update").val().trim()
				if (name == "") {
					alert("請輸入要更新的暱稱...");
				} else {
					$(".name-save").toggleClass("none");
					$(".name-v").find(".para").html(name);
					$(".name-v").find(".para").toggleClass("none");
					$(".name-update").toggleClass("none");
				}
			});

			$(".pswd-save").on("click", function() {
				let pswd = $(".pswd-update").val().trim();
				let star = "";
				let step;
				for (step = 1; step <= pswd.length; step++) {
					star = star + "*";
				}
				if (pswd == "") {
					alert("請輸入要更新的暱稱...");
				} else {
					$(".pswd-save").toggleClass("none");
					$(".pswd-v").find(".para").html(star);
					$(".pswd-v").find(".para").toggleClass("none");
					$(".pswd-update").toggleClass("none");
				}
			});

			//上傳圖片 var reader = new FileReader();
			$(".img-update-input").on("change", function() {
				previewFile(this);
			});

			function previewFile(input) {
				var file = $("input[type=file]").get(0).files[0];
				console.log(file);
				if (file) {
					var reader = new FileReader();
					reader.onload = function() {
						$(".rounded-circle").attr("src", reader.result);
					}
					reader.readAsDataURL(file);
				}
			}
			//資料庫select會員的資料
			var send_obj = {"account" : "${sessionScope.infoVO.account}" };
			
			//判斷是否登入，如登入顯示下拉選單
			if("OK" == "${sessionScope.login}"){
				$(".islogin").toggleClass("none");
			}
			
			$.ajax({
				method : "POST",
				url : "http://localhost:8081/FFF/InfoServletSelect",
				data : send_obj,
				dataType : 'json',
				success : function(data) {
					let step;
					let star = "";
					$(".account-v").find(".para").html(data.account);
					$(".email-v").find(".para").html(data.email);
					$(".nikename-v").find(".para").html(data.user_nickname);
					$(".nikename-v").find(".nikename-update").val(
							data.user_nickname);
					$(".name-v").find(".para").html(data.user_name);
					$(".name-v").find(".name-update").val(data.user_name);
					for (step = 1; step <= data.password.length; step++) {
						star = star + "*";
					}
					$(".pswd-v").find(".para").html(star);
					$(".pswd-v").find(".pswd-update").val(data.password);
					$(".birthday-v").find(".para").html(data.birthday);
					$(".rounded-circle").attr("src", data.photo);
				},
				error : function(data) {
				},
				complete : function() {
				}
			});
			//更新資料
			$("#submit-btn").on("click",function() {
				var update_obj = {
					"account" : "${sessionScope.infoVO.account}",
					"user_nickname" : $(".nikename-v").find(".nikename-update").val().trim(),
					"user_name" : $(".name-v").find(".name-update").val().trim(),
					"password" : $(".pswd-v").find(".pswd-update").val().trim(),
					"photo" : $(".rounded-circle").attr('src')
					}
					$.ajax({
						method : "POST",
						url : "http://localhost:8081/FFF/InfoServletUpdate",
						data : update_obj,
						dataType : 'json',
						success : function(data) {
						},
						error : function(data) {},
						complete : function() {}
					});
			});
		</script>
	</main>
</body>
</html>