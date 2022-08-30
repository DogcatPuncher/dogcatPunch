<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	<script src ="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>
	<!-- Moment Js -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
	<script type="text/javascript">
		$(function(){
			let word = "<c:out value='${data.keyword}' />";
            let value = "";
            if(word != ""){
               $("#keyword").val("<c:out value='${data.keyword}' />");
               $("#search").val("<c:out value='${data.search}' />");
               
               
               
	        if($("#search").val() != 'all'){
	            	   
	         	//:contains() 는 특정 테스트를 포함한 요소반환
	            if($("#search").val() == 'hotel') value = ".searchHotel";
	               else if($("#search").val() == 'userID') value = ".searchID";
	               else if($("#search").val() == 'userName') value=".searchName";
	
	               $(value + ":contains('" + word + "')").each(function(){
	               let regex = new RegExp(word, 'gi');
	               $(this).html($(this).html().replace(regex,"<span class='required'>"+word+"</span>"));
	              });
	           }
           }
			
			
            
            /* 입력 양식 enter 제거 */
            $("#keyword").bind("keydown", function(event){
               if(event.keyCode == 13){
                  event.preventDefault();
               }
            });
            
            /* 검색 버튼 클릭 */
            $("#searchData").click(function(){
               if($("#search").val() != "all"){
            	   if(!chkData("#keyword", "검색어를")) return;
               }
               goPage();
            });
            
			$(".paginate_button a").click(function(e) {
				e.preventDefault();
				$("#r_search").find("input[name='pageNum']").val($(this).attr("href"));
				goPage();
			})
            
            $("#search").change(function() {
                if($("#search").val()=="all") {
                   $("#keyword").val("전체 데이터 조회입니다.");
                } else if($("#search").val() != "all") {
                   $("#keyword").val("");
                   $("#keyword").focus();
                }
             })
			
			let cancel = "";
			const today = moment().format('YYYY-MM-DD');
			console.log(today);
			
			$(".reservcancel").click(function(){
				cancel = $(this).parents("tr").attr("cancel"); 
				console.log(cancel); 
				
				const cancel_date = moment(today).diff(cancel,'days');
				console.log(cancel_date);
				
				if(parseInt(cancel_date) <= 0){
					let result = Math.abs(parseInt(cancel_date));
					
					if( result < 8){
						let check = confirm("체크인 날짜 : " + cancel + " 예약일이 7일 이내 입니다. 정말 예약 취소 하시겠습니까?");
						if(check == false) return false;
						
						let reserv_no = $(this).parents("tr").attr("data-num");
						$("#reserv_no").val(reserv_no);
						console.log("예약번호 : " + reserv_no);
						
						$("#reservCancel_no").attr({
							"method" : "get",
							"action" : "/admin/member/reservDelete"
						});
						$("#reservCancel_no").submit();
					} else {
						confirm = confirm("예약 취소 하시겠습니까?");
						if(confirm == false) return false;
						
						let reserv_no = $(this).parents("tr").attr("data-num");
						$("#reserv_no").val(reserv_no);
						console.log("예약번호 : " + reserv_no);
						
						$("#reservCancel_no").attr({
							"method" : "get",
							"action" : "/admin/member/reservDelete"
						});
						$("#reservCancel_no").submit();
					}
				}
			})
		});
		
		function goPage(){
			if($("#search").val() == "all"){
                $("#keyword").val("");
             }
			
			$("#r_search").attr({
				"method":"get",
				"action":"/admin/member/reservList"
			});
			$("#r_search").submit();
		}
	</script>
</head>
<body>
	<div id = "reservList" class = "table-hegiht">
		<form id="reservCancel_no">
			<input type="hidden" id="reserv_no" name="reserv_no">
 		</form>
 		
 		<!-- 검색 -->
		<div id="reservSearch" class="text-right">
			<form id="r_search" name="r_search" class="form-inline">
	 			<input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}">
         		<input type="hidden" name="amount" value="${pageMaker.cvo.amount}"> 
         		
				<div class="form-group">
					<select id="search" name="search" class="form-control">
						<option value="all">전체</option>
						<option value="hotel">숙소명</option>
						<option value="userID">회원 ID</option>
						<option value="userName">예약자 명</option>
					</select>
					<input type="text" id="keyword" name="keyword" value="검색어를 입력하세요" class="form-control">
	 				<button type="button" id="searchData" class="btn btn-primary">검색</button>
		 		</div>
				</form>
	 		</div>
	 		<!-- 검색 끝 -->	
			<table summary="예약내역" class="table table-striped">
				<thead>
					<tr class="text-center">
						<th data-value="b_no" class="order text-center col-md-1">예약번호</th>
						<th class="text-center"> 회원번호</th>
						<th class="text-center"> 회원 ID</th>
						<th class="text-center" > 예약자명</th>
						<th class="text-center">숙소</th>
						<th data-value="b_regdate" class="order col-md-1 text-center">숙소 가격</th>
						<th class="text-center"> 체크인 </th>
						<th class="text-center"> 체크아웃 </th>
						<th class="col-md-4 text-center "> 기타 요청 사항</th>
						<th class="text-center"> 상태</th>
					</tr>
				</thead>
				<tbody id = "list" class="table-striped">
					<!-- 데이터 출력 -->
				<c:choose>
					<c:when test="${ not empty reservList }">
						<c:forEach var="reserv" items="${ reservList }" varStatus="status">
							<tr class="text-center reserv" data-num="${ reserv.reserv_no }"  cancel="${reserv.checkin }">
								<td> ${ reserv.reserv_no } </td>
								<td> ${reserv.user_no }</td>
								<td class="searchID"> ${reserv.user_id }</td>
								<td class="searchName"> ${reserv.reserv_name }</td>
								<td class="text-center searchHotel"> ${ reserv.hotel_name } </td>
								<td class="text-center">${ reserv.reserv_price }</td>
								<td class="searchCheckin"> ${reserv.checkin }</td>
                           		<td class="searchCheckout"> ${reserv.checkout }</td>
                           		<td> ${reserv.reserv_etc }</td>
                           		<td class="text-center">
   									<c:if test="${reserv.reserv_status==3 }">
     									<input type="button" id="reservResult" class="btn reservResult" readonly value="예약 취소 완료">
     								</c:if>
    								<c:if test="${reserv.reserv_status==1 }">
   										<input type="button" id="reservCancel" class="btn reservcancel" value="예약 취소">
   									</c:if>
   									<c:if test="${reserv.reserv_status==2}">
   										<input type="button" id="reservResult" class="btn reservResult" readonly value="이용 완료">
   									</c:if> 
   								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="5" class="tac text-center">예약 내역이 존재하지 않습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
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

<!-- SCRIPTS =============================-->
<script src="/resources/include/scorilo/js/jquery-.js"></script>
<script src="/resources/include/scorilo/js/bootstrap.min.js"></script>
<script src="/resources/include/scorilo/js/anim.js"></script>

</body>
</html>