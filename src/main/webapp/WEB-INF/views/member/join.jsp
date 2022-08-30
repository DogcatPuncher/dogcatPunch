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
		
	    #joinBtn {
        background: url( "/resources/images/common/samo.png" ) no-repeat;
        border: none;
        width: 80px;
        height: 80px;
        background-size: contain;
        cursor: pointer;
        line-height:210%;
        color:black;
        margin-top:50px;
      }
      
	    #emailAuth {
        background: url( "/resources/images/common/pa.png" ) no-repeat;
        border: none;
        width: 80px;
        height: 75px;
        background-size: contain;
        cursor: pointer;
        line-height:190%;
        color:black;
      }
      
      #loginWarn {
      	text-align:center;
      	color:#c80000;
      }
      
    .shorten { height:70px;}
      
    .spanF {
		  font-size: 15px;
		  color: #2b2a2a;
		  margin-right : 20px;

	} 
	
	.shortenW {
		width : 370px;
		float : left;
	}
	
	.shortenWb {
		width : 80px;
		float : left;
	}
	
 	.emailNum{
    background-color :#f5f5f2;
	} 
	
	.terms_wrap{
		text-align : center;
	}
	
	.inline {
		display : inline;
	}

		</style>
		
		<script>
		
		let code = "";
		
		 /* 유효성 검사 통과유무 변수 */
		 let idCheck = false;            // 아이디
		 //let idckCheck = false;            // 아이디 중복 검사
		 let pwCheck = false;            // 비번
		 let pwckCheck = false;            // 비번 확인
		 let nameCheck = false;            // 이름
		 let phoneCheck = false;            // 이름
		 let mailCheck = false;            // 이메일
		 let mailnumCheck = false;        // 이메일 인증번호 확인
		 let existEmail= false;

			$(function(){
				//회원가입 버튼(회원가입 기능 작동)
				$("#joinBtn").click(function(){
			       
			       if(idCheck && pwCheck && pwckCheck && nameCheck && mailCheck && phoneCheck && mailnumCheck) {
								
			    	   	if(!$("input:checkbox[name='terms']").is(":checked")) {
							 alert("약관 동의가 필요합니다.");
							 return;
						 }

						$("#joinForm").attr({
							method : "post",
							action : "/member/join"
						});
						
						$("#joinForm").submit();
			        } else {
						alert("ᐡ ・ ﻌ ・ ᐡ 양식을 제대로 입력해주세요");
			        }
				})
				
				 
				/* 인증번호 이메일 전송 */
				$("#emailAuth").click(function(){
				    
					var email = $("#user_email").val();            // 입력한 이메일
				    var checkBox = $("#emailNum");        // 인증번호 입력란
				    var boxWrap = $(".emailNum");    // 인증번호 입력란 박스
				    
				    if(existEmail) {
				    	
				    	alert("ฅ(´-ω-`)ฅ 이미 가입된 이메일입니다.");
				    	
				    } else if(!mailCheck) {
				    	
				    	alert("ฅ(´-ω-`)ฅ 올바른 형식으로 입력해주세요.");
				    	
				    } else {
				    	
					    $.ajax({
					        
					        type:"GET",
					        url:"mailCheck?email=" + email,
					        success:function(data){
					            
					        	alert("▼・ᴥ・▼ 인증번호를 발송했습니다.\n메일이 오지 않으면 입력하신 정보를 다시 확인해주세요.");
					            //console.log("data : " + data);
					            checkBox.attr("disabled",false);
					            boxWrap.css("background-color", "white");
					        	checkBox.val("");
					            code = data;
					        }
					                
					    });
				    
				    }
				});

	
				//아이디 중복검사
				$("#user_id").on("propertychange change keyup paste input", function(){
					//console.log("keyup 테스트");	
					let memberId = $('#user_id').val();			// user_id에 입력되는 값
					let idSpan = $('#user_id').next();
					let idRxp = /^[a-zA-Z0-9_]{6,11}$/g;
					let data = {user_id : memberId}				// '컨트롤에 넘길 데이터 이름' : '데이터(user_id에 입력되는 값)'
					
					if(!idRxp.test(memberId)) {
						idSpan.html("6~12자의 영문, 숫자, '_'만 사용할 수 있습니다.");
						if(memberId=="") {
							idSpan.html("");
						} else if(memberId.search(/\s/) != -1){
							idSpan.html("공백없이 입력해주세요.");
						} 
					} else {
							$.ajax({
								type : "post",
								url : "/member/memberIdChk",
								data : data,
								success : function(result){
									 //console.log("성공 여부" + result);
									if(result != 'fail'){
										idSpan.html("사용 가능한 아이디입니다.");
										idCheck = true;
									} else {
										idSpan.html("이미 존재하는 아이디입니다.");
									}
								}// success 종료
							}); // ajax 종료	
					}
				}); 
				
				$("#user_pw").on("propertychange change keyup paste input", function(){
					let memberPw = $("#user_pw").val();
					let pwSpan = $('#user_pw').next();
					
					let num = memberPw.search(/[0-9]/g);
					let eng = memberPw.search(/[A-Z][a-z]/ig);
					let spe = memberPw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
	
					if(memberPw.length < 8 || memberPw.length > 16){
						pwSpan.html("8~16자리 이내로 입력하세요");
					} else if(memberPw.search(/\s/) != -1){
						pwSpan.html("공백없이 입력해주세요.");
					} else if((num < 0 && eng < 0) || (eng < 0 && spe < 0) || (spe < 0 && num < 0)){
						pwSpan.html("영문, 숫자, 특수문자 2가지 이상을 혼합하여 입력하세요");
					} else {
						pwSpan.html("");
						pwCheck = true; 
					}
				});
			
				
				$("#user_pwChk").on("propertychange change keyup paste input", function(){
					let pwChkSpan = $('#user_pwChk').next();
					if($(this).val() != $("#user_pw").val()) {
						pwChkSpan.html("비밀번호가 일치하지 않습니다.");
					} else {
						pwChkSpan.html("비밀번호가 일치합니다.");
						pwckCheck = true;
					}
				});
				
				$("#user_phone").on("propertychange change keyup paste input", function(){
					let phoneSpan = $('#user_phone').next();
					let memberPhone = $('#user_phone').val();
					let data = {user_phone : memberPhone}
					
					phoneRxp = /^(010|011|016|017|018|019)[0-9]{3,4}[0-9]{4}$/g;
					
					if(!phoneRxp.test(memberPhone)) {
						phoneSpan.html("올바른 전화번호를 입력하세요")
					} else {
						
						$.ajax({
							type : "post",
							url : "/member/memberPhoneChk",
							data : data,
							success : function(result){
								 //console.log("성공 여부" + result);
								if(result != 'fail'){
									//phoneSpan.html("사용 가능한 번호입니다.");
									phoneSpan.html("");
									phoneCheck = true;
								} else {
									phoneSpan.html("이미 가입된 번호입니다.");
									existEmail = true;
								}
								
							}// success 종료
							
						}); // ajax 종료	
						
					}
					
				})
				
				$("#user_name").on("propertychange change keyup paste input", function(){
					let nameSpan = $('#user_name').next();

					let nameRxp = /^[가-힝]{2,}$/;
					
					if (!nameRxp.test($('#user_name').val())) {              
						nameSpan.html("이름을 제대로 입력하세요");                               
					} else { 
						nameSpan.html("");
		 				nameCheck = true;
					}
				})

				$("#user_email").on("propertychange change keyup paste input", function(){
					let eRxp = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
					let emailSpan = $('#user_email').next();
					let email = $("#user_email").val();
					let data = {user_email : email};
					mailCheck = false;
					existEmail = false;
					
					if (email == '' || !eRxp.test(email)) {
						emailSpan.html("qwe@asd.zxc 형식으로 입력하세요.")
					} else {
						$.ajax({
							type : "post",
							url : "/member/memberEmailChk",
							data : data,
							success : function(result){
								if(result != 'fail'){
									emailSpan.html("사용 가능한 이메일입니다.");
									emailSpan.html("");
									mailCheck = true;
								} else {
									emailSpan.html("이메일 가입 정보가 존재합니다.");
									existEmail = true;
								}
								
							}// success 종료
							
						}); // ajax 종료	
					}	
				})
				
				/* 인증번호 비교 */
				$("#emailNum").blur(function(){
				    
				    var inputCode = $("#emailNum").val();   // 입력코드    
				    var chkResult = $("#emailNum").next();    // 비교 결과     
				    
				    if(inputCode == code){                            // 일치할 경우
				    	chkResult.html("인증번호가 일치합니다.");
				        mailnumCheck = true;
				    } else {                                            // 일치하지 않을 경우
				    	chkResult.html("인증번호를 다시 확인해주세요.");
				    }    
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
                            JOIN
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
				<form id="joinForm" class="login100-form validate-form">
					<span class="login100-form-title p-b-43">
						<!--  
						Login to continue
							petcation
							96361f77-b
						🐾
						-->
						PETCATION
					</span>
					
					
					<div class="wrap-input100 validate-input shorten" data-validate = "아이디를 정확히 입력해주세요">
						<input class="input100" type="text" id="user_id" name="user_id">
						<span class="focus-input100 text-right spanF"></span>
						<span class="label-input100">아이디</span>
					</div>
					
					
					<div class="wrap-input100 validate-input shorten" data-validate="비밀번호를 정확히 입력해주세요">
						<input class="input100" type="password" id="user_pw" name="user_pw">
						<span class="focus-input100 text-right spanF"></span>
						<span class="label-input100">비밀번호</span>
					</div>

					<div class="wrap-input100 validate-input shorten" data-validate="비밀번호 확인을 정확히 입력해주세요">
						<input class="input100" type="password" id="user_pwChk" name="user_pwChk">
						<span class="focus-input100 text-right spanF"></span>
						<span class="label-input100">비밀번호 확인</span>
					</div>
					
					<div class="wrap-input100 validate-input shorten" data-validate = "이름을 정확히 입력해주세요">
						<input class="input100" type="text" id="user_name" name="user_name">
						<span class="focus-input100 text-right spanF"></span>
						<span class="label-input100">이름</span>
					</div>

					<div class="wrap-input100 validate-input shorten" data-validate = "핸드폰 번호를 정확히 입력해주세요">
						<input class="input100" type="text" id="user_phone" name="user_phone">
						<span class="focus-input100 text-right spanF"></span>
						<span class="label-input100">핸드폰 번호</span>
					</div>

					<div class="wrap-input100 validate-input shorten shortenW" data-validate = "이메일을 정확히 입력해주세요">
						<input class="input100" type="email" id="user_email" name="user_email">
						<span class="focus-input100 text-right spanF"></span>
						<span class="label-input100">이메일</span>
					</div>
					
					<div class="container-login100-form-btn shortenWb">
						<button class="login100-form-btn" id="emailAuth">
							<br/><br/><br/>전송
						</button>
					</div>
					
					<div class="wrap-input100 validate-input shorten emailNum" data-validate = "인증번호를 정확히 입력해주세요">
						<input class="input100" type="text" id="emailNum" name="emailNum" disabled="disabled" maxlength="6">
						<span class="focus-input100 text-right spanF"></span>
						<span class="label-input100">인증번호</span>
					</div>
					
					<div class="terms_wrap">
						<div>
							<label class="inline"><input type="checkbox" id="terms1" name="terms"> [필수] PETCATION 이용약관 동의 </label>
							<a href="javascript:void(window.open('/member/terms1', '약관','width=#, height=#'))">전문 보기</a>
						</div>
						<div>
							<label class="inline"><input type="checkbox" id="terms2" name="terms"> [필수] 개인정보 제3자 제공 동의 </label>
							<a href="javascript:void(window.open('/member/terms2', '약관','width=#, height=#'))">전문 보기</a>
						</div>
					</div>
					
					<div class="container-login100-form-btn">
						<button class="login100-form-btn" id="joinBtn">
							<br/><br/><br/>가입
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
	
</html>