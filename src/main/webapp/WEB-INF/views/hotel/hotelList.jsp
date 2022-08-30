<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<!DOCTYPE html>
<html>
<head>

	<link rel="stylesheet" href="/resources/include/icofont/icofont.min.css">
	<link rel="stylesheet" href="/resources/include/icofont/fonts/icofont.woff">
	<link rel="stylesheet" href="/resources/include/icofont/fonts/icofont.woff2">
	<link rel="stylesheet" type="text/css" href="/resources/include/scorilo/css/bootstrap.min.css"/>
	<link rel="stylesheet" type="text/css" href="/resources/include/scorilo/css/bootstrap-theme.min.css"/>
	<link rel="stylesheet" type="text/css" href="/resources/include/scorilo/css/style.css" >
<!-- 	<link rel="stylesheet" type="text/css" href="/resources/include/scorilo/css/justified-nav.css"/> -->
	<link href="https://fonts.googleapis.com/css?family=Dosis:200,300,400,500,600,700" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Roboto:200,300,400,500,600,700" rel="stylesheet">
	
	<style>
		.goDetail {
			 cursor:pointer;
		}
		
		img.goDetail {
		  width: 505px;
		  height: 336px;
		  object-fit: cover;
		}
		
		img.goDetail:hover {
			opacity: 0.5;
			filter: alpha(opacity=100); /* For IE8 and earlier */
		}
		
/* 		#searchData{
			 background: url( "/resources/images/common/dog.png" ) no-repeat;
	        border: none;
	        width: 30px;
	        height: 30px;
	        background-size: contain;
	        cursor: pointer;
	        line-height:200%;
	        color:black;
		} */
		
	    #searchData {
        background: url( "/resources/images/common/dog.png" ) no-repeat;
        border: none;
        width: 80px;
        height: 80px;
        background-size: contain;
        cursor: pointer;
        line-height:200%;
        color:black;
      }
		
	</style>
	<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="/resources/include/js/common.js"></script>
   <script type="text/javascript">
		$(function(){
			
			let word = "<c:out value='${data.keyword}' />";
			let search = "<c:out value='${data.search}' />";
			let value = "";
			if(word!= "" || search!= ""){
				$("#keyword").val("<c:out value='${data.keyword}' />");
				$("#search").val("<c:out value='${data.search}' />");
				
 			/* 	if($("#search").val()!= 'all'){
					if($("#search").val() == '서울') value = "#list div p a.goDetail"; */ 
					//:contains() 는 특정 테스트를 포함한 요소반환
					if($("#search").val() == 'all') value = "#list div p a.goDetail"; 
					else if($("#search").val() == '서울') value = "#list div p a.goDetail";
					else if($("#search").val() == '경기도') value = "#list div p a.goDetail";
					else if($("#search").val() == '충청도') value = "#list div p a.goDetail";
					else if($("#search").val() == '강원도') value = "#list div p a.goDetail";
					else if($("#search").val() == '경상도') value = "#list div p a.goDetail";
					else if($("#search").val() == '전라도') value = "#list div p a.goDetail";
					else if($("#search").val() == '제주도') value = "#list div p a.goDetail";
					

					$(value + ":contains('" + word + "')").each(function(){
						let regex = new RegExp(word, 'gi');
						$(this).html($(this).html().replace(regex,"<span class='required'>"+word+"</span>"));
					});
				//}
			}

			$("#searchData").click(function(){
				goPage();
			});
			
			$(".goDetail").click(function(){
				let hotel_no = $(this).parents("div").attr("data-no");
				$("#hotel_no").val(hotel_no);
				console.log("호텔 일련번호 : " + hotel_no);
				
				$("#hotelDetail").attr({
					"method":"get",
					"action":"/hotel/hotelDetail"
				});
				$("#hotelDetail").submit();
			}); 
			
			$(".paginate_button a").click(function(e) {
				e.preventDefault();
				$("#h_search").find("input[name='pageNum']").val($(this).attr("href"));
				goPage();
			})
			
			/* $(".goDetail").click(function(){
				let hotel_no = $(this).parents("tr").attr("data-no");
				
				location.href="/hotel/hotelDetail?hotel_no=" + hotel_no;
			}); */
			
		});
		
		function goPage(){
			$("#h_search").attr({
				"method":"get",
				"action":"/hotel/hotelList"
			});
			$("#h_search").submit();
		}
		
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
                   Hotels
               </div>
            </div>
         </div>
      </div>
   </div>
