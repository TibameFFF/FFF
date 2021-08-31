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
	String login = (String) session.getAttribute("info");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>配對設定</title>

<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link href="<%=request.getContextPath()%>/info/css/styles.css" rel="stylesheet" />
<link href="<%=request.getContextPath()%>/info/css/14.css" rel="stylesheet" />
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
							class="d-block link-light text-decoration-none"> 登入/註冊 </a>
					</div>
					<div class="flex-shrink-0 dropdown islogin none">
						<a href="#"
							class="d-block link-light text-decoration-none dropdown-toggle"
							id="dropdownUser2" data-bs-toggle="dropdown"
							aria-expanded="false"> <img src="<%=request.getContextPath()%>/info/img/123.jpg" alt="mdo"
							width="32" height="32" class="rounded-circle">
						</a>
						<ul class="dropdown-menu text-small shadow"
							aria-labelledby="dropdownUser2" id="dropdownUserImg">
							<li><a class="dropdown-item" href="<%=request.getContextPath()%>/info/Info.jsp">會員資料</a></li>
							<li><a class="dropdown-item" href="<%=request.getContextPath()%>/info/Mapping.jsp">配對設定</a></li>
							<li><a class="dropdown-item" href="#">檢舉回覆</a></li>
							<li><a class="dropdown-item" href="#">揪團紀錄</a></li>
							<li><a class="dropdown-item" href="<%=request.getContextPath()%>/info/Order.jsp">商城紀錄</a></li>
							<li><a class="dropdown-item" href="#">論壇紀錄</a></li>
							<li><hr class="dropdown-divider"></li>
							<li>
								<form method="post" action="<%=request.getContextPath()%>/logout">
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
					<div class="col-lg-8 mapping">
						<p>配對是否開啟</p>
					</div>
					<div class="col-lg-2"></div>
					<div class="col-lg"></div>
				</div>
				<div class="row gx-5 align-items-center info">
					<div class="col-lg"></div>
					<div class="col-lg-8 mapping-v">
						<label class="switch"> <input type="checkbox" id="togBtn">
							<div class="slider round">
								<span class="off">OFF</span>
								<span class="on">ON</span>
							</div>
						</label>
					</div>
					<div class="col-lg-2"></div>
					<div class="col-lg"></div>
				</div>


				<div class="row gx-5 align-items-center info">
					<div class="col-lg"></div>
					<div class="col-lg-8 sex">
						<p>性別</p>
					</div>
					<div class="col-lg-2"></div>
					<div class="col-lg"></div>
				</div>
				<div class="row gx-5 align-items-center info">
					<div class="col-lg"></div>
					<div class="col-lg-8 sex-v">
						<p class="para"></p>
					</div>
					<div class="col-lg-2"></div>
					<div class="col-lg"></div>
				</div>


				<div class="row gx-5 align-items-center info">
					<div class="col-lg"></div>
					<div class="col-lg-8 mapping-age">
						<p>配對年齡</p>
					</div>
					<div class="col-lg-2 mapping-age-btn">
						<button class="mapping-age-edit">
							<img src="<%=request.getContextPath()%>/info/img/pencil-square.svg" width="26" height="26" alt="">
						</button>
						<button class="mapping-age-save none">
							<img src="<%=request.getContextPath()%>/info/img/check.svg" width="26" height="26" alt="">
						</button>
					</div>
					<div class="col-lg"></div>
				</div>
				<div class="row gx-5 align-items-center info">
					<div class="col-lg"></div>
					<div class="col-lg-8 mapping-age-v">
						<p id="amount"></p>
						<div class="mapping-age-update none" id="slider-range"></div>
					</div>
					<div class="col-lg-2"></div>
					<div class="col-lg"></div>
				</div>


				<div class="row gx-5 align-items-center info">
					<div class="col-lg"></div>
					<div class="col-lg-8 mapping-sex">
						<p>配對性別</p>
					</div>
					<div class="col-lg-2 mapping-sex-btn">
						<button class="mapping-sex-edit">
							<img src="img\pencil-square.svg" width="26" height="26" alt="">
						</button>
						<button class="mapping-sex-save none">
							<img src="<%=request.getContextPath()%>/info/img/check.svg" width="26" height="26" alt="">
						</button>
					</div>
					<div class="col-lg"></div>
				</div>
				<div class="row gx-5 align-items-center info">
					<div class="col-lg"></div>
					<div class="col-lg-8 mapping-sex-v">
						<p class="para"></p>

						<input type="radio" class="mapping-sex-update none" id="man"
							name="mapping-sex" value="1"> <label
							class="mapping-sex-update none" for="woman">男</label> <input
							type="radio" class="mapping-sex-update none" id="woman"
							name="mapping-sex" value="0"> <label
							class="mapping-sex-update none" for="man">女</label> <input
							type="radio" class="mapping-sex-update none" id="all"
							name="mapping-sex" value="2"> <label
							class="mapping-sex-update none" for="all">我全都要</label>
					</div>
					<div class="col-lg-2"></div>
					<div class="col-lg"></div>
				</div>


				<div class="row gx-5 align-items-center info">
					<div class="col-lg"></div>
					<div class="col-lg-8 intro">
						<p>自我介紹</p>
					</div>
					<div class="col-lg-2 intro-btn">
						<button class="intro-edit">
							<img src="<%=request.getContextPath()%>/info/img/pencil-square.svg" width="26" height="26" alt="">
						</button>
						<button class="intro-save none">
							<img src="<%=request.getContextPath()%>/info/img/check.svg" width="26" height="26" alt="">
						</button>
					</div>
					<div class="col-lg"></div>
				</div>
				<div class="row gx-5 align-items-center info">
					<div class="col-lg"></div>
					<div class="col-lg-8 intro-v">
						<p class="para"></p>
						<textarea class="intro-update none" name="intro" id="intro"
							cols="50" rows="10"></textarea>
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

		<!-- Footer -->
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
		<script src="<%=request.getContextPath()%>/info/jquery/jquery-3.6.0.min.js"></script>
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		<script>
		//按編輯按鈕
		$(".mapping-age-edit").on("click", function() {
		    $(".mapping-age-save").toggleClass("none");
		    $(".mapping-age-v").find(".para").toggleClass("none");
		    $(".mapping-age-update").toggleClass("none");
		});

		$(".mapping-sex-edit").on("click", function() {
		    $(".mapping-sex-save").toggleClass("none");
		    $(".mapping-sex-v").find(".para").toggleClass("none");
		    $(".mapping-sex-update").toggleClass("none");
		});

		$(".intro-edit").on("click", function() {
		    $(".intro-save").toggleClass("none");
		    $(".intro-v").find(".para").toggleClass("none");
		    $(".intro-update").toggleClass("none");
		});

		//按儲存按鈕
		$(".mapping-age-save").on("click", function() {
		    $(".mapping-age-save").toggleClass("none");
		    $(".mapping-age-update").toggleClass("none");
		});

		$(".mapping-sex-save").on("click", function() {
		    let msex = $("input[name=mapping-sex]:checked").val();
		    if (msex == "") {
		        alert("請選擇要要配對的性別...");
		    } else {
		        $(".mapping-sex-save").toggleClass("none");
		        $("#man").attr("checked", false); //取消打勾
		        $("#woman").attr("checked", false); //取消打勾
		        $("#all").attr("checked", false); //取消打勾
		        if (msex == 0) {
		            $(".mapping-sex-v").find(".para").html("女");
		            $("#woman").attr("checked", true); //設定打勾
		        } else if (msex == 1) {
		            $(".mapping-sex-v").find(".para").html("男");
		            $("#man").attr("checked", true); //設定打勾
		        } else if (msex == 2) {
		            $(".mapping-sex-v").find(".para").html("我全都要");
		            $("#all").attr("checked", true);
		        }

		        $(".mapping-sex-v").find(".para").toggleClass("none");
		        $(".mapping-sex-update").toggleClass("none");
		    }
		});

		$(".intro-save").on("click", function() {
		    let intro = $(".intro-update").val().trim();
		    if (intro == "") {
		        alert("請輸入要更新的自我介紹...");
		    } else {
		        $(".intro-save").toggleClass("none");
		        $(".intro-v").find(".para").html(intro);
		        $(".intro-v").find(".para").toggleClass("none");
		        $(".intro-update").toggleClass("none");
		    }
		});

		//開啟配對
		$("#togBtn").on('change', function() {
		    if ($(this).is(':checked')) {
		        $(this).attr('value', 'on');
		        // console.log($(this).val());
		    } else {
		        $(this).attr('value', 'off');
		        // console.log($(this).val());
		    }
		});

		//資料庫select會員的資料
		var send_obj = { "account": "${sessionScope.infoVO.account}" };
		
		//判斷是否登入，如登入顯示下拉選單
		if("OK" == "${sessionScope.login}") {
			$(".islogin").toggleClass("none");
		}
		
		$.ajax({
		    method: "GET",
		    url: "http://localhost:8081/FFF/MappingServletSelect",
		    data: send_obj,
		    dataType: 'json',
		    success: function(data) {
		        switch (data.mapping) {
		            case 0:
		                break;
		            case 1:
		                $("#togBtn").click();
		                break;
		        }
		        var min = data.age_min;
		        var max = data.age_max;

		        $(function() {
		            //配對年齡
		            $("#slider-range").slider({
		                range: true,
		                min: 18,
		                max: 50,
		                values: [min, max],
		                slide: function(event, ui) {
		                    $("#amount").html(ui.values[0] + " - " + ui.values[1]);
		                }
		            });
		            $("#amount").html($("#slider-range").slider("values", 0) +
		                " - " + $("#slider-range").slider("values", 1));

		            $("#togBtn").change();
		        });
		        //性別
		        switch (data.sex) {
		            case 0:
		                $(".sex-v").find(".para").html("女");
		                break;
		            case 1:
		                $(".sex-v").find(".para").html("男");
		                break;
		        }
		        //配對性別
		        $(".maping-sex-v").find(".mapping-sex-update").val(data.mapping_sex);
		        if (data.mapping_sex == 0) {
		            $(".mapping-sex-v").find(".para").html("女");
		            $("#woman").attr("checked", true); //設定打勾
		        } else if (data.mapping_sex == 1) {
		            $(".mapping-sex-v").find(".para").html("男");
		            $("#man").attr("checked", true); //設定打勾
		        } else if (data.mapping_sex == 2) {
		            $(".mapping-sex-v").find(".para").html("我全都要");
		            $("#all").attr("checked", true); //設定打勾
		        }
		        $(".intro-v").find(".para").html(data.intro);
		        $(".intro-v").find(".intro-update").val(data.intro);
		        $(".rounded-circle").attr("src", data.photo);
		    },
		    error: function() {},
		    complete: function() {}
		});

		var min;
		var max;
		$(function() {
		    //配對年齡
		    $("#slider-range").slider({
		        range: true,
		        min: 18,
		        max: 50,
		        values: [min, max],
		        slide: function(event, ui) {
		            $("#amount").html(ui.values[0] + " - " + ui.values[1]);
		        }
		    });
		    $("#amount").html($("#slider-range").slider("values", 0) +
		        " - " + $("#slider-range").slider("values", 1));

		    $("#togBtn").change();
		});

		$("#submit-btn").on("click", function() {
		    var mapping;
		    switch ($(".mapping-v").find("#togBtn").val()) {
		        case "off":
		            mapping = 0;
		            break;
		        case "on":
		            mapping = 1;
		            break;
		    }
		    var mappingsex;
		    switch ($("input[name=mapping-sex]:checked").val()) {
		        case "0":
		            mappingsex = 0;
		            break;
		        case "1":
		            mappingsex = 1;
		            break;
		        case "2":
		            mappingsex = 2;
		            break;
		    }

		    var update_obj = {
		        "account": "${sessionScope.infoVO.account}",
		        "mapping": mapping,
		        "age_min": $("#slider-range").slider("values", 0),
		        "age_max": $("#slider-range").slider("values", 1),
		        "mapping_sex": mappingsex,
		        "intro": $(".intro-v").find(".intro-update").val().trim(),
		    }
		    $.ajax({
		        method: "POST",
		        url: "http://localhost:8081/FFF/MappingServletUpdate",
		        data: update_obj,
		        dataType: 'json',
		        success: function(data) {
		        },
		        error: function(data) {
		        },
		        complete: function() {}
		    });
		});
		</script>
	</main>
</body>
</html>