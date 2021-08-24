<%@page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="zh-hant">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>購買完成</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/Shop/vendors/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/Shop/style/style.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/Shop/style/buy.css">


</head>
<% 
	String id = request.getParameter("id"); 
	if (id != null ){
		pageContext.setAttribute("id", id);
	}


%>


<body>
	<jsp:include page="pieces/header.jsp"></jsp:include> <!-- header -->
    <jsp:include page="pieces/search_bar.jsp"></jsp:include> <!-- search_bar -->
    
    <!-- 購物流程圖示 -->
    <section class="process row justify-content-end">
        <div class="col-sm-3">
            <i class=" fas fa-shopping-cart "></i>
            <div>
                <p>Step 1</p>
                <p> 購物車 </p>
            </div>
        </div>
        <div class="dash col-sm-1">-----</div>
        <div class="col-sm-3">
            <i class="far fa-credit-card"></i>
            <div>
                <p>Step 2</p>
                <p>訂購資訊</p>
            </div>
        </div>
        <div class="dash col-sm-1">-----</div>

        <div class="col-sm-3">
            <i class="fas fa-check-circle"></i>
            <div>
                <p>Step 3</p>
                <p>訂購完成</p>
            </div>
        </div>

    </section>
    
        <hr>

        <!-- 購物車內容 -->
        <section class="main_part">
            <h1><i class="far fa-check-circle"></i>訂購完成!</h1>
            <hr>
            <p>感謝您的購買!</p>
            <p>訂單編號: O${orderID}${id}</p>
            <p>將盡快配送您的商品，如有問題請聯繫客服。</p>
        </section>

        <section class="confirm">
            <a href="<%= request.getContextPath()%>/Shop/index.html"><button>繼續找商品</button></a>
            <a href="<%= request.getContextPath()%>/ShowEachOrderServlet?order=${orderID}"><button>查看訂單</button></a>
        </section>
    </main>

    <script>
        history.pushState(null, null, "<%= request.getContextPath()%>/Shop/buy3_complete.jsp?id=${orderID}${id}");
         
         window.addEventListener('popstate', function(){history.forward();});
    </script>
	    <script src="<%= request.getContextPath() %>/Shop/vendors/bootstrap.bundle.min.js"></script>
</body>

</html>