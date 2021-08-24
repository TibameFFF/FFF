document.addEventListener("DOMContentLoaded", function () {

  update_preview_cart();
  ////////////////////商品小卡設定//////////////////////////////

  //商品preview
  $(document).on("click", "div.preview", function (e) {
//    console.log($(this).attr("data-prod"));

    let obj = {
      type: "get_spec",
      prod_id: $(this).attr("data-prod"),
    };

    $.ajax({
      url: "http://localhost:8081/FFF/ProdToIndex",
      type: "GET",
      dataType: "json",
      data: obj,
      success: function (data) {
        // 設定名稱
        $("div.preview_prod div.info h2#prod_name").text(data["prodName"]);

        // 設定圖片
        $("section.product_info div div.big_pic").html(`<img class="col-3" src="http://localhost:8081/FFF/ProdImage?id=${data["prodPicList"][0]}" alt="prod_pic">`)
        let img_sub = "";
        for (let i = 1; i < data["prodPicList"].length; i++) {
          img_sub += `<img class="col-3" src="http://localhost:8081/FFF/ProdImage?id=${data["prodPicList"][i]}" alt="prod_pic">`;
        }
        $("section.product_info div div.small_pics").html(img_sub);
        
        
        //設定商品選項
        let option = "";
        for (let i = 0; i < data["specList"].length; i++) {
          if(i == 0){
            
            option += `<option value="${data["specIdList"][i]}" data-price="${data["specPriceList"][i]}">${data["specList"][i]}</option>`;
          } else{
            option += `<option value="${data["specIdList"][i]}" data-price="${data["specPriceList"][i]}">${data["specList"][i]}</option>`;

          }
        }

        $("select.index_spec").html(option);

        $("h2#prod_price").html(
          `$${data["specPriceList"][0].toLocaleString()}`
        );



        //數量歸回1
        $("input[name='prod_num']").val(1);
        $("div.preview_prod_bg").show();
      }
    });

  });

  //關閉商品preview
  $("div.exit").on("click", function () {
    $("div.preview_prod_bg").hide();
  });

  //商品換價格
  $("select.index_spec").on("change", function(){
    let price = parseInt($(this).find("option:selected").attr("data-price"));
    $("h2#prod_price").text(`$`+ price.toLocaleString());
  })

  //商品圖片hover換圖

  $(document).on("mouseenter", "div.product", function () {
    if ($(this).find("img").attr("data-img2") != undefined) {
      let second_img = $(this).find("img").attr("data-img2");
      $(this)
        .find("img")
        .stop(true, false)
        .animate({ opacity: 0.5 }, 200, function () {
          $(this).attr("src", second_img);
        })
        .animate({ opacity: 1 }, 200);
    }

    $(this).find(".preview").stop(true, false).slideToggle("fast");
  });

  $(document).on("mouseleave ", "div.product", function () {
    $(this).find(".preview").stop(true, false).slideToggle("fast");

    if ($(this).find("img").attr("data-img2") != undefined) {
      let first_img = $(this).find("img").attr("data-img1");
      $(this)
        .find("img")
        .stop(true, false)
        .animate({ opacity: 0.5 }, 200, function () {
          $(this).attr("src", first_img);
        })
        .animate({ opacity: 1 }, 200);
    }
  });



  //////////////商品詳情///////////////////////////

  //圖片事件綁定
  let pic_list = document.querySelectorAll("div.small_pics img");
  for (let i = 0; i < pic_list.length; i++) {
    pic_list[i].addEventListener("click", function (e) {
      document
        .querySelector("div.big_pic img")
        .setAttribute("src", e.target.getAttribute("src"));
    });
  }

  //選擇規格改變價格
  $("div.spec_choice").on("click", "input[name='prod_spec']", function (e) {
    let price = parseInt(e.target.dataset.price);
    $("button#add_to_cart").attr("data-spec", e.target.value);
    $(this)
      .parent()
      .parent()
      .find("h2#prod_price")
      .text("$" + price.toLocaleString());
  });

  ///////////////////每筆訂單頁面///////////////////////
  //按取消訂單 btn_order_cancel
  $(".btn_order_cancel").on("click", function () {
    $("div.order_popup").show();
  })
  
  $("button.comfirm_cancel").on('click', function(){

    let obj={
      id: $(this).attr("data-id")
    }
    $.ajax({
      url: "http://localhost:8081/FFF/CancelOrderServlet",           // 資料請求的網址
      type: "GET",                  // GET | POST | PUT | DELETE | PATCH
      data: obj,               // 傳送資料到指定的 url
      dataType: "text",             // 預期會接收到回傳資料的格式： json | xml | html
      success: function(data){      // request 成功取得回應後執行
        console.log(data);
        $("div.order_popup div.confirm_jump").html("<p>成功取消!<p>");

        setTimeout(function () {
          location.reload();
        }, 1000);
      }
    });
    
     
  });


  // 客服區塊彈跳
  $(".btn_support").on("click", function () {
    $(this).parent().siblings(".costumer_support").slideToggle();
  });

  // 客服按確定跳彈窗
  $("button.yes").on("click", function () {
    if (
      $(this).siblings("textarea").val().trim() == "" ||
      $(this).siblings("textarea").val() == "請輸入內容...."
    ) {
      alert("請輸入文字!");
    } else {
      $(this).siblings("textarea").val("");
      $(this).parent().siblings("section.confirm").find(".btn_support").click();
      $(".confirm_jump_bg").css("display", "block");
    }
  });

  //客服彈窗按確定
  $("button.cust_comfirm").on("click", function () {
    $(".confirm_jump_bg").css("display", "none");
  });

  // 客服按取消
  $("button.no").on("click", function () {
    $(this).siblings("textarea").val("");
    $(this).parent().siblings("section.confirm").find(".btn_support").click();
  });

  /////////////////////評價頁面//////////////////////////

  //按確認
  if (document.getElementsByClassName("comment_yes")[0]) {
    document
      .getElementsByClassName("comment_yes")[0]
      .addEventListener("click", function () {
        document.getElementsByClassName("confirm_jump_bg")[0].style.display =
          "block";
      });
  }

  // 點星星按紐顯示點選星數
  $("p.star_area").on("click", "i", function () {
    $(this).parent().next().val($(this).attr("data-star"));
    $(this)
      .parent()
      .html(star_rating_str_big($(this).attr("data-star")));
  });

  // 產生預覽圖
  $("input.pic").on("change", function (e) {
    // console.log(this.files);
    let pic_preview = e.target.parentNode.nextSibling.nextSibling;
    pic_preview.innerHTML =
      '<div class="spin"><i class="fas fa-spinner fa-pulse"></i></div>';
    for (let i = 0; i < this.files.length && i < 3; i++) {
      let reader = new FileReader();
      reader.readAsDataURL(this.files[i]);
      reader.addEventListener("load", function () {
        let li_html = `<img src="${reader.result}" class="preview"> `;
        pic_preview.insertAdjacentHTML("beforeend", li_html);
        $("div.spin").remove();
      });
    }
  });
  //產生星數字串
  function star_rating_str_big(star_rating) {
    let star_rate = "";
    //把數字變成以0.5為單位，計算多少星星變黃色
    let star_temp = Math.floor(star_rating);
    //計算剩下不變色的星星
    let star_left = 5 - Math.ceil(star_temp);
    let i = 1;
    //做星星html的顯示字串
    for (star_temp; star_temp > 0; star_temp--) {
      star_rate += `<i class="fas fa-star" data-star='${i++}'"></i> `;
    }
    for (star_left; star_left > 0; star_left--) {
      star_rate += `<i class="far fa-star" data-star='${i++}'"></i> `;
    }
    return star_rate;
  }

  // 退換貨頁面產生預覽圖
  // 產生預覽圖
  $("input[name='reex_upload']").on("change", function (e) {
    console.log(this.files);
    let pic_preview = e.target.parentNode.nextSibling.nextSibling;
    pic_preview.innerHTML =
      '<div class="spin"><i class="fas fa-spinner fa-pulse"></i></div>';

    let reader = new FileReader();
    reader.readAsDataURL(this.files[0]);
    reader.addEventListener("load", function () {
      let li_html = `<img src="${reader.result}" class="preview"> `;
      pic_preview.insertAdjacentHTML("beforeend", li_html);
      $("div.spin").remove();
    });
  });
});

