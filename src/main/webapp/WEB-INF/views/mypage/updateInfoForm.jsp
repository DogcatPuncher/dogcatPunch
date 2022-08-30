<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

   <script type="text/javascript">
   $(function() {
      // 수정하기 버튼 클릭 시 유효성 체크 & 수정 구현
      $("#updateInfoBtn").click(function() {
         let pwChkSpan = $('#user_pwChk').next();
         if(!chkData("#user_phone", "전화번호를")) return;
         else if(!chkData("#user_email", "이메일을")) return;
         else if($("#user_pwChk").val() != $("#user_pw").val()) {
               pwChkSpan.html("비밀번호가 일치하지 않습니다.");
            } else {
               $("#updateInfoForm").attr({
                  "method" : "post",
                  "action" : "/mypage/updateInfo"
               });
            
               $("#updateInfoForm").submit();
            }
      });
      
      // 탈퇴하기 버튼 클릭 시
      $("#deleteInfoBtn").click(function(){
        	let check = confirm("정말 회원 탈퇴 하시겠습니까? 예약중인 모든 예약이 취소, 환불됩니다.");
			if(check == false) return false;
            $("#deleteInfoForm").attr({
            	 "method" : "post",
                 "action" : "/mypage/deleteInfo"
            });
           
           	 $("#deleteInfoForm").submit();
          
      })
      
      
      // 돌아가기 버튼 클릭 시
      $("#backToInfoBtn").click(function() {
         location.href="/mypage/main";
      });
   });
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
            <h1 class="text-center latestitems">내 정보 수정</h1>
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
               <li class="active"><a href="/mypage/main">나의 정보</a></li>
               <li><a href="/mypage/reserv">예약내역</a></li>
               <li><a href="/mypage/boardList">작성한 글</a></li>
             </ul>
       </nav><br/><br/><br/>
       
       <form id="deleteInfoForm">
       		<input type="hidden" id="user_id" name="user_id" value="${lmember.user_id}">
       </form>
   <div id="edd_checkout_wrap" class="col-md-8 col-md-offset-2">
      <div id="edd_checkout_form_wrap" class="edd_clearfix">
         <form id="updateInfoForm" class="edd_form">
            <fieldset id="edd_checkout_user_info">
               <legend>Personal Info</legend>
                  
                  <table class = "table table-bordered" >
                  <tr>
                     <td class = "text-center">이름</td>
                     <td class = "text-left">${lmember.user_name}</td>
                  </tr>
                  <tr>
                     <td class = "text-center">아이디</td>
                     <td colspan = "3" class = "text-left">${lmember.user_id}</td>
                  </tr>
                  <tr>
                     <td class = "text-center">전화번호</td>
                     <td colspan = "3"><input type = "text" name = "user_phone" id = "user_phone" value = "${lmember.user_phone}" class = "form-control"></td>
                  </tr>
                  <tr>
                     <td class = "text-center">이메일</td>
                     <td colspan = "3"><input type = "text" name = "user_email" id = "user_email" value = "${lmember.user_email}" class = "form-control"></td>
                  </tr>
                  <tr>
                     <td class = "text-center">비밀번호</td>
                     <td colspan = "3"><input type = "password" name = "user_pw" id = "user_pw" class = "form-control" placeholder = "비밀번호 수정을 원하시면 새로운 비밀번호를 입력해 주세요."></td>
                  </tr> 
                  <tr>
                     <td class = "text-center">비밀번호 확인</td>
                     <td colspan = "3"><input type = "password" name = "user_pwChk" id = "user_pwChk" class = "form-control" placeholder = "비밀번호 수정을 원하시면 새로운 비밀번호를 입력해 주세요.">
                     <span id="pwChk"></span>
                     </td>
                  </tr> 
               </table>               
               <button type="button" class="btn btn-dark btn-sm" id="updateInfoBtn">수정하기</button>
               <button type="button" class="btn btn-dark btn-sm" id="deleteInfoBtn">탈퇴하기</button>
               <button type="button" class="btn btn-dark btn-sm" id="backToInfoBtn">돌아가기</button>
            </fieldset>
         </form>
      </div>
   </div>
   </div>
   
</section>
</body>
</html>