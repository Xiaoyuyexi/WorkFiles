$(document).ready(function(){
	//���Ƶ����Ӳ˵�����
	$(".block-imglist li").mouseover(function(){
		$(this).addClass("li_over");
	});
	$(".block-imglist li").mouseout(function(){
		$(this).removeClass("li_over");
	});
	
	$(".lbox-r li").mouseover(function(){
		$(this).addClass("li_over");
	});
	$(".lbox-r li").mouseout(function(){
		$(this).removeClass("li_over");
	});
});