//商品收藏按紐-商品詳細頁面
$("button#heart").on("click", function () {
  let prod_id = $(this).attr("data-id");
  if ($(this).children().hasClass("fas")) {
    $(this).children().addClass("far");
    $(this).children().removeClass("fas");

    
    let snedData = {
      type: "remove",
      prodid: prod_id,
    };

    $.ajax({
      url: "http://localhost:8081/FFF/FavProdServlet",
      type: "GET",
      data: snedData,
      dataType: "text",
      success: function (data) {
        console.log(data);
      },
    });
  } else {
    
    let snedData = {
      type: "add",
      userid: 1,
      prodid: prod_id,
    };
    $.ajax({
      url: "http://localhost:8081/FFF/FavProdServlet",
      type: "GET",
      data: snedData,
      dataType: "text",
      success: function (data) {
    	  if(data=="未登入") {
    		  $("div.add_to_cart_alert").text("請先登入!");
    		  $("div.add_to_cart_alert").stop(true, false).fadeIn();
              $("div.add_to_cart_alert").delay(2000).fadeOut();
    	  } else{
    		  $(this).children().addClass("fas");
    		  $(this).children().removeClass("far");
    	  }
        console.log(data);
      },
    });
  }
});

// 商品收藏案紐-商品瀏覽頁面
function add_heart_btn(e) {
  let heart = document.getElementsByClassName("heart_btn");
  for (let i = 0; i < heart.length; i++) {
    heart[i].addEventListener("click", function (e) {
      e.stopImmediatePropagation();
      let fav_btn = e.target;
      let index=$(fav_btn).next().next().attr("href").lastIndexOf("=");
      let prodid = $(fav_btn).next().next().attr("href").substring(index+1);
      //移除收藏
      if (fav_btn.classList.contains("fas")) {
        fav_btn.classList.add("far");
        fav_btn.classList.remove("fas");
        fav_btn.nextSibling.nextSibling.textContent = "已取消收藏 ！";

        setTimeout(function () {
          fav_btn.nextSibling.nextSibling.textContent = "加入收藏";
        }, 2000);

        let snedData = {
          type: "remove",
          prodid: prodid,
        };

        $.ajax({
          url: "http://localhost:8081/FFF/FavProdServlet",
          type: "GET",
          data: snedData,
          dataType: "text",
          success: function (data) {
        	 
            console.log(data);
          },
        });
      } else { //加入收藏
        

        let snedData = {
          type: "add",
          userid: 1,
          prodid: prodid,
        };

        $.ajax({
          url: "http://localhost:8081/FFF/FavProdServlet",
          type: "GET",
          data: snedData,
          dataType: "text",
          success: function (data) {
        	  if(data == "未登入"){
        		  fav_btn.nextSibling.nextSibling.textContent = "請先登入 ！";

                  setTimeout(function () {
                    fav_btn.nextSibling.nextSibling.textContent = "加入收藏";
                  }, 2000);
        		  
        		 
        	  }else{
        		  fav_btn.classList.add("fas");
                  fav_btn.classList.remove("far");
                  fav_btn.nextSibling.nextSibling.textContent = "已加入收藏 ！";

                  setTimeout(function () {
                    fav_btn.nextSibling.nextSibling.textContent = "取消收藏";
                  }, 2000);
            	  
        	  }
        	  
            console.log(data);
          },
        });
      }
    });
  }

// 加入購物車
$("button#addCart").on("click", function (e) {
  
  e.stopImmediatePropagation();
  let spec = $("select.index_spec option:selected").val();
  let num = $("input[name='prod_num']").val();
  let obj = {
    type: "add",
    specid: spec,
    num: num,
  };
  $.ajax({
    url: "http://localhost:8081/FFF/ProdToCartServlet",
    type: "GET",
    dataType: "text",
    data: obj,
    success: function (data) {
      console.log(data);
      
      if(data=="未登入"){
    	  $("div.add_to_cart_alert").text("請先登入!");
        console.log("XXX");
      } else{
    	  $("div.add_to_cart_alert").text("成功加入購物車!");
    	  update_preview_cart();
      }
      
      $("div.add_to_cart_alert").fadeIn();
      $("div.add_to_cart_alert").delay(2000).fadeOut();
      
      
      
    },
  });
});






}

