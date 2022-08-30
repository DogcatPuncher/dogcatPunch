<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<title>다이어리</title>
	<link rel="stylesheet" type="text/css" href="/resources/include/scorilo/css/bootstrap-theme.min.css"/>
	<link rel="stylesheet" type="text/css" href="/resources/include/scorilo/css/style.css" >
	<link href="https://fonts.googleapis.com/css?family=Dosis:200,300,400,500,600,700" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Roboto:200,300,400,500,600,700" rel="stylesheet">
	<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="/resources/include/js/common.js"></script>
	<script type="text/javascript" src="/resources/include/scorilo/js/bootstrap.min.js"></script>
	<style>
		@font-face {
		  font-family: SCDream5;
		  src: url('/resources/include/dist/fonts/SCDream5.otf'); 
		}
		
		#insertFormBtn {
	        background: url( "/resources/images/common/writebtn.png" ) no-repeat;
	        border: none;
	        font-size : 13px;
	        color:#fff;
	        width: 80px;
	        height: 80px;
	        background-size: contain;
	        cursor: pointer;
	        line-height:200%;
	        color:black;
	        margin-bottom:25px;
      	}
      	#insertFormBtn:focus { outline: none; }		
		h3 {
			  position: relative;
			  display: inline-block;
			  padding: 0.7rem 1rem;
			  font-size:35px;
			}
		h3::before, h3::after { 
		  position: absolute;
		  display: inline-block;
		  content: '';
		  width: 20px;
		  height: 30px;
		}
		h3::before {
		  top: 0px;
		  left: 0px;
		  border-top: 2px solid #f44336;
		  border-left: 2px solid #f44336;
		}
		h3::after {
		  right: 0px;
		  bottom: 0px;
		  border-right: 2px solid #f44336;
		  border-bottom: 2px solid #f44336;
		}
	/* 	h3{
			color:green;
			font-size:40px;
			text-align: center;
		} */
		.story >img{
			/* border:5px solid #B1E1FF; */
		}
		#boardSearch{
			margin-bottom:10px;
		}
			* {
	  box-sizing: border-box;
	}
	
	.box {
	  background-color: #fff;
	  /* box-shadow: 0 4px 5px rgba(0, 0, 0, 0.3); */
	  border-radius: 10px;
	  padding: 30px;
	  /* max-width: 1000px; */
	  justify-content:center;
	}
	
	body {
	  /* background-color: #947EB0; */
	  /* justify-content: center;
	  display: flex; */
	}
	
	body {
	  padding-top: 20px;
	  font-family: SCDream5;
	}
	
	.grid {
	  display: grid;
	  /* grid-template-columns: repeat(auto-fill, minmax(270px, 1fr)); */
	  grid-template-columns: repeat(3,minmax(270px,1fr));
	  grid-gap: 20px;
	
	}
	
	.grid > article {
	  border: 1px solid #ccc;
	  /* box-shadow: 2px 2px 6px 0px rgba(187, 163, 206, 1); */
	  box-shadow: 2px 2px 6px 0px rgba(255, 165, 0, 1);
	  text-align:center;
	  background-color: #fff;
	  padding: 5% 0;
	   border-radius: 20px;
	}
	
	
	.grid .text {
	  padding: 10px 20px 20px 30px;
	  color: #808285;
	  margin-bottom: 20px;  
	}
	
	.grid .goDetail {
	  margin-top: 20px;
	  /* background-color: #e0d4e9; */
	    background-color:#FFE5B4;
		border: 0;
		border-radius: 5px;
		color: #777;
		font-size: 18px;
		font-weight:bold;
		padding: 5px 10px 5px 10px;
	  line-height: 5;
	  text-decoration: none;
	  
	}
	.goDetail:hover {
	  background: #d1d3d4;
	  transition-duration: 80ms;
	}
	
	h3{ 
	  color: #000;
	  text-align: left;
	}
	.user{
		font-size:20px;
		font-weight:bold;
	}
	.form-control{
		background-color: #fff;
  		border-radius: 20px;
  		border:1px solid #FFA500;
  		/* box-shadow: 0 2px 3px #FFA500; */
	}
		
	</style>
	<script type="text/javascript">
		$(function(){
			let word = "<c:out value='${data.keyword}'/>";
			let value="";
			if(word!=""){
				$("#keyword").val("<c:out value='${data.keyword}'/>");
				$("#search").val("<c:out value='${data.search}'/>");
				
				if($("#search").val()!='d_content'){
					//:contains()는 특정 텍스트를 포함한 요소 반환
					if($("#search").val()=='d_title') value="#diarybox div div.goDetail";
					else if($("#search").val()=='user_id') value="#diarybox	div div.user";
					console.log($(value+":contains('"+word+"')").html()); 
					
					$(value+":contains('"+word+"')").each(function(){
						let regex = new RegExp(word,'gi');
						$(this).html($(this).html().replace(regex, "<span class='required'>" + word + "</span>"));
					});
				}
			}
			
			$("#keyword").bind("keydown",function(e){
				if(e.keyCode==13){
					e.preventDefault();
				} 
			});
			/*검색 대상이 변경될 때마다 처리 이벤트*/
			$("#search").change(function(){
				if($("#search").val()=="all"){
					$("#keyword").val("전체 데이터 조회 합니다.");
				}else if($("#search").val()!="all"){
					$("#keyword").val("");
					$("#keyword").focus();
				}
			});
			/*검색 버튼 클릭 시 처리 이벤트*/
			$("#searchData").click(function(){
				if($("#search").val()!="all"){
					if(!chkData("#keyword","검색어를")) return;
				}
				$("#pageNum").val(1);
				goPage();
			});
			$("#insertFormBtn").click(function(){
				location.href = "/diary/diaryBoardWrite";
			});
			
			$(".paginate_button a").click(function(e) {
				e.preventDefault();
				$("#f_search").find("input[name='pageNum']").val($(this).attr("href"));
				goPage();
			})
			
			$(".goDetail").click(function(){
				/* let d_no = $(".info").attr("data-num"); */
				let d_no=$(this).parents("div").attr("data-num");
				$("#d_no").val(d_no);
				console.log("글번호 : " +d_no);
				//상세 페이지로 이동하기 위해 form 추가 (id : detailForm)
				$("#detailForm").attr({
					"method":"get",
					"action":"/diary/diaryBoardDetail"
				});
				$("#detailForm").submit();
			});
		});
		/*검색을 위한 실질적인 처리 함수*/
		function goPage(){
			if($("#search").val()=="all"){
				$("#keyword").val("");
			}
			$("#f_search").attr({
				"method":"get",
				"action":"/diary/diaryBoardList"
			})
			$("#f_search").submit();
		}
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
	                   			Travel Diary
	               			</div>
	            		</div>
	         		</div>
	      		</div>
	   		</div>
	   		
		</div>
	</header>


	<div class="container toparea" style="position: relative;">
			<div class="diary text-center" style="position: relative;top: -50px;"><h3>여행 다이어리</h3></div>
			<form id="detailForm">
				<input type="hidden" id="d_no" name="d_no"/>
			</form>
			<div id="boardSearch" class="text-right">
				<form id="f_search" name="f_search" class="form-inline">
				<!-- 페이징 처리를 위한 파라미터 -->
					<input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
					<div class="form-group">
						<!-- <label>검색조건</label> -->
						<select id="search" name="search" class="form-control">
							<option value="all">전체</option>
							<option value="d_title">제목</option>
							<option value="d_content">내용</option>
							<option value="user_id">작성자</option>
						</select>
						<input type="text" name="keyword" id="keyword" value="검색어를 입력하세요" class="form-control"/>
						<button type="button" id="searchData" class="btn btn-warning">검색</button>
					</div>
				</form>
			</div>
        		<div class="container row box">
					<div class="row">
					  <main class="grid" id="diarybox">
					  	<c:choose>
					  		<c:when test="${not empty diaryBoardList}">
							  	<c:forEach items="${diaryBoardList }" var="diary" varStatus="status">
							    	<article>			    	
							      		<div class="story" data-num="${diary.d_no}">
								      		<input class="info" type="hidden" id="d_no" name="d_no" data-num="${diary.d_no}"/>
								      		<c:if test = "${not empty diary.d_thumb}">
												<img src="/petcationStorage/diary/thumbnail/${diary.d_thumb}" style="width: 220px; height: 220px;">
											</c:if>
											<c:if test = "${empty diary.d_thumb}">
												<img src="/resources/images/common/nothumb.jpg" style="width: 220px; height: 220px;"/>
											</c:if>
											<div class="user text-center">${diary.user_id}</div>
			            					<div class="goDetail text-center">${diary.d_title}</div>
		            					</div>            				
							    	</article>
							    </c:forEach>
					    	</c:when>
					    	<c:otherwise>
					    		<article>			    	
							      		<div class="story">
			            					<div class="goDetail text-center">등록된 게시물이 존재하지 않습니다.</div>
		            					</div>            				
							    	</article>
					    	</c:otherwise>
					    </c:choose>					                                                                                                                                                  
					  </main>
					</div>
				</div>
				
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
				
        <div class="contentBtn text-right">
			<input type="button" value="" id="insertFormBtn"class="btn btn-warning">
		</div>
	</div>
<!-- SCRIPTS =============================-->
<script src="/resources/include/scorilo/js/jquery-.js"></script>
<script src="/resources/include/scorilo/js/bootstrap.min.js"></script>
<script src="/resources/include/scorilo/js/anim.js"></script>
</body>
</html>