<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0,shrink-to-fit=no, user-scalable=no">
<meta name="KeyWords" content="">
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="renderer" content="webkit">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/fontawesome/css/all.min.css">
<link rel="stylesheet" href="css/animate.min.css">
<link rel="stylesheet" href="css/style.css">

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/index.js"></script>


<title>各類主題</title>

<meta property="og:title" content="">
<meta property="og:KeyWords" content="">
<meta property="og:description" content="">
<meta property="og:image" content="">

</head>
<body>

	<script>
		$(function() {
			if (checkIsNullSpace('${list[0].article_type_name}')) {
				$("#target").attr("action", "FirstPageIndexLoad3");
				$("#target").submit();
			}
		})
		function checkIsNullSpace(val) {
			if (val == null || val == undefined || val == "undefined"
					|| val == "") {
				return true;
			}
			return false;
		}
	</script>



	<body>

	<form id="target" name="actionForm" method="post"
		enctype="multipart/form-data"></form>
	<div class="main">

		<header>
			<div class="container">
				<div class="header_menu">
					<a href="" class="header_logo">Fun Friend</a> <span
						class="d-none d-lg-inline-block"> <a href="">論壇</a> <a
						href="">交友</a> <a href="">商城</a> <a href="">揪團</a> <a href="">聊天室</a>
					</span>
				</div>
				<div>
					<div class="header_activity d-inline-block">
						<a href="">登入</a> <a href="">註冊</a>
					</div>
					<!-- <div class="header_icons d-inline-block">
						<a href=""><i class="fas fa-envelope"></i></a>
						<a href=""><i class="fas fa-bell"></i></a>
						<a href=""><i class="fas fa-user-circle"></i></a>
					</div> -->
					<i class="fas fa-bars d-lg-none"></i>
				</div>
			</div>
		</header>

		<div class="navs">
			<div class="navs_menu container">
				<c:forEach var="list" items="${list}">
					<!--                                                       地址(跟web.xml)    問號後 傳值識別字串             集合                  屬性      -->
					<a
							href=<c:url value='/forum/SubjectPageIndexLoad2?article_type_num=${ list.article_type_num}&article_type_name=${ list.article_type_name}'/>>${list.article_type_name}</a>
				</c:forEach>

				<div class="navs_search">
					<input type="text" placeholder="請輸入關鍵字.."> <a
						href="result.html"><i class="fas fa-search"></i></a>
				</div>
			</div>
		</div>

		<section class="result">
			<div class="result_container">
				<div class="content">
					<div class="result_title">
						<div class="row h-100">
							<div class="col-5">
								<div class="result_">
									主題：<b>${Type_name}</b>
								</div>
							</div>
							<div class="col-7">
								<div class="row">
									<div class="col">
										<span>發佈時間</span>
									</div>
									<div class="col">
										<span>最後回覆時間</span>
									</div>
									<div class="col">
										<span>回應</span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="result_content">
						<c:forEach var="articleList" items="${articleList}">
							<div class="row">
								<div class="col-5">
									<a href=<c:url value='/forum/ShowArticle?article_id=${articleList.article_id}'/> class="text-truncate">${articleList.title}</a>
								</div>
								<div class="col-7">
									<div class="row">
										<div class="col">
											<span>${articleList.article_time}</span>
										</div>
										<div class="col">
											<span>2021/06/06</span>
										</div>
										<div class="col">
											<span>${articleList.pageviews}</span>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
						<div class="pages">
							<a href="" class="prev"><i class="fas fa-caret-left"></i></a> <a
								href="" class="pages_active">1</a> <a href="">2</a> <a href="">3</a>
							<a href="">4</a> <a href="">5</a> <a href="" class="next"><i
								class="fas fa-caret-right"></i></a>
						</div>
					</div>
				</div>
			</div>
		</section>

		<div class="plugins">
			<a href="create_content.jsp"><i class="fas fa-comment-medical"></i></a>
		</div>

		<footer>
			<div class="container">
				<div class="footer_more">
					<a href="">首頁</a> <a href="">關於</a> <a href="">購物說明</a>
				</div>
				<p>&copy;&nbsp;Company Marru. All Right Reversed.</p>
			</div>
		</footer>

	</div>

</body>


</html>