<%@page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="zh-hant"> 

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>商城</title>
    <link rel="stylesheet" href="vendors/bootstrap.min.css">
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css"
        integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.css" />

</head>

<body class="container-fluid">

    



	<jsp:include page="pieces/header.jsp"></jsp:include> <!-- header -->
	<jsp:include page="pieces/search_bar.jsp"></jsp:include> <!-- search_bar -->


    <!-------------------------------- 輪播 -------------------------------->
    <div id="carouselExampleCaptions" class="carousel slide carousel_custom" data-bs-ride="carousel">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active"
                aria-current="true" aria-label="Slide 1"></button>
            <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1"
                aria-label="Slide 2"></button>
            <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2"
                aria-label="Slide 3"></button>
        </div>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="https://www.drprint.com.tw/wp-content/uploads/2019/05/%E9%A6%96%E9%A0%81banner-1920x650-%E6%97%85%E8%A1%8C%E7%9A%84%E6%84%8F%E7%BE%A9_%E9%81%94%E5%8D%B0%E7%B6%B2.jpg"
                    class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
                <img src="https://diz36nn4q02zr.cloudfront.net/webapi/images/o/400/400/Activity/23526/7d1c0504-0de9-4e16-8c93-141e94d6d112/195634"
                    class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
                <img src="https://i.pinimg.com/originals/f1/4e/09/f14e0999db07519ee526e41b7f7e4dc1.jpg"
                    class="d-block w-100" alt="...">
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions"
            data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions"
            data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>


    <!-------------------------------- 注目商品輪播 -------------------------------->
    <div class="top_prod">
        <h3>注目商品</h3>
        <hr>
        <div class="slider">
            <!-- <div class="product">
                <a href="#">
                    <img src="https://via.placeholder.com/300x200" alt="product pictures">
                    <p>商品名稱</p>
                    <p>$2,200</p>
                </a>
                <a href="#sss" class="preview" style="display:none">快速瀏覽</a>
            </div>
            <div class="product">
                <a href="#">
                    <img src="https://via.placeholder.com/300x200" alt="product pictures"
                        data-img1="https://via.placeholder.com/300x200" data-img2="pics/1.jpg">
                    <p>商品名稱</p>
                    <p>$2,200</p>
                </a>
                <a href="#sss" class="preview" style="display:none">快速瀏覽</a>
            </div> -->
        </div>
    </div>

    <!-------------------------------- 商品分類-------------------------------->
    <div class="top_prod_type">
        <h3>商品分類</h3>
        <hr>
        <div class="type_row">
            <div>
                <a href="http://localhost:8081/FFF/ProductFilterServlet?search=生活休閒">
                    <img src="pics/1.jpg" alt="">
                    <h5>生活休閒</h5>
                </a>
            </div>
            <div>
                <a href="http://localhost:8081/FFF/ProductFilterServlet?search=美妝保養">
                    <img src="pics/2.jpg" alt="">
                    <h5>美妝保養</h5>
                </a>
            </div>
            <div>
                <a href="http://localhost:8081/FFF/ProductFilterServlet?search=風格穿搭">
                    <img src="pics/3.jpg" alt="">
                    <h5>風格穿搭</h5>
                </a>
            </div>
            <div>
                <a href="http://localhost:8081/FFF/ProductFilterServlet?search=3C家電">
                    <img src="pics/4.jpg" alt="">
                    <h5>3C家電</h5>
                </a>
            </div>
        </div>

    </div>
    </div>
    <!-------------------------------- main page-------------------------------->
    <main>

        <h3>全部商品</h3>
        <hr>
        <section id="product_display">
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


        </section>

        <section class="page">
            <div class="spin"></div>
            <!-- <i class="fas fa-spinner fa-pulse fa-2x"></i> -->
        </section>



    </main>

    <!-- Footer-->
    <footer class="py-4 mt-auto">
        <div class="container px-5">
            <div class="row align-items-center justify-content-between flex-column flex-sm-row">
                <div class="col-auto">
                    <div class="small m-0 text-white">Copyright &copy; Fun Friends 2021</div>
                </div>
                <div class="col-auto">
                    <a class="link-light small" href="#!">Privacy</a>
                    <span class="text-white mx-1">&middot;</span>
                    <a class="link-light small" href="#!">Terms</a>
                    <span class="text-white mx-1">&middot;</span>
                    <a class="link-light small" href="#!">Contact</a>
                </div>
            </div>
        </div>

        <div class="add_to_cart_alert" style="display:none">成功加入購物車!</div>
        
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
        <script src="vendors/jquery-3.6.0.min.js"></script>
        <script src="js/index.js"></script>
        <script src="vendors/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.js"></script>
        <script src="js/main_page.js"></script>

        
</body>

</html>