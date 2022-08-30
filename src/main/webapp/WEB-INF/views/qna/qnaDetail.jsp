<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

	<style>
		@font-face {
		  font-family: SCDream5;
		  src: url('/resources/include/dist/fonts/SCDream5.otf'); 
		}
		
		body {
			font-family: SCDream5;
		}
		
		table {
			border : none;
		}
		
		.container{
			width: 1000px;
		}
		
		button {
			background-color:white;
			border : 1px solid #f7f7f7;
		}
		
		img{
			width:500px;
		}
		
		.detailBtn{
			background: url( "/resources/images/common/catbtn.png" ) no-repeat;
	        border: none;
	        font-size : 13px;
	        width: 60px;
	        height: 55px;
	        background-size: contain;
	        cursor: pointer;
	        line-height:200%;
	        color:black;
	        margin-bottom:30px;
	        line-height:180%;
		}
		
		.title-height {
			height : 50px;
			font-size : 20px;
		}
		
		.table-tr-height{
			height : 200px;
		}
		
		.wborder{
			border : 1px solid #e3e3e3;
			padding : 40px;
			margin-bottom : 30px;
		}
		
	</style>
		<script>
			let buttonCheck = 0; //수정버튼과 삭제버튼 구별하기 위한 변수
			$(function() {
				
				$("#pwdChk").css("visibility","hidden");
				
				$("#updateFormBtn").click(function() {
					$("#pwdChk").css("visibility","visible");
					$("#q_pwd").focus();
					$("#msg").text("작성시 입력한 비밀번호를 입력해 주세요.").css("color","#000099");
					buttonCheck = 1;
				});
				
				/*
				$("#qnaDeleteBtn").click(function() {
					$("#pwdChk").css("visibility","visible");
					$("#msg").text("작성시 입력한 비밀번호를 입력해 주세요.").css("color","#000099");
					buttonCheck = 2;
				})
				*/
				
				$("#qnaDeleteBtn").click(function() {
					$.ajax({
						url : "/qna/replyCnt",
						type : "post",
						data : "q_num="+$("#q_num").val(),
						dataType : "text",
						error : function() {
							alert('시스템 오류. 관리자에게 문의하세요');
						},
						success : function(resultData){
							if(resultData==0){
								$("#pwdChk").css("visibility", "visible");
								$("#q_pwd").focus();
								$("#msg").text("작성시 입력한 비밀번호를 입력해 주세요.").css("color", "#000099");
								buttonCheck = 2;
							} else{
								alert("댓글 존재시 게시물 삭제를 할 수가 없습니다.\n댓글 삭제 후 다시 확인해주세요.")
								return;
							}
						}
					})
				});
					
				$("#p_pwd").bind("keydown", function(event) {
					if(event.keyCode === 13) {
						event.preventDefault();
					}
				})
				
				$("#pwdBtn").click(function() {
					qnaPwdConfirm();
				})
				
				$("#insertFormBtn").click(function() {
					location.href="/qna/qnaWrite";
				})
				
				$("#qnaListBtn").click(function() {
					location.href="/qna/qnaList";
				})

			})
			
				function qnaPwdConfirm() {
					if(!formCheck($('#q_pwd'),$('#msg'), "비밀번호를")) return;
					else {
						$.ajax({
							url : "/qna/pwdConfirm",
							type : "post",
							data : $("#f_pwd").serialize(),
							dataType : "text",
							error : function() {
								alert('시스템 오류입니다. 관리자에게 문의하세요.');
							},
							success : function(resultData) {
								let goUrl="";
								console.log(resultData);
								if(resultData=="실패"){
									$("#msg").text("작성시 입력한 비밀번호가 일치하지 않습니다.").css("color","red");
									$("#q_pwd").select();
								} else if(resultData=="성공") {
									$("#msg").text("");
									if(buttonCheck==1) {
										goUrl = "/qna/qnaUpdateForm";
										$("#f_data").attr("action",goUrl);
										$("#f_data").submit();
									} else if(buttonCheck==2) {
										if(confirm("정말 삭제하시겠습니까?")) {
											goUrl = "/qna/qnaDelete";
											$("#f_data").attr("action",goUrl);
											$("#f_data").submit();
										}
									}
								}
							}
						})
					}
				}
			
		</script>
		<link rel="stylesheet" type="text/css" href="/resources/include/dist/css/bootstrap-theme.min.css"/>
		<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
		 <script type="text/javascript" src="/resources/include/js/common.js"></script>

		
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
					<button id="updateFormBtn" class="detailBtn"><br/><br/>수정</button>
					<button id="qnaDeleteBtn" class="detailBtn"><br/><br/>삭제</button>
					<button id="insertFormBtn" class="detailBtn" style="color:black;"><br/><br/>글쓰기</button>
					<button id="qnaListBtn" class="detailBtn"><br/><br/>목록</button>
				</div>
			</div>
			<div class="contentTB text-center wborder">
				<table style="border:none;">
					<tbody>
						<tr>
							<!-- <td class="wh">글제목</td> -->
							<td colspan="3" class="col-md-8 text-left title-height">${detail.q_title}</td>
						</tr>
						<tr style="border-bottom:1px solid lightgray;">
							<!-- <td class="wh">작성자</td> -->
							<td class="col-md-3 text-left">${detail.q_name} (조회수: ${detail.readcnt})</td>
							<!-- <td class="wh">작성일</td> -->
							<td class="col-md-3 text-left">${detail.q_date}</td>
							
						</tr>
						<tr class="table-tr-height">
							<!-- <td class="wh">글내용</td> -->
							<td colspan="3" class="col-md-8 text-left">${detail.q_content}</td>
						</tr>
						<c:if test="${not empty detail.q_file}">
							<tr>
								<!-- <td class="wh">이미지</td> -->
								<td colspan="3" class="col-md-8 text-left">
									<img src="/petcationStorage/qna/${detail.q_file}" />
								</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
						<br/><br/>
			<jsp:include page="reply.jsp" /> 
		</div>
		</div>
		<br/><br/>
	</body>
</html> 