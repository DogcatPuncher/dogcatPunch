<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<script type="text/javascript">
$(function(){
   $("#noticeUpdateBtn").click(function(){
      if(!chkData("#n_title","제목을")) return;
      else if(!chkData("#n_content", "작성할 내용을")) return;
      else {
         /*if($("#file").val() != ""){
            if(!chkFile($("#file"))) return;
         }*/
         
         $("#n_updateForm").attr({
            "method" : "post",
            //"enctype": "multipart/form-data", // enctype 속성의 기본 값은 "application/x-www-form-urlcencoded" POST방식 폼 전송에 기본 값으로 사용
            "action" : "/admin/notice/noticeUpdate"
         });
         $("#n_updateForm").submit();
      }
   });
   
   $("#noticeCancelBtn").click(function(){
      $("#n_updateForm").each(function(){
         this.reset();
      });
   });
   
   $("#noticeListBtn").click(function(){
      location.href="/admin/notice/noticeList";
   });
});
</script>

<body>
   <div class="container">
            <form id="n_updateForm" name="n_updateForm" class="form-horizontal">
               <input type="hidden" id="n_no" name="n_no" value="${updateData.n_no}"/>
            
               <table class="table table-bordered">
                  <colgroup>
                     <col width="20%" />
                     <col width="80%" />
                  </colgroup>
                  <tbody>
                     <tr>
						<td style="vertical-align: middle;">제목</td>
						<td><input type="text" class="form-control" name="n_title" id="n_title" value="${updateData.n_title}" autofocus="autofocus" /></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2">
						<textarea id="n_content" name="n_content" rows="10" cols="100" required="required">${updateData.n_content}</textarea>
						</td>							
					</tr>
                  </tbody>
               </table>
               
               <div class="text-right">
                  <input type="button" id="noticeUpdateBtn" value="수정" class="btn btn-info" />
                  <input type="button" id="noticeCancelBtn" value="취소" class="btn btn-info" />
                  <input type="button" id="noticeListBtn" value="목록" class="btn btn-info" />
               </div>
            </form>
         </div>
</body>