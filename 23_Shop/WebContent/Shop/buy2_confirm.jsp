<%@page contentType="text/html; charset=UTF-8" %>

<%@ page import="java.util.*, com.shop.model.*, com.shop.util.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<jsp:useBean id="ProdPicDao" class="com.shop.service.ProdPicsService"/>
<jsp:useBean id="SpecDao" class="com.shop.service.ProdSpecService"/>
<jsp:useBean id="ProdDao" class="com.shop.service.ProdService"/>
<jsp:useBean id="ShipMethodDao" class="com.shop.service.ShipMethodService"/>


<!DOCTYPE html>
<html lang="zh-hant">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>付款寄件</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Shop/vendors/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css"
        integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Shop/style/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Shop/style/buy.css">

</head>


<body class="container-fluid">
<%
	HashMap buyList = (HashMap)request.getAttribute("buyList");
	Set specList = buyList.keySet();
	
	pageContext.setAttribute("specList", specList);
%>
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

    <!-- 付款和地址內容 -->
    <form action="<%= request.getContextPath() %>/MakeOrderServlet">
        <section class="main_part">
            <h1>資訊確認</h1>
            <hr>

            <section class="product row">
                <h3 class="col-sm-2">訂購商品</h3>
                <!-- 商品列 -->
                <div class="product_list col-sm-10">
                    <div class="row justify-content-between cart_header">
                        <div class="col-2"></div>
                        <div class="col-4">品名/規格</div>

                        <div class="col-2">單價</div>
                        <div class="col-2">數量</div>

                        <div class="col-2">小計</div>
                    </div>
                    <hr>
					
					<c:forEach var="item" items="${specList}">
					
					    <div class="row justify-content-between each_product">
	                        <div class="col-2">
	                            <img src="/FFF/ProdImage?id=${ProdPicDao.getAllProdPicByProdID(SpecDao.getOneProdSpecByPK(item).prod_id).get(0).getProd_pic_id()}" alt="">
	                        </div>
	                        <div class="col-4">
	                            <p>${ProdDao.getOneById(SpecDao.getOneProdSpecByPK(item).prod_id).prod_name}</p>
	                            <p>${SpecDao.getOneProdSpecByPK(item).spec_name}</p>
	                            <input type="hidden" name="spec_id" value="${item}">
	                        </div>
	                        <div class="col-2">${String.format("%,d",SpecDao.getOneProdSpecByPK(item).prod_price)}</div>
	                        <div class="col-2">${buyList.get(item)}</div>
	                        <input type="hidden" name="prodNum${item}" value="${buyList.get(item)}">
	                        <div class="col-2">${String.format("%,d",SpecDao.getOneProdSpecByPK(item).prod_price*buyList.get(item))}</div>
	                    </div>
							
					</c:forEach>

                    <!-- <div class="row justify-content-between each_product">
                        <div class="col-2">
                            <img src="https://via.placeholder.com/400x300" alt="">
                        </div>
                        <div class="col-4">
                            <p>❤現貨❤俏樂斯CHURACOS沖繩美人の All-In-One Gel 幼美肌超導逆時彈力水凝霜30g</p>
                            <p>規格</p>
                            <input type="hidden" name="spec_id" value="">
                        </div>
                        <div class="col-2">1,000</div>
                        <div class="col-2">2</div>
                        <input type="hidden" name="prodNumX" value="">
                        <div class="col-2">1,000</div>
                    </div> -->
                    

            </section>

            <hr>
            <section class="address row">
                <h3 class="col-sm-2">運送方式</h3>
                <div class="col-sm-10">
                    <div class="ship_method">
                         <select name="ship_method">
                            <!-- <option value="" selected disabled hidden>選擇運送方式</option> -->
                            <c:forEach var = "shipNo" items="${shipMethodList}">
                            	<option value="${shipNo}" data-price="${ShipMethodDao.getOneShipMethodByPK(shipNo).ship_fee}">
                            	${ShipMethodDao.getOneShipMethodByPK(shipNo).ship_name} 
                            	(運費${ShipMethodDao.getOneShipMethodByPK(shipNo).ship_fee})</option>
                            </c:forEach>
