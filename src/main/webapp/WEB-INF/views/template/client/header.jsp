<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<style>
	   a:hover {
	      cursor: pointer;
	   }
	   
	   .login_success_area{
	      text-align:right;   
	   }
	   
	   .subtext-image {
	       text-align:center;
	      color:#3A5BA0;
	      z-index:2;
	      position:relative;
	      font-size:100px;
	      line-height:90px;
	      text-transform:uppercase;
	      padding-top:100px;
	      padding-bottom:100px;
	      font-weight:700;
	      font-family:Dosis;   
	   }
	</style>
<script>
	$(function() {
		$("#logoutBtn").click(function() {
			//alert("로그아웃");			
			$.ajax({
	            type:"post",
	            url:"/member/logout",
	            success:function(data){
	                //alert("로그아웃 성공");
	                /* document.location.reload(); */
	            	location.href="/";
	            } 
	        }); // ajax 
		})
	})
</script>
<div class="wrapper">
	<nav role="navigation" class="navbar navbar-white navbar-embossed navbar-lg navbar-fixed-top">
	<div class="container">
		<div class="navbar-header">
			<button data-target="#navbar-collapse-02" data-toggle="collapse" class="navbar-toggle" type="button">
			<i class="fa fa-bars"></i>
			<span class="sr-only">Toggle navigation</span>
			</button>
			<a href="/"> 
            	<img src="/resources/images/common/logo.png" alt="sub logo" style="width:200px;">
         	</a>
		</div>
		<div id="navbar-collapse-02" class="collapse navbar-collapse">
			<ul class="nav navbar-nav navbar-right">
				<li class="propClone"><a href="/hotel/hotelList">숙소</a></li>
				
				<li class="propClone"><a href="/diary/diaryBoardList">여행 다이어리</a></li>
				
				<li class="propClone"><a href="/community/communityBoardList/1">커뮤니티</a></li>
				
                <li class="propClone"><a href="/qna/qnaList">Q&amp;A</a></li>
                  
                <c:choose>
                  <c:when test="${lmember == null && kname == null && nname == null}">
                     <li class="propClone"><a href="/member/login">로그인</a></li>
                  </c:when>
               <c:otherwise>
			                  <li class="propClone"><a href="/mypage/main">마이페이지</a></li>
                     <c:choose>
                        <c:when test="${lmember!=null}">
                                <div class="login_success_area">
                                   <span>${lmember.user_name}님 </span><a id="logoutBtn">로그아웃</a>
                                </div>
                        </c:when>
                        <c:when test="${nname!=null}">
                                <div class="login_success_area">
                                   <span>${nname}님 </span><a id="logoutBtn">로그아웃</a>
                                </div>
                        </c:when>
                        <c:when test="${kname!=null}">
                                <div class="login_success_area">
                                   <span>${kname}님 </span><a id="logoutBtn">로그아웃</a>
                                </div>
                        </c:when>
                     </c:choose>
               </c:otherwise>
            </c:choose>
			</ul>
			 <div id="weather">
			      <span></span>
			      <span></span>
    		</div>
		</div>
	</div>
	</nav>
</div>