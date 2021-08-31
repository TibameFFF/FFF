<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.group.model.*"%>

<%
	GroupVO groupVO = (GroupVO) request.getAttribute("groupVO");
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>���έק�</title>
<!-- Favicon-->
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->

<link href="css/styles.css" rel="stylesheet" />
<link href="css/t33.css" rel="stylesheet" />
</head>
<body class="d-flex flex-column">
	<main class="flex-shrink-0">
		<nav>
			<!-- Navigation-->
			<script src="js/nav.js"></script>
		</nav>
		<!-- Page content-->
		<section class="py-5">
			<div class="container px-5">
				<!-- Contact form-->
				<div class="bg-33 rounded-3 py-5 px-4 px-md-5 mb-5">
					<div class="text-center mb-5">
						<div
							class="feature bg-primary bg-gradient text-white rounded-3 mb-3">
							<i class="bi bi-people"></i>
						</div>
						<h1 class="fw-bolder">Edit my Group</h1>
						<p class="lead fw-normal text-muted mb-0">�קﬡ��
					</div>
					<div class="row gx-5 justify-content-center">
						
							<form METHOD="post" ACTION="group.do" name="form1" enctype="multipart/form-data">
								
							<div class="container">
  								<div class="row row-cols-2">
								<!-- �}�Ϊ� input-->
								<div class="col">
								<div class="form-floating mb-3">
									<input class="form-control" id="user_id" name="user_id" value="${groupVO.user_id}"
										type="text" placeholder="Enter your name..."
										data-sb-validations="required" /> <label
										for="name">�}�Ϊ�</label>
									<div class="invalid-feedback" data-sb-feedback="name:required">A
										name is required.</div>
								</div>
								<!-- Email  input-->
								<div class="form-floating mb-3">
									<input class="form-control" id="email" type="email" value="${groupVO.email}" 
										name="email" placeholder="name@example.com"
										data-sb-validations="required,email"/>
									<label for="email">Email</label>
									<div class="invalid-feedback" data-sb-feedback="email:required">An
										email is required.</div>
									<div class="invalid-feedback" data-sb-feedback="email:email">Email
										is not valid.</div>
								</div>
								<!-- ������X input-->
								<div class="form-floating mb-3">
									<input class="form-control" id="phone" name="phone" type="tel" value="${groupVO.phone}" 
										placeholder="(09)12345678" data-sb-validations="required"/>
									<label for="phone">������X</label>
									<div class="invalid-feedback" data-sb-feedback="phone:required">A
										phone number is required.</div>
								</div>
								<!-- �ۧڤ��� input-->
								<div class="form-floating mb-3">
									<textarea class="form-control" id="message" name="introduce"
										placeholder="Enter your message here..." style="height: 10rem"
										data-sb-validations="required">${groupVO.introduce}</textarea>
									<label for="message">�ۧڤ���</label>
									<div class="invalid-feedback"
										data-sb-feedback="message:required">A message is
										required.</div>
								</div>
								<!-- ���ʦW�� input-->
								<div class="form-floating mb-3">
									<input class="form-control" id="g_name" name="g_name" value="${groupVO.g_name}"
										type="text" placeholder="�п�J���ʦW��"
										data-sb-validations="required"/>
									<label for="g_name">���ʦW��</label>
									<div class="invalid-feedback"
										data-sb-feedback="g_name:required">�п�J���ʦW��</div>
								</div>


								<!-- <label for="customRange2" class="form-label">Example range</label>
                                        <input type="range" class="form-range" min="0" max="5" id="customRange2"> -->



								<!-- �H�ƤU�� input -->
								<div class="form-floating mb-3">
									<div class="input-group ">
										<label>���ʤH��</label> <input class="form-control" id="lower"
											type="number" placeholder="�U��" max="20" min="1"
											name="number_lower"
											value="${groupVO.number_lower}"/><label>��</label>
										<input class="form-control" id="upper" type="number"
											placeholder="�W��" max="20" min="1" name="number_upper"
											value="${groupVO.number_upper}"/>
										<label>�H</label>
									</div>
								</div>

								<!-- ���ʤ��e input-->
								<div class="form-floating mb-3">
									<textarea class="form-control" id="g_content" name="g_content"
										placeholder="�п�J���ʤ��e" style="height: 10rem"
										data-sb-validations="required">${groupVO.g_content}</textarea>
									<label for="g_content">���ʤ��e</label>
									<div class="invalid-feedback"
										data-sb-feedback="g_content:required">�п�J���ʤ��e</div>
								</div>

			

								</div>
								<div class="col">


								<!-- ��������input-->
								<div class="form-floating mb-3">
									<select class="form-select" name="g_type_no" aria-label="��������">
