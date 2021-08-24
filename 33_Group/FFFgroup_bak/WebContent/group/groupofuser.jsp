<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.group.model.*"%>

<%
	GroupService groupSvc = new GroupService();
	List<GroupVO> list1 = groupSvc.getMyGroup(9,1);//��user_id �� ���ʪ��A
	pageContext.setAttribute("list1",list1);
	
	List<GroupVO> list2 = groupSvc. getMyGroup(9,2);
	pageContext.setAttribute("list2",list2);
	
	List<GroupVO> list3 = groupSvc.getMyGroup(9,3);
	pageContext.setAttribute("list3",list3);
	
	List<GroupVO> list0 = groupSvc.getMyGroup(9,0);
	pageContext.setAttribute("list0",list0);  

%>


<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        <link href="css/t33.css" rel="stylesheet" />
</head>
    <body class="d-flex flex-column">
        <main class="flex-shrink-0">
            <!-- Navigation-->
            <script src="js/nav.js"></script>
            <!-- About section one-->   
            <header class="py-3 ">
                <div class="container py-3 ">
                    <div class="row justify-content-center">
                        <!-- <div class="col-lg-8 col-xxl-6"> -->
                            <!-- <div class="text-center my-5"> -->
                                <h4 class="fw-bolder mb-3">�ڪ�����</h4>
                                <!-- <p class="lead fw-normal text-muted mb-4">aaa</p> -->
                                <!-- <a class="btn btn-primary btn-lg" href="#scroll-target">Read our story</a> -->
                            <!-- </div>
                        </div> -->
                    </div>
                </div>
            </header>


            <section class="py-1 " id="scroll-target">
                <div class="container">
                <div class="text-center mb-5">
                <ul class="nav nav-tabs" id="myTab" role="tablist">
                    <li class="nav-item" role="presentation">
                      <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home" type="button" role="tab" aria-controls="home" aria-selected="true">���ݤ�</button>
                    </li>
                    <li class="nav-item" role="presentation">
                      <button class="nav-link" id="2-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="false">�w����</button>
                    </li>
                    <li class="nav-item" role="presentation">
                      <button class="nav-link" id="3-tab" data-bs-toggle="tab" data-bs-target="#contact" type="button" role="tab" aria-controls="contact" aria-selected="false">�w����</button>
                    </li>
                    	<li class="nav-item" role="presentation">
                      <button class="nav-link" id="0-tab" data-bs-toggle="tab" data-bs-target="#zero" type="button" role="tab" aria-controls="contact" aria-selected="false">�w�y��</button>
                    </li>
                  </ul>
                  <div class="tab-content" id="myTabContent">
                  


                    <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                        <!-- ���ݤ������� -->
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th>���ʦW��</th>
                                <th>�D��H</th>
                                <th>���ʮɶ�</th>
                                <th>���W�ɶ�</th>
                                <th>�ثe�H��</th>
                                <th>���ʪ��A</th>
                                <th>  </th>
                                </tr>
                            </thead>

                           <c:forEach var="groupVO1" items="${list1}">                                                                             
                              <tr>
                                <td>${groupVO1.g_no}${groupVO1.g_name}</td>
                                <td>${groupVO1.user_id}</td>
                                <td>${groupVO1.g_start_time} ~ ${groupVO1.g_end_time}</td>
                                <td>${groupVO1.apply_start_time} ~ ${groupVO1.apply_end_time}</td>  
                                <td>3/10</td>
                                <td>�}�Τ�</td>
                                <td>
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                                         
                                        </button>
                                        <ul class="dropdown-menu">
                                          <li><a class="dropdown-item" href="#">�ԲӸ�T</a></li>
                                          <li><a class="dropdown-item" href="#">�[�J��ѫ�</a></li>
                                          <li><hr class="dropdown-divider"></li>
                                          <li><a class="dropdown-item" href="groupedit.html">�s�贪��</a></li>
                                          <li><a class="dropdown-item" href="#">�Ѵ�����</a></li>
                                        </ul>
                                      </div>
      
                                </td>
                            </tr>
                           </c:forEach> 
                        </table>
                      </div> 
             
				 
 				                    	
				
				
                    <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="2-tab">
                        <!-- �w���Ϊ����� -->
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th>���ʦW��</th>
                                <th>�D��H</th>
                                <th>���ʮɶ�</th>
                                <th>���W�ɶ�</th>
                                <th>�ثe�H��</th>
                                <th>���ʪ��A</th>
                                <th>  </th>
               				</tr>
                            </thead>

							<c:forEach var="groupVO2" items="${list2}">
                              <tr>
                                <td>${groupVO2.g_no}${groupVO2.g_name}</td>
                                <td>${groupVO2.user_id}</td>
                                <td>${groupVO2.g_start_time} ~ ${groupVO2.g_end_time}</td>
                                <td>${groupVO2.apply_start_time} ~ ${groupVO2.apply_end_time}</td>
                                <td>10/10</td>
                                <td>�w����</td>
                                <td>
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-danger dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                                          
                                        </button>
                                        <ul class="dropdown-menu">
                                          <li><a class="dropdown-item" href="#">�ԲӸ�T</a></li>
                                          <li><a class="dropdown-item" href="#">�[�J��ѫ�</a></li>
                                          <li><hr class="dropdown-divider"></li>
                                          <li><a class="dropdown-item" href="#">�h�X����</a></li>
                                        </ul>
                                      </div>
                                </td>
                              <tr> 
                          </c:forEach>  
                        </table>
                    </div>
          
          
          			            
                    <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="3-tab">
                        <!-- �w���������� -->
                        <table class="table table-hover">
                            <thead>                          
                            <tr>
                                <th>���ʦW��</th>
                                <th>�D��H</th>
                                <th>���ʮɶ�</th>
                                <th>���W�ɶ�</th>
                                <th>�ثe�H��</th>
                                <th>���ʪ��A</th>
                                <th>  </th>
                           </tr>
                            </thead>

 						<c:forEach var="groupVO3" items="${list3}"> 
                              <tr>
                                <td>${groupVO3.g_no}${groupVO3.g_name}</td>
                                <td>${groupVO3.user_id}</td>
                                <td>${groupVO3.g_start_time} ~ ${groupVO3.g_end_time}</td>
                                <td>${groupVO3.apply_start_time} ~ ${groupVO3.apply_end_time}</td>
                                <td>3/10</td>
                                <td>�w����</td>
                                <td>
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-danger dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                                          
                                        </button>
                                        <ul class="dropdown-menu">
                                          <li><a class="dropdown-item" href="#">�ԲӸ�T</a></li>
                                          <li><a class="dropdown-item" href="#">�y�έ�]</a></li>
                                          <li><hr class="dropdown-divider"></li>
                                          <li><a class="dropdown-item" href="#">���|����</a></li>
                                        </ul>
                                      </div>
                                </td>
                       </c:forEach>       
                       </table>
                   </div>

                 <div class="tab-pane fade" id="zero" role="tabpanel" aria-labelledby="0-tab">
                        <!-- �w�y�Ϊ����� -->
                        <table class="table table-hover">
                            <thead>                          
                            <tr>
                                <th>���ʦW��</th>
                                <th>�D��H</th>
                                <th>���ʮɶ�</th>
                                <th>���W�ɶ�</th>
                                <th>�ثe�H��</th>
                                <th>���ʪ��A</th>
                                <th>  </th>
                           </tr>
                            </thead>

 						<c:forEach var="groupVO0" items="${list0}"> 
                              <tr>
                                <td>${groupVO0.g_no}${groupVO0.g_name}</td>
                                <td>${groupVO0.user_id}</td>
                                <td>${groupVO0.g_start_time} ~ ${groupVO0.g_end_time}</td>
                                <td>${groupVO0.apply_start_time} ~ ${groupVO0.apply_end_time}</td>
                                <td>3/10</td>
                                <td>�w�y��</td>
                                <td>
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-danger dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                                          
                                        </button>
                                        <ul class="dropdown-menu">
                                          <li><a class="dropdown-item" href="#">�ԲӸ�T</a></li>
                                          <li><a class="dropdown-item" href="#">�y�έ�]</a></li>
                                          <li><hr class="dropdown-divider"></li>
                                          <li><a class="dropdown-item" href="#">���|����</a></li>
                                        </ul>
                                      </div>
                                </td>
                      	 </c:forEach>       
                        </table>
                    </div>
                	
                	
                	
                  </div>
                  
				 </div>

               </div>
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

</body>
</html>