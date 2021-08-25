$(document).ready(function () {

    //////////////////首頁////////////////////////////

  //RWD篩選跳出
  $("button.filter").on("click", function () {
    $("aside").slideToggle();
  });

  

  add_heart_btn();


  //取得注目商品
  $.ajax({
    url: "http://localhost:8081/FFF/ProdToIndex?type=recommandation",
    type: "GET",
    dataType: "json",
    success: function (data) {
      for (let i = 0; i < data.length; i++) {
        let str = `<div class="product">
                                        <a href="http://localhost:8081/FFF/ShowEachProd?prodID=${data[i]["prod_id"]}">`;
        //判斷是否有兩張圖
        if (data[i]["img2"]) {
          str += `<img src="http://localhost:8081/${data[i]["img1"]}" alt="product pictures"
                                                data-img1="http://localhost:8081/${data[i]["img1"]}" data-img2="http://localhost:8081/${data[i]["img2"]}">`;
        } else {
          str += `<img src="http://localhost:8081/${data[i]["img1"]}" alt="product pictures">`;
        }

        str += `    <p>${data[i]["prod_name"]}</p>
                                            <p>$${data[i][
                                              "price"
                                            ].toLocaleString()}</p>
                                        </a>
                                        <div class="preview" style="display:none" data-prod="${
                                          data[i]["prod_id"]
                                        }">快速瀏覽</div>
                                    </div>`;
        $("div.slider").append(str);
      }

      //讓注目商品輪播
      $(".slider").slick({
        slidesToShow: 3,
        slidesToScroll: 3,
        arrows: true,
      });
    },
  });

  var prod_num = 0;

  var obj = {
    type: "prod",
    start: 0,
    end: 12,
  };

  prod_num += 12;
  //取得第1~12個商品
  $.ajax({
    url: "http://localhost:8081/FFF/ProdToIndex",
    type: "GET",
    data: obj,
    dataType: "json",
    success: function (data) {
      console.log(data);
      for (let i = 0; i < data.length; i++) {
        let str = `<div class="product">`;

        if(data[i]["favProd"]){
          str+=  `<i class="fas fa-heart fa-lg heart_btn"></i>
          <div class="heart_tag">取消收藏</div>`;
        }else{
          str+=  `<i class="far fa-heart fa-lg heart_btn"></i>
          <div class="heart_tag">加入收藏</div>`;
        }
        str+= `<a href="http://localhost:8081/FFF/ShowEachProd?prodID=${data[i]["prod_id"]}">`;
        //判斷是否有兩張圖
        if (data[i]["img2"]) {
          str += `<img src="http://localhost:8081/${data[i]["img1"]}" alt="product pictures"
                                                data-img1="http://localhost:8081/${data[i]["img1"]}" data-img2="http://localhost:8081/${data[i]["img2"]}">`;
        } else {
          str += `<img src="http://localhost:8081/${data[i]["img1"]}" alt="product pictures">`;
        }

        str += `<p class="prod_name">${data[i]["prod_name"]}</p>
                                <p>$${data[i]["price"].toLocaleString()}</p>
                                </a>
                                <div class="preview" style="display:none" data-prod="${
                                  data[i]["prod_id"]
                                }">快速瀏覽</div>
                                <div>`;

        //判斷是否賣出
        if (data[i]["sale"]) {
          str += `<p>已售出${data[i]["sale"].toLocaleString()}</p>`;
        } else {
          str += `<p></p>`;
        }

        //判斷星數

        if (data[i]["star"]) {
          str += `<div>${star_rating_str_reg(
            data[i]["star"]
          )}</div></div></div>`;
        } else {
          `<div></div></div></div>`;
        }

        $("section#product_display").append(str);
      }

      add_heart_btn();
    },
  });

  //動態加載新的商品
  var send = false;
  $(window).on("scroll", function () {
    if (
      $(document).height() - ($(window).scrollTop() + $(window).height()) <=
        100 &&
      send === false
    ) {
      // 滑到底部達到 100px 時觸發

      send = true;
      obj = {
        type: "prod",
        start: prod_num,
        end: prod_num + 12,
      };

      prod_num += 12;
      //取得第1~12個商品
      $.ajax({
        url: "http://localhost:8081/FFF/ProdToIndex",
        type: "GET",
        data: obj,
        dataType: "json",
        beforeSend: function () {
          $("div.spin").append('<i class="fas fa-spinner fa-pulse fa-2x"></i>');
        },
        success: function (data) {
          if (data.result == "no result") {
            $("div.spin").children().remove();
            return;
          }
          for (let i = 0; i < data.length; i++) {
            let str = `<div class="product">`;

            if(data[i]["favProd"]){
              str+=  `<i class="fas fa-heart fa-lg heart_btn"></i>
              <div class="heart_tag">取消收藏</div>`;
            }else{
              str+=  `<i class="far fa-heart fa-lg heart_btn"></i>
              <div class="heart_tag">加入收藏</div>`;
            }
            str+= `<a href="http://localhost:8081/FFF/ShowEachProd?prodID=${data[i]["prod_id"]}">`;
        //判斷是否有兩張圖
            if (data[i]["img2"]) {
              str += `<img src="http://localhost:8081/${data[i]["img1"]}" alt="product pictures"
                                                data-img1="http://localhost:8081/${data[i]["img1"]}" data-img2="http://localhost:8081/${data[i]["img2"]}">`;
            } else {
              str += `<img src="http://localhost:8081/${data[i]["img1"]}" alt="product pictures">`;
            }

            str += `<p class="prod_name">${data[i]["prod_name"]}</p>
                                <p>$${data[i]["price"].toLocaleString()}</p>
                                </a>
                                <div class="preview" style="display:none" data-prod="${
                                  data[i]["prod_id"]
                                }">快速瀏覽</div>
                                <div>`;

            //判斷是否賣出
            if (data[i]["sale"]) {
              str += `<p>已售出${data[i]["sale"].toLocaleString()}</p>`;
            } else {
              str += `<p></p>`;
            }

            //判斷星數

            if (data[i]["star"]) {
              str += `<div>${star_rating_str_reg(
                data[i]["star"]
              )}</div></div></div>`;
            } else {
              `<div></div></div></div>`;
            }

            $("section#product_display").append(str);
          }

          add_heart_btn();
          send = false;
          $("div.spin").children().remove();
        },
      });
    }
  });

//商品加減按鈕
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
});