<!--                             <option value="1" data-price="60">7-11 (運費60)</option> -->
                        </select><br>
                    </div>
                    <label>姓名: <input type="text" name="name" id="name" required value="asd"></label><br>
                    <label class="phone_area">電話:
                        <input class="phone" type="text" name="phone1" id="" required pattern="09\d{2}" maxlength="4" value="0912"> -
                        <input class="phone" type="text" name="phone2" id="" required pattern="\d{6}"
                            maxlength="6" value="938271"></label><br>
                    <label>市區: <span id="twzipcode" required></span><br>
                        <!-- https://code.essoduke.org/twzipcode/#download -->
                        <label>地址: <input type="text" name="address" id="" required value="dddd"></label><br>
                        <label>電子郵件: <input type="text" name="email" id="" required
                                pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$" value="10000@hotmail.com"/></label><br>
                </div>
            </section>
            <hr>
            <section class="credit_info row">
                <h3 class="col-sm-2">付費資訊</h3>
                <div class="col-sm-10">
                    <label id="card">信用卡號碼:
                        <input class="card_number" type="text" name="card_num1" required pattern="\d{4}" maxlength="4" value="1111">-
                        <input class="card_number" type="text" name="card_num2" required pattern="\d{4}" maxlength="4" value="1111">-
                        <input class="card_number" type="text" name="card_num3" required pattern="\d{4}" maxlength="4" value="1111">-
                        <input class="card_number" type="text" name="card_num4" required pattern="\d{4}" maxlength="4" value="1111">
                    </label><br>
                    <label>日期: <input type="text" name="date" id="" required pattern="\d{2}/\d{2}"
                            placeholder="YY/MM" value="11/11"></label><br>
                    <label>認證碼: <input type="text" name="CVN" id="" required pattern="\d{3}" value="111"></label><br>
                    <label>姓名: <input type="text" name="card_name" id="" required value="aaa"></label>
                </div>
            </section>
        </section>

        <!-- 按鈕 -->
        <section class="confirm">
            <span>共選擇${totalList.get("prodNum")}項商品，總金額: $<span id="price_total" data-price="${totalList.get("total")}">${String.format("%,d",totalList.get("total")+ShipMethodDao.getOneShipMethodByPK(shipMethodList[0]).ship_fee)}</span></span>
            <a href="<%= request.getContextPath() %>/Shop/buy1_cart.jsp"><button type="button" class="btn_goback"><i class="fas fa-arrow-circle-left"></i>返回購物車</button></a>
            <button type="submit"><i class="fas fa-arrow-circle-right"></i>確認訂單</button>
        </section>
        </main>
    </form>

    <script src="<%= request.getContextPath() %>/Shop/vendors/jquery-3.6.0.min.js"></script>
    <script src="<%= request.getContextPath() %>/Shop/js/index.js"></script>
    <script src="<%= request.getContextPath() %>/Shop/vendors/jquery.twzipcode.js"></script>
    <script>
        $('#twzipcode').twzipcode();
        $("#twzipcode").find('input').attr('required', true).prop('required', true);
        //信用卡跳格
        $("input.card_number").on("keydown", function (e) {
            if ((e.which >= 48 && e.which <= 57) || e.which == 8) {
                if (e.target.value.length == 0 && e.which == 8) {
                    $(this).prev().focus();
                }
            } else {
                e.preventDefault();
            }
        });

        $("input.card_number").on("keyup", function (e) {
            // \D 代表非數字字元，g 代表全域尋找
            let str = (e.target.value).replace(/\D/g, "");
            $(this).val(str);
            if (str.length == 4) {
                $(this).next().focus();
            }
        });
        //電話號碼跳格
        $("input.phone").on("keydown", function (e) {
            if ((e.which >= 48 && e.which <= 57) || e.which == 8) {
                if (e.target.value.length == 0 && e.which == 8) {
                    $(this).prev().focus();
                }
            } else {
                e.preventDefault();
            }
        });

        $("input.phone").on("keyup", function (e) {
            // \D 代表非數字字元，g 代表全域尋找
            let str = (e.target.value).replace(/\D/g, "");
            $(this).val(str);
            if (str.length == 4) {
                $(this).next().focus();
            }
        });

        //選擇運費後改變總金額
        var original_price = parseInt($("span#price_total").attr("data-price"));
        $("select[name='ship_method']").on("change", function(e){
            let ship_price = parseInt($(this).find("option:selected").attr("data-price"));
            let current_price = parseInt($("span#price_total").text().replace(",", ""));

            $("span#price_total").text((ship_price+original_price).toLocaleString());
        })
        
// 		window.onpopstate = function(event) {
//             alert("不能重新載入哦!重導到商品首頁");
<%--             location.href = '<%= request.getContextPath()%>/Shop/index.html'; --%>
//         };
    </script>

</body>

</html>