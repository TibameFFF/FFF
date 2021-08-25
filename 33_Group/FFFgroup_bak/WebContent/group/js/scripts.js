/*!
* Start Bootstrap - Modern Business v5.0.3 (https://startbootstrap.com/template-overviews/modern-business)
* Copyright 2013-2021 Start Bootstrap
* Licensed under MIT (https://github.com/StartBootstrap/startbootstrap-modern-business/blob/master/LICENSE)
*/
// This file is intentionally blank
// Use this file to add JavaScript to your project

var preview_el = document.getElementById("preview");
var p_file_el = document.getElementById("p_file");

var preview_img = function(file){
    var img_node = document.createElement("img");
    var reader = new FileReader(); // 用來讀取檔案
    reader.addEventListener("load", function () {
      //console.log(reader.result);
      let img_node = document.createElement("img");
      img_node.setAttribute("src", reader.result); // <img src="abdafaewre">
      img_node.setAttribute("class", "preview_img"); // <img src="abdafaewre" class="preview_img">
      preview_el.innerHTML = '';
      preview_el.append(img_node);
    });
    reader.readAsDataURL(file); // 讀取檔案
  };

  p_file_el.addEventListener("change", function(e){
    if(this.files.length > 0){
      preview_img(this.files[0]);
    }else{
      preview_el.innerHTML = '<span class="text">預覽圖</span>';
    }
  });