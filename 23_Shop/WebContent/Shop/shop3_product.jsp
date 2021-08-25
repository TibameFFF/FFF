<%@page import="com.shop.dao.OrderDAO"%>
<%@page import="com.shop.dao.ShipMethodDAO"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.shop.model.*, com.shop.util.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html lang="zh-hant">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>商品頁面</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Shop/vendors/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Shop/style/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.css" />
    

</head>


<jsp:useBean id="prodDAO" class="com.shop.daoImpl.ProdDAOImpl"/>
<jsp:useBean id="prodPicDAO" class="com.shop.daoImpl.ProdPicsDAOImpl"/>
<jsp:useBean id="prodSpecDAO" class="com.shop.daoImpl.ProdSpecDAOImpl"/>
<jsp:useBean id="prodShipDAO" class="com.shop.daoImpl.ProdShipsDAOImpl"/>
<jsp:useBean id="shipMethodDAO" class="com.shop.daoImpl.ShipMethodDAOImpl"/>
<jsp:useBean id="showDAO" class="com.shop.util.ProdStarSaleViewDAOImpl"/>
<jsp:useBean id="OrderProdDAO" class="com.shop.service.OrderProdService"/>
<jsp:useBean id="OrderDAO" class="com.shop.service.OrderService"/>
<jsp:useBean id="EvalPicDAO" class="com.shop.service.EvalPicService"/>

<% 
	int prodID =(Integer)request.getAttribute("prodID");
	Prod prod = prodDAO.findByPK(prodID);
    pageContext.setAttribute("prodID", prodID);
	
	List<ProdPics> picList = prodPicDAO.findByProdID(prodID);
	pageContext.setAttribute("picList", picList);
	
	
	List<ProdSpec> allSpecList = prodSpecDAO.findByProdID(prodID);
	List<ProdSpec> showSpecList = new ArrayList<ProdSpec>();
	for(ProdSpec prodSpec: allSpecList){
		if(prodSpec.getStock() > 0 ) {
			showSpecList.add(prodSpec);
	}}
	pageContext.setAttribute("specList", showSpecList);
	
	List<ShipMethod> shipMethodList = shipMethodDAO.getAll();
	pageContext.setAttribute("shipMethodList", shipMethodList);
	
	List<ProdShips> prodShipList = prodShipDAO.findByProdID(prodID);
	pageContext.setAttribute("prodShipList", prodShipList);

	
	List<OrderProd> orderProductList = new ArrayList<>();
	for(int i=0; i< showSpecList.size(); i++){
		for(OrderProd orderProd: OrderProdDAO.getAllByProdSpec(showSpecList.get(i).getProd_spec_id())){
			orderProductList.add(orderProd);
		}
	}
	pageContext.setAttribute("orderProductList", orderProductList);
		
%>




<% //計算顯示星星數量
	double star_rating = showDAO.getStarRate(prodID);
	//把數字變成以0.5為單位，計算多少星星變黃色
	int star_temp = (int)Math.floor(star_rating);
	if (star_rating % 1 >= 0.5) {
        star_temp += 0.5;
    }
	//計算剩下不變色的星星
	int star_left = 5 - (int)Math.ceil(star_temp);
	
	pageContext.setAttribute("star_rating", star_rating);
%>







