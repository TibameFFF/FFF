<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.group.model.*"%>

<%
    GroupService groupSvc = new GroupService();
    List<GroupVO> list = groupSvc.getAll();
    pageContext.setAttribute("list",list);
%>

<jsp:useBean id="typeSvc" scope="page" class="com.group.model.TypeService" />
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>揪團</title>
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        <link href="css/t33.css" rel="stylesheet" />
</head>
<body>
    <body class="d-flex flex-column h-100">
        <main class="flex-shrink-0">
            <!-- Navigation-->
            <script src="js/nav.js"></script>
            <!-- Page Content-->
            <section class="py-5">
                <div class="container px-5 my-5">
                    <div class="text-center mb-5">
                        <h1 class="fw-bolder">參加揪團</h1>
                        <br>

                            <!-- <p class="lead fw-normal text-muted mb-0">Company portfolio</p> -->
                            <div class="input-group mb-2">
                                <input class="form-control"  type="search" placeholder="Search Group" aria-label="Search Group" aria-describedby="button-newsletter" />
                                <button class="btn btn-lg btn-primary" id="button-newsletter" type="button">Search</button>
                            </div>

                            <!-- <div class="input-group mb-2"> -->
                              <div id="twzipcode"class="input-group mb-2" >
                                <select class="form-select" aria-label="Default select example">
                                  <option selected>活動類型</option>
                                  <option value="1">運動</option>
                                  <option value="2">遊戲</option>
                                  <option value="3">美食</option>
                                  <option value="4">購物</option>
                                  <option value="5">程式</option>
                                </select>
                              </div>
                                <!-- <select class="form-select" aria-label="Default select example">
                                    <option selected>地點</option>
                                    <option value="1">台北</option>
                                    <option value="2">高雄</option>
                                    <option value="3">台中</option>
                                    <option value="4">附近活動</option>
                                  </select> -->

                                <!-- <h2 class="display-4 fw-bolder mb-4">Let's build something together</h2> -->
                                <!-- <a class="btn btn-lg btn-primary" href="#!">Contact us</a> -->
                            <!-- </div> -->

                    </div>
                    <div class="row gx-5">
                              <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                              	<%@ include file="page1.file" %>
                              <c:forEach var="groupVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" >
                                <div class="col">
                                  <div class="card shadow-sm">
                                    <img class="bd-placeholder-img card-img-top" width="100%" height="240"  src=/IBM_emp_0201MVC_Single-Table_mySQL8/DBGifReader3?g_no=${groupVO.g_no} role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#55595c"/>                        
                                    <div class="card-body cardcolor">
                                      <p class="card-text"><strong>${groupVO.g_name}</strong><br>${groupVO.g_content}</p>
                                      <div class="d-flex justify-content-between align-items-center">
                                        <div class="btn-group">
                                          <button type="button" class="btn btn-sm btn-outline-light"  onclick="location.href='groupinfo.html'">詳細資訊</button>
                                          <button type="button" class="btn btn-sm btn-outline-light">檢舉</button>
                                        </div>
                                        <small class="text-white">目前人數: ${groupVO.number_total}</small>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                               </c:forEach>
                               </div>
                  			</div>
                  		</div>
                  			<%@ include file="page2.file" %>
                  			
            			</section>

        
 		
        </main>
        <!-- Footer-->
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
        <!-- 地址-->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
        <script src="./vendors/jquery/jquery-3.4.1.min.js"></script>
        <script>$("#twzipcode").twzipcode({
          zipcodeIntoDistrict: true, // 郵遞區號自動顯示在地區
          css: ["city form-control", "town form-control"], // 自訂 "城市"、"地區" class 名稱 
          countyName: "city", // 自訂城市 select 標籤的 name 值
          districtName: "town" // 自訂地區 select 標籤的 name 值
          });</script>
          
          
</body>
</html>