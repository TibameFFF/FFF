<%@page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="zh-hant">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>收藏頁面</title>
    <link rel="stylesheet" href="vendors/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css"
        integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.css" />

</head>

<body class="container-fluid">

    <jsp:include page="pieces/search_bar.jsp"></jsp:include> <!-- search_bar -->

    <!------------- main page --------------->
    <main>
        <!------------- product sort and type --------------->
        <article class="title">
            <h1>我的收藏</h1>
            <p id="total_product_num">1項商品</p>
        </article>
        <hr>

        <section id="product_display">
            <!-- <div class="product">
                <i class="fas fa-heart fa-lg"></i>
                <div class="heart_tag">取消收藏</div>
                <a href="#">
                    <img src="https://via.placeholder.com/300x200" alt="product pictures"
                        data-img1="https://via.placeholder.com/300x200" data-img2="pics/1.jpg">
                    <p>商品名稱</p>
                    <p>$2,200</p>
                </a>
                <div href="#sss" class="preview" style="display:none">快速瀏覽</div>
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
        </section>

    </main>


    <!-- 快速瀏覽視窗 -->
    <div class="preview_prod_bg" style="display:none">
        <div class="preview_prod">

            <div class="exit"><a href="#"><i class="far fa-times-circle fa-2x"></i></a></div>
            <!-- 商品介紹 -->
            <section class="product_info row">
                <div class="col-md-5">
                    <div class="big_pic slider-prod-for">
                        <img class="col-3" src="https://via.placeholder.com/300x200" alt="">
                        <img class="col-3" src="https://via.placeholder.com/300x200" alt="">
                        <img class="col-3" src="https://via.placeholder.com/300x200" alt="">
                        <img class="col-3" src="https://via.placeholder.com/300x200" alt="">
                    </div>
                    <div class="small_pics row slider-prod-nav">
                        <img class="col-3" src="https://via.placeholder.com/300x200" alt="">
                        <img class="col-3" src="https://via.placeholder.com/300x200" alt="">
                        <img class="col-3" src="https://via.placeholder.com/300x200" alt="">
                        <img class="col-3" src="https://via.placeholder.com/300x200" alt="">
                    </div>
                </div>
                <div class="info col-md-7">
                    <h2 id="prod_name">商品名稱</h2>
                    <hr>
                    <div>
                        <span>商品選項: </span>
                        <select name="spec">
                            <option value="">ssss</option>
                            <option value="">ssss</option>
                            <option value="">ssss</option>
                        </select>
                    </div>
                    <div>
                        <span>數量: </span>
                        <div class="amount">
                            <button type="button" class="minus">-</button>
                            <input type="text" name="" id="" value="1" readonly>
                            <button type="button" class="plus">+</button>
                        </div>
                    </div>
                    <div class="btn">
                        <h2 id="prod_price">$1,000</h2>
                        <button><i class="fas fa-shopping-cart"></i>加入購物車</button>
                    </div>
                </div>
            </section>
        </div>
    </div>

    <div class="add_to_cart_alert" style="display: none">成功加入購物車!</div>
    <div id="to_top"><a href="#top"><i class="fas fa-chevron-circle-up fa-2x"></i></a></div>
    <script src="vendors/jquery-3.6.0.min.js"></script>
    <script src="js/index.js"></script>
    <script src="vendors/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.js"></script>
    <script src="js/favorite.js"></script>
</body>

</html>