<body class="container-fluid">
	<jsp:include page="pieces/header.jsp"></jsp:include> <!-- header -->
    <jsp:include page="pieces/search_bar.jsp"></jsp:include> <!-- search_bar -->

    <!-------------------------------- main page -------------------------------->
    <main class="product">

        <!-- 商品介紹 -->
        <section class="product_info row">
            <div class="col-md-5">
                <div class="big_pic slider-for">
	                <c:forEach var="pic" items="${picList}">
					     <img class="col-3" src="/FFF/ProdImage?id=${pic.getProd_pic_id()}" alt="">  }
					</c:forEach>
                </div>
                <div class="small_pics row slider-nav">
                    <c:forEach var="pic" items="${picList}">
				     <img class="col-3" src="/FFF/ProdImage?id=${pic.getProd_pic_id()}" alt="">  }
					</c:forEach>
                </div>
            </div>
            <div class="info col-md-7">
                <h2 id="prod_name"><%= prod.getProd_name() %></h2>
                <div class="row justify-content-between">
                    <span class="star_rate col-sm-4">
                        <%
							//做星星html的顯示字串
							for (double i = star_temp; i > 0; i--) {
								if (i == 0.5) {
						%>
							<i class="fas fa-star-half-alt"></i>	 
						<% } else { %>
							<i class="fas fa-star"></i>
						<%}} for (int i = star_left; i > 0; i--) {%>
							  <i class="far fa-star"></i>
						<%}%>
                    </span>
                    <span class="col-sm-4" id="eval_total">${commentList.size()}則評價</span>
                    <span class="col-sm-4" id="sale_total">已銷售${showDAO.getNumSale(prodID)}件</span>
                </div>
                <hr>
				
                <div class="spec_choice">
                    <span>商品選項: </span>
                    
                    <c:forEach var="spec" items="${specList}" varStatus="s">
                    <c:if test="${s.index == 0}">
                    	<input type="radio" name="prod_spec" id="${spec.prod_spec_id}" value="${spec.prod_spec_id}" data-price="${spec.prod_price}" checked>
                    </c:if>
                    	<c:if test="${s.index != 0}">
                    	<input type="radio" name="prod_spec" id="${spec.prod_spec_id}" value="${spec.prod_spec_id}" data-price="${spec.prod_price}">
                    </c:if>
                    	<label class="choose_spec" for="${spec.prod_spec_id}">${spec.spec_name}</label>
					</c:forEach>
                    <!-- 
                    <input type="radio" name="prod_spec" id="green">
                    <label for="green">綠色</label>
                    -->
                </div>
                <c:if test="${specList.size() !=0}">
                    <div>
	                    <span>數量: </span>
	                    <div class="amount">
	                        <button type="button" class="minus prod_page">-</button>
	                        <input type="text" name="prod_amount" id="" value="1" readonly>
	                        <button type="button" class="plus prod_page">+</button>
	                    </div>
	                </div>
                </c:if>
               
                <div id="ship_method">運送方式：
                	<c:forEach var="prodShip" items ="${prodShipList}" varStatus="s">
	                	<c:forEach var="ship" items="${shipMethodList}">
	                		<c:if test="${ship.ship_no== prodShip.ship_no}">
	                    		${ship.ship_name }
	                    	</c:if>
	                    	
	                    </c:forEach>
	                    <c:if test="${not s.last}">、</c:if>
                	</c:forEach>
                </div>
                <div class="btn">
                	<c:if test="${specList.size() ==0}">
                    	<h2 id="prod_price">已無庫存!</h2>
                    </c:if>
                    <c:if test="${specList.size() !=0}">
                    	<h2 id="prod_price">$${String.format("%,d",specList[0].prod_price)}</h2>
                    </c:if>
                    
                    <c:if test="${specList.size() !=0}"><button id="add_to_cart" data-spec="${specList[0].prod_spec_id}" data-num="1"><i class="fas fa-shopping-cart"></i>加入購物車</button></c:if>
                    <button id="heart" data-id="${prodID}"><i  class="<c:if test="${favProd}">fas</c:if><c:if test="${!favProd}">far</c:if> fa-heart"></i></button>
                </div>
                
                
            </div>
        </section>

        <!-- 商品詳情 -->
        <section class="product_text">
            <h3>商品詳情</h3>
            <hr>
            <p><%= prod.getProd_text() %></p>
        </section>

        <!-- 評價區塊 -->
        <section class="product_eval">
            <div class="product_eval_header row align-items-center">
                <h3 class="col-md-2">商品評價</h3>
                <span class="star_rate col-md-5">
                    <%
						//做星星html的顯示字串
						for (double i = star_temp; i > 0; i--) {
							if (i == 0.5) {
					%>
						<i class="fas fa-star-half-alt"></i>	 
					<% } else { %>
						<i class="fas fa-star"></i>
					<%}} for (int i = star_left; i > 0; i--) {%>
						  <i class="far fa-star"></i>
					<%}%>
                    <span><fmt:formatNumber value="${star_rating}" type="number" maxFractionDigits="1"/>顆星</span>
                </span>
                <span class="col-md-5" id="comment_total">${commentList.size()}則評價</span>
              

            </div>
            <hr>
            <div class="eval_detail">
				<c:forEach var="comment" items="${commentList }">
					
					
					<article class="row each_eval row align-items-center">
                    <div class="eval_user col-sm-3">
                        <img src="https://via.placeholder.com/300x400" alt="">
                        <p>帳號名稱:${comment.name }</p>
                        <div>
                        	<c:forEach begin="1" end="5" varStatus="s">
                        		<c:if test="${s.count > comment.star }">
                        			<i class="far fa-star"></i>
                        		
                        		</c:if>
                        		<c:if test="${s.count <= comment.star }">
                        			<i class="fas fa-star"></i>
                        		
                        		</c:if>
                        	</c:forEach>
