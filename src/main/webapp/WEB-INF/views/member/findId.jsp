<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	
<!--===============================================================================================-->
<!--
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
		
	    #findId {
        background: url( "/resources/images/common/cat2.png" ) no-repeat;
        border: none;
        width: 80px;
        height: 80px;
        background-size: contain;
        cursor: pointer;
        line-height:200%;
        color:black;
        margin-top:100px;
      }
      
	</style>	
	
	<script>
		$(function() {
			$("#findId").click(function() {
				$("#findIdForm").attr({
					action : "/member/searchPhone",
					method : "post"
				})
				
				$("#findIdForm").submit();
			})
			
		})
	</script>
	</head>
	<body>
	<header class="item header margin-top-0">
      <div class="wrapper">
            <div class="container">
               <div class="row">
                  <div class="col-md-12 text-center">
                     <div class="text-pageheader">
                           <div class="subtext-image" data-scrollreveal="enter bottom over 1.7s after 0.0s">
                            Forgot Id?
                               <br/><br/><br/><br/>
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
				<form id="findIdForm" class="login100-form validate-form">
					<span class="login100-form-title p-b-43">
						<!--  
						Login to continue
						-->
						아이디 찾기
					</span>
					
					<div class="wrap-input100 validate-input" data-validate = "이름을 정확히 입력해주세요">
						<input class="input100" type="text" id="user_name" name="user_name">
						<span class="focus-input100"></span>
						<span class="label-input100">이름</span>
					</div>
					
					
					<div class="wrap-input100 validate-input" data-validate="핸드폰번호를 정확히 입력해주세요">
						<input class="input100" type="text" id="user_phone" name="user_phone">
						<span class="focus-input100"></span>
						<span class="label-input100">핸드폰번호</span>
						<!-- <i class="fa fa-eye fa-lg"></i> -->
					</div>
			
					<div class="text-right">
						<a href="/member/findPw" class="txt1">
								비밀번호 찾기
						</a>
					</div>
					
					<div class="container-login100-form-btn">
						<button class="login100-form-btn" id="findId">
							<br/><br/><br/><br/>찾기
						<!-- <img src="/resources/images/common/btn.png" alt=""> -->
						</button>
					</div>
					
				</form>
				</fieldset>

				<!-- <div class="login100-more" style="background-image: url('images/bg-01.jpg');">
				</div> -->
			</div>
		</div>
	</div>
</div>
		
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