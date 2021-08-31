<%@page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, com.shop.model.*, com.shop.util.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-hant">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>每筆訂單</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Shop/vendors/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Shop/style/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Shop/style/order.css">
</head>




<body>
	<jsp:include page="pieces/header.jsp"></jsp:include> <!-- header -->
    <jsp:include page="pieces/search_bar.jsp"></jsp:include> <!-- search_bar -->
    
    
    <!------------- main page --------------->
    <main>



        <!-- 每筆訂單 -->
        <section class="each_order">
            <!-- 每筆訂單標頭 -->
            <article class="head">
                <span>訂單編號: ${orderDetailList.id}</span>
                <span>購買時間: ${orderDetailList.date}</span>
            </article>
            <hr>

            <!-- 訂單配送狀態 -->
            <article class="order_status">
	            <c:if test="${'訂單成立' == orderDetailList.status}">
	            	<div><i class="fas fa-receipt"></i>訂單成立</div>
	                <div class="gray">-----</div>
	                <div class="gray"><i class="gray fas fa-shipping-fast"></i>商品出貨</div>
	                <div class="gray">-----</div>
	                <div class="gray"><i class="far fa-check-circle gray"></i>訂單完成</div>
	            </c:if>
	            
	            <c:if test="${'商品出貨' == orderDetailList.status}">
	            	<div><i class="fas fa-receipt"></i>訂單成立</div>
	                <div>-----</div>
	                <div><i class="fas fa-shipping-fast"></i>商品出貨</div>
	                <div class="gray">-----</div>
	                <div class="gray"><i class="far fa-check-circle gray"></i>訂單完成</div>
	            </c:if>
	            
	            <c:if test="${'訂單完成'== orderDetailList.status}">
	            	<div><i class="fas fa-receipt"></i>訂單成立</div>
	                <div>-----</div>
	                <div><i class="fas fa-shipping-fast"></i>商品出貨</div>
	                <div>-----</div>
	                <div><i class="far fa-check-circle"></i>訂單完成</div>
	            </c:if>
	            
	            <c:if test="${'訂單取消' == orderDetailList.status}">
	            	<div><i class="fas fa-times-circle"></i>訂單取消</div>
	            </c:if>
                
            </article>
            <hr>

            <!-- 商品列表 -->
            <div class="products">
                <table>
                    <thead>
                        <tr>
                            <th></th>
                            <th>品名/規格</th>
                            <th>單價</th>
                            <th>數量</th>
                            <th>小計</th>
                        </tr>
                    </thead>

                    <tbody>
                        <tr>
                            <td colspan="5">
                                <hr>
                            </td>
                        </tr>
                        
                        
                        <!-- <tr>
                            <td>
                                <img src="https://cdn.britannica.com/s:800x1000/22/206222-050-3F741817/Domestic-feline-tabby-cat.jpg"
                                    alt="">
                            </td>
                            <td style="word-wrap : break-word">
                                <p>品名ssssssssssssssssssssssssss</p>
                                <p>規格</p>
                            </td>
                            <td>1,000</td>
                            <td>1</td>
                            <td>1,000</td>
                        </tr>
                        
                        
                        <tr>
                            <td colspan="5">
                                <hr>
                            </td>
                        </tr>
                        
                        
                        <tr>
                            <td>
                                <img src="https://cdn.britannica.com/s:800x1000/22/206222-050-3F741817/Domestic-feline-tabby-cat.jpg"
                                    alt="">
                            </td>
                            <td style="word-wrap : break-word">
                                <p>品名</p>
                                <p>規格</p>
                            </td>
                            <td>1,000</td>
                            <td>1</td>
                            <td>1,000</td>
                        </tr> -->
                        
                        <c:forEach var="prod" items="${prodList}" varStatus="s">
							<tr>
	                            <td>
	                                <img src="<%= request.getContextPath() %>/OrderProdImage?id=${prod.ord_prod_id}" alt="prod_pic">
	                            </td>
	                            <td style="word-wrap : break-word">
	                                <p>${prod.hist_prod_name}</p>
	                                <p>${prod.hist_prod_spec}</p>
	                            </td>
	                            <td>${String.format("%,d",prod.hist_prod_price)}</td>
	                            <td>${prod.prod_num}</td>
	                            <td>${String.format("%,d",prod.prod_num*prod.hist_prod_price)}</td>
                        	</tr>
                        
                        <c:if test="${not s.last}">
                        	<tr>
                            <td colspan="5">
                                <hr>
                            </td>
                        	</tr>
                        </c:if>
                        
						</c:forEach>
                        
                    </tbody>
                </table>
            </div>
            <hr>

            <!-- 買家資訊 -->
            <section class="buyed_info">
                <div>

                    <p>收件地址</p>
                    <p>${orderDetailList.name} ${orderDetailList.phone}</p>
                    <p>${orderDetailList.address}</p>
                    <p>${orderDetailList.email}</p>
                </div>
                <div>
                    <p>運送方式: ${orderDetailList.shipName}</p>
                    <p>運費:${orderDetailList.shipFee}</p>
                	<p>商品小計:${String.format("%,d",Integer.parseInt(orderDetailList.total))}</p>
                </div>
            </section>

            <!-- 退換貨內容 -->
            <!--<div class="re_ex">
                <hr>
                <section class="re_ex_inner">
                    <div>
                        <p>退換貨內容:XXX換成XXX，</p>
                        <p>回覆內容: XXX退貨，XX運費，退費XXX</p>
                    </div>
                    <div>
                        <p>退換貨金額:XXX</p>
                    </div>
                </section>
            </div> -->

            <hr>


            <!-- 按鈕 -->
            <section class="confirm confirm_total">
                <button class="btn_goto_orderlist">返回我的訂單</button>
                
                <c:if test="${'訂單成立' == orderDetailList.status}">
	            	<button class="btn_order_cancel">取消訂單</button>
	            </c:if>
                
                <c:if test="${prodList[0].eval_star == 0 && '訂單完成' == orderDetailList.status}">
	            	<a href="/FFF/Shop/order2_comment.jsp?id=${orderDetailList.id.replace('O','')}"><button class="btn_goto_comment">評價</button></a>
	            </c:if>
                
                
                <!-- <button class="btn_goto_ReEx">退貨/換貨</button> -->
