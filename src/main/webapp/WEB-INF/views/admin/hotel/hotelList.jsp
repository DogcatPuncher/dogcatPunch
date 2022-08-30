<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	<link rel="stylesheet" href="/resources/include/dist/css/offcanvas.css">
	<link href="/resources/include/dist/css/dashboard.css" rel="stylesheet">
	
<script type="text/javascript">
   $(function(){
		let word = "<c:out value='${data.keyword}' />";
		let value = "";
		if(word != ""){
			$("#keyword").val("<c:out value='${data.keyword}' />");
			$("#search").val("<c:out value='${data.search}' />");
			
			if($("#search").val() != 'all'){
				//:contains() 는 특정 테스트를 포함한 요소반환
				if($("#search").val() == '서울') value = "#list tr td.goDetail";
				else if($("#search").val() == '경기도') value = "#list tr td.goDetail";
				else if($("#search").val() == '충청도') value = "#list tr td.goDetail";
				else if($("#search").val() == '강원도') value = "#list tr td.goDetail";
				else if($("#search").val() == '경상도') value = "#list tr td.goDetail";
				else if($("#search").val() == '전라도') value = "#list tr td.goDetail";
				else if($("#search").val() == '제주도') value = "#list tr td.goDetail";
				

				$(value + ":contains('" + word + "')").each(function(){
					let regex = new RegExp(word, 'gi');
					$(this).html($(this).html().replace(regex,"<span class='required'>"+word+"</span>"));
				});
			}
		}
		
		$("#searchData").click(function(){
			goPage();
		});
		
		$(".goDetail").click(function(){
			let hotel_no = $(this).parents("tr").attr("data-no");
			
			location.href="/admin/hotel/hotelDetail?hotel_no=" + hotel_no;
		});
		
		$("#hotelInsert").click(function(){
			location.href="/admin/hotel/hotelWrite";
		});
		
		$(".paginate_button a").click(function(e){
			e.preventDefault();
			$("#h_search").find("input[name='pageNum']").val($(this).attr("href"));
			goPage();
		});
	})
	
		function goPage(){
	   		if($("#search").val() == "all"){
				$("#keyword").val("all");
			}
			$("#h_search").attr({
				"method":"get",
				"action":"/admin/hotel/hotelList"
			});
			$("#h_search").submit();
		}
				
   </script>
</head>
<body>

<div id="noticeList" class="table-height">
	<div id="boardSearch" class="text-left">
					<form id="h_search" name="h_search" class="form-inline">
						<input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}">
						<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
						<div class="form-group">
							<label>지역</label>
							<select id="search" name="search" class="form-control">
								<option value="all">전체</option>
								<option value="서울">서울</option>
								<option value="경기도">경기도</option>
								<option value="충청도">충청도</option>
								<option value="강원도">강원도</option>
								<option value="경상도">경상도</option>
								<option value="전라도">전라도</option>
								<option value="제주도">제주도</option>
							</select>
							<button type="button" id="searchData" class="btn btn-info">검색</button>
							<input type="hidden" id="keyword">
							
						</div>
					</form>
				</div>

					<table summary="게시판 리스트" class="table table-striped">
						<thead>
							<tr>
								<th data-value="n_no" class="order text-center col-md-1">번호</th>
								<th class="order text-center col-md-1">숙소명</th>
								<th class="order text-center col-md-1">가격</th>
								<th class="order text-center col-md-1">숙소썸네일</th>
							</tr>
						</thead>
						<tbody id="list" class="table-striped">
							<!-- 데이터 출력 -->
							<c:choose>
								<c:when test="${not empty hotelList}">
									<c:forEach items="${hotelList}" var="hotel" varStatus="status">
										<tr class="text-center" data-no="${hotel.hotel_no}">
											<td>${hotel.hotel_no}</td>
											<td class="goDetail text-center">${hotel.hotel_name}</td>
											<td class="text-center">${hotel.hotel_price}</td>
											<td class="text-center"><img src="/petcationStorage/hotel/thumbnail/${hotel.hotel_thumb}"></td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="7" class="tac text-center">등록된 숙소가 없습니다.</td>
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
					<input type="button" id="hotelInsert" class="btn btn-info" value="추가하기">
				</div>
</body>	