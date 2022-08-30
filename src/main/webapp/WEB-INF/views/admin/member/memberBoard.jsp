<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

         <script type="text/javascript">
            $(function(){
               $("#memberListBtn").click(function(){
                  location.href="/admin/member/memberList";
               });
               
               $(".goDetail").click(function(){
                  let user_no = $(this).parents("tr").attr("data-number");
                  let b_no = $(this).parents("tr").attr("data-no");
                  let c_no = $(this).parents("tr").attr("data-categorynum");
                  $("#user_no").val(user_no);
                  $("#b_no").val(b_no);
                  $("#c_no").val(c_no)
                  //상세 페이지로 이동하기 위해 form 추가 (id : detailForm)
                  $("#f_data").attr({
                     "method":"get",
                     "action":"/admin/member/memberBoardDetail"
                  });
                  $("#f_data").submit();
                  
               });
               
               $(".goDiary").click(function(){
                  let d_no=$(this).parents("tr").attr("data-num");
                  let user_no2 = $(this).parents("tr").attr("data-user");
                  $("#d_no").val(d_no);
                  $("#user_no2").val(user_no2);
                  //console.log(d_no);
                  $("#diaryForm").attr({
                     "method":"get",
                     "action":"/admin/member/memberDiaryDetail"
                  });
                  $("#diaryForm").submit();
               });
            })
         </script>
      </head>
      <body>
         <div class="container toparea">
            <form name="f_data" id="f_data" method="post">
               <input type="hidden" id="user_no" name="user_no"/>
               <input type="hidden" id="b_no" name="b_no"/>
               <input type="hidden" id="c_no" name="c_no" />
            </form>
      
        <br/>
      <div id="boardList" class="table-height">
            <div id="boardSearch" class="text-right">
               <form id="f_search" name="f_search" class="form-inline">
                  <div class="form-group">
                     <label>검색조건</label>
                     <select id="search" name="search" class="form-control">
                        <option value="all">전체</option>
                        <option value="b_title">제목</option>
                        <option value="c_no">게시판</option>
                     </select>
                     <input type="text" name="keyword" id="keyword" value="검색어를 입력하세요" class="form-control"/>
                     <button type="button" id="searchData" class="btn btn-info">검색</button>
                  </div>
               </form>
            </div>
            <h3 class="categoryName text-center"></h3>
            <div>
            <h3>커뮤니티 작성글</h3>
         </div>
         <table summary="게시판 리스트" class="table table-striped">
            <thead>
               <tr >
                  <th data-value="user_num" class="order text-center col-md-1">게시판</th>
                  <th class="order text-center col-md-1">글번호</th>
                  <th class="order text-center col-md-3">글제목</th>
                  <th class="order text-center col-md-1">작성자</th>
                  <th data-value="b_date" class="order text-center col-md-1">작성일</th>
                  <th class="order text-center col-md-1">조회수</th>
               </tr>
            </thead>
            <tbody>
               <c:choose>
               <c:when test="${not empty communityBoardList}">
               <c:forEach items="${communityBoardList }" var="board" varStatus="status">
                  <tr class="info text-center" data-number="${board.user_no}" data-no="${board.b_no}" data-categorynum="${board.c_no}">
                     <td>${board.c_name} 게시판</td>
                     <td>${board.b_no }</td>
                     <td class="goDetail text-center">
                        ${board.b_title}
                        <c:if test="${board.com_rcnt > 0}"><span class="reply_count">[${board.com_rcnt}]</span></c:if>
                     </td>
                     <td>${board.user_id}</td>
                     <td class="text-center">${board.b_regdate}</td>
                     <td class="text-center">${board.b_readcnt}</td>
                  </tr>
               </c:forEach>
               </c:when>
               <c:otherwise>
                  <tr>
                     <td colspan="7" class="tac text-center">작성한 글이 없습니다.</td>
                  </tr>
               </c:otherwise>
               </c:choose>
            </tbody>
         </table>
         
         <%--------------------------------------------------------------------------------------------- --%>
         <div>
            <h3>다이어리 작성글</h3>
         </div>
         <form id="diaryForm">
            <input type="hidden" id="d_no" name="d_no"/>
            <input type="hidden" id="user_no2" name="user_no"/>
         </form>
         
         <table summary="다이어리 리스트" class="table table-striped">
            <thead>
               <tr >
                  <th class="order text-center col-md-1">글번호</th>
                  <th class="order text-center col-md-3">글제목</th>
                  <th class="order text-center col-md-1">작성자</th>
                  <th data-value="d_regdate" class="order text-center col-md-1">작성일</th>
                  <th class="order text-center col-md-1">조회수</th>
               </tr>
            </thead>
            <tbody>
               <c:choose>
               <c:when test="${not empty diaryList}">
               <c:forEach items="${diaryList }" var="diary" varStatus="status">
                  <tr class="info text-center" data-user="${diary.user_no}" data-num="${diary.d_no}">
                     <td>${diary.d_no }</td>
                     <td class="goDiary text-center">${diary.d_title}</td>
                     <td>${diary.user_id}</td>
                     <td class="text-center">${diary.d_regdate}</td>
                     <td class="text-center">${diary.d_readcnt}</td>
                  </tr>
               </c:forEach>
               </c:when>
               <c:otherwise>
                  <tr>
                     <td colspan="7" class="tac text-center">작성한 글이 없습니다.</td>
                  </tr>
               </c:otherwise>
               </c:choose>
            </tbody>
         </table>
         
         <br/>
         
         
         
         <div class="text-right">
            <button type="button" class="btn btn-info" id="memberListBtn">회원목록</button>
         </div>
               
      </div>
   </div>
      </body>
   </html>