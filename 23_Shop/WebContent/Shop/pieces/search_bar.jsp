<%@page contentType="text/html; charset=UTF-8" %>

<!-------------------------------- search bar -------------------------------->
    <article class="search_bar row ">


        <div class="search_input col-sm-6">
        <form action="http://localhost:8081/FFF/ProductFilterServlet">
        	<input type="text" name="search" id="search" placeholder="搜尋商品.......">
            <button class="btn_search"><i class="fas fa-search"></i></button>
        </form>
            
        </div>
        <div class="btn col-sm-6">
            <div class="cart_preview_div">
                <a href="/FFF/Shop/buy1_cart.jsp"><button class="cart"><i class="fas fa-shopping-cart"></i>購物車</button></a>
                <!-- <div class="cart_preview">
                    <div class="info row align-items-center">
                        最近加入的商品
                    </div>
                    <div class="row align-items-center justify-content-around">
                        <img class="col-3" src="https://via.placeholder.com/300x2400" alt="">
                        <p class="col-6">商品名稱商品名稱商品名稱商品名稱</p>
                        <p class="col-3">$200</p>
                    </div>
                </div> -->
            </div>
            <a href="/FFF/Shop/shop2_favorites.jsp"><button><i class="fas fa-heart"></i>我的收藏</button></a>

        </div>
    </article>