<%--                 <c:if test="${ '訂單取消' != orderDetailList.status}"> --%>
<!-- 	            	<button class="btn_support">聯繫客服</button> -->
<%-- 	            </c:if> --%>
                
                <p>訂單總額: ${String.format("%,d",Integer.parseInt(orderDetailList.total)+Integer.parseInt(orderDetailList.shipFee))}</p>
            </section>



<!--             聯繫客服 -->
<!--             <article class="costumer_support" style="display:none"> -->
<!--                 <hr> -->
<!--                 <p>聯繫內容</p> -->
<!--                 <textarea name="" id="" cols="30" rows="10">請輸入內容....</textarea> -->
<!--                 <button class="yes">確認送出</button> -->
<!--                 <button class="no">取消</button> -->
<!--             </article> -->
        </section>




    </main>


    <footer>footer~~~~~~~~~~~~~~~~</footer>

    <div class="confirm_jump_bg order_popup" style="display:none">
        <div class="confirm_jump">
            <p>是否確認取消訂單? </p>
            <div>
                <button class="comfirm_cancel" data-id="${orderDetailList.id.replace('O','')}">確認</button>
                <button class="cust_comfirm">取消</button>
            </div>
        </div>
    </div>


<!--     <div class=confirm_jump_bg style="display:none"> -->
<!--         <div class="confirm_jump"> -->
<!--             <p>感謝您的意見! </p> -->
<!--             <p>客服人員將盡快與您聯繫!</p> -->
<!--             <div> -->
<!--                 <button class="cust_comfirm">確認</button> -->
<!--             </div> -->
<!--         </div> -->
<!--     </div> -->
    <script src="<%= request.getContextPath() %>/Shop/vendors/jquery-3.6.0.min.js"></script>
    <script src="<%= request.getContextPath() %>/Shop/vendors/bootstrap.bundle.min.js"></script>
    <script src="<%= request.getContextPath() %>/Shop/js/index.js"></script>
</body>

</html>