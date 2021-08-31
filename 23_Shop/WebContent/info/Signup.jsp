<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>註冊</title>
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <!-- Bootstrap icons-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="<%=request.getContextPath()%>/info/css/styles.css" rel="stylesheet" />
    <link href="<%=request.getContextPath()%>/info/css/14.css" rel="stylesheet" />
</head>

<body class="d-flex flex-column">
    <main class="flex-shrink-0">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-md navbar-dark bg-dark " aria-label="Fourth navbar example">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Fun Friend</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsExample04" aria-controls="navbarsExample04" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                <div class="collapse navbar-collapse" id="navbarsExample04">
                    <ul class="navbar-nav me-auto mb-2 mb-md-0">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="dropdown04" data-bs-toggle="dropdown" aria-expanded="false">論壇</a>
                            <ul class="dropdown-menu" aria-labelledby="dropdown04">
                                <li><a class="dropdown-item" href="#">aaaaaaa</a></li>
                                <li><a class="dropdown-item" href="#">bbbbbbb</a></li>
                                <li><a class="dropdown-item" href="#">ccccccc</a></li>
                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="dropdown04" data-bs-toggle="dropdown" aria-expanded="false">交友</a>
                            <ul class="dropdown-menu" aria-labelledby="dropdown04">
                                <li><a class="dropdown-item" href="#">aaaaaaa</a></li>
                                <li><a class="dropdown-item" href="#">bbbbbbb</a></li>
                                <li><a class="dropdown-item" href="#">ccccccc</a></li>
                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="dropdown04" data-bs-toggle="dropdown" aria-expanded="false">商城</a>
                            <ul class="dropdown-menu" aria-labelledby="dropdown04">
                                <li><a class="dropdown-item" href="#">aaaaaaa</a></li>
                                <li><a class="dropdown-item" href="#">bbbbbbb</a></li>
                                <li><a class="dropdown-item" href="#">ccccccc</a></li>
                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="dropdown04" data-bs-toggle="dropdown" aria-expanded="false">揪團</a>
                            <ul class="dropdown-menu" aria-labelledby="dropdown04">
                                <li><a class="dropdown-item" href="#">aaaaaaa</a></li>
                                <li><a class="dropdown-item" href="#">bbbbbbb</a></li>
                                <li><a class="dropdown-item" href="#">ccccccc</a></li>
                            </ul>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="dropdown04" data-bs-toggle="dropdown" aria-expanded="false">聊天室</a>
                                <ul class="dropdown-menu" aria-labelledby="dropdown04">
                                    <li><a class="dropdown-item" href="#">aaaaaaa</a></li>
                                    <li><a class="dropdown-item" href="#">bbbbbbb</a></li>
                                    <li><a class="dropdown-item" href="#">ccccccc</a></li>
                                </ul>
                            </li>
                    </ul>
                    <div class="flex-shrink-0 dropdown islogin">
                        <a href="<%=request.getContextPath()%>/info/Login.jsp" class="d-block link-light text-decoration-none" target="_blank">
                            	登入/註冊
                        </a>
                    </div>
                </div>
            </div>
        </nav>

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
                                            <h1 class="h4 text-gray-900 mb-4">建立帳號!</h1>
                                        </div>
                                        <form class="user" method="post" action="<%=request.getContextPath()%>/Signup">
                                            <div class="form-group row">
                                                <div class="col-sm-6 mb-3 mb-sm-0">
                                                    <input type="text" class="form-control form-control-user" name="signup-name" placeholder="輸入真實姓名">
                                                </div>
                                                <div class="col-sm-6">
                                                    <input type="text" class="form-control form-control-user" name="signup-nickname" placeholder="輸入暱稱">
                                                </div>
                                            </div>
                                            <br>
                                            <div class="form-group row">
                                                <div class="col-sm-6 mb-3 mb-sm-0">
                                                    <input type="text" class="form-control form-control-user" name="signup-account" placeholder="輸入帳號">
                                                </div>
                                                <div class="col-sm-6">
                                                    <input type="email" class="form-control form-control-user" name="signup-email" placeholder="輸入電子信箱">
                                                </div>
                                            </div>
                                            <br>
                                            <div class="form-group row">
                                                <div class="col-sm-6 mb-3 mb-sm-0">
                                                    <input type="date" class="form-control form-control-user" name="signup-birthday" placeholder="輸入出生日期">
                                                </div>
                                                <div class="col-sm-6" style="text-align: center; align-items: center;">
                                                    <label for="signup-radio1">男:</label>
                                                    <input type="radio" id="signup-radio1" name="signup-radio" value="1">
                                                    <label for="signup-radio2">女:</label>
                                                    <input type="radio" id="signup-radio2" name="signup-radio" value="0">
                                                </div>
                                            </div>
                                            <br>
                                            <div class="form-group row">
                                                <div class="col-sm-6 mb-3 mb-sm-0">
                                                    <input type="password" class="form-control form-control-user" name="signup-password" placeholder="輸入密碼">
                                                </div>
                                                <div class="col-sm-6">
                                                    <input type="password" class="form-control form-control-user" name="signup-repassword" placeholder="再輸入一次密碼">
                                                </div>
                                            </div>
                                            <br>
                                            <input class="btn btn-primary btn-user btn-block" type="submit" value="註冊">
                                        </form>
                                        <br>
                                        <div class="form-group row">
                                        	<c:if test="${not empty errorMsgs}">
											<font style="color:red">請修正以下錯誤:</font>
											<ul>
											    <c:forEach var="message" items="${errorMsgs}">
													<li style="color:red">${message}</li>
												</c:forEach>
											</ul>
										</c:if>
                                        </div>
                                        <div class="text-center">
                                            <a class="small" href="<%=request.getContextPath()%>/info/Forgot.jsp">忘記密碼?</a>
                                        </div>
                                        <div class="text-center">
                                            <a class="small" href="<%=request.getContextPath()%>/info/Login.jsp">已經有帳號?登入</a>
                                        </div>
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
                <div class="row align-items-center justify-content-between flex-column flex-sm-row">
                    <div class="col-auto">
                        <div class="small m-0 text-white">Copyright &copy; Fun Friends 2021</div>
                    </div>
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
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="<%=request.getContextPath()%>/info/jquery/jquery-3.6.0.min.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</body>
</html>