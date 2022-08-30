<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
		<style>
			img{ width:100px;}
			
		</style>
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
						else if($("search").val()=='user_no') value="#list tr td.userNo";
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
							action:"/admin/qna/aQnaDetail"
						})
						$("#detailForm").submit();
				})
				
				$(".paginate_button a").click(function(e) {
					e.preventDefault();
					$("#f_search").find("input[name='pageNum']").val($(this).attr("href"));
					goPage();
				})
				
				$(".del").click(function() {
					if(confirm("정말 삭제하시겠습니까?")) {
						let q_num = $(this).parents("tr").attr("data-num");
						$("#q_num").val(q_num);
						console.log("글번호 : " + q_num);
							$("#detailForm").attr({
								method:"get",
								action:"/admin/qna/aQnaDelete?q_num="
							})
							$("#detailForm").submit();
					} 
				})
				
			})
				function goPage() {
					if($("#search").val()=="all") {
						$("#keyword").val("");
					}
					$("#f_search").attr({
						method:"get",
						action:"/admin/qna/qnaList"
					})
					$("#f_search").submit();
				}
		</script>
	<title>Insert title here</title>
	</head>
	<body>
		<div class="contentContainer container">
			<!--  
			<div class="contentTit page-header"><h3 class="text-center">게시판 리스트</h3></div>
			-->
		</div>
		
		<form id="detailForm">
			<input type="hidden" id="q_num" name="q_num" />
		</form>
		
		<div id="boardSearch" class="text-right">
			<form id="f_search" name="f_search" class="form-inline">
				<input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}">
				<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
				<div class="form-group">
					<label>검색조건</label>
					<select id="search" name="search" class="form-control">
						<option value="all">전체</option>
						<option value="user_no">회원번호</option>
						<option value="q_title">제목</option>
						<option value="q_content">내용</option>
						<option value="q_name">작성자</option>
					</select>
					<input type="text" name="keyword" id="keyword" value="검색어를 입력하세요" class="form-control" />
					<button type="button" id="searchData" class="btn btn-success">검색</button>
				</div>
			</form>
		</div>
		
		<div id="boardList" class="table-height">
			<table summary="게시판 리스트" class="table table-striped">
				<thead>
					<tr>
						<th data-value="user_no" class="order text-center col-md-1">회원번호</th>
						<th class="text-center col-md-2">작성자</th>
						<th data-value="q_num" class="order text-center col-md-1">글 번호</th>
						<th class="text-center col-md-4">제목</th>
						<th data-value="q_status" class="order col-md-1">상태</th>
						<th data-value="q_date" class="order col-md-1">작성일</th>
						<th class="text-center col-md-1">조회수</th>
						<th class="text-center col-md-3">이미지</th>
					</tr>
				</thead>
				<tbody id="list" class="table-striped">
					<c:choose>
						<c:when test="${not empty qnaList}">
							<c:forEach var="qna" items="${qnaList}" varStatus="status">
								<tr class="text-center" data-num="${qna.q_num}">
									<td class="userNo">${qna.user_no}</td>
									<td class="name">${qna.q_name}</td>
									<td>${qna.q_num}</td>
									<td class="goDetail text-left" style="cursor:pointer;">
										${qna.q_title}
									</td>
									<td class="text-left">
										<c:if test="${qna.r_cnt > 0}">
											<span class="reply_count" style="font-size:12px; color:red;"> 답변완료</span>
											<%-- <span class="reply_count">[${qna.r_cnt}]</span> --%>
										</c:if>
										<c:if test="${qna.r_cnt <= 0}">
											<span class="reply_count" style="font-size:12px; color:gray;"> 답변대기</span>
										</c:if>
									</td>
									<td class="text-left">${qna.q_date}</td>
									<td class="text-center">${qna.readcnt}</td>
									<td>
												<c:if test="${not empty qna.q_thumb}">
													<img src="/petcationStorage/qna/thumbnail/${qna.q_thumb}" />
												</c:if>
												<c:if test="${empty qna.q_thumb}">
													<img src="/resources/images/common/noImage.jpg" />
												</c:if>
												<button class="del">삭제</button>
									</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="7" class="tac text-center">등록된 게시물이 존재하지 않습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>			
				</tbody>				
			</table>
			
			<!-- <button id="selDel">선택삭제</button>
			<button id="allDel">전체삭제</button> -->
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
		
		
		<%-- <tag:pagination pageNum="${pageMaker.cvo.pageNum}" amount="${pageMaker.cvo.amount}"
		startPage="${pageMaker.startPage}" endPage="${pageMaker.endPage}" prev="${pageMaker.prev}" next="${pageMaker.next}" /> --%>
		
	</body>
</html> 
