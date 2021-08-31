<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.group.model.*"%>
<%-- �����Ƚm�߱ĥ� Script ���g�k���� --%>

<%
  GroupVO groupVO = (GroupVO) request.getAttribute("groupVO"); //EmpServlet.java(Concroller), �s�Jreq��empVO����
%>

<jsp:useBean id="typeSvc" scope="page" class="com.group.model.TypeService" />
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>FFF group -${groupVO.g_name}</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        <link href="css/t33.css" rel="stylesheet" />
		<script src="<%=request.getContextPath()%>/jquery/jquery-3.6.0.min.js"></script>
</head>
    <body class="d-flex flex-column">
        <main class="flex-shrink-0">
            <!-- Navigation-->
            <script src="js/nav.js"></script>
            <!-- Page Content-->
            <section class="py-5">
                <div class="container px-5 my-5">
                    <div class="row gx-5">
                        <div class="col-lg-4">
                            <div class="d-flex align-items-center">
                                <img class="img-fluid rounded-circle" src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="..." />
                                <div class="ms-3">
                                    <div class="fw-bold">${groupVO.user_id}.xxx</div>
                                    <div class="text-muted">�}�Ϊ�</div>
                                </div>

                            </div>
                            	�@<h5 class="fw-bolder ">�ۧڤ���</h5>
                            		<p class="fs-5 mb-4">${groupVO.introduce}</p>
                            		<p><strong>�p����T</strong></p>
					               <ul>					               
					                <li><strong>���</strong>:${groupVO.phone}</li>
					                <li><strong>EMAIL</strong>:${groupVO.email}</li>
					              </ul>
                       			 </div>
                        <div class="col-lg-7">
                            <!-- Post content-->
                            <article>
                                <!-- Post header-->
                                <header class="mb-4">
                                    <!-- Post title-->
                                    <h1 class="fw-bolder mb-1">${groupVO.g_name}</h1>
                                    <!-- Post meta content-->
                                    <div class="text-muted fst-italic mb-2">�������� �G${typeSvc.getOneType(groupVO.g_type_no).g_type}</div>
                                    <!-- Post categories-->
                                    
<!--                                     <button type="button" class="badge btn-primary box entypo-thumbs-up">�[�J����</button> -->
                                    <a class="badge bg-success text-decoration-none link-light">�ثe�H��:${groupVO.number_total}</a>
                                </header>
                                <!-- Preview image figure-->       <!-- https://dummyimage.com/700x350/ced4da/6c757d.jpg -->                     
                                <figure class="mb-4"><img class="img-fluid rounded" src="<%=request.getContextPath()%>/DBGifReader3?g_no=${groupVO.g_no}" alt="..." style="height:300px;weight:300px"/></figure>
                                
                                <!-- Post content-->
                                <section class="mb-5">
                            
                                    <h5 class="fw-bolder ">���ʸ�T</h5>
                                    <p class="fs-5 mb-4">${groupVO.g_content}</p>
	
                                    
                                    <div class="row">
                                    <div class="col">
                                    
                                  <ul>					               
					                <li><strong>���ʦa�I</strong>:${groupVO.place}</li>
					                <li><strong>���ʺ��}</strong>:${groupVO.g_url}</li>
					                <li><strong>�H�ƭ���</strong>:${groupVO.number_lower}~${groupVO.number_upper}�H</li>
					              	<li><strong>���ʪ��A</strong>:${groupVO.state_no}</li>
					              	<li><strong>���W�ɶ�</strong>:${groupVO.g_start_time}~${groupVO.g_end_time}</li>
					              	<li><strong>�}�l�ɶ�</strong>:${groupVO.apply_start_time}~${groupVO.apply_end_time}</li>
					              </ul>
                                    
                                    
                                    <h6 class="fw-bolder mb-4 mt-5">�y�έ�]</h6>
                                    <p class="fs-5 mb-4">${groupVO.g_flow_cause}</p>
                                    </div>

   									</div>  
   									 <button type="button" class="btn btn-primary box entypo-thumbs-up">�[�J����</button>                                      
                                  </section>                              
                                
                            </article>
                            <!-- Comments section-->

                        </div>
                    </div>
                </div>
        <section class="py-5 bg-light">
            <div class="container px-4 px-lg-5 mt-5">
                <h2 class="fw-bolder mb-4">Message Board</h2>
                
                <div class="card-body">
                    <h4 class="fw-bolder mb-3">�d���O</h4>
                    <!-- Comment form-->
                    <form class="mb-4"><textarea class="form-control" rows="3" placeholder="Join the discussion and leave a comment!"></textarea>
                      <div class="bbb"><button type="submit" class="btn btn-primary">�o�e</button></div>
                    </form>
                    
                    <!-- Comment with nested comments-->
                    <div class="d-flex mb-4">
                        <!-- Parent comment-->
                        <div class="flex-shrink-0"><img class="rounded-circle" src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="..." /></div>
                        <div class="ms-3">
                            <div class="fw-bold">Commenter Name</div>
                            If you're going to lead a space frontier, it has to be government; it'll never be private enterprise. Because the space frontier is dangerous, and it's expensive, and it has unquantified risks.
                            <!-- Child comment 1-->
                            <div class="d-flex mt-4">
                                <div class="flex-shrink-0"><img class="rounded-circle" src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="..." /></div>
                                <div class="ms-3">
                                    <div class="fw-bold">Commenter Name</div>
                                    And under those conditions, you cannot establish a capital-market evaluation of that enterprise. You can't get investors.
                                </div>
                            </div>
                            <!-- Child comment 2-->
                            <div class="d-flex mt-4">
                                <div class="flex-shrink-0"><img class="rounded-circle" src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="..." /></div>
                                <div class="ms-3">
                                    <div class="fw-bold">Commenter Name</div>
                                    When you put money directly to a problem, it makes a good headline.
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Single comment-->
                    <div class="d-flex">
                        <div class="flex-shrink-0"><img class="rounded-circle" src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="..." /></div>
                        <div class="ms-3">
                            <div class="fw-bold">Commenter Name</div>
                            When I look at the universe and all the ways the universe wants to kill us, I find it hard to reconcile that with statements of beneficence.
                        </div>
                    </div>
                </div>
            </div>
        </section>
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
         <script>
            $(function(){
              $('.box').on('click',function(){
                if ($(this).text()=='�[�J����'){
                  $(this).removeClass('entypo-thumbs-up btn-primary').addClass('entypo-thumbs-down btn-secondary').text('�����[�J');
                }else{
                  $(this).removeClass('entypo-thumbs-down btn-secondary').addClass('entypo-thumbs-up btn-primary').text('�[�J����');
                }
              });
            });
        </script>
    </body>
</html>