<!-- 										<option selected></option> -->
										<jsp:useBean id="typeSvc" scope="page"
											class="com.group.model.TypeService" />
										<c:forEach var="typeVO" items="${typeSvc.all}">
										<option value="${typeVO.g_type_no}" ${(groupVO.g_type_no==typeVO.g_type_no)? 'selected':'' } >${typeVO.g_type}
										</c:forEach>
									</select> <label for="��������">��������</label>
								</div>

								<!-- ���ʦa�}-->



								<div class="form-floating mb-3">
									<input class="form-control" name="place" type="text"
										placeholder="��J���ʦa�}" data-sb-validations="required"
										value="${groupVO.place}"/> <label
										for="address">���ʦa�I</label>
								</div>


								<!-- �ñ�>
                                    <div class="input-group">
                                        <input type="text" class="form-control" placeholder="Start"/>
                                        <span class="input-group-addon">-</span>
                                        <input type="text" class="form-control" placeholder="End"/>
                                    </div> -->
								<!-- xxx input-->
								<div class="form-floating mb-3">
									<input class="form-control" name="g_url" type="text" value="${groupVO.g_url}"
										placeholder="xxxx" data-sb-validations="required"/>
									<label for="xxx">���ʺ��}</label>
									<div class="invalid-feedback" data-sb-feedback="xxx:required">xxx.</div>
								</div>
								<div class="input-group mb-3">
									<input type="text" name="g_start_time"  value="${groupVO.g_start_time}"
										class="form-control f_date1" placeholder="begin"
										aria-label="Username"> <span class="input-group-text">���W�ɶ�</span>
									<input type="text" name="g_end_time"  value="${groupVO.g_end_time}"
										class="form-control f_date1" placeholder="end"
										aria-label="Server">
								</div>
								<div class="input-group mb-3">
									<input type="text" name="apply_start_time" value="${groupVO.apply_start_time}"
										class="form-control f_date1" placeholder="begin" 
										aria-label="Username"> <span class="input-group-text">���ʮɶ�</span>
									<input type="text" name="apply_end_time" value="${groupVO.apply_end_time}"
										class="form-control f_date1" placeholder="end" 
										aria-label="Username">
								</div>


								<!-- �Ϥ��W�� -->
								<div class="input-group mb-3">
									<label>�ФW�ǹϤ�</label> <input type="file" name="photo" id="upload" onchange="loadImageFile(event)"> 
										<img src="<%=request.getContextPath()%>/DBGifReader3?g_no=${groupVO.g_no}" id="image" style="max-width: 100%; max-height: 100%" >
								</div>
								<div style="visibility:hidden;">
								<input type="TEXT" name="state_no" size="45"
									value="<%=groupVO.getState_no()%>" />
								<input type="TEXT" name="g_flow_cause" size="45"
									 value="<%=groupVO.getG_flow_cause()%>"  />

								<input type="text" name="number_total" size="45"
									value="<%=groupVO.getNumber_total()%>" />
								</div>
								<!-- Submit error message-->
								<!---->
								<!-- This is what your users will see when there is-->
								<!-- an error submitting the form-->
								<!-- <div class="d-none" id="submitErrorMessage"><div class="text-center text-danger mb-3">Error sending message!</div></div> -->
								<!-- Submit Button-->
								</div>
								</div>
									
									<div class="input-group mb-3 aaa"> 
                                    <input type="button" class="btn btn-primary" Onclick="location.href='groupofuser.jsp'" value="����">    
                                    <input type="hidden" name="action" value="update">
									<input type="hidden" name="g_no" value="${groupVO.g_no}">
									<input type="submit" class="btn btn-primary" onClick="window.alert('�ק令�\!!');" value="�T�w�ק�">
                                    </div>
								
								</div>
							
						<c:if test="${not empty errorMsgs}">
							<font style="color:red">�Эץ��H�U���~:</font>
							<ul>
								<c:forEach var="message" items="${errorMsgs}">
									<li style="color:red">${message}</li>
								</c:forEach>
							</ul>
						</c:if>

							</form>

						</div>

					</div>

				</div>

			


		</section>

	</main>
	<!-- Footer-->
	<footer class="bg-dark py-4 mt-auto">
		<div class="container px-5">
			<div
				class="row align-items-center justify-content-between flex-column flex-sm-row">
				<div class="col-auto">
					<div class="small m-0 text-white">Copyright &copy; Your
						Website 2021</div>
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

	<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
	<script
		src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>
	<script>
		$.datetimepicker.setLocale('zh'); // kr ko ja en
		$('.f_date1').datetimepicker({
			theme : '', //theme: 'dark',
			timepicker : true, //timepicker: false,
			step : 1, //step: 60 (�o�Otimepicker���w�]���j60����)
			format : 'Y-m-d H:i:s'
		//disabledDates:    ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
		//startDate:	        '2017/07/10',  // �_�l��
		//minDate:           '-1970-01-01', // �h������(���t)���e
		//maxDate:           '+1970-01-01'  // �h������(���t)����
		});
	</script>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
	<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
	<!-- * *                               SB Forms JS                               * *-->
	<!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
	<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
	<script>
		$("#twzipcode").twzipcode();
	</script>
	<script>
		function loadImageFile(event) {
			var image = document.getElementById('image');
			image.src = URL.createObjectURL(event.target.files[0]);
		};
	</script>

</body>



</html>