<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title></title>
  <link rel="shortcut icon" href="resources/fc/images/icon/favicon.ico">
  <!--[if lt IE 9]>
   <script src="plug-in/login/js/html5.js"></script>
  <![endif]-->
  <!--[if lt IE 7]>
  <script src="plug-in/login/js/iepng.js" type="text/javascript"></script>
  <script type="text/javascript">
	EvPNG.fix('div, ul, img, li, input'); //EvPNG.fix('包含透明PNG图片的标签'); 多个标签之间用英文逗号隔开。
</script>
  <![endif]-->
  <link href="plug-in/login/css/zice.style.css" rel="stylesheet" type="text/css" />
  <link href="plug-in/login/css/buttons.css" rel="stylesheet" type="text/css" />
  <link href="plug-in/login/css/icon.css" rel="stylesheet" type="text/css" />
  <link rel="stylesheet" type="text/css" href="plug-in/login/css/tipsy.css" media="all" />
  <style type="text/css">
html {
	background-image: none;
}

label.iPhoneCheckLabelOn span {
	padding-left: 0px
}

#versionBar {
	background-color: #212121;
	position: fixed;
	width: 100%;
	height: 35px;
	bottom: 0;
	left: 0;
	text-align: center;
	line-height: 35px;
	z-index: 11;
	-webkit-box-shadow: black 0px 10px 10px -10px inset;
	-moz-box-shadow: black 0px 10px 10px -10px inset;
	box-shadow: black 0px 10px 10px -10px inset;
}

.copyright {
	text-align: center;
	font-size: 10px;
	color: #CCC;
}

.copyright a {
	color: #A31F1A;
	text-decoration: none
}

#login .logo {
	width: 500px;
	height: 51px;
}
</style>

 </head>
 <body>
  <div id="alertMessage"></div>
  <div id="successLogin"></div>
  <div class="text_success">
   <img src="plug-in/login/images/loader_green.gif" alt="Please wait" />
   <span>注册成功!请稍后....</span>
  </div>
  <div id="login" style="height:350px;">
   <div class="ribbon" style="background-image:url(plug-in/login/images/typelogin.png);"></div>
   <div class="inner" style="height:350px;">
    <div class="logo">
     <!-- <img src="plug-in/login/images/toplogo-jeecg.png"/> -->
     <img src="plug-in/login/images/logo.jpg" height="59px"/>
    </div>
    <div class="formLogin">
    
     <form name="formLogin" id="formLogin" action="loginController.do?login" check="userController.do?checkregist" method="post">
      <input name="userKey" type="hidden" id="userKey" value="CommonUserRegistration"/>
      <div class="tip">
       <input class="userName" name="userName" type="text" id="userName" title="用户名(邮箱地址)" iscookie="true" nullmsg="请输入用户名!" />
      </div>
      <div class="tip">
       <input class="userName" name="realName" type="text" id="realName" title="真实姓名" iscookie="true" nullmsg="请输入真实姓名!"/>
      </div>
      <div class="tip">
       <input class="password" name="password" type="password" id="password" title="密码" nullmsg="请输入密码!"/>
      </div>
       <div class="tip">
       <input class="password" name="newpassword" type="password" id="newpassword" title="重复密码" nullmsg="请再输入密码!"/>
      </div>
      <div class="loginButton">
       
       
       <div style="float: right; padding: 3px 0; margin-right: -12px;">
        <div>
         <ul class="uibutton-group">
          <li>
           <a class="uibutton normal" href="#" id="but_login">注册</a>
          </li>
          <li>
           <a class="uibutton normal" href="loginController.do?login"  >返回</a>
          </li>
         </ul>
        </div>
        <div style="float: left; margin-left: 30px;">
       <a href="userController.do?resetPasswd"><span class="f_help">忘记密码</span></a>
       </div>
       </div>
       <div class="clear"></div>
      </div>
     </form>
    </div>
   </div>
   <div class="shadow"></div>
  </div>
  <!--Login div-->
  <div class="clear"></div>
  <div id="versionBar">
   <div class="copyright">
    &copy; 版权所有
    <span class="tip">Copyright© 1999-2013     E-TRACK   版权所有</span>
   </div>
  </div>
    <!-- Link JScript-->
  <script type="text/javascript" src="plug-in/jquery/jquery-1.8.3.min.js"></script>
  <script type="text/javascript" src="plug-in/jquery/jquery.cookie.js"></script>
  <script type="text/javascript" src="plug-in/login/js/jquery-jrumble.js"></script>
  <script type="text/javascript" src="plug-in/login/js/jquery.tipsy.js"></script>
  <script type="text/javascript" src="plug-in/login/js/iphone.check.js"></script>
  <script type="text/javascript" src="plug-in/login/js/login.js"></script>
 </body>
</html>