//產生星數字串
function star_rating_str_reg(star_rating) {
  let star_rate = "";
  //把數字變成以0.5為單位，計算多少星星變黃色
  let star_temp = Math.floor(star_rating);
  //計算剩下不變色的星星
  let star_left = 5 - Math.ceil(star_temp);
  let i = 1;
  //做星星html的顯示字串
  for (star_temp; star_temp > 0; star_temp--) {
      star_rate += `<i class="fas fa-star fa-xs" data-star='${i++}'"></i> `;
  }
  for (star_left; star_left > 0; star_left--) {
      star_rate += `<i class="far fa-star fa-xs" data-star='${i++}'"></i> `;
  }
  return star_rate;
}



//購物說明頁面
$("article.explanation h2").on("click", function () {
  $(this).next().slideToggle();
});

function update_preview_cart(){
  $.ajax({
    url: "http://localhost:8081/FFF/HeaderShowCartServlet", 
    type: "GET",                 
    dataType: "json",             
    success: function(data){
      if(data.length !=0){
        let str = '<a class="cart" href="/FFF/ShowCartServlet"><button class="cart"><i class="fas fa-shopping-cart"></i>購物車</button></a>';
        str += '<div class="cart_preview">'+'<div class="info row align-items-center">購物車預覽 </div>';
  
        for(let i=0; i<data.length; i++){
          str+=`<div class="row align-items-center justify-content-around">
                    <img class="col-3" src="${data[i]["img1"]}" alt=""/>
                    <p class="col-6">${data[i]["prod_name"]}</p>
                    <p class="col-3">$${data[i]["price"]}</p>
                </div> `;
        }
        str+="</div>";
        $("div.cart_preview_div").html(str);
      }

    }
  });
}
