
$(document).ready(function(){

    
    let obj={
        "prod_id":$("section.product_info").attr("id")
    }

    $.ajax({
        url: "http://localhost:8081/FFF/ShowCommentServlet",           // 資料請求的網址
        type: "GET",                  
        data: obj,              
        dataType: "json",            
        success: function(data){     
          console.log(data);

          //設定清單
          let comment_1star = [];
          let comment_2star = [];
          let comment_3star = [];
          let comment_4star = [];
          let comment_5star = [];
          let comment_total = comment_listAll.length;
          let page_num = 0;
          let current_page = 1;
          for (comment in data) {
              console.log(comment);
            switch (comment_listAll[i]["star_rate"]) {
                case 1:
                    comment_1star.push(comment_listAll[i]);
                    break;
                case 2:
                    comment_2star.push(comment_listAll[i]);
                    break;
                case 3:
                    comment_3star.push(comment_listAll[i]);
                    break;
                case 4:
                    comment_4star.push(comment_listAll[i]);
                    break;
                case 5:
                    comment_5star.push(comment_listAll[i]);
                    break;
            }
        }

          





















        }
      });

});