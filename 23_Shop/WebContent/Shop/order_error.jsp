<%@page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="zh-hant">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Shop/vendors/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Shop/style/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Shop/style/order.css">
    <style>
        .navbar{
            z-index: 1000;
        }
    </style>
</head>
<body>
	<jsp:include page="pieces/header.jsp"></jsp:include> <!-- header -->
	<jsp:include page="pieces/search_bar.jsp"></jsp:include> <!-- search_bar -->
    
    
    <div class=confirm_jump_bg style="z-index: 1">
        <div class="confirm_jump">
            <p>購買發生錯誤! 請返回購物車再次結帳! </p>
            <div>
                <a class="cart" href="<%= request.getContextPath() %>/ShowCartServlet"><button class="btn_goto_orderlist">返回購物車</button></a>
            </div>
        </div>
    </div>
    
    <script src="<%= request.getContextPath() %>/Shop/vendors/jquery-3.6.0.min.js"></script>
    <script src="<%= request.getContextPath() %>/Shop/vendors/bootstrap.bundle.min.js"></script>
</body>
</html>