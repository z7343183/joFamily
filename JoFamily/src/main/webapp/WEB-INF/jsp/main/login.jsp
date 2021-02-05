<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MY HOME LOGIN</title>

<link href="css/login.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/showLoading.css" charset="UTF-8" />
<script src="vendor/jquery/jquery.min.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/jquery.showLoading.js"></script>
<script src="js/common.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){
		
		var id = getCookie("id");
		var pw = getCookie("pw");
		$('#Username').val(id);
		$('#Password').val(pw);
		$('#Password').trigger('focus');
		$('#Username').trigger('focus');
		$(document).bind('keyup', function(e){
			if(e.keyCode == 13 ){
				login();
			}
		})
		
		$('#remember').change(function(){
			if($(this).is(':checked') == false){
				deleteCookie("id"); //삭제
				deleteCookie("pw"); //삭제
			}
		});
		
		
		
	})
	
	function login(){
		
		var bar = new loadingBar("cont");
		var name = $('#Username').val();
		var pass = $('#Password').val();			
		if(name == "" || pass == ""){
			return;
		}else{
			bar.start();
			$.ajax({
				type        : "POST",
	 			url :  "<%=request.getContextPath()%>/loginCheck.do",
	 			data : {id : name, pw : pass },
	 			success : function(data){	 				
	 				
	 				if(data.result == 'success'){
	 				   		// 쿠키 생성
	 				   		if($('#remember').is(':checked')){
	 				   			setCookie("id",	   name, 365*24*60*60); //1년
	 				   		    setCookie("pw",    pass, 365*24*60*60); //1년
	 				   		}
	 					  $(location).attr('href',  "<%=request.getContextPath()%>/main.do");
	 				}else{	 					
	 					bar.end();
	 					alert("잘못된 로그인 정보입니다. 다시 확인해 주세요.");
	 				}
	 				
	 			},
	 			error : function(request, status, error){
	 				bar.end();
	 				alert("오류가 발생하였습니다.");
	 			}
 			}); 
				
		}
	}	
	function setCookie(cName, cValue, cDay){
         var expire = new Date();
         expire.setDate(expire.getDate() + cDay);
         cookies = cName + '=' + escape(cValue) + '; path=/ '; 
         if(typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
         document.cookie = cookies;
    }
    function getCookie(cName) {
        cName = cName + '=';
        var cookieData = document.cookie;
        var start = cookieData.indexOf(cName);
        var cValue = '';
        if(start != -1){
             start += cName.length;
             var end = cookieData.indexOf(';', start);
             if(end == -1)end = cookieData.length;
             cValue = cookieData.substring(start, end);
        }
        return unescape(cValue);
   }
    
    function deleteCookie( cookieName )
    {
     var expireDate = new Date();
     //어제 날짜를 쿠키 소멸 날짜로 설정한다.
     expireDate.setDate( expireDate.getDate() - 1 );
     document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString() + "; path=/";
    }   
</script>

</head>
<body  >

<div class="container">
	<div class="row">
<!-- Mixins-->
<!-- Pen Title-->
<div class="pen-title">
  <br/><br/><br/><br/>
</div>
<div class="container">
  <div class="card"></div>
  <div class="card" id="cont" >
    <h1 class="title">Login</h1>
    	
      <div class="input-container">
      	<input type="hidden" id="fc"/>
        <input type="text"  id="Username" required="required"/>
        <label for="Username">Username</label>
        <div class="bar"></div>
      </div>            
      <div class="input-container">
        <input type="password" autocomplete="new-password" id="Password" required="required"/>
        <label for="Password">Password</label>
        <div class="bar"></div>
      </div>
      <div   style="margin-left: 52px;margin-bottom: 50px;font-size: 18px;"><label><input id="remember" type="checkbox" checked="checked"/>Remember me</div></label>       
      <div class="button-container">
        <button id ="loginBtn" OnClick="return login()" ><span>Go</span></button>
      </div>
   		<div>
  </div>
  <!-- 
  <div class="card alt">
    <div class="toggle"></div>
    <h1 class="title">Register
      <div class="close"></div>
    </h1>
    <form>
      <div class="input-container">
        <input type="text" id="Username" required="required"/>
        <label for="Username">Username</label>
        <div class="bar"></div>
      </div>
      <div class="input-container">
        <input type="password" id="Password" required="required"/>
        <label for="Password">Password</label>
        <div class="bar"></div>
      </div>
      <div class="input-container">
        <input type="password" id="Repeat Password" required="required"/>
        <label for="Repeat Password">Repeat Password</label>
        <div class="bar"></div>
      </div>
      <div class="button-container">
        <button><span>Next</span></button>
      </div>
    </form>
  </div>-->
</div>
	</div>
</div>

</body>

</html>




