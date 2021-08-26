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
<title>����</title>
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        <link href="css/t33.css" rel="stylesheet" />
        <script src="<%=request.getContextPath()%>/jquery/jquery-3.6.0.min.js"></script>
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
                        <h1 class="fw-bolder">�ѥ[����</h1>
                        <br>

                            <!-- <p class="lead fw-normal text-muted mb-0">Company portfolio</p> -->
                            <div class="input-group mb-2">
                                <input class="form-control"  type="search" placeholder="Search Group" aria-label="Search Group" aria-describedby="button-newsletter" />
                                <button class="btn btn-lg btn-primary " id="button-newsletter" type="button">Search</button>
                            </div>

                            <!-- <div class="input-group mb-2"> -->
<!--                               <div id="twzipcode"class="input-group mb-2" > -->
                                <select class="form-select" name="g_type_no" aria-label="Default select example">
                                  <option selected>��������</option>

									<c:forEach var="typeVO" items="${typeSvc.all}">
										<option value="${typeVO.g_type_no}" ${(groupVO.g_type_no==typeVO.g_type_no)? 'selected':'' } >${typeVO.g_type}
									</c:forEach>

                                </select>
<!--                               </div> -->

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
	                                        <FORM METHOD="post" ACTION="group.do" enctype="multipart/form-data">
	                                           <input type="hidden" name="g_no" value="${groupVO.g_no}">
	        								   <input type="hidden" name="action" value="getOne_For_Display">
	        								   <input type="submit" class="btn btn-sm btn-outline-light " value="�ԲӸ�T">
	        								</FORM>   
                                          
                                          <button type="button" class="btn btn-sm btn-outline-light box entypo-thumbs-up">�[�J����</button>
                                        </div>
                                        <small class="text-white">�ثe�H��: ${groupVO.number_total}</small>
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
        <!-- �a�}-->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
        <script src="./vendors/jquery/jquery-3.4.1.min.js"></script>
        <script>$("#twzipcode").twzipcode({
          zipcodeIntoDistrict: true, // �l���ϸ��۰���ܦb�a��
          css: ["city form-control", "town form-control"], // �ۭq "����"�B"�a��" class �W�� 
          countyName: "city", // �ۭq���� select ���Ҫ� name ��
          districtName: "town" // �ۭq�a�� select ���Ҫ� name ��
          });</script>
         <script>
            $(function(){
              $('.box').on('click',function(){
                if ($(this).text()=='�[�J����'){
                  $(this).removeClass('entypo-thumbs-up btn-outline-light').addClass('entypo-thumbs-down btn-secondary').text('�����[�J');
                }else{
                  $(this).removeClass('entypo-thumbs-down btn-secondary').addClass('entypo-thumbs-up btn-outline-light').text('�[�J����');
                }
              });
            });
        </script> 
          
</body>
</html>