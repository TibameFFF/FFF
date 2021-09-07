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


<title>首頁</title>

<meta property="og:title" content="">
<meta property="og:KeyWords" content="">
<meta property="og:description" content="">
<meta property="og:image" content="">

</head>

<script>
	$(function() {
		if (checkIsNullSpace('${list[0].article_type_name}')) {
			$("#target").attr("action", "FirstPageIndexLoad");
			$("#target").submit();
		}
	})
	function checkIsNullSpace(val) {
		if (val == null || val == undefined || val == "undefined" || val == "") {
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
			<div class="container">
				<div class="navs_menu">

					<c:forEach var="list" items="${list}">
						<!--                                                       地址(跟web.xml)    問號後 傳值識別字串             集合                  屬性      -->
						<a
							href=<c:url value='/forum/SubjectPageIndexLoad2?article_type_num=${ list.article_type_num}&article_type_name=${ list.article_type_name}'/>>${list.article_type_name}</a>

					</c:forEach>



				</div>
			</div>
		</div>

		<section class="idx">
			<div class="idx_container">
				<div class="content">
					<div class="notify">
						<i class="fas fa-bullhorn pr-3"></i>
						<marquee scrolldelay="120" direction="left"
							onmouseenter="this.stop();" onmouseout="this.start();">
							<a href="">Tibame 所有課程全面五折起 兩人同型一人免費 只限100人次 報名要快唷！</a>
						</marquee>
					</div>
					<div class="row h_lg_100">
						<div class="col-12 col-lg text-center mb-4 mb-lg-0">
							<span class="idx_items">精選文章TOP10</span><br>
							<div class="idx_frame">
								<ol>

									<c:forEach var="list1" items="${list1}">
										<li>
											<p class="text-truncate">
												<a href=<c:url value='/forum/ShowArticle?article_id=${list1.article_id}'/>>${list1.title}</a>
											</p>
										</li>
									</c:forEach>

								</ol>
							</div>
						</div>
						<div class="col-12 col-lg text-center mb-4 mb-lg-0">
							<span class="idx_items">商城精選</span><br>
							<div class="idx_frame">
								<ol>

									<c:forEach var="list3" items="${list3}">

										<li>
											<p class="text-truncate">
												<a href="navs.jsp">${list3.hist_prod_name}</a>
												<!--								<a href="">&nbsp;五月天門票，買一送一</a>    -->
											</p>
										</li>
									</c:forEach>

								</ol>
							</div>
						</div>
						<div class="col-12 col-lg text-center mb-4 mb-lg-0">
							<span class="idx_items">最新文章NEW10..</span><br>
							<div class="idx_frame">
								<ol>

									<c:forEach var="list2" items="${list2}">
										<li>
											<p class="text-truncate">
												<a href=<c:url value='/forum/ShowArticle?article_id=${list2.article_id}'/>>${list2.title}</a>
											</p>
										</li>
									</c:forEach>

								</ol>
							</div>
						</div>
					</div>
				</div>
				<!-- <div class="ads">
					<div><span>tibame</span></div>
					<div><span>tibame</span></div>
				</div> -->
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