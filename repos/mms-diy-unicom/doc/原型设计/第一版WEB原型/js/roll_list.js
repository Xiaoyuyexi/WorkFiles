
/*�����б���*/
	function RollList(obj,config){
		var _this = this;//������������
		/*��������*/
		var ctrl1 = ".ctrl1";
		var ctrl2 = ".ctrl2";
		var m1=m2=mt=0;
		var everywidth,totalLength,margins,step,showLength,objIn,autotime,gunauto;
		var state=true;
		this.obj;
		this.towards;
		this.events;
		this.animation;
		this.time;
		this.autoplay;
		/*���캯��*/
		var init = (function(){
			/*��ʼ��*/
			_this.obj=$(obj);
			objIn = config.objIn || "li";
			var _obj=(config.objIn!=null)?_this.obj.find(config.objIn).eq(0):_this.obj.find("ul,dl,li,dd,div,p").eq(0);
			var _omt=Number($(_obj).css("margin-top").split("px")[0]);
			var _omb=Number($(_obj).css("margin-bottom").split("px")[0]);
			var _oml=Number($(_obj).css("margin-left").split("px")[0]);
			var _omr=Number($(_obj).css("margin-right").split("px")[0]);
			var _opt=Number($(_obj).css("padding-top").split("px")[0]);
			var _opb=Number($(_obj).css("padding-bottom").split("px")[0]);
			var _opl=Number($(_obj).css("padding-left").split("px")[0]);
			var _opr=Number($(_obj).css("padding-right").split("px")[0]);
			step = config.step || 50;
			_this.towards=config.towards || 4;
			_this.events= config.events || "click";
			_this.animation = config.animation || true;
			everywidth=config.everywidth || null;
			switch(_this.towards)//1��2��3��4��
			{
				/*����*/
				case 1: case 3: break;
				/*����*/
				case 2: case 4: break;
			}
			ctrl1 = config.ctrl1 || obj+" .ctrl1";
			ctrl2 = config.ctrl2 || obj+" .ctrl2";
			
			$(ctrl1).bind(_this.events,function(){run(Number(everywidth))}).bind("dblclick",function(){ return false;});
			$(ctrl2).bind(_this.events,function(){run(-Number(everywidth))}).bind("dblclick",function(){ return false;});
			
			$(_this.obj).find(objIn).clone().appendTo(_this.obj);
			/*auto*/
			if(config.auto==true){
				_this.time= config.time || 2000;
				gunauto=function (){
					autotime = window.setInterval(function(){
						run(-step);
					},_this.time);
				};
				gunauto();
				$(_this.obj).hover(function(){ clearInterval(autotime);},function(){gunauto();});//������ͼƬ��ͣ����
			}
		})();
		/**/
		/*��������*/
		var run =function(s){
			
			switch(_this.towards)
			{
				case 1: case 3:
				
				case 2: case 4:roll_l(s); break;	
			}
			
		}
		var roll_l = function(s){
			
			var _move;
			if(s<0)
			{
				//if(mt+s>-2*everywidth){
					//����
					//mt+=s;
//					$(_this.obj).stop().animate({marginLeft:mt+"px"},"slow","easeOutBack",function(){
//						if(mt<=-everywidth)
//						{
//							mt%=everywidth;
//							$(_this.obj).css({"margin-left":mt+"px"});
//							//���е�һ�������
//							_move = $(_this.obj).find(objIn).first();
//							$(_this.obj).find(objIn).first().remove();
//							$(_this.obj).append(_move);
//						}
//					});
				//}
				
				if(mt<=-everywidth)
				{
					//�������һ������һ
					mt%=everywidth;
					$(_this.obj).css({"margin-left":mt+"px"});
					//���е�һ�������
					_move = $(_this.obj).find(objIn).first();
					$(_this.obj).find(objIn).first().remove();
					$(_this.obj).append(_move);
				}
				mt+=s;
				$(_this.obj).stop().animate({marginLeft:mt+"px"},"slow")
				
				
			}
			else{
				//����
				if(mt+s>=0)
				{
					//�������һ������һ
					_move = $(_this.obj).find(objIn).last();
					$(_this.obj).find(objIn).last().remove();
					$(_this.obj).prepend(_move);
					mt-=everywidth;
					$(_this.obj).css({"margin-left":mt+"px"});
				}
				mt+=s;
				$(_this.obj).stop().animate({marginLeft:mt+"px"},"slow")
			}
		}
		
		
	}