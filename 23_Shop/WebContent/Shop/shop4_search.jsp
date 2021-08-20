<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh-hant">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>商城</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Shop/vendors/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Shop/style/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.css" />


</head>
<% 
	List list = (List)request.getAttribute("sendList"); 
	pageContext.setAttribute("list", list);

	String searchResult = request.getParameter("search");

%>




<body class="container-fluid">
    
    <jsp:include page="pieces/search_bar.jsp"></jsp:include> <!-- search_bar -->


    <div class="row">
    		<c:if test="${searchForType != null }">
    			<h4>"${searchForType}"的搜尋結果:</h4>
            </c:if>
            <c:if test="${searchWord != null }">
    			<h4>"${searchWord}"的搜尋結果:</h4>
            </c:if>
        
        <hr>
        <button class="filter"><i class="fas fa-filter">篩選條件</i></button>
        <!-------------------------------- side bar -------------------------------->
        <aside class="side col-sm-3">
            <h5><i class="fas fa-filter"></i> 篩選條件</h4>
            <form action="<%= request.getContextPath()%>/ProductFilterServlet">
            	<input type="hidden" name="search" value="<%=searchResult%>">
            	<input type="hidden" name="filter" value="yes">
            <hr>
            <c:if test="${searchWord != '生活休閒' && searchWord != '美妝保養'&& searchWord != '風格穿搭'&& searchWord != '3C家電'}">
            	<%
            	List<Integer> typeCheckList = (List<Integer>)request.getAttribute("typeList");
            	%>
            	
            	
            	<p>分類</p>
            	<label><input type="checkbox" name="prod_type" value=1 <%if(typeCheckList.size()!=4 && typeCheckList.contains(1)){%>checked<% }%>>生活休閒</label>
	            <label><input type="checkbox" name="prod_type" value=2 <%if(typeCheckList.size()!=4 && typeCheckList.contains(1)){%>checked<% }%>>美妝保養</label>
	            <label><input type="checkbox" name="prod_type" value=3 <%if(typeCheckList.size()!=4 && typeCheckList.contains(1)){%>checked<% }%>>風格穿搭</label>
	            <label><input type="checkbox" name="prod_type" value=4 <%if(typeCheckList.size()!=4 && typeCheckList.contains(1)){%>checked<% }%>> 3C家電 </label>
	            <hr>
            </c:if>
            <%
            	List<Integer> shipCheckList = (List<Integer>)request.getAttribute("ship");
            %>
            <p>運送方式</p>
            <label><input type="checkbox" name="prod_ship" value=1 <%if(shipCheckList.size()!=4 && shipCheckList.contains(1)){%>checked<% }%>>7-11</label>
            <label><input type="checkbox" name="prod_ship" value=2 <%if(shipCheckList.size()!=4 && shipCheckList.contains(2)){%>checked<% }%>>黑貓宅急便</label>
            <label><input type="checkbox" name="prod_ship" value=3 <%if(shipCheckList.size()!=4 && shipCheckList.contains(3)){%>checked<% }%>>全家</label>
            <label><input type="checkbox" name="prod_ship" value=4 <%if(shipCheckList.size()!=4 && shipCheckList.contains(4)){%>checked<% }%>>郵局包裹</label>
            <hr>
            <p class=>價格範圍</p>
            <div class="row">
                <div class="col-2"></div>
                <input class="col-3" type="number" name="min" <c:if test="${price[0] != 0 }">value="${price[0]}"</c:if>>
                <div class="col-2">～</div>
                <input class="col-3" type="number" name="max" <c:if test="${price[1] != 99999 }">value="${price[1]}"</c:if>>
                <div class="col-2"></div>
                <div class="col-2"></div>
            </div>
            <hr>
            <p>評價</p>
            <label class="star_radio"><input type="radio" name="star" value="4" <c:if test = "${starSearch == 4 }">checked</c:if>>四星以上</label>
            <label class="star_radio"><input type="radio" name="star" value="3" <c:if test = "${starSearch == 3 }">checked</c:if>>三星以上</label>
            <label class="star_radio"><input type="radio" name="star" value="2" <c:if test = "${starSearch == 2 }">checked</c:if>>二星以上</label>
            <label class="star_radio"><input type="radio" name="star" value="1" <c:if test = "${starSearch == 1 }">checked</c:if>>一星以上</label>
            <hr>
            <p>排序條件</p>
            <label><input type="radio" name="sort" value="4" <c:if test = "${sortType == 1 }">checked</c:if>>銷售排行</label>
            <label><input type="radio" name="sort" value="3" <c:if test = "${sortType == 2 }">checked</c:if>>評價</label>
            <label><input type="radio" name="sort" value="2" <c:if test = "${sortType == 3 }">checked</c:if>>價格:高到低</label>
            <label><input type="radio" name="sort" value="1" <c:if test = "${sortType == 4 }">checked</c:if>>價格:低到高</label>
            	
            <div class="row">
            <div class="col-2"></div>
            <button id="send_filter" class="col-9">送出</button>
            <div class="col-1"></div>
            
            </div>
            </form>
        </aside>

        <!-------------------------------- main page-------------------------------->
        <main class="col-sm-9">

            <!-------------------------------- product sort -------------------------------->
            
            <article class="prod_sort_bar row">

                <div class="prod_types col-sm-8">
                    
                </div>
<%--                 <div class="col-sm-4">${sendList.size()}項商品，共${Math.ceil(sendList.size()/12).intValue()}頁</div> --%>
<!--             </article> -->