<!--                             <i class="fas fa-star"></i> -->
<!--                             <i class="fas fa-star"></i> -->
<!--                             <i class="fas fa-star-half-alt"></i> -->
<!--                             <i class="far fa-star"></i> -->
<!--                             <i class="far fa-star"></i> -->
                        </div>
                    </div>
                    <div class=" eval_detail col-sm-9">
                        <p>${comment.text}</p>
                        <div class="pic_area row">
                        	<c:forEach var="evalPic" items="${comment.pic}">
	                            <img class="col-sm-2 " src="${evalPic}" alt="">
                        	</c:forEach>
                        </div>
                    </div>
                </article>
                <hr>
				</c:forEach>
<!--                 <article class="row each_eval row align-items-center"> -->
<!--                     <div class="eval_user col-sm-3"> -->
<!--                         <img src="https://via.placeholder.com/300x400" alt=""> -->
<!--                         <p>帳號名稱</p> -->
<!--                         <div> -->
<!--                             <i class="fas fa-star"></i> -->
<!--                             <i class="fas fa-star"></i> -->
<!--                             <i class="fas fa-star-half-alt"></i> -->
<!--                             <i class="far fa-star"></i> -->
<!--                             <i class="far fa-star"></i> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                     <div class=" eval_detail col-sm-9"> -->
<!--                         <p>評論內容.....</p> -->
<!--                         <div class="pic_area row"> -->
<!--                             <img class="col-sm-2 " src="https://via.placeholder.com/300x400" alt=""> -->
<!--                             <img class="col-sm-2" src="https://via.placeholder.com/300x400" alt=""> -->
<!--                             <img class="col-sm-2" src="https://via.placeholder.com/300x400" alt=""> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </article> -->
<!--                 <hr> -->

               
            </div>

    </main>


    
    <div class="add_to_cart_alert" style="display:none">成功加入購物車!</div>

    <div id="to_top"><a href="#top"><i class="fas fa-chevron-circle-up fa-2x"></i></a></div>
    <script src="<%= request.getContextPath() %>/Shop/vendors/jquery-3.6.0.min.js"></script>
    <script src="<%= request.getContextPath() %>/Shop/js/index.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.js"></script>
    <script src="<%= request.getContextPath() %>/Shop/vendors/bootstrap.bundle.min.js"></script>
    <script>
    $(document).ready(function(){
    	$('.slider-for').slick({
            slidesToShow: 1,
            slidesToScroll: 1,
            arrows: false,
            fade: true,
            asNavFor: '.slider-nav'
        });
        $('.slider-nav').slick({
            slidesToShow: 3,
            slidesToScroll: 1,
            asNavFor: '.slider-for',
            dots: true,
            centerMode: true,
            focusOnSelect: true
        });
        // 加入購物車
        $("button#add_to_cart").on("click", function(e){
            let num = parseInt(e.target.dataset.num);
            let spec = parseInt(e.target.dataset.spec);


            let obj = {
                "type" : "add",
                "userid" : 1,
                "specid" : spec,
                "num" : num
            }
            $.ajax({
                    url: "http://localhost:8081/FFF/ProdToCartServlet",
                    type: "GET",
                    dataType: "text",
                    data: obj,
                    success: function (data) {
                    	if(data=="未登入"){
                       	  $("div.add_to_cart_alert").text("請先登入!");
                        } else{
                       	  $("div.add_to_cart_alert").text("成功加入購物車!");
                       		update_preview_cart();
                        }
                         console.log(data);
                        $("div.add_to_cart_alert").stop(true, false).fadeIn();
                        $("div.add_to_cart_alert").delay(2000).fadeOut();
                        
                    }
                });
        });

        // 商品加減按鈕
        let minus_list = document.getElementsByClassName("minus");
        let plus_list = document.getElementsByClassName("plus");
        for (let i = 0; i < minus_list.length; i++) {
            minus_list[i].addEventListener("click", function (e) {
            let current_amount = e.target.nextSibling.nextSibling;
            let price =
                e.target.parentNode.parentNode.previousSibling.previousSibling;
            if (current_amount.value > 1) {
                current_amount.value -= 1;
            }
            });

            plus_list[i].addEventListener("click", function (e) {
            let val_plus = parseInt(e.target.previousSibling.previousSibling.value);
            let current_amount = e.target.previousSibling.previousSibling;
            current_amount.value = val_plus + 1;
            let price =
                e.target.parentNode.parentNode.previousSibling.previousSibling;
            });
        }

        $("button.prod_page").on("click", function(){
            $("button#add_to_cart").attr("data-num", $(this).siblings("input").val())
        })
    });
        

    </script>

</html>