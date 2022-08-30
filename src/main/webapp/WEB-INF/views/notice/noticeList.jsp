<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	
	<style>
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
	<script type="text/javascript">
$(function(){
	let word = "<c:out value='${data.keyword}' />";
	let value = "";
	if(word != ""){
		$("#keyword").val("<c:out value='${data.keyword}' />");
		$("#search").val("<c:out value='${data.search}' />");
		
		if($("#search").val() != 'n_content'){
			//:contains() 는 특정 테스트를 포함한 요소반환
			if($("#search").val() == 'n_title') value = "#list tr td.goDetail"

			$(value + ":contains('" + word + "')").each(function(){
				let regex = new RegExp(word, 'gi');
				$(this).html($(this).html().replace(regex,"<span class='required'>"+word+"</span>"));
			});
		}
	}
	
	$("#keyword").bind("keydown", function(event){
		if(event.keyCode == 13){
			event.preventDefault();
		}
	});
	
	$("#searchData").click(function(){
		if($("#search").val() != "all"){
			if(!chkData("#keyword", "검색어를")) return;
		}
		goPage();
	});
	
	$("#search").change(function() {
        if($("#search").val()=="all") {
           $("#keyword").val("전체 데이터 조회입니다.");
        } else if($("#search").val() != "all") {
           $("#keyword").val("");
           $("#keyword").focus();
        }
     })
	
	
	$(".goDetail").click(function(){
		let n_no = $(this).parents("tr").attr("data-no");
		/*$("#n_no").val(n_no);
		//상세 페이지로 이동하기 위해 form 추가 (id : detailForm)
		$("#detailForm").attr({
			"method":"get",
			"action":"/admin/notice/noticeDetail"
		});*/
		$("#detailForm").submit();
		
		location.href="/notice/noticeDetail?n_no=" + n_no;
	});
	
	
	$(".paginate_button a").click(function(e){
		e.preventDefault();
		$("#n_search").find("input[name='pageNum']").val($(this).attr("href"));
		goPage();
	});
	
	$("#search").change(function() {
        if($("#search").val()=="all") {
           $("#keyword").val("전체 데이터 조회입니다.");
        } else if($("#search").val() != "all") {
           $("#keyword").val("");
           $("#keyword").focus();
        }
     })
});

function goPage(){
	if($("#search").val() == "all"){
		$("#keyword").val("");
	}
	$("#n_search").attr({
		"method":"get",
		"action":"/notice/noticeList"
	});
	$("#n_search").submit();
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
	                   			NOTICE
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
        
        <div id="boardList" class="table-height">
        <div id="boardSearch" class="text-right">
        <form id="n_search" name="n_search" class="form-inline">
						<input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}">
						<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
						<div class="form-group">
							<select id="search" name="search" class="form-control">
								<option value="all">전체</option>
								<option value="n_title">제목</option>
							</select>
							<input type="text" name="keyword" id="keyword" value="검색어를 입력하세요" class="form-control" />
							<button type="button" id="searchData" class="btn btn-warning">검색</button>
						</div>
					</form>
				</div>
		<div id="noticeList" class="table-height">
				<h3 class="categoryName text-center"></h3>
			<table summary="게시판 리스트" class="table table-striped">
				<thead>
					<tr >
						<th data-value="n_no" class="order text-center col-md-1">번호</th>
						<th class="order text-center col-md-4">제목</th>
						<th class="order text-center col-md-2">작성자</th>
						<th data-value="b_date" class="order text-center col-md-1">작성일</th>
						<th class="order text-center col-md-1">조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty noticeList}">
							<c:forEach items="${noticeList}" var="notice" varStatus="status">
								<tr class="info text-center" data-no="${notice.n_no}">
									<td>${notice.n_no}</td>
									<td class="goDetail text-center">${notice.n_title}</td>
									<td>${notice.a_name}</td>
									<td class="text-center">${notice.n_date}</td>
									<td class="text-center">${notice.n_readcnt}</td>
								</tr>
							</c:forEach>
						</c:when>
							<c:otherwise>
								<td colspan="5" class="tac text-center">등록된 게시물이 존재하지 않습니다.</td>
							</c:otherwise>
					</c:choose>	
					<!--<tr class="info text-center">
						<td>3</td>
						<td class="goDetail text-center">테스트제목</td>
						<td>김현승</td>
						<td class="text-center">2022.08.07</td>
						<td class="text-center">1</td>
					</tr>-->
					
				</tbody>
			</table>			
		</div>
		
		<div class="text-center">
					<ul class="pagination">
						<!-- 이전 바로가기 10개 존재 여부를 prev 필드의 값으로 확인. -->
						<c:if test="${pageMaker.prev}">
							<li class="paginate_button previous">
								<a href="${pageMaker.startPage -1}">이전</a>
							</li>
						</c:if>
						
						<!-- 바로가기 번호 출력 -->
						<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
							<li class="paginate_button ${pageMaker.cvo.pageNum == num? 'active':'' }">
								<a href="${num}">${num}</a>
							</li>
						</c:forEach>
						
						<!-- 다음 바로가기 10개 존재 여부를 next 필드의 값으로 확인. -->
						<c:if test="${pageMaker.next }">
							<li class="paginate_button next">
								<a href="${pageMaker.endPage + 1 }">다음</a>
							</li>
						</c:if>
					</ul>
				</div>
			</div>
		<!-- <div class="col-sm-3">
			<input type="button" value="글쓰기" id="insertFormBtn" class="submit button ">
		</div> -->
	</div>
</body>
</html>