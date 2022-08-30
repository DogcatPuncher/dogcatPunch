<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
    
		<style>
			@font-face {
			  font-family: SCDream5;
			  src: url('/resources/include/dist/fonts/SCDream5.otf'); 
			}
			
			container {
				margin-bottom : 100px;
			}
			
			body {
				font-family: SCDream5;
			}
			
			.col-md-3 {
				width:150px;
			}
			
			table {
				width: 900px;
			}
			
			button {
				background-color : white;
				border : 1px solid lightgray;
			}
			
		</style>   	
		<script>
		
			$(function() {
				$("#qnaUpdateBtn").click(function() {
					if(!chkData("#q_title","제목을")) return;
					else if(!chkData("#q_content","작성할 내용을")) return;
					else {
						if($("#file").val()!="") {
							if(!chkFile($("#file"))) return;
						}
						$("#f_updateForm").attr({
							method:"post",
							enctype : "multipart/form-data",
							action:"/qna/qnaUpdate"
						})
						$("#f_updateForm").submit();
					}
				})
				
				/* $("#qnaCancelBtn").click(function() {
					$("#f_updateForm").each(function(){
						this.reset;
					})
				}) */
				$("#qnaListBtn").click(function() {
					location.href="/qna/qnaList";	
				})
			})
		</script>
	<title>Insert title here</title>
	</head>
	<body>
		<header class="item header margin-top-0">
	      <div class="wrapper">
	            <div class="container">
	               <div class="row">
	                  <div class="col-md-12 text-center">
	                     <div class="text-pageheader">
	                           <div class="subtext-image" data-scrollreveal="enter bottom over 1.7s after 0.0s">
	                            Q&A
	                           </div>
	                     </div>
	                  </div>
	               </div>
	            </div>
	      </div>
	   </header>
	   <div class="container toparea">
			<div class="contentContainer container">
				<!-- 
				<div class="contentTit page-header"><h3 class="text-center">게시판 글작성</h3></div>
				 -->
				
				<div class="contentTB text-center">
					<form id="f_updateForm" name="f_updateForm">
						<input type="hidden" id="q_num" name="q_num" value="${updateData.q_num}" />
						<input type="hidden" id="q_file" name="q_file" value="${updateData.q_file}" />
						<input type="hidden" id="q_thumb" name="q_thumb" value="${updateData.q_thumb}" />
						
						<table class="table table-bordered">
							<tbody>
								<tr>
									<td class="col-md-3">글번호</td>
									<td class="text-left">${updateData.q_num}</td>
									<td class="col-md-3">작성일</td>
									<td class="text-left">${updateData.q_date}</td>
								</tr>
								<tr>
									<td>작성자</td>
									<td colspan="3" class="text-left">${updateData.q_name}</td>
								</tr>
								<tr>
									<td>글제목</td>
									<td colspan="3" class="text-left">
										<input type="text" name="q_title" id="q_title" value="${updateData.q_title}" class="form-control"/>
									</td>
								</tr>
								<tr class="table-tr-height">
									<td>글내용</td>
									<td colspan="3" class="text-left">
										<textarea name="q_content" id="q_content" rows="8" class="form-control">${updateData.q_content}</textarea>
									</td>
								</tr>
								<tr class="form-inline">
									<td>비밀번호</td>
									<td colspan="3" class="text-left">
										<input type="password" name="q_pwd" id="q_pwd" class="form-control" maxlength="4"/>
										<label>수정할 비밀번호를 입력해 주세요.</label>
									</td>
								</tr>
								<tr>
									<td>이미지파일첨부</td>
									<td colspan="3" class="text-left"><input type="file" name="file" id="file" /></td>
								</tr>
							</tbody>
						</table>
						
						<div class="text-right">
						<button type="button" id="qnaUpdateBtn" class="">등록</button>
						<button type="button" id="qnaListBtn" class="">목록</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<br/><br/>
	</body>
</html> 