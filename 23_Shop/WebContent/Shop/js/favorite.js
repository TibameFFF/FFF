//取得user收藏商品
$.ajax({
  url: "http://localhost:8081/FFF/ProdToIndex?type=favProd",
  type: "GET",
  dataType: "json",
  success: function (data) {
    if (data["result"]) {
      let empty = "<h3>目前沒有收藏的商品，快去看看商品吧!!</h3>";
      $("section#product_display").append(empty);
      return;
    }

    $("p#total_product_num").text(data.length + "項商品");
    
    for (let i = 0; i < data.length; i++) {
      let str = `<div class="product">
                                        <i class="fas fa-heart fa-lg heart_btn"></i>
                                        <div class="heart_tag">取消收藏</div>
                                        <a href="http://localhost:8081/FFF/ShowEachProd?prodID=${data[i]["prod_id"]}">`;
      //判斷是否有兩張圖
      if (data[i]["img2"]) {
        str += `<img src="http://localhost:8081/${data[i]["img1"]}" alt="product pictures"
                                                data-img1="http://localhost:8081/${data[i]["img1"]}" data-img2="http://localhost:8081/${data[i]["img2"]}">`;
      } else {
        str += `<img src="http://localhost:8081/${data[i]["img1"]}" alt="product pictures">`;
      }

      str += `<p>${data[i]["prod_name"]}</p>
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
        str += `<div>${star_rating_str_reg(data[i]["star"])}</div></div></div>`;
      } else {
        `<div></div></div></div>`;
      }

      $("section#product_display").append(str);
    }

    add_heart_btn();
  },
});

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
