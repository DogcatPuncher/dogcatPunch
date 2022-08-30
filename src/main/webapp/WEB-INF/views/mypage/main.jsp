<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	<style>
		#updateInfoBtn {
	        background: url( "/resources/images/common/updatebtn.png" ) no-repeat;
	        border: none;
	        width: 60px;
	        height: 60px;
	        background-size: contain;
	        cursor: pointer;
	        line-height:200%;
	        color:black;
	        margin-bottom:30px;
	        font-size:60px;
      	}
      	#updateInfoBtn:focus{outline: none; }		
	</style>
   <script type="text/javascript">
      $(function() {
         
         /* 비밀번호 확인 숨김*/
         $("#pwdChk").css("visibility", "hidden");
         
         /* 수정버튼 클릭 시 비밀번호 확인 */
         $("#updateInfoBtn").click(function() {
            $("#pwdChk").css("visibility", "visible");
            $("#msg").text("비밀번호를 입력해주세요.").css("color", "#000099");
         });
         
         /* 비밀번호 입력 시 enter 불가 */
         $("#user_pw").bind("keydown", function(event) {
            if(event.keyCode === 13) {
               event.preventDefault();
            }
         });
         
         /* 비밀번호 확인 버튼 클릭 시 */
         $("#pwdBut").click(function() {
            //console.log("keyup 테스트");
            //mypagePwdConfirm();
            
            let memberPw = $('#user_pw').val();         // user_pw에 입력되는 값
            pwSpan = $('#msg');
            let data = {user_pw : memberPw}            // '컨트롤에 넘길 데이터 이름' : '데이터(user_pw에 입력되는 값)'

               $.ajax({
                  type : "post",
                  url : "/mypage/pwdCheck",
                  data : data,
                  success : function(result){
                      //console.log("일치 여부" + result);
                     if(result == 'success'){
                        location.href="/mypage/updateInfoForm";
                     } else {
                        pwSpan.html("비밀번호가 일치하지 않습니다.");
                     }                        
                  }// success 종료
               }); // ajax 종료
            
         }); 
         
      /* 비밀번호 확인 클릭 후 개인정보 수정 로직 처리 */
      /* function mypagePwdConfirm() {
         if(!formCheck("#user_pw", "#msg", "비밀번호를")) return;
         else {
            $.ajax ({
               url : "/mypage/pwdCheck",
               type : "post",
               data : $("#f_pwd").serialize(),
               dataType : "text",
               error : function() {
                  alert("시스템 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
               },
               success : function(resultData) {
                  let goUrl = "";
                  if(resultData == "실패") {
                     $("#msg").text("비밀번호가 일치하지 않습니다.");
                     $("#user_pw").select();
                  } else if(resultData == "성공") {   
                     goUrl="/mypage/updateInfoForm";
                     $("#f_data").attr("action", goUrl);
                     $("#f_data").submit();
                  }
               }
            });
         }
      }) */
   })
   </script>
</head>
<body>

<!-- HEADER =============================-->
<header class="item header margin-top-0">
<div class="wrapper">
   <div class="container">
      <div class="row">
         <div class="col-md-12 text-center">
            <div class="text-pageheader">
               <div class="subtext-image" data-scrollreveal="enter bottom over 1.7s after 0.0s">
                   MY PAGE
               </div>
            </div>
         </div>
      </div>
   </div>
</div>
</header>


<!-- CONTENT =============================-->
<section class="item content">
<div class="container toparea">
   <div class="underlined-title">
      <div class="editContent">
         <h1 class="text-center latestitems">나의 정보</h1>
      </div>
      <div class="wow-hr type_short">
         <span class="wow-hr-h">
         <i class="fa fa-star"></i>
         <i class="fa fa-star"></i>
         <i class="fa fa-star"></i>
         </span>
      </div>
   </div>
<!-- NAVBAR=============================== -->
   <nav>
          <ul class="nav nav-tabs nav-justified">
              <c:if test="${lmember != null}">
                   <li class="active"><a href="/mypage/main">나의 정보</a></li>
            </c:if>
            <li><a href="/mypage/reservList">예약내역</a></li>
            <li><a href="/mypage/boardList">작성한 글</a></li>
          </ul>
    </nav><br/><br/><br/>
        
 <!-- CONTENT============================== -->       
    <c:if test="${lmember != null}">
      <div id="edd_checkout_wrap" class="col-md-8 col-md-offset-2">
          <%-- <div class="contentContainer container">
             <form name = "f_data" id = "f_data" method = "post">
                <input type="hidden" name="user_no" value="${ mainPage.user_no }">
             </form>
          </div> --%>
         <div id="edd_checkout_form_wrap" class="edd_clearfix">
            <form id="edd_purchase_form" class="edd_form" action="#" method="POST">
               <fieldset id="edd_checkout_user_info">
                  <legend>Personal Info</legend>
                  <%-- <c:set var="info" value="${ mainPage }" /> --%>
                     <table class="table table-light">
                        <tr>
                           <th class="col-md-3">이 름</th>
                           <td class="col-md-9">${mainPage.user_name}</td>
                        </tr>
                        <tr>
                           <th class="col-md-3">아이디</th>
                           <td class="col-md-9">${mainPage.user_id}</td>
                        </tr>
                        <tr>
                           <th class="col-md-3">전화번호</th>
                           <td class="col-md-9">${mainPage.user_phone}</td>
                        </tr>
                        <tr>
                           <th class="col-md-3">이메일</th>
                           <td class="col-md-9">${mainPage.user_email}</td>
                        </tr>
                     </table>
               </fieldset>
            </form>
            
            
               <div class="col-md-3 text-center">            
                  <button type="button" class="btn btn-dark btn-sm text-center" id="updateInfoBtn"></button>
               </div>
               <br/>
               <div id = "pwdChk" class = "col-md-9 text-left" style="margin-bottom: 40px;">
                  <form name = "f_pwd" id = "f_pwd" class = "form-inline">
                     <%-- <input type = "hidden" name = "user_no" id = "user_no" value = "${ info.user_no }" /> --%>
                     <input type = "password" name = "user_pw" id = "user_pw" class = "form-control" />
                     <button type = "button" id = "pwdBut" class = "btn btn-dark btn-sm">확인</button>
                     <span id = "msg"></span>
                  </form>
               </div>
            
         </div>
      </div>
   </c:if>
</div>
</section>


<!-- SCRIPTS =============================-->
<script src="/resources/include/scorilo/js/jquery-.js"></script>
<script src="/resources/include/scorilo/js/bootstrap.min.js"></script>
<script src="/resources/include/scorilo/js/anim.js"></script>

</body>
</html>