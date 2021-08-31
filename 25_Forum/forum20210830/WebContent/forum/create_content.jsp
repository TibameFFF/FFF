<%@page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0,shrink-to-fit=no, user-scalable=no">
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


<title></title>

<meta property="og:title" content="">
<meta property="og:KeyWords" content="">
<meta property="og:description" content="">
<meta property="og:image" content="">

</head>
<body>

	<div class="main">
		
		<header>
			<div class="container">
				<div class="header_menu">
					<a href="" class="header_logo">Fun Friend</a>
					<span class="d-none d-lg-inline-block">
						<a href="">論壇</a>
						<a href="">交友</a>
						<a href="">商城</a>
						<a href="">揪團</a>
						<a href="">聊天室</a>
					</span>
				</div>
				<div>
					<!-- <div class="header_activity d-inline-block">
						<a href="">登入</a>
						<a href="">註冊</a>
					</div> -->
					<div class="header_icons d-inline-block">
						<a href=""><i class="fas fa-envelope"></i></a>
						<a href=""><i class="fas fa-bell"></i></a>
						<a href=""><i class="fas fa-user-circle"></i></a>
					</div>
					<i class="fas fa-bars d-lg-none"></i>
				</div>
			</div>
		</header>
		
		<div class="navs">
			<div class="container">
				<div class="navs_menu">
					<a href="navs.html">運動</a>
					<a href="navs.html">旅遊</a>
					<a href="navs.html">戶外</a>
					<a href="navs.html">生活</a>
					<a href="navs.html">閒聊</a>
					<a href="navs.html">時事</a>
					<a href="navs.html">戀愛交友</a>
					<a href="navs.html">知性男女</a>
					<a href="navs.html">男女法律</a>
				</div>
				<div class="navs_search">
					<input type="text" placeholder="請輸入關鍵字..">
					<a href="result.html"><i class="fas fa-search"></i></a>
				</div>
			</div>
		</div>

		<section class="result">
			<div class="result_container">
				<div class="content">
					<div class="result_title">
						<div class="row h-100">
							<div class="col-12 d-flex align-items-center justify-content-center">
								<div class="result_ w-75">
									<!-- 文章標題框 -->
									<input type="text" minlength="1" maxlength="" placeholder="請輸入文章標題">
								</div>
							</div>
						</div>
					</div>
					<div class="result_content">
						<div class="containers">
							<div class="row">
								<div class="col-12">
									<form action="">
										<div class="see_text">
											<div class="row justify-content-center">
												<div class="col-12 col-lg-8">
													<!-- user 上傳圖片的 圖片資料 獲取 value 值 -->
													<input class="avator_url" type="hidden" value="">
													<input onchange="load_file($(this));" id="upload" type="file" style="display:none;" accept="image/png, image/jpg, image/jpeg">
													<label for="upload" class="btn_upload bg-secondary">
														<i class="fas fa-plus-circle"></i><br>上傳圖片
													</label>
													<label onclick="load_file($(this));" class="btn_delete bg-danger d-none">
														<i class="fas fa-minus-circle"></i><br>刪除圖片
													</label>
													<p class="text_larger text-secondary">圖片預覽</p>
													<small class="text-danger text-center d-block mb-2">圖片上傳限制大小為 5MB</small>
													<!-- user 上傳圖片 預覽區塊 -->
													<div class="review_avator"></div>
												</div>
											</div>
											<!-- 文章輸入框 -->
											<textarea class="mb-4" name="" id="" cols="30" rows="10" placeholder="請輸入您的文章..."></textarea>
											<div class="row justify-content-center">
												<div class="col-12 col-lg-8">
													<div class="row">
														<div class="col-6 mb-5">
															<span class="btn btn-block btn-lg btn-danger" onclick="history.back();">取消發佈</span>
														</div>
														<div class="col-6 mb-5">
															<a href=""><span class="btn btn-block btn-lg btn-success">確定發佈</span></a>
														</div>
													</div>
												</div>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>

		<div class="plugins">
			<a href="create_content.html"><i class="fas fa-comment-medical"></i></a>
		</div>

		<footer>
			<div class="container">
				<div class="footer_more">
					<a href="">首頁</a>
					<a href="">關於</a>
					<a href="">購物說明</a>
				</div>
				<p>&copy;&nbsp;Company Marru. All Right Reversed.</p>
			</div>
		</footer>
	
	</div>

	<!-- 上傳圖片code-->
	<script>
		function load_file(_self) {
			if (_self.is("#upload")) {
				var file = _self[0].files[0];
				var file_reader = new FileReader;
				if (!file || file.type.indexOf("image") != 0) {
					_self.val("");
					return false;
				}
				var file_max = 5*1024*1024; 
				var file_size = file.size;
				if (file_size > file_max) {
					_self.val("");
					alert("請上傳5MB以內jpg、png圖檔。");
					return false;
				} else if (file_size <= 0) {
					_self.val("");
					alert("上傳jpg、png圖檔，不能爲0。");
					return false;
				} 
				file_reader.onload = function(e) {
					var img_info = e.target.result;
					var html_real = '<img id="real_avator" src="' + img_info + '">' 
					$(".review_avator").html(html_real);
					$(".avator_url").val(img_info);
				};
				file_reader.readAsDataURL(file);
				_self.val("");
				$(".btn_upload").hide();
				$(".btn_delete").removeClass("d-none").show();
			}
			if (_self.is(".btn_delete")) {
				$(".review_avator").html("");
				$("#upload").val("");
				$(".avator_url").val("");
				$(".btn_upload").show();
				$(".btn_delete").hide();
			}
		};
	</script>
	
</body>
</html>