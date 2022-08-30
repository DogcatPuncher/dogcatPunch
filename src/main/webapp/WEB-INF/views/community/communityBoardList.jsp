<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/common/common.jspf" %>


	<style>
		.form-control{
			background-color: #fff;
	  		border-radius: 20px;
	  		border:1px solid #FFA500;
	  		/* box-shadow: 0 2px 3px #FFA500; */
		}
		#insertFormBtn {
        background: url( "/resources/images/common/writebtn.png" ) no-repeat;
        border: none;
        font-size : 13px;
        color:#fff;
        width: 70px;
        height: 70px;
        background-size: contain;
        cursor: pointer;
        line-height:200%;
        color:black;
        margin-bottom:30px;
      }	
      	#insertFormBtn:focus { outline: none; }			
		/*
		=====
		DEPENDENCES
		=====
		*/
		
		.r-link{
		  display: var(--rLinkDisplay, inline-flex) !important;
		}
		
		.r-link[href]{
		  color: var(--rLinkColor) !important;
		  text-decoration: var(--rLinkTextDecoration, none) !important;
		}
		
		.r-list{
		  padding-left: var(--rListPaddingLeft, 0) !important;
		  margin-top: var(--rListMarginTop, 0) !important;
		  margin-bottom: var(--rListMarginBottom, 0) !important;
		  list-style: var(--rListListStyle, none) !important;
		}
		
		
		/*
		=====
		CORE STYLES
		=====
		*/
		
		.menu{
		  --rLinkColor: var(--menuLinkColor, currentColor);
		}
		
		.menu__link{
		  display: var(--menuLinkDisplay, block);
		}
		
		/* 
		focus state 
		*/
		
		.menu__link:focus{
		  outline: var(--menuLinkOutlineWidth, 2px) solid var(--menuLinkOutlineColor, currentColor);
		  outline-offset: var(--menuLinkOutlineOffset);
		}
		
		/* 
		fading siblings
		*/
		
		.menu:hover .menu__link:not(:hover){
		  /* --rLinkColor: var(--menuLinkColorUnactive, rgba(22, 22, 22, .35)); */
		  --rLinkColor: var(--menuLinkColorUnactive, rgba(58, 91, 160, .35));
		}
		
		/*
		=====
		PRESENTATION STYLES
		=====
		*/
		
		.menu{
		  background-color: var(--menuBackgroundColor, #FFE5B4);
		  box-shadow: var(--menuBoxShadow, 0 1px 3px 0 rgba(0, 0, 0, .12), 0 1px 2px 0 rgba(0, 0, 0, .24));
		}
		
		.menu__list{
		  display: flex;
		  text-align: center; 
		}
		
		.menu__link{
		  padding: var(--menuLinkPadding, 1.5rem 2.5rem);
		  font-weight: 700;
		  text-transform: uppercase;
		}
		
		/* 
		=====
		TEXT UNDERLINED
		=====
		*/
		
		.text-underlined{
		  position: relative;
		  overflow: hidden;
		
		  will-change: color;
		  transition: color .25s ease-out;  
		}
		
		.text-underlined::before, 
		.text-underlined::after{
		  content: "";
		  width: 0;
		  height: 3px;
		  background-color: var(--textUnderlinedLineColor, #3A5BA0);
		
		  will-change: width;
		  transition: width .1s ease-out;
		
		  position: absolute;
		  bottom: 0;
		}
		
		.text-underlined::before{
		  left: 50%;
		  transform: translateX(-50%); 
		}
		
		.text-underlined::after{
		  right: 50%;
		  transform: translateX(50%); 
		}
		
		.text-underlined:hover::before, 
		.text-underlined:hover::after{
		  width: 100%;
		  transition-duration: .2s;
		}
		
		/*
		=====
		SETTINGS
		=====
		*/
		
		.page__custom-settings{
		  --menuBackgroundColor: #6c5ce7;
		  --menuLinkColor: #fff;
		  --menuLinkColorUnactive: #241c69;
		  --menuLinkOutlineOffset: -.5rem; 
		}
		
		/*
		=====
		DEMO
		=====
		*/
		
		/* body > div.page {
		  font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Open Sans, Ubuntu, Fira Sans, Helvetica Neue, sans-serif;
		  margin: 0;
		  min-height: 100vh;
		  display: flex;  
		  flex-direction: column;
		} */
		
		.page{
		  box-sizing: border-box;
		  /* max-width: 640px; */
		  padding-left: .75rem;
		  padding-right: .75rem;
		  margin: auto;
		}
		
		.page__menu:nth-child(n+2){
		  margin-top: 3rem;
		}
		
		
		.substack{
		  border:1px solid #EEE; 
		  background-color: #fff;
		  width: 100%;
		  max-width: 480px;
		  height: 280px;
		  margin: 1rem auto;;
		}
		
		.linktr{
		  display: flex;
		  justify-content: flex-end;
		  padding: 2rem;
		  text-align: center;
		}
		
		.linktr__goal{
		  background-color: rgb(209, 246, 255);
		  color: rgb(8, 49, 112);
		  box-shadow: rgb(8 49 112 / 24%) 0px 2px 8px 0px;
		  border-radius: 2rem;
		  padding: .75rem 1.5rem;
		}
		
		.r-link{
		    --uirLinkDisplay: var(--rLinkDisplay, inline-flex);
		    --uirLinkTextColor: var(--rLinkTextColor);
		    --uirLinkTextDecoration: var(--rLinkTextDecoration, none);
		
		    display: var(--uirLinkDisplay) !important;
		    color: var(--uirLinkTextColor) !important;
		    text-decoration: var(--uirLinkTextDecoration) !important;
		}
	</style>
	<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="/resources/include/js/common.js"></script>
	<script type="text/javascript"> 
		$(function(){
			let word = "<c:out value='${data.keyword}'/>";
			let value="";
			if(word!=""){
				$("#keyword").val("<c:out value='${data.keyword}'/>");
				$("#search").val("<c:out value='${data.search}'/>");
				
				if($("#search").val()!='b_content'){
					//:contains()는 특정 텍스트를 포함한 요소 반환
					if($("#search").val()=='b_title') value="#list tr td.goDetail";
					else if($("#search").val()=='user_id') value="#list tr td.name";
					console.log($(value+":contains('"+word+"')").html());
					
					$(value+":contains('"+word+"')").each(function(){
						let regex = new RegExp(word,'gi');
						$(this).html($(this).html().replace(regex,"<span class='required'>"+word+"</span>"));
					});
				}
			}
			$("#keyword").bind("keydown",function(event){
				if(event.keyCode==13){
					event.preventDefault();
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
			var url = window.location.pathname;
			var arr = url.split('/');
			
			$("#insertFormBtn").click(function(){
				var c_no = $(".info").attr('data-categorynum');
				location.href = "/community/communityBoardWrite/${c_no}";
			});
			
			$(document).ready(function(){
				var c_name = $(".info").attr('data-category');
				$(".categoryName").text(c_name)
			});
			
			
			
			$(".goDetail").click(function(){
				let b_no = $(this).parents("tr").attr("data-num");
				$("#b_no").val(b_no);
				console.log("글번호 : "+b_no);
				
				
				$("#detailForm").attr({
					"method":"get",
					"action":"/community/communityBoardDetail/"+ ${c_no}
				});
				$("#detailForm").submit();
			});
			
			$(".paginate_button a").click(function(e) {
				e.preventDefault();
				$("#f_search").find("input[name='pageNum']").val($(this).attr("href"));
				goPage();
			})
			
		});
		
		/*검색을 위한 실질적인 처리 함수*/
		function goPage(){
			if($("#search").val()=="all"){
				$("#keyword").val("");
			}
			$("#f_search").attr({
				"method":"get",
				"action":"/community/communityBoardList/"+${c_no}
			});
			$("#f_search").submit();
		}
		$(document).ready(function () {
	            $('nav a').click(function () {
	                $('nav a').removeClass("active");
	                $(this).addClass("active");
	            });
	       });
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
	                   			COMMUNITY
	               			</div>
	            		</div>
	         		</div>
	      		</div>
	   		</div>
		</div>
	</header>
	<div class="container toparea">
	        <div class="page" style="display: flex; align-items: center; justify-content: center; text-align: center;">
	        	<nav class="page__menu menu" style="display: inline-block;">
	        		<ul class="menu__list r-list">
			           <li class="menu__group"><a href="/community/communityBoardList/1" class="menu__link r-link text-underlined">잡담</a></li>
			           <li class="menu__group"><a href="/community/communityBoardList/2" class="menu__link r-link text-underlined">여행후기</a></li>
			           <li class="menu__group"><a href="/community/communityBoardList/3" class="menu__link r-link text-underlined">꿀팁공유</a></li>
			           <li class="menu__group"><a href="/community/communityBoardList/4" class="menu__link r-link text-underlined">고민상담</a></li>
			           <li class="menu__group"><a href="/community/communityBoardList/5" class="menu__link r-link text-underlined">무료나눔</a></li>
			           <li class="menu__group"><a href="/notice/noticeList" class="menu__link r-link text-underlined">공지사항</a></li>
			         </ul>
	        	</nav>
	        </div>
        <br/>
        <form id="detailForm">
			<input type="hidden" id="b_no" name="b_no"/>
		</form>
		
		
		<div id="boardList" class="table-height">
				
				<div id="boardSearch" class="text-right">
					<form id="f_search" name="f_search" class="form-inline">
						<!-- 페이징 처리를 위한 파라미터 -->
						<input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}">
						<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
						<div class="form-group">
							<!-- <label>검색조건</label> -->
							<select id="search" name="search" class="form-control">
								<option value="all">전체</option>
								<option value="b_title">제목</option>
								<option value="b_content">내용</option>
								<option value="user_id">작성자</option>
							</select>
							<input type="text" name="keyword" id="keyword" value="검색어를 입력하세요" class="form-control"/>
							<button type="button" id="searchData" class="btn btn-warning">검색</button>
						</div>
					</form>
				</div>
				<h3 class="categoryName text-center"></h3>
			<table summary="게시판 리스트" class="table table-striped">
				<thead>
					<tr >
						<th data-value="b_num" class="order text-center col-md-1">글번호</th>
						<th class="order text-left col-md-4">글제목</th>
						<th class="order text-center col-md-2">작성자</th>
						<th data-value="b_date" class="order text-center col-md-2">작성일</th>
						<th class="order text-center col-md-1">조회수</th>
					</tr>
				</thead>
				<tbody id="list">
					<c:choose>
						<c:when test="${not empty communityBoardList}">
							<c:forEach items="${communityBoardList }" var="communityBoard" varStatus="status">
								<tr class="info text-center" data-num="${communityBoard.b_no}" data-category="${communityBoard.c_name}" data-categorynum="${communityBoard.c_no}">
									<td>${communityBoard.b_no}</td>
									<td class="goDetail text-left">
										${communityBoard.b_title}
										<c:if test="${communityBoard.com_rcnt > 0}"><span class="reply_count">[${communityBoard.com_rcnt}]</span></c:if>
									</td>
									<td>${communityBoard.user_id}</td>
									<td class="text-center">${communityBoard.b_regdate}</td>
									<td class="text-center">${communityBoard.b_readcnt}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td></td>
								<td class="text-left col-md-4">등록된 게시물이 존재하지 않습니다.</td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>			
		</div>
		<!-- <div class="col-sm-3">
			<input type="button" value="글쓰기" id="insertFormBtn" class="submit button ">
		</div> -->
		<div class="contentBtn text-right">
			<input type="button" id="insertFormBtn"class="btn btn-warning">
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
	</div>
<!-- SCRIPTS =============================-->
<script src="/resources/include/scorilo/js/jquery-.js"></script>
<script src="/resources/include/scorilo/js/bootstrap.min.js"></script>
<script src="/resources/include/scorilo/js/anim.js"></script>	
</body>
</html>