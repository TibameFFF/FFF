<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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


<title>文章</title>

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
					<a href="" class="header_logo">Fun Friend</a> <span
						class="d-none d-lg-inline-block"> <a href="">論壇</a> <a
						href="">交友</a> <a href="">商城</a> <a href="">揪團</a> <a href="">聊天室</a>
					</span>
				</div>
				<div>
					<!-- <div class="header_activity d-inline-block">
						<a href="">登入</a>
						<a href="">註冊</a>
					</div> -->
					<div class="header_icons d-inline-block">
						<a href=""><i class="fas fa-envelope"></i></a> <a href=""><i
							class="fas fa-bell"></i></a> <a href=""><i
							class="fas fa-user-circle"></i></a>
					</div>
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
<!-- 					<a href="navs.html" class="font-weight-bold">運動</a> <a -->
<!-- 						href="navs.html">旅遊</a> <a href="navs.html">戶外</a> <a -->
<!-- 						href="navs.html">生活</a> <a href="navs.html">閒聊</a> <a -->
<!-- 						href="navs.html">時事</a> <a href="navs.html">戀愛交友</a> <a -->
<!-- 						href="navs.html">知性男女</a> <a href="navs.html">男女法律</a> -->
				</div>
				<div class="navs_search">
					<input type="text" placeholder="請輸入關鍵字.."> <a
						href="result.html"><i class="fas fa-search"></i></a>
				</div>
			</div>
		</div>

		<section class="result">
			<div class="result_container">
				<c:forEach var="articleList" items="${articleList}">
					<div class="content">
						<!-- --- -->
						<div class="result_title">
							<div class="row h-100">
								<div
									class="col-12 d-flex align-items-center justify-content-center">
									<div class="result_">${articleList.title}</div>
								</div>
							</div>
						</div>
						<div class="result_content">
							<div class="containers">
								<div class="row">
									<div class="col-12">
										<div class="see_text">
											<div class="row justify-content-center">
												<div class="col-12 col-lg-8">
													<img
														src='${pageContext.servletContext.contextPath}/forum/RetrieveLaunchImageServlet?article_id=${articleList.article_id}'
														height="100%" width="100%" />
												</div>
											</div>
											<p class="mb-5 text-justify">

												${articleList.article_content}</p>
											<div
												class="d-flex flex-wrap align-items-center justify-content-between">
												<div class="col-12 col-lg-7 text-left px-0">
													<small>
														<div class="d-inline text-secondary">
															<i class="fas fa-user"></i>&nbsp;<span>${articleList.user_id}</span>
														</div> <a href="" class="reply_msg text-secondary"><i
															class="fas fa-thumbs-up"></i>&nbsp;${articleList.article_num_count}</a>
														<div class="d-inline text-secondary">


															<i class="far fa-clock"></i>&nbsp;<span>${fn:substring(articleList.article_time,0,10)}</span>&nbsp;
															<%-- 															<span>${fn:substring(articleList.article_time,10,16)}</span> --%>
														</div>
													</small>
												</div>
												<div class="col-12 col-lg-5 text-right px-0">
													<small>
														<div class="d-inline text-secondary">
															<i class="far fa-eye"></i>&nbsp;<span>${articleList.pageviews}</span>
														</div> <!-- 														<a href="" class="text-secondary"><i -->
														<!-- 															class="far fa-heart"></i>&nbsp;收藏</a>  -->
														<!-- <a href="" class="text-danger"><i class="fas fa-heart"></i>&nbsp;已收藏</a> -->
														<a href="javascript:void(0);"
														class="text-secondary main_reply"
														onclick="msg_reply($(this));"><i
															class="fas fa-comment"></i>&nbsp;留言</a> <a
														href="#modal_report" data-toggle="modal"
														class="font-weight-light">檢舉</a>
													</small>
												</div>
											</div>
											<div class="reply_area"></div>
											<br>
											<hr>
											<br>
											<div class="reply_all">
												<div class="user_reply">
													<if test="${replyList} != null"> <c:forEach
														var="replyList" items="${replyList}">
														<div class="d-flex w-100">
															<!--  留言開始-->
															<img src="https://picsum.photos/500/400?random=1">
															<div class="p">
																<span>${replyList.reply_user_id}</span>
																<p>${replyList.reply_content}</p>
																<div class="reply_date">
																	<i class="far fa-clock"></i>&nbsp;發布時間&nbsp;<span>${fn:substring(replyList.reply_time,0,10)}</span>&nbsp;
																	<!-- 																<span>16:26</span> -->
																</div>
																<small> <a href=""
																	class="reply_msg text-primary"><i
																		class="fas fa-thumbs-up"></i>&nbsp;${replyList.reply_like_count}</a>
																	<a href="javascript:void(0);"
																	class="reply_msg text-primary"
																	onclick="msg_reply($(this));">回覆</a> <a
																	href="javascript:void(0);"
																	onclick="msg_reply($(this));"
																	class="reply_remove text-danger">刪除</a> <!-- <a href="#modal_report" data-toggle="modal" class="text-danger">檢舉</a> -->
																</small>
																<div class="reply_area"></div>
																<div class="reply_show">
																	<!-- 																<div class="d-flex w-100"> -->
																	<!-- 																	<img src="https://picsum.photos/500/400?random=1"> -->
																	<!-- 																	<div class="p"> -->
																	<!-- 																		<span>這是我本人</span> -->
																	<!-- 																		<p>單進一，觀率員一開行。錢可身顧性的先超一望我不專感車土連畫人，明保兩聲電上面代操的了助最今變、及後場是，油們題的，是如校？總己發，排傳的，是因加古，因候年樹了，青不我清有手面：話必部性天中見斯位待無的求代世來場遠陸必發期金。</p> -->
																	<!-- 																		<div class="reply_date"> -->
																	<!-- 																			<i class="far fa-clock"></i>&nbsp;發布時間&nbsp;<span>2021/03/03</span>&nbsp;<span>16:26</span> -->
																	<!-- 																		</div> -->
																	<!-- 																		<small> <a href=""><i -->
																	<!-- 																				class="fas fa-thumbs-up"></i>&nbsp;(99)</a></a> <a -->
																	<!-- 																			href="javascript:void(0);" -->
																	<!-- 																			onclick="msg_reply($(this));" -->
																	<!-- 																			class="reply_remove_inner">刪除</a> <a href="#modal_report" data-toggle="modal">檢舉</a> -->
																	<!-- 																		</small> -->
																	<!-- 																	</div> -->
																	<!-- 																</div> -->
																</div>
															</div>
														</div>
														<!--  留言結束-->
													</c:forEach> </if>
													<if test="${replyList} == null"> 按留言搶頭香喔喔喔 </if>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="pages">
								<a href="" class="prev"><i class="fas fa-caret-left"></i></a> <a
									href="" class="pages_active">1</a> <a href="">2</a> <a href="">3</a>
								<a href="">4</a> <a href="">5</a> <a href="" class="next"><i
									class="fas fa-caret-right"></i></a>
							</div>
						</div>
					</div>
					<!-- --- -->
				</c:forEach>
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

		<div id="modal_report" class="modal fade">
			<div class="modal-dialog modal-dialog-centered modal-lg">
				<div class="modal-content">
					<span data-dismiss="modal" class="modal_close"><i
						class="fas fa-times"></i></span>
					<div class="modal-header pt-5">請輸入您檢舉的原因</div>
					<div class="modal-body">
						<div class="d-flex w-100 align-items-center mb-3">
							<input type="checkbox">&ensp;<label for="">裸露</label>
						</div>
						<div class="d-flex w-100 align-items-center mb-3">
							<input type="checkbox">&ensp;<label for="">暴力</label>
						</div>
						<div class="d-flex w-100 align-items-center mb-3">
							<input type="checkbox">&ensp;<label for="">自殺自殘</label>
						</div>
						<div class="d-flex w-100 align-items-center mb-3">
							<input type="checkbox">&ensp;<label for="">不實資訊</label>
						</div>
						<div class="d-flex w-100 align-items-center mb-3">
							<input type="checkbox">&ensp;<label for="">垃圾訊息</label>
						</div>
						<div class="d-flex w-100 align-items-center mb-3">
							<input type="checkbox">&ensp;<label for="">販售違禁品</label>
						</div>
						<div class="d-flex w-100 align-items-center mb-3">
							<input type="checkbox">&ensp;<label for="">仇恨言論</label>
						</div>
						<div class="d-flex w-100 align-items-center mb-3">
							<input type="checkbox">&ensp;<label for="">恐怖主義</label>
						</div>
						<div class="d-flex w-100 align-items-center mb-3">
							<input type="checkbox">&ensp;<label for="">其他</label> <br>
						</div>
						<textarea name="" id="" cols="30" rows="10" placeholder="請輸入..."></textarea>
					</div>
					<div class="modal-footer">
						<span class="btn btn-secondary" data-dismiss="modal">取消</span> <a
							href=""><span class="btn btn-primary">提交</span></a>
					</div>
				</div>
			</div>
		</div>

	</div>


	<script>
		function msg_reply(_self) {
			var txtarea = '<textarea name="" id="" cols="30" rows="5" placeholder="請輸入您的回覆訊息..."></textarea><a href="javascript:void(0);" class="reply_cancel" onclick="msg_reply($(this));"><span class="btn btn-danger d-inline-block text-white">取消</span></a>&emsp;<a href=""><span class="btn btn-primary d-inline-block text-white">確認</span></a>';
			$(".reply_area").html("");
			if (_self.is(".reply_msg")) {
				_self.parent().siblings(".reply_area").html(txtarea);
			}
			if (_self.is(".main_reply")) {
				_self.parent().parent().parent().siblings(".reply_area").html(
						txtarea);
			}
			if (_self.is(".reply_cancel")) {
				$(".reply_area").html("");
			}
			if (_self.is(".reply_remove")) {
				_self.parent().parent().parent().parent().remove();
			}
			if (_self.is(".reply_remove_inner")) {
				_self.parent().parent().parent().remove();
			}
		};
	</script>

</body>
</html>