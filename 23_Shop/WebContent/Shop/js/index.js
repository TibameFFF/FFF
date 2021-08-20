document.addEventListener("DOMContentLoaded", function () {
  ////////////////////商品小卡設定//////////////////////////////

  //商品preview
  $(document).on("click", "div.preview", function (e) {
    // console.log($(this).attr("data-prod"));

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
        // $('.slider-prod-for').slick('unslick');
        // $('.slider-prod-nav').slick('unslick');
        $("div.preview_prod_bg").show();
      }
    });

  });

  $("div.exit").on("click", function () {
    $("div.preview_prod_bg").hide();
  });

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
        .stop()
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
        .stop()
        .animate({ opacity: 0.5 }, 200, function () {
          $(this).attr("src", first_img);
        })
        .animate({ opacity: 1 }, 200);
    }
  });

  //////////////////首頁////////////////////////////

  //RWD篩選跳出
  $("button.filter").on("click", function () {
    $("aside").slideToggle();
  });

  $("article.explanation h2").on("click", function () {
    $(this).next().slideToggle();
  });

  add_heart_btn();

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
        console.log(document.getElementsByClassName("confirm_jump_bg")[0]);
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
    console.log(e.target);
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

//商品收藏按紐-商品詳細頁面未完成!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
$("button#heart").on("click", function () {
  if ($(this).children().hasClass("fas")) {
    $(this).children().addClass("far");
    $(this).children().removeClass("fas");
    let snedData = {
      type: "remove",
      userid: 1,
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
  } else {
    $(this).children().addClass("fas");
    $(this).children().removeClass("far");
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
        console.log(data);
      },
    });
  }
});

// 商品收藏案紐-商品瀏覽頁面
function add_heart_btn(e) {
  let heart = document.getElementsByClassName("heart_btn");
  for (let i = 1; i < heart.length; i++) {
    heart[i].addEventListener("click", function (e) {
      let fav_btn = e.target;
      let prodid = $(fav_btn).next().next().attr("href").slice(1);
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
          userid: 1,
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
      } else {
        //加入收藏
        fav_btn.classList.add("fas");
        fav_btn.classList.remove("far");
        fav_btn.nextSibling.nextSibling.textContent = "已加入收藏 ！";

        setTimeout(function () {
          fav_btn.nextSibling.nextSibling.textContent = "取消收藏";
        }, 2000);

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
            console.log(data);
          },
        });
      }
    });
  }
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