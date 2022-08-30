<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<!DOCTYPE html>
<script type="text/javascript">
	$(function(){
		 $("#boardListBtn").click(function(){
	         location.href = "/admin/member/memberBoardList?user_no="+${detail.user_no}
	      })
	      
	      $("#boardDeleteBtn").click(function(){
	         if(confirm("삭제하시겠습니까?")){
	            location.href = "/admin/member/memberBoardDelete?user_no="+${detail.user_no}+"&c_no="+${detail.c_no}+"&b_no="+${detail.b_no}
	         }
	      })

	})
</script>
</head>
<body>
<div class="container toparea">
		<form name="f_data" id="f_data" method="post">
			<input type="hidden" name="user_no"/>
		</form>
		<div class="contentTB text-center">
			<h3 class="text-center"></h3>
			<table class="table table-bordered">
					<tr>
						<td class="col-md-1">글제목</td>
						<td colspan="3" class="col-md-8 text-left">${detail.b_title} (조회수 : ${detail.b_readcnt})</td>
					</tr>
					<tr>
						<td class="col-md-1">작성자</td>
						<td class="col-md-2 text-left">${detail.user_id}</td>
						<td class="col-md-1">작성일</td>
						<td class="col-md-2 text-left">${detail.b_regdate}</td>
					</tr>
					<tr class="table-tr-height">
						<td class="col-md-1">글내용</td>
						<td colspan="3" class="col-md-8 text-left">${detail.b_content}</td>
					</tr>
					<c:if test="${not empty detail.b_file}">
					<tr>
						<td class="col-md-4">이미지</td>
						<td colspan="3" class="col-md-8 text-left">
							<img src="/petcationStorage/CommunityBoard/${detail.b_file}"/>
						</td>
					</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		<div class="text-right">
			<button type="button" id="boardDeleteBtn" class="btn btn-info">삭제</button>
			<button type="button" id="boardListBtn" class="btn btn-info">목록</button>
		</div>
	</div>
</body>