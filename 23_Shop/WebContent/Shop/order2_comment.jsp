<%@page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, com.shop.model.*, com.shop.util.*, java.text.SimpleDateFormat" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html lang="zh-hant">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>訂單評價</title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css"
        integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="style/order.css">
</head>

<jsp:useBean id="orderDAO" class="com.shop.service.OrderService"/>
<jsp:useBean id="orderProdDAO" class="com.shop.service.OrderProdService"/>
<%
	int orderID= Integer.parseInt(request.getParameter("id"));
	pageContext.setAttribute("orderID", orderID);
	Date buyDate = new Date(orderDAO.getOneByOrderId(orderID).getOrd_time().getTime());
	SimpleDateFormat sf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
// 	;
	
%>

<body>

    <form method="post" action="/FFF/MakeCommentServlet" enctype="multipart/form-data" >
        <!------------- main page --------------->
        <main>
            <h1>商品評價</h1>
            <hr>


            <!-- 每筆訂單 -->
            <section class="each_order">
                <!-- 每筆訂單標頭 -->
                <article class="head">
                    <span>訂單編號: O${orderID}</span>
                    <span>購買時間: <%= sf.format(buyDate)%></span>
                </article>
                <hr>

                <!-- 商品列表 -->
                <div class="display">
                
                <c:forEach var="prod" items="${orderProdDAO.getAllByOrdNo(orderID)}" varStatus="s">
					
					<section class="order_prods eval_sec">
                        <img src="/FFF/OrderProdImage?id=${prod.ord_prod_id}" alt="prod_pic">
                        <div>
                            <span>${prod.hist_prod_name} | ${prod.hist_prod_spec}</span>
                            <input type="hidden" name="order_prod_id" value="${prod.ord_prod_id}">
                            <p class="star_area">
                                <i class="fas fa-star" data-star="1"></i>
                                <i class="fas fa-star" data-star="2"></i>
                                <i class="fas fa-star" data-star="3"></i>
                                <i class="fas fa-star" data-star="4"></i>
                                <i class="fas fa-star" data-star="5"></i>
                            </p>
                            <input type="hidden" name="star_rate_${prod.ord_prod_id}" value="5">
                            <label class="file_upload_btn" for="${prod.ord_prod_id}">上傳圖片(最多三張)
                                <input class="pic" type="file" id="${prod.ord_prod_id}" name="pic_${prod.ord_prod_id}" id="id" accept="image/*" multiple></label>
                            <div class="pic_preview"></div>
                            <textarea name="comment_${prod.ord_prod_id}" cols="30" rows="5" placeholder="評論內容..."></textarea>
                        </div>
                    </section>
                    
                    <c:if test="${not s.last }">
                    	<hr>
                    </c:if>
				</c:forEach>
                    
                    <!-- <section class="order_prods eval_sec">
                        <img src="https://cdn.britannica.com/s:800x1000/22/206222-050-3F741817/Domestic-feline-tabby-cat.jpg"
                            alt="">
                        <div>
                            <span>商品名稱|規格</span>
                            <input type="hidden" name="order_prod_id" value="id">
                            <p class="star_area">
                                <i class="fas fa-star" data-star="1"></i>
                                <i class="fas fa-star" data-star="2"></i>
                                <i class="fas fa-star" data-star="3"></i>
                                <i class="fas fa-star" data-star="4"></i>
                                <i class="fas fa-star" data-star="5"></i>
                            </p>
                            <input type="hidden" name="star_rate_ID" value="5">
                            <label class="file_upload_btn" for="id">上傳圖片(最多三張)
                                <input type="file" name="pic_id" id="id" accept="image/*" multiple></label>
                            <div class="pic_preview"></div>
                            <textarea name="comment_ID" cols="30" rows="5" placeholder="評論內容..."></textarea>
                        </div>
                    </section>
                    <hr> -->
                </div>
                <hr>



                <!-- 按鈕 -->
                <section class="confirm">
                    <button type="button" class="comment_yes">確認</button>
                    <button type="button" class="btn_goback">取消</button>
                </section>





        </main>
        <div class=confirm_jump_bg style="display:none">
            <div class="confirm_jump">
                <p>感謝您的評論! </p>
                <div>
                    <button class="btn_goto_orderlist">返回我的訂單</button>
                    <button class="btn_goto_index">繼續找商品</button>
                </div>
            </div>
        </div>

    </form>
    <script src="vendors/jquery-3.6.0.min.js"></script>

    <script src="js/index.js"></script>
</body>

</html>