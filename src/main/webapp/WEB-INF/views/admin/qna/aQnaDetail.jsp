<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
		
		<style>
			img { 
				width: 600px;
			}
			
			.con {
				height : 100px;
			}
			
			.replyBtn {
				display:inline-block;
			}	
		</style>
		<script>
		let buttonCheck = 0; //수정버튼과 삭제버튼 구별하기 위한 변수
		$(function() {
			
			$("#pwdChk").css("visibility","hidden");
			
		 
			$("#qnaDeleteBtn").click(function() {
	
				if(confirm("정말 삭제하시겠습니까?")) {
						goUrl = "/admin/qna/aQnaDelete";
						$("#f_data").attr("action",goUrl);
						$("#f_data").submit();
				}
				
			});
				
/* 			$("#p_pwd").bind("keydown", function(event) {
				if(event.keyCode === 13) {
					event.preventDefault();
				}
			}) */
			
			
			$("#qnaListBtn").click(function() {
				location.href="/admin/qna/qnaList";
			})

		})

					
		</script>
		<link rel="stylesheet" type="text/css" href="/resources/include/dist/css/bootstrap-theme.min.css"/>
		<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
		 <script type="text/javascript" src="/resources/include/js/common.js"></script>

		
	<title>Insert title here</title>
	</head>
	<body>
		<div class="contentContainer container">
			<!--  
			<div class="contentTit page-header"><h3 class="text-center">게시판 리스트</h3></div>
			-->
			
			<form name="f_data" id="f_data" method="post">
				<input type="hidden" name="q_num" value="${detail.q_num}"/>
				<input type="hidden" name="q_file" value="${detail.q_file}"/>
				<input type="hidden" name="q_thumb" value="${detail.q_thumb}"/>
			</form>
			
			<div id="qnaPwdBut" class="row text-center">
				<div id="pwdChk" class="authArea col-md-8 text-left">
					<form name="f_pwd" id="f_pwd" class="form-inline">
						<input type="hidden" name="q_num" id="q_num" value="${detail.q_num}"/>
						<label for="q_pwd" id="l_pwd">비밀번호 : </label>
						<input type="password" name="q_pwd" id="q_pwd" class="form-control" />
						
						<button type="button" id="pwdBtn" class="btn btn-default">확인</button>
						<span id="msg"></span>
					</form>
				</div> 
				<div class="btnArea col-md-4 text-right">
					<input type="button" value="글삭제" id="qnaDeleteBtn" class="btn btn-success"/>
					<!-- <input type="button" value="글쓰기" id="insertFormBtn" class="btn btn-success"/> -->
					<input type="button" value="목록" id="qnaListBtn" class="btn btn-success"/>
				</div>
			</div>
			<div class="contentTB text-center">
				<table class="table table-bordered">
					<tbody>
						<tr>
							<td class="col-md-3">회원번호</td>
							<td class="col-md-3 text-left">${detail.user_no}</td>
							<td class="col-md-3">글번호</td>
							<td class="col-md-3 text-left">${detail.q_num}</td>
						</tr>
						<tr>
							<td class="col-md-3">작성자</td>
							<td class="col-md-3 text-left">${detail.q_name} (조회수: ${detail.readcnt})</td>
							<td class="col-md-3">작성일</td>
							<td class="col-md-3 text-left">${detail.q_date}</td>
						</tr>
						<tr>
							<td class="col-md-4">글제목</td>
							<td colspan="3" class="col-md-8 text-left">${detail.q_title}</td>
						</tr>
						<tr class="table-tr-height">
							<td class="col-md-4 con">글내용</td>
							<td colspan="3" class="col-md-8 text-left">${detail.q_content}</td>
						</tr>
						<c:if test="${not empty detail.q_file}">
						<tr>
							<td class="col-md-4">이미지</td>
							<td colspan="3" class="col-md-8 text-left">
								<img src="/petcationStorage/qna/${detail.q_file}" />
							</td>
						</tr>
						</c:if>
					</tbody>
				</table>
			</div>
			<jsp:include page="../../qna/reply.jsp" />
		</div>
	</body>
</html>