<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

         <script type="text/javascript">
            $(function(){
               let word = "<c:out value='${data.keyword}' />";
               let value = "";
               if(word != ""){
                  $("#keyword").val("<c:out value='${data.keyword}' />");
                  $("#search").val("<c:out value='${data.search}' />");
                  
                  if($("#search").val() != 'b_content'){
                     //:contains() 는 특정 테스트를 포함한 요소반환
                     if($("#search").val() == 'user_id') value = "#list tr td.goDetail";
                     else if($("#search").val() == 'user_name') value = "#list tr td.goDetail";
                     else if($("#search").val() == 'user_phone') value = "#list tr td.goDetail";
                     else if($("#search").val() == 'user_email') value = "#list tr td.goDetail";

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
               
               $("#insertFormBtn").click(function(){
                  location.href = "/board/writeForm";
               });
               
               $(".banBtn").click(function(){
            	  let check = confirm("정말 회원 탈퇴 하시겠습니까? 예약중인 회원의 예약이 취소, 환불됩니다.");
				  if(check == false) return false;
					
                  let user_no = $(this).parents("tr").attr("data-no");
                  console.log(user_no);
               	  location.href = "/admin/member/memberDelete?user_no=" + user_no;
               });
               
               $("#search").change(function() {
                    if($("#search").val()=="all") {
                       $("#keyword").val("전체 데이터 조회입니다.");
                    } else if($("#search").val() != "all") {
                       $("#keyword").val("");
                       $("#keyword").focus();
                    }
                 })
               
               $(".goBoard").click(function(){
                  let user_no = $(this).parents("tr").attr("data-no");
                  let user_id = $(this).parents("tr").attr("data-id");
                  $("#user_no").val(user_no);
                  $("#user_id").val(user_id);
                  //상세 페이지로 이동하기 위해 form 추가 (id : detailForm)
                  $("#detailForm").attr({
                     "method":"get",
                     "action":"/admin/member/memberBoardList"
                  });
                  $("#detailForm").submit();
                  
                  //location.href="/admin/member/memberBoardList?user_no=" + user_no;
               });;
               
               $(".paginate_button a").click(function(e){
                  e.preventDefault();
                  $("#m_search").find("input[name='pageNum']").val($(this).attr("href"));
                  goPage();
               });
               
            });
            
            function goPage(){
               if($("#search").val() == "all"){
                  $("#keyword").val("");
               }
               $("#m_search").attr({
                  "method":"get",
                  "action":"/admin/member/memberList"
               });
               $("#m_search").submit();
            }
            
         </script>
      </head>
      <body>
         <div class="container">
            <div class="contentTit page-header"><h3 class="text-center">회원 리스트</h3></div>
            
            <form id="detailForm">
               <input type="hidden" id="user_no" name="user_no" />
               <input type="hidden" id="user_id" name="user_id" />
            </form>
            
            <%-- ================= 검색기능 시작 ================= --%>
            <div id="boardSearch" class="text-right">
               <form id="m_search" name="m_search" class="form-inline">
                  <input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}">
                  <input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
                  <div class="form-group">
                     <label>검색조건</label>
                     <select id="search" name="search" class="form-control">
                        <option value="all">전체</option>
                        <option value="user_name">이름</option>
                        <option value="user_id">아이디</option>
                        <option value="user_phone">휴대폰번호</option>
                        <option value="user_email">이메일</option>
                     </select>
                     <input type="text" name="keyword" id="keyword" value="검색어를 입력하세요" class="form-control" />
                     <button type="button" id="searchData" class="btn btn-success">검색</button>
                  </div>
               </form>
            </div>
            
            <%-- ================= 검색기능 종료 ================= --%>
            
            <%-- ================= 리스트 시작 ================= --%>
            <div id="boardList" class="table-height">
               
            
               <table summary="게시판 리스트" class="table table-striped">
                  <thead>
                     <tr>
                        <th data-value="b_num" class="order text-center col-md-1">회원번호</th>
                        <th class="text-center col-md-1">이름</th>
                        <th data-value="b_date" class="order text-center col-md-1">아이디</th>
                        <th class="text-center col-md-1">계정생성일</th>
                        <th class="text-center col-md-1">휴대폰번호</th>
                        <th class="text-center col-md-1">이메일</th>
                        <th class="text-center col-md-1"></th>
                     </tr>
                  </thead>
                  <tbody id="list" class="table-striped">
                     <!-- 데이터 출력 -->
                     <c:choose>
                        <c:when test="${not empty memberList}">
                           <c:forEach var="member" items="${memberList}" varStatus="status">
                              <tr class="text-center" data-no="${member.user_no}" data-id="${member.user_id}">
                                 <td>${member.user_no}</td>
                                 <td class="text-center goBoard">${member.user_name}</td>
                                 <td class="goBoard text-center">${member.user_id}</td>
                                 <td class="text-center">${member.user_date}</td>
                                 <td class="text-center">${member.user_phone}</td>
                                 <td class="email">${member.user_email }</td>
                                 <td class="ban"><input type="button" class="banBtn" value="탈퇴"></td>
                              </tr>
                           </c:forEach>
                        </c:when>
                        <c:otherwise>
                           <tr>
                              <td colspan="7" class="tac text-center">가입한 회원이 없습니다.</td>
                           </tr>
                        </c:otherwise>
                     </c:choose>
                  </tbody>
               </table>
            </div>
            <%-- ================= 리스트 종료 ================= --%>   
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
      </body>
   </html>