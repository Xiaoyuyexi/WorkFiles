$(document).ready(function(){
	//����table�б���ɫ
	$(".tbl-list tr").mouseover(function(){
		$(this).addClass("over");
	});
	$(".tbl-list tr").mouseout(function(){
		$(this).removeClass("over");
	});
	
	//���Ƶ�����ϵ�˵ı���ɫ
	$(".lbox-r li").mouseover(function(){
		$(this).addClass("li_over");
	});
	$(".lbox-r li").mouseout(function(){
		$(this).removeClass("li_over");
	});
	
	//���Ƶ�����ϵ�˵ı���ɫ
	$(".user-box dt,.user-box dd,.user-selected li").mouseover(function(){
		$(this).addClass("over");
	});
	$(".user-box dt,.user-box dd,.user-selected li").mouseout(function(){
		$(this).removeClass("over");
	});
	
	//�۵�չ���л�Ч��
	$(".user-box dt").click(function(){
		$(this).parent().toggleClass("show-dd");
	});
});