<!--             <section id="product_display"> -->

<!--     分頁 -->
 <%@ include file="pieces/page1.file" %> 
 <c:if test="${ list.size() != 0}">
 	
  <div class="col-sm-4"><%=rowNumber%>項商品，第<%=whichPage%>/<%=pageNumber%>頁</div> 
 </c:if>
</article>

<section id="product_display">
 	<c:if test="${ list.size() == 0}">
 	<br><br>
		<div style="text-align:center"><h2>沒有找到商品哦!找找看別的吧!</h2></div>
	</c:if>
 
 
            <c:forEach var="prod" items="${sendList}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
	
	            <div class="product">
	                <i class="far fa-heart fa-lg heart_btn"></i>
	                <div class="heart_tag">加入收藏</div>
	                <a href="/FFF/ShowEachProd?prodID=${prod.prod_id}">
	                	<c:if test="${prod.img2 != null}">
	                		<img src="/${prod.img1}" alt="product pictures"
	                        data-img1="/${prod.img1}" data-img2="/${prod.img2}">
	                	</c:if>
	                	<c:if test="${prod.img2 == null}">
	                		<img src="/${prod.img1}" alt="product pictures">
	                	</c:if>
	                    
	                    <p>${prod.prod_name}</p>
	                    <p>$${String.format("%,d",prod.price)}</p>
	                </a>
	                <div class="preview" style="display:none" data-prod="${prod.prod_id}">快速瀏覽</div>
	                <div>
	                    <c:if test="${prod.sale != null}"><p>已售出${prod.sale}</p></c:if>
	                    <div>
	                        <c:forEach begin="1" end="5" varStatus="s">
                        		<c:if test="${s.count > prod.star }">
                        			<i class="far fa-star"></i>
                        		
                        		</c:if>
                        		<c:if test="${s.count <= prod.star }">
                        			<i class="fas fa-star"></i>
                        		
                        		</c:if>
                        	</c:forEach>
	                    </div>
	                </div>
	            </div>
            
            </c:forEach>

	
                <!-- <div class="product">
                <i class="far fa-heart fa-lg"></i>
                <div class="heart_tag">加入收藏</div>
                <a href="#">
                    <img src="https://via.placeholder.com/300x200" alt="product pictures"
                        data-img1="https://via.placeholder.com/300x200" data-img2="pics/1.jpg">
                    <p>商品名稱</p>
                    <p>$2,200</p>
                </a>
                <a href="#sss" class="preview" style="display:none">快速瀏覽</a>
                <div>
                    <p>已售出2,000</p>
                    <div>
                        <i class="fas fa-star fa-xs"></i>
                        <i class="fas fa-star fa-xs"></i>
                        <i class="fas fa-star fa-xs"></i>
                        <i class="fas fa-star fa-xs"></i>
                        <i class="fas fa-star fa-xs"></i>
                    </div>
                </div>
            </div> -->

                

                <!-------------------------------- change pages -------------------------------->
                <section class="page">
                    
                    <%
		String str = request.getQueryString();
		if(str.contains("whichPage")){
			
			str=str.substring(0,str.lastIndexOf("&whichPage"));
		}
	%>


  <%if (pageNumber>1) {%> 
       	<hr>
         <%for (int i=1; i<=pageNumber; i++){%>
         
         	<%if(i == whichPage){ %>
            	<button class="-on"><%=i%></button>
            <% }else{ %>
            	<a href="/FFF/ProductFilterServlet?<%=str%>&whichPage=<%=i%>"><button><%=i%></button></a>
            <% } } }%>
                </section>
            </section>
    </div>
</main>

    <!-- 快速瀏覽視窗 -->
    <div class="preview_prod_bg" style="display:none">
        <div class="preview_prod">

            <div class="exit"><i class="far fa-times-circle fa-2x"></i></div>
            
            <section class="product_info row">
                <div class="col-md-5">
                    <div class="big_pic slider-prod-for">
                        <img class="col-3" src="https://via.placeholder.com/300x200" alt="">
                    </div>
                    <div class="small_pics row slider-prod-nav">
                        <img class="col-3" src="https://via.placeholder.com/300x200" alt="">
                    </div>
                </div>
                <div class="info col-md-7">
                    <h2 id="prod_name">商品名稱</h2>
                    <hr>
                    <div>
                        <span>商品選項: </span>
                        <select class="index_spec">
                            <option value="">ssss</option>
                        </select>
                    </div>
                    <div>
                        <span>數量: </span>
                        <div class="amount">
                            <button type="button" class="minus">-</button>
                            <input type="text" name="prod_num" value="1" readonly>
                            <button type="button" class="plus">+</button>
                        </div>
                    </div>
                    <div class="btn">
                        <h2 id="prod_price">$1,000</h2>
                        <button id="addCart"><i class="fas fa-shopping-cart"></i>加入購物車</button>
                    </div>
                </div>
            </section>
        </div>
    </div>

    <div class="add_to_cart_alert" style="display: none">成功加入購物車!</div>

    <div id="to_top"><a href="#top"><i class="fas fa-chevron-circle-up fa-2x"></i></a></div>
    <script src="<%= request.getContextPath() %>/Shop/vendors/jquery-3.6.0.min.js"></script>
    <script src="<%= request.getContextPath() %>/Shop/js/index.js"></script>
    <script src="<%= request.getContextPath() %>/Shop/vendors/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.js"></script>
    <script>

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

    </script>
</body>

</html>