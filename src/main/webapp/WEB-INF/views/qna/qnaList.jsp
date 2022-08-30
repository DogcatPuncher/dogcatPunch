<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

<link rel="stylesheet" href="/resources/include/icofont/icofont.min.css">
<link rel="stylesheet" href="/resources/include/icofont/fonts/icofont.woff">
<link rel="stylesheet" href="/resources/include/icofont/fonts/icofont.woff2">
	
	<style>
		@font-face {
		  font-family: SCDream5;
		  src: url('/resources/include/dist/fonts/SCDream5.otf'); 
		}
		
		body {
			font-family: SCDream5;
		}
		
		thead { height: 50px;}
		tr, td{
			height: 50px;
			vertical-align:middle
		}
		
		#wrap {
			width : 900px; 
			text-align : center; 
			margin : auto;}
		
		img{ width:100px; hegiht:100px;}
		.material-symbols-outlined {
		  font-variation-settings:
		  'FILL' 0,
		  'wght' 400,
		  'GRAD' 0,
		  'opsz' 48
		}
		
		.col-md-1{
			width:100px;
		}/* 글번호 작성일 조회수 */
		.col-md-4 {
			width:400px;
		}/* 제목 */
		.col-md-2 {
			width:80px;
		}/* 작성자 */
		
		#insertFormBtn {
        background: url( "/resources/images/common/seal.png" ) no-repeat;
        border: none;
        font-size : 13px;
        width: 70px;
        height: 70px;
        background-size: contain;
        cursor: pointer;
        line-height:200%;
        color:black;
        margin-bottom:30px;
      }
      
		#searchData {
        background: url( "/resources/images/common/search1.png" ) no-repeat;
        border: none;
        width: 30px;
        height: 30px;
        background-size: contain;
        cursor: pointer;
        line-height:200%;
        color:black;
      }
      
      button {
			background-color:white;
			border : 1px solid gray;
	}
      
      
	</style>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

		<script>
			$(function() {
				
				let word="<c:out value='${qnaVO.keyword}' />";
				let value="";
				if(word!=""){
					$("#keyword").val("<c:out value='${qnaVO.keyword}' />");
					$("#search").val("<c:out value='${qnaVO.search}' />");
					
					if($("#search").val()!='q_content'){
						if($("#search").val()=='q_title') value="#list tr td.goDetail";
						else if($("search").val()=='q_name') value="#list tr td.name";
						console.log($(value+":contains('"+word+"')").html());
						
						$(value+":contains('"+word+"')").each(function() {
							let regex = new RegExp(word,'gi');
							$(this).html($(this).html().replace(regex, "<span class='required'>" + word + "</span>"));
						})
						
					}					
				}
					
				$("#keyword").bind("keydown", function(event) {
					if (event.keyCode == 13) {
						event.preventDefault();
					}
				})
				
				$("#search").change(function() {
					if($("#search").val()=="all") {
						$("#keyword").val("전체 데이터 조회입니다.");
					} else if($("#search").val() != "all") {
						$("#keyword").val("");
						$("#keyword").focus();
					}
				})		
				
				$("#searchData").click(function() {
					if($("#search").val()!="all"){
						if(!chkData("#keyword","검색어를")) return;
					}
					$("#pageNum").val(1);
					goPage();
				})
				
				$("#insertFormBtn").click(function() {
					location.href = "/qna/qnaWrite";
				})
				
				$(".goDetail").click(function() {
					let q_num = $(this).parents("tr").attr("data-num");
					$("#q_num").val(q_num);
					console.log("글번호 : " + q_num);
						$("#detailForm").attr({
							method:"get",
							action:"/qna/qnaDetail"
						})
						$("#detailForm").submit();
				})
				
				$(".paginate_button a").click(function(e) {
					e.preventDefault();
					$("#f_search").find("input[name='pageNum']").val($(this).attr("href"));
					goPage();
				})
				
				$(".adminDel").click(function() {
					/* if(confirm("정말 삭제하시겠습니까?")) {
						goUrl = "/qna/qnaDelete";
						$("#detailForm").attr("action",goUrl);
						$("#detailForm").submit();
					} */
				})
			})
				function goPage() {
					if($("#search").val()=="all") {
						$("#keyword").val("");
					}
					$("#f_search").attr({
						method:"get",
						action:"/qna/qnaList"
					})
					$("#f_search").submit();
				}
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
	                           QNA
	                           </div>
	                     </div>
	                  </div>
	               </div>
	            </div>
	      </div>
	   </header>
	   <div class="container toparea">
		<div class="contentContainer container">
			
			<br/><br/><br/>  
			<!-- <div class="contentTit page-header"><h1 class="text-left"><i class="icofont-question"></i>QnA</h1></div> -->
			
		</div>
		<form id="detailForm">
			<input type="hidden" id="q_num" name="q_num" />
		</form>
		
		<div id="wrap">
			<div id="qnaSearch" class="text-left" style="float:left;">
				<form id="f_search" name="f_search" class="form-inline">
					<!-- 페이징 처리를 위한 파라미터 -->
					<input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
					<div class="form-group" style="display: flex;">
						<select id="search" name="search" class="form-control">
							<option value="all">전체</option>
							<option value="q_title">제목</option>
							<option value="q_content">내용</option>
							<option value="q_name">작성자</option>
						</select>
						<input type="text" name="keyword" id="keyword" value="검색어를 입력하세요" class="form-control" />
						<button type="button" id="searchData" class="btn btn-info"></button>
					</div>
				</form>
			</div>
			<!-- 
			<div class="contentBtn text-right" style="float:right;">
				<button type="button" id="insertFormBtn" class="btn btn-success">글쓰기</button>
			</div> -->
			<div class="contentBtn text-right" style="float:right;">
				<button type="button" id="insertFormBtn">
						<br/><br/>문의하기
				</button>
			</div>
			
			<div id="qnaList" class="table-height">
				<table summary="게시판 리스트" class="table table-striped">
					
					<thead>
						<tr>
							<th data-value="q_num" class="order text-center col-md-1">글번호</th>
							<th class="text-center col-md-4">글제목</th>
							<th class="text-center col-md-2">작성자</th>
							<th data-value="q_date" class="order text-center col-md-1">작성일</th>
							<th class="text-center col-md-1">조회수</th>
							<c:if test="${admin != null}">
								<th class="text-center col-md-3">이미지</th>
							</c:if>
						</tr>
					</thead>
					 
					 
					<tbody id="list" class="table-striped">
						<c:choose>
							<c:when test="${not empty qnaList}">
								<c:forEach var="qna" items="${qnaList}" varStatus="status">
									<tr class="text-center" data-num="${qna.q_num}">
										<td>${qna.q_num}</td>
										<c:choose>
											<c:when test="${lmember.user_no==qna.user_no}">
							                    <td class="goDetail text-left" id="title" style="cursor:pointer;">
													${qna.q_title}
													<c:if test="${qna.r_cnt > 0}">
														<span class="reply_count" style="color:#FFA200;"> [답변완료]</span>
														<%-- <span class="reply_count">[${qna.r_cnt}]</span> --%>
													</c:if>
													<c:if test="${qna.r_cnt <= 0}">
														<span class="reply_count" style="color:#3A5BA0;"> [답변대기]</span>
													</c:if>
												</td>
											</c:when>
											<c:otherwise>  
												<td class="text-left" id="title">
													<i class="icofont-lock"></i>${qna.q_title}
													<c:if test="${qna.r_cnt > 0}">
														<span class="reply_count" style="color:#FFA200;"> [답변완료]</span>
														<%-- <span class="reply_count">[${qna.r_cnt}]</span> --%>
													</c:if>
													<c:if test="${qna.r_cnt <= 0}">
														<span class="reply_count" style="color:#3A5BA0;"> [답변대기]</span>
													</c:if>
												</td>
											</c:otherwise>
										</c:choose>
										<td class="name" id="name">${qna.q_name}</td>
										<td class="text-center">${qna.q_date}</td>
										<td class="text-center">${qna.readcnt}</td>
										<c:if test="${admin != null}">
											<td>
												<c:if test="${not empty qna.q_thumb}">
													<img src="/petcationStorage/qna/thumbnail/${qna.q_thumb}" />
												</c:if>
												<c:if test="${empty qna.q_thumb}">
													<img src="/resources/images/common/noImage.jpg" />
												</c:if>
												<button class="adminDel">삭제</button>
											</td>
										</c:if>
										
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
			<!-- 리스트 종료 -->
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
		<!-- 페이징 처리를 커스텀태그(pagination)를 정의 -->
		<%-- <tag:pagination pageNum="${pageMaker.cvo.pageNum}" amount="${pageMaker.cvo.amount}"
		startPage="${pageMaker.startPage}" endPage="${pageMaker.endPage}" prev="${pageMaker.prev}" next="${pageMaker.next}" /> --%>
		
	</body>
</html>