</div>
</header>

<!-- CONTENT =============================-->

<div class="container toparea">
<!--    <div class="underlined-title">
      <div class="editContent">
         <h1 class="text-center latestitems">숙소 리스트</h1>
      </div>
      <div class="wow-hr type_short">
         <span class="wow-hr-h">
         <i class="fa fa-star"></i>
         <i class="fa fa-star"></i>
         <i class="fa fa-star"></i>
         </span>
      </div>
   </div> -->
   <div class="main" style="width:1100px; margin:auto;">
		<div class="col-xs-12 col-sm-9" style="width:1100px; margin:auto;">
			<form id="hotelDetail">
				<input type="hidden" id="hotel_no" name="hotel_no"/>
			</form>
			<div id="boardSearch" class="text-center" style="margin-bottom:50px;">
				<form id="h_search" name="f_search" class="form-inline">
					<!-- 페이징 처리를 위한 파라미터 -->
					<input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
					<div class="form-group">
						<!-- <label>검색조건</label> -->
							<select id="search" name="search" class="form-control" style="width:100px; height:50px;">
								<option value="all">전체</option>
								<option value="서울">서울</option>
								<option value="경기도">경기도</option>
								<option value="충청도">충청도</option>
								<option value="강원도">강원도</option>
								<option value="경상도">경상도</option>
								<option value="전라도">전라도</option>
								<option value="제주도">제주도</option>
							</select>
						<input type="text" id="keyword" name="keyword" placeholder="&nbsp;&nbsp;&nbsp;໒(●ܫฺ●)ʋ 호텔명을 입력하세요" style="width:320px; height:50px;"/>
						<button type="button" id="searchData" class="btn btn-info"></button>
						<!-- <input type="hidden" id="keyword"> -->	
					</div>
				</form>
			</div>
<!-- 			<div class="text-center">
	   			<button id="dog"></button>
	   		</div> -->
			<div class="list">
				<c:choose>
					<c:when test="${not empty hotelList}">
						<c:forEach var="hotel" items="${hotelList}" varStatus="status">
							<div class="col-xs-6 col-lg-4" data-no="${hotel.hotel_no}" style="margin-bottom:30px; width:50%;">
								<%-- <img src="/petcationStorage/hotel/thumbnail/${hotel.hotel_thumb }"/> --%>
								<c:set var="TextValue" value="${hotel.hotel_thumb}"/>
								<c:set var="leng" value="${fn:length(TextValue)}"/>
								<img class="goDetail" src="/petcationStorage/hotel/${fn:substring(TextValue,10,leng)}" style="height:336px"/>
		           					<p class="goDetail" style="font-size:20px; font-weight:bold; color:#3A5BA0; padding:8px 5px 0px 5px;"><i class="icofont-5-star-hotel"></i> ${hotel.hotel_name }</p>
		           					<p class="goDetail">&nbsp;&nbsp;&#8361;${hotel.hotel_price }</p>
		           					<p class="goDetail text-right" style="font-size:17px;">${hotel.hotel_address }</p>
	           					<!-- <p><a class="btn btn-default goDetail" role="button">View details &raquo;</a></p> -->
	       					</div >
						</c:forEach>
					</c:when>
						<c:otherwise>
							<div class="tac text-center">등록된 게시물이 존재하지 않습니다.</div>
					</c:otherwise>
				</c:choose>          
			</div>
		</div>
	</div>         
   
</div>
<!-- NAVBAR=============================== -->
   
        
 <!-- CONTENT============================== -->       
 
   
<!-- 페이징 출력 시작 텍스트 파일로 만듦? -->
		<div class="text-center">
			<ul class="pagination">
				<c:if test="${pageMaker.prev}">
					<li class="paginate_button previous">
						<a href="${pageMaker.startPage -1}">Previous</a>
					</li>
				</c:if>
				
				<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
					<li class="paginate_button ${pageMaker.cvo.pageNum == num ? 'active':''}">
						<a href="${num}">${num}</a>
					</li>
				</c:forEach>
				
				<c:if test="${pageMaker.next}">
					<li class="paginate_button next">
						<a href="${pageMaker.endPage +1 }">Next</a>
					</li>
				</c:if>
			</ul>
		</div>




<!-- SCRIPTS =============================-->
<script src="/resources/include/scorilo/js/jquery-.js"></script>
<script src="/resources/include/scorilo/js/bootstrap.min.js"></script>
<script src="/resources/include/scorilo/js/anim.js"></script>

</body>
</html>