<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	
<!--===============================================================================================
	<link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css"> 메뉴 오른쪽-->
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/resources/include/Login_v18/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/resources/include/Login_v18/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/resources/include/Login_v18/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="/resources/include/Login_v18/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/resources/include/Login_v18/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/resources/include/Login_v18/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="/resources/include/Login_v18/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/resources/include/Login_v18/css/util.css">
	<link rel="stylesheet" type="text/css" href="/resources/include/Login_v18/css/main.css"> <!-- 로그인폼 오른쪽 -->
<!--===============================================================================================-->
<style>
		fieldset {
		  /* 
		  background-color: yellow;
		  */
		  margin: auto;
		  border: 1px solid lightgray; 
		  /* 
		  box-shadow: 10px 10px 5px #F1ECF0;
		  */
		}
		
	    #loginBtn {
        background: url( "/resources/images/common/btn.png" ) no-repeat;
        border: none;
        width: 80px;
        height: 80px;
        background-size: contain;
        cursor: pointer;
        line-height:200%;
        color:black;
      }
      
      #loginWarn {
      	text-align:center;
      	color:#c80000;
      }
    	.form-social{
    		text-align:center;
    	}
		
		.form-social {
			margin-bottom : 5px;
		}
      
	</style>
		<script>
			$(function() {
			    $("#loginBtn").click(function(){
			        
			    	//alert("로그인 버튼 작동");
			    	
			    	/* 로그인 메서드 서버 요청 */
			        $("#loginForm").attr({
			        	"method" : "post",
			        	"action": "/member/login"
			        });
			        $("#loginForm").submit();
			        
			    });
			})
		</script>
	<title>Insert title here</title>
</head>
<body>
	<header class="item header margin-top-0">
      <div class="wrapper">
            <div class="container">
               <div class="row">
                  <div class="col-md-12 text-center">
                     <div class="text-pageheader">
                           <div class="subtext-image" data-scrollreveal="enter bottom over 1.7s after 0.0s">
                            LOGIN
                           </div>
                     </div>
                  </div>
               </div>
            </div>
      </div>
   </header>
   <div class="container toparea">
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100">
				<fieldset>
				<form id="loginForm" class="login100-form validate-form">
					<span class="login100-form-title p-b-43">
						<!--  
						Login to continue
						-->
						PETCATION
					</span>
					
					<div class="wrap-input100 validate-input" data-validate = "아이디를 정확히 입력해주세요">
						<input class="input100" type="text" name="user_id">
						<span class="focus-input100"></span>
						<span class="label-input100">아이디</span>
					</div>
					
					<div class="wrap-input100 validate-input" data-validate="비밀번호를 정확히 입력해주세요">
						<input class="input100" type="password" name="user_pw">
						<span class="focus-input100"></span>
						<span class="label-input100">비밀번호</span>
						<!-- <i class="fa fa-eye fa-lg"></i> -->
					</div>
					
					<div class="flex-sb-m w-full p-t-3 p-b-32">
						<div>
							<a href="/member/findId" class="txt1">
								아이디/비밀번호 찾기
							</a>
							
						</div>
						
						<div>
							<a href="/member/join" class="txt1">
								회원가입
							</a>
						</div>
					</div>
			
						<c:if test = "${result == 0 }">
	                		<div id="loginWarn">아이디 또는 비밀번호를 잘못 입력하셨습니다.</div>
	            		</c:if>
					<br/>
					
					<div class="container-login100-form-btn">
						<button class="login100-form-btn" id="loginBtn">
							<br/><br/><br/><br/>로그인
						</button>
					</div>
					
					<div class="text-center p-t-46 p-b-20">
						<span class="txt2">
							or sign up using
						</span>
					</div>

					<div class="form-social-wrap">
						<div class="form-social">
							<div id="kakao_id_login" style="text-align: center">
			                     <a href="${kakao_url}">
			                     <img src="/resources/images/common/kakao_login.png" style="height:46px; width:190px;" /></a>
      					  	</div>
						</div>
						<div class="form-social">
							<div id="naver_id_login" style="text-align: center">
			                     <a href="${naver_url}">
			                     <img src="/resources/images/common/naver_login.png" style="height:45px; width:189px;" /></a>
      					  	</div>
						</div>	
						<!-- 
						<div class="form-social">
							<div id="googleLogin" style="cursor: pointer">
									<img id="googleLogin" src="/resources/images/common/google_login.png" style="height:45px; width:183px;">
							</div>
						</div>
						 -->
					</div>
				</form>
				</fieldset>
				<!-- <div class="login100-more" style="background-image: url('images/bg-01.jpg');">
				</div> -->
			</div>
		</div>
	</div>
</div>
</html>	


	
	
<!--===============================================================================================-->
	<script src="/resources/include/Login_v18/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="/resources/include/Login_v18/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="/resources/include/Login_v18/vendor/bootstrap/js/popper.js"></script>
	<script src="/resources/include/Login_v18/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="/resources/include/Login_v18/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="/resources/include/Login_v18/vendor/daterangepicker/moment.min.js"></script>
	<script src="/resources/include/Login_v18/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="/resources/include/Login_v18/vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="/resources/include/Login_v18/js/main.js"></script>

</body>
</html>