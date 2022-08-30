<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	
	<script type="text/javascript">
		$(function(){
			$(".goDetail").click(function(){
				let b_no = $(this).parents("tr").attr("data-num");
				$("#b_no").val(b_no);
				console.log("글번호 : "+b_no);
				let c_no = $(this).parents("tr").attr("data-categorynum");
				$("#c_no").val(c_no);
				console.log("카테고리 번호 : "+c_no);
				
				$("#detailForm").attr({
					"method":"get",
					"action":"/community/communityBoardDetail/"+ c_no
				});
				$("#detailForm").submit();
			});
			
			$(".diaryDetail").click(function(){
				let d_no = $(this).parents("tr").attr("data-num");
				$("#d_no").val(d_no);
				console.log("다이어리 글번호 : "+d_no);
				
				$("#f_data").attr({
					"method":"get",
					"action" : "/diary/diaryBoardDetail"
				});
				$("#f_data").submit();
			});
			
			$(".paginate_button a").click(function(e) {
				e.preventDefault();
				$("#f_search").find("input[name='pageNum']").val($(this).attr("href"));
				goPage();
			})
			$(".paginate_button2 a").click(function(e) {
				e.preventDefault();
				$("#f_search_2").find("input[name='pageNum']").val($(this).attr("href"));
				goPage2();
			})
		});
		
		function goPage() {
			$("#f_search").attr({
				method:"get",
				action:"/mypage/boardList"
			})
			$("#f_search").submit();
		}
		
		function goPage2() {
			$("#f_search_2").attr({
				method:"get",
				action:"/mypage/boardList"
			})
			$("#f_search_2").submit();
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
						<h1 class="text-center latestitems">작성한 글</h1>
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
			            <li><a href="/mypage/main">나의 정보</a></li>
			            <li><a href="/mypage/reservList">예약내역</a></li>
			            <li class="active"><a href="/mypage/boardList">작성한 글</a></li>
			          </ul>
			    </nav><br/><br/><br/>
  				<form id="detailForm">
					<input type="hidden" id="b_no" name="b_no"/>
				</form>
				<form name="f_data" id="f_data">
		 			<input type="hidden" id="d_no" name="d_no"/>
	  		    </form>
	  		    
	  		    <form id="f_search" name="f_search" class="form-inline">
					<!-- 페이징 처리를 위한 파라미터 -->
					<input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
				</form>
				<form id="f_search_2" name="f_search" class="form-inline">
					<!-- 페이징 처리를 위한 파라미터 -->
					<input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
				</form>
			 <!-- CONTENT============================== -->       
			 	<div id = "boardList" class = "table-hegiht">
			 	<h4>커뮤니티 리스트</h4>
				<table summary="게시판 리스트" class="table table-striped">
					<thead>
						<tr>
							<th data-value="b_no" class="order text-center col-md-1">글번호</th>
							<th class="text-center col-md-4">글제목</th>
							<th data-value="b_regdate" class="order col-md-1">작성일</th>
						</tr>
					</thead>
					<tbody id = "list" class="table-striped">
						<!-- 데이터 출력 -->
						<c:choose>
							<c:when test="${ not empty communityBoardList }">
								<c:forEach var="board" items="${communityBoardList}" varStatus="status">
									<tr class="text-center" data-num="${board.b_no}" user="${board.user_id}" data-categorynum="${board.c_no}">
										<td>${board.b_no}</td>
										<td class="goDetail text-left">
											${board.b_title}
										</td>
										<td class="text-left">${board.b_regdate}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="5" class="tac text-center">등록된 게시물이 존재하지 않습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<div class="text-center">
					<ul class="pagination">
						<c:if test="${pageMaker.prev}">
							<li class="paginate_button2 previous">
								<a href="${pageMaker.startPage -1}">Previous</a>
							</li>
						</c:if>
						
						<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
							<li class="paginate_button2 ${pageMaker.cvo.pageNum == num ? 'active':''}">
								<a href="${num}">${num}</a>
							</li>
						</c:forEach>
						
						<c:if test="${pageMaker.next}">
							<li class="paginate_button2 next">
								<a href="${pageMaker.endPage +1 }">Next</a>
							</li>
						</c:if>
					</ul>
				</div>
				
				<h4>다이어리 리스트</h4>
				<table summary="게시판 리스트" class="table table-striped">
					<thead>
						<tr>
							<th data-value="b_no" class="order text-center col-md-1">글번호</th>
							<th class="text-center col-md-4">글제목</th>
							<th data-value="b_regdate" class="order col-md-1">작성일</th>
						</tr>
					</thead>
					<tbody id = "list" class="table-striped">
						<!-- 데이터 출력 -->
						<c:choose>
							<c:when test="${ not empty diaryList }">
								<c:forEach var="diary" items="${diaryList}" varStatus="status">
									<tr class="text-center" data-num="${diary.d_no}" user="${diary.user_id}">
										<td>${diary.d_no}</td>
										<td class="diaryDetail text-left">
											${diary.d_title}
										</td>
										<td class="text-left">${diary.d_regdate}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="5" class="tac text-center">등록된 게시물이 존재하지 않습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			
			<%-- 검색 기능 --%>
			<!-- <div id="boardSearch" class="text-center">
					<form id="f_search" name="f_search" class="form-inline">
						<div class="form-group">
							<label>검색조건</label> 
							<select id="search" name="search" class="form-control">
								<option value="all">전체</option>
								<option value="b_title">제목</option>
								<option value="b_content">내용</option>
							</select> 
							<input type="text" name="keyword" id = "keyword" value = "검색어를 입력하세요" class = "form-control" />
							<input type="button" id="searchData" class="btn btn-dark btn-sm" value = "검색" />
						</div>
					</form>
				</div> -->
		</div>
		
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
	</section>
				


<!-- SCRIPTS =============================-->
<script src="/resources/include/scorilo/js/jquery-.js"></script>
<script src="/resources/include/scorilo/js/bootstrap.min.js"></script>
<script src="/resources/include/scorilo/js/anim.js"></script>

</body>
</html>