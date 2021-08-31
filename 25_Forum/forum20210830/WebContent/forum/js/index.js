"use strict";

$(function() {
	$("section").css("minHeight", "calc(100vh - ("+$('header').height()+"px + "+$('.navs').height()+"px + "+$('footer').height()+"px + "+$('footer').css("paddingTop")+" + "+$('footer').css("paddingBottom")+"))");
	$("img").css({
		"-webkit-transition": "all .4s",
		"-khtml-transition": "all .4s",
		"-moz-transition": "all .4s",
		"-ms-transition": "all .4s",
		"-o-transition": "all .4s",
		"transition": "all .4s",
	});
});