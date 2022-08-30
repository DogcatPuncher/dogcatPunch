<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

<link rel="stylesheet" href="/resources/include/icofont/icofont.min.css">
<link rel="stylesheet" href="/resources/include/icofont/fonts/icofont.woff">
<link rel="stylesheet" href="/resources/include/icofont/fonts/icofont.woff2">
		
		<style>
			@font-face {
			  font-family: SCDream5;
			  src: url('/resources/include/dist/fonts/SCDream5.otf'); 
			}
			
			input, textarea {
				border : none;
				margin-bottom:20px;
			}
			
			body {
				font-family: SCDream5;
			}
			
			button {
				background-color:white;
				border : 1px solid lightgray;
			}
			
			table{
				width: 900px;
				border: none;
			}
			
			.form-control {
				border:none;
			}
			
			.tHeight {
				height: 50px;
				font-size : 20px;
			}
			
			.wborder{
				border : 1px solid #e3e3e3;
				padding : 40px;
				margin-bottom : 30px;
			}
			
			#q_content {
				padding:40px;
			}
			
		</style>   	
		<script>
			$(function() {
				
				$("#qnaInsertBtn").click(function(){
					if(!chkData("#q_title", "제목을")) return;
					else if(!chkData("#q_content", "작성할 내용을")) return;
					else if(!chkData("#q_pwd", "비밀번호를")) return;
					else {
						if($("#file").val()!=""){
						if(!chkFile($("#file"))) return;
						}
						
						$("#f_writeForm").attr({
							method:"post",
							enctype:"multipart/form-data",
							action:"/qna/qnaWrite"
						})
						$("#f_writeForm").submit();
					}
				});
				
				$("#qnaListBtn").click(function(){
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
				
				<div class="contentTB text-center wborder">
					<form id="f_writeForm" name="f_writeForm" class="form-horizontal">
						<input type="hidden" name="user_no" value="${lmember.user_no}"/>
						<table>
							<tbody>
								<tr>
									<!-- <td>글제목</td> -->
									<td class="text-left"><input type="text" id="q_title" name="q_title" placeholder="제목을 입력하세요" class="form-control tHeight"/></td>
								</tr>
								<tr>
									<!-- <td>작성자</td> -->
									<c:choose>
										<c:when test="${lmember!=null}">
						                    <td class="text-left"><input type="hidden" id="q_name" name="q_name" class="form-control" value="${lmember.user_name}" readonly/></td>
										</c:when>
										<c:when test="${nname!=null}">
						                    <td class="text-left"><input type="hidden" id="q_name" name="q_name" class="form-control" value="${nname}" readonly/></td>
										</c:when>
										<c:when test="${kname!=null}">
						                    <td class="text-left"><input type="hidden" id="q_name" name="q_name" class="form-control" value="${kname}" readonly/></td>
										</c:when>
									</c:choose>
								</tr>
								<tr>
									<!-- <td>글내용</td> -->
									<td class="text-left"><textarea name="q_content" id="q_content" class="form-control" rows="15"></textarea></td>
								</tr>
								<tr>
									<!-- <td>비밀번호</td> -->
									<td class="text-left"><input type="text" id="q_pwd" name="q_pwd" class="form-control pwWid" placeholder="비밀번호" maxlength="4" style="width:150px;"/></td>
								</tr>
								<tr>
									<!-- <td>이미지파일첨부</td> -->
									<td class="text-left"><input type="file" id="file" name="file" /></td>
								</tr>
							</tbody>
						</table>
						
						<div class="text-right">
						<button type="button" id="qnaInsertBtn" class="">등록</button>
						<button type="button" id="qnaListBtn" class="">목록</button>
						</div>
					</form>
				</div>
			</div>
		</div>		
	</body>
</html>