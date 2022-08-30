<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	<link rel="stylesheet" href="/resources/include/dist/css/offcanvas.css">
	<link href="/resources/include/dist/css/dashboard.css" rel="stylesheet">
<%@ include file="/WEB-INF/views/common/common.jspf" %>

<script type="text/javascript">
$(function(){
	let word = "<c:out value='${data.keyword}' />";
	let value = "";
	if(word != ""){
		$("#keyword").val("<c:out value='${data.keyword}' />");
		$("#search").val("<c:out value='${data.search}' />");
		
		if($("#search").val() != 'all'){
			//:contains() 는 특정 테스트를 포함한 요소반환
			if($("#search").val() == 'a_name') value = "#list tr td.goDetail";
			else if($("#search").val() == 'n_title') value = "#list tr td.goDetail";

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
		
		location.href="/admin/notice/noticeDetail?n_no=" + n_no;
	});
	
	$("#noticeInsert").click(function(){
		location.href = "/admin/notice/writeForm";
	});
	
	$(".paginate_button a").click(function(e){
		e.preventDefault();
		$("#n_search").find("input[name='pageNum']").val($(this).attr("href"));
		goPage();
	});
});

function goPage(){
	if($("#search").val() == "all"){
		$("#keyword").val("");
	}
	$("#n_search").attr({
		"method":"get",
		"action":"/admin/notice/noticeList"
	});
	$("#n_search").submit();
}

   </script>
</head>
<body>
			<div class="container">
				<div class="contentTit page-header"><h3 class="text-center">공지사항</h3></div>
				
				<%-- ================= 검색기능 시작 ================= --%>
				<div id="boardSearch" class="text-right">
					<form id="n_search" name="n_search" class="form-inline">
						<input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}">
						<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
						<div class="form-group">
							<label>검색조건</label>
							<select id="search" name="search" class="form-control">
								<option value="all">전체</option>
								<option value="a_name">작성자</option>
								<option value="n_title">제목</option>
							</select>
							<input type="text" name="keyword" id="keyword" value="검색어를 입력하세요" class="form-control" />
							<button type="button" id="searchData" class="btn btn-info">검색</button>
						</div>
					</form>
				</div>
				
				<%-- ================= 검색기능 종료 ================= --%>
				
				<%-- ================= 리스트 시작 ================= --%>
				<div id="noticeList" class="table-height">
					<table summary="게시판 리스트" class="table table-striped">
						<thead>
							<tr>
								<th data-value="n_no" class="order text-center col-md-1">번호</th>
								<th class="order text-center col-md-4">제목</th>
								<th class="order text-center col-md-2">작성자</th>
								<th data-value="n_date" class="order text-center col-md-1">작성일</th>
								<th class="order text-center col-md-1">조회수</th>
							</tr>
						</thead>
						<tbody id="list" class="table-striped">
							<!-- 데이터 출력 -->
							<c:choose>
								<c:when test="${not empty noticeList}">
									<c:forEach items="${noticeList}" var="notice" varStatus="status">
										<tr class="text-center" data-no="${notice.n_no}">
											<td>${notice.n_no}</td>
											<td class="goDetail text-center">${notice.n_title}</td>
											<td class="name">${notice.a_name}</td>
											<td class="text-center">${notice.n_date}</td>
											<td class="text-center">${notice.n_readcnt}</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="7" class="tac text-center">작성된 공지사항이 없습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
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
				<div class="text-right">
					<input type="button" class="btn btn-info" id="noticeInsert" name="noticeInsert" value="글쓰기" />
				</div>
			</div>
		</body>