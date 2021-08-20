<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, com.shop.model.*, com.shop.util.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:useBean id="ShopCartDao" class="com.shop.service.ShopCartService"/>
<jsp:useBean id="ProdPicDao" class="com.shop.service.ProdPicsService"/>
<jsp:useBean id="SpecDao" class="com.shop.service.ProdSpecService"/>
<jsp:useBean id="ProdDao" class="com.shop.service.ProdService"/>

<%
//id要換!
	List<ShopCart> shopList = ShopCartDao.getAllShopCartByUserID(6);
	pageContext.setAttribute("shopList", shopList);
%>






<!DOCTYPE html>
<html lang="zh-hant">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>購物車</title>
    <link rel="stylesheet" href="vendors/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="style/buy.css">

</head>

<body>

   <jsp:include page="pieces/search_bar.jsp"></jsp:include> <!-- search_bar -->

    <!------------- main page --------------->
    <main class="cart container-fluid">
        <!-- 購物流程圖示 -->
        <section class="process row justify-content-end">
            <div class="col-sm-3">
                <i class=" fas fa-shopping-cart "></i>
                <div>
                    <p>Step 1</p>
                    <p> 購物車 </p>
                </div>
            </div>
            <div class="dash gray col-sm-1">-----</div>
            <div class="col-sm-3">
                <i class="far fa-credit-card gray"></i>
                <div>
                    <p class="gray">Step 2</p>
                    <p class="gray">訂購資訊</p>
                </div>
            </div>
            <div class="dash gray col-sm-1">-----</div>

            <div class="col-sm-3">
                <i class="fas fa-check-circle gray"></i>
                <div>
                    <p class="gray">Step 3</p>
                    <p class="gray">訂購完成</p>
                </div>
            </div>

        </section>
        <hr>

        <!-- 購物車內容 -->
        <section class="main_part">
            <h1>購物車</h1>
            <hr>

            <form id="cart" action="<%= request.getContextPath() %>/ShopToComfirmServlet">
                
                
                <c:if test="${shopList.size()==0 }">
                	<h2>購物車沒有商品哦! 快去逛逛吧!</h2>
                </c:if>
                
                <c:if test="${shopList.size()!=0 }">
                	<div class="row justify-content-between cart_header">
                    <div class="col-2"><label> <input type="checkbox" name="" id="check_all" checked> 全選</label></div>
                    <div class="col-4">品名/規格</div>
                    <div class="col-1">單價</div>
                    <div class="col-2">數量</div>
                    <div class="col-1">小計</div>
                    <div class="col-1">刪除</div>
                	</div>
                <hr>
                </c:if>
                
                <c:forEach var="prod" items="${shopList}">
					
						<div class="row justify-content-between each_product">
						    <div class="col-2 pic">
						        <label class="row align-items-center items">
						            <input class="col-1" type="checkbox" name="specCheck" value="${prod.prod_spec_id}" checked>
						            <img class="col-11" src="/FFF/ProdImage?id=${ProdPicDao.getAllProdPicByProdID(SpecDao.getOneProdSpecByPK(prod.prod_spec_id).prod_id).get(0).getProd_pic_id()}" alt="">
						        </label>
						    </div>
						    <div class="col-4">
						        <a href=""><p>${ProdDao.getOneById(SpecDao.getOneProdSpecByPK(prod.prod_spec_id).prod_id).prod_name}</p></a>
						        <div class="spec" id="${prod.prod_spec_id}">${SpecDao.getOneProdSpecByPK(prod.prod_spec_id).spec_name}</div>
						    </div>
						    <div class="col-1">${String.format("%,d",SpecDao.getOneProdSpecByPK(prod.prod_spec_id).prod_price)}</div>
						    <div class="col-2 amount">
						        <button type="button" class="minus">-</button>
						        <input type="text" class="prod_num" name="specAmount${prod.prod_spec_id}" value="${prod.prod_num}" readonly >
						        <button type="button" class="plus">+</button>
						    </div>
						    <div class="col-1 total_price">${String.format("%,d",prod.prod_num*SpecDao.getOneProdSpecByPK(prod.prod_spec_id).prod_price)}</div>
						    <div class="col-1 trash"><i class="fas fa-trash-alt"></i></div>
						</div>
						<hr>
					</c:forEach>
                <!-- <div class="row justify-content-between each_product">
                    <div class="col-2 pic">
                        <label class="row align-items-center items">
                            <input class="col-1" type="checkbox" name="specCheck" value="1" checked>
                            <img class="col-11" src="https://via.placeholder.com/300x300" alt="">
                        </label>
                    </div>
                    <div class="col-4">
                        <a href=""><p>❤現貨❤俏樂斯CHURACOS沖繩美人の All-In-One Gel 幼美肌超導逆時彈力水凝霜30g</p></a>
                        <div class="spec" id="123">規格</div>
                    </div>
                    <div class="col-1">500</div>
                    <div class="col-2 amount">
                        <button type="button" class="minus">-</button>
                        <input type="text" class="prod_num" name="specAmount1" value="1" readonly >
                        <button type="button" class="plus">+</button>
                    </div>
                    <div class="col-1 total_price">500</div>
                    <div class="col-1 trash"><i class="fas fa-trash-alt"></i></div>
                </div> -->
                
   				<c:if test="${shopList.size()!=0 }">
                	<div class="subtotal_right">
                	<p>運費: 下一步驟計算</p>
            		</div>
                </c:if>
            
            </section>


             
    </section>

        <section class="confirm">
            <span>共選擇<span class="total_count">0</span>項商品，總金額: $<span class="total_price">0</span></span>
            
            <c:if test="${shopList.size()!=0 }">
                <button><i class="fas fa-arrow-circle-right"></i>寄件與付款資訊</button>
            </c:if>
        </section>
        </form>
    </main>






    <script src="vendors/jquery-3.6.0.min.js"></script>
    <script src="js/index.js"></script>
    <script>
        calc_total_price(); //重新計算總額
        // 商品加減按鈕
        $("button.minus").on("click", function(e){
            let current_amount = e.target.nextSibling.nextSibling;
            if (current_amount.value > 1) {
                current_amount.value -= 1;

                //設定小計
                let num = parseInt(current_amount.value);
                let original_price = parseInt($(this).parent().prev().text().replace(",", ''));
                $(this).parent().next().text((num*original_price).toLocaleString());

                let spec = $(this).parent("div.each_product").prev().prev().find("div.spec");
                let obj = {
                "type":"update",
                "userid": 1,
                "specid" : $(spec).attr("id"),
                "num":num
                }
                $.ajax({
                        url: "http://localhost:8081/FFF/ProdToCartServlet",
                        type: "GET",
                        dataType: "text",
                        data: obj,
                        success: function (data) {
                            console.log(data);
                        }
                });
                    calc_total_price(); //重新計算總額
                }
            
        });

        $("button.plus").on("click", function(e){
            let val_plus = parseInt(e.target.previousSibling.previousSibling.value);
            let current_amount = e.target.previousSibling.previousSibling;
            current_amount.value = val_plus + 1;

            //設定小計
            let num = parseInt(current_amount.value);
            let original_price = parseInt($(this).parent().prev().text().replace(",", ''));
            $(this).parent().next().text((num*original_price).toLocaleString());

            let spec = $(this).parents().prev().prev().find("div.spec");
            
            let obj = {
                "type":"update",
                "userid": 1,
                "specid" : $(spec).attr("id"),
                "num":num
            }
            $.ajax({
                    url: "http://localhost:8081/FFF/ProdToCartServlet",
                    type: "GET",
                    dataType: "text",
                    data: obj,
                    success: function (data) {
                        console.log(data);
                    }
            });

                calc_total_price(); //重新計算總額
            });
        
        


        //商品移除按鈕
        $("div.trash").on("click", function () {
            $(this).parent().prev().remove();
            $(this).parent().remove();

            let spec = $(this).parent("div.each_product").find("div.spec");
            let obj = {
                "type":"remove",
                "userid": 1,
                "specid" : $(spec).attr("id"),
            }
            $.ajax({
                    url: "http://localhost:8081/FFF/ProdToCartServlet",
                    type: "GET",
                    dataType: "text",
                    data: obj,
                    success: function (data) {
                        console.log(data);
                    }
            });

            calc_total_price();
        });

        //全選按鈕設定
        $("#check_all").on("click", function () {
            if ($("label.items input:checked").length < $("label.items input").length) {
            $("label.items input").prop("checked", true);
            $("#check_all").prop("checked", true);
            } else {
            $("label.items input").prop("checked", false);
            }
            calc_total_price();
        });

        $("label.items input").on("click", function () {
            if (
            $("label.items input:checked").length >= $("label.items input").length
            ) {
            $("#check_all").prop("checked", true);
            } else {
            $("#check_all").prop("checked", false);
            }
            calc_total_price();
        });

        //計算目前有打勾的總金額
        function calc_total_price() {
        let total_price = 0;
        let total_count=0;
        $("label.items input:checked").each(function () {
            total_count += parseInt($(this).parents("div.each_product").find("input.prod_num").val());
            total_price += parseInt($(this).parents("div.each_product").find("div.total_price").text().replace(",", ''));
        });
        $("span.total_count").text(total_count);
        $("span.total_price").text(total_price.toLocaleString());
        }
    </script>
</body>

</html>