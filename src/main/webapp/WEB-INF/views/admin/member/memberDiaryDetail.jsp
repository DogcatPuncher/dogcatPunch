<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<!DOCTYPE html>
<script type="text/javascript">
   $(function(){
      $("#boardListBtn").click(function(){
         location.href = "/admin/member/memberBoardList?user_id="+${detail.user_id}
      })
      
      $("#diaryDeleteBtn").click(function(){
         if(confirm("삭제하시겠습니까?")){
            goUrl = "/admin/member/memberDiaryDelete";
            $("#f_data").attr("action", goUrl);
            $("#f_data").submit();
         }
      })
   })
</script>
</head>
<body>
<div class="container toparea">
      <div class="contentTB text-center">
         <form name="f_data" id="f_data" method="post">
            <input type="hidden" name="d_no" value="${detail.d_no}"/>
            <input type="hidden" name="user_id" value="${detail.user_id }">
         </form>
         <h3 class="text-center">상세페이지</h3>
         <table class="table table-bordered">
               <tr>
                  <td class="col-md-4">글제목</td>
                  <td colspan="3" class="col-md-8 text-left">${detail.d_title}</td>
               </tr>
               <tr>
                  <td class="col-md-3">작성자</td>
                  <td class="col-md-3 text-left">${detail.user_id} (조회수 : ${detail.d_readcnt})</td>
                  <td class="col-md-3">작성일</td>
                  <td class="col-md-3 text-left">${detail.d_regdate}</td>
               </tr>
               <tr class="table-tr-height">
                  <td class="col-md-4">글내용</td>
                  <td colspan="3" class="col-md-8 text-left">${detail.d_content}</td>
               </tr>
         </table>
      </div>
      <div class="text-right">
         <button type="button" id="diaryDeleteBtn" class="btn btn-info">삭제</button>
         <button type="button" id="boardListBtn" class="btn btn-info">목록</button>
      </div>
   </div>