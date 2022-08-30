<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
	<title></title>
	

	<link rel="shortcut icon" href="/resources/image/icon.png"/>
	<link rel="apple-touch-icon" href="/resources/image/icon.png"/>
	

	<link rel="stylesheet" type="text/css" href="/resources/include/scorilo/css/bootstrap.min.css"/>
	<link rel="stylesheet" type="text/css" href="/resources/include/scorilo/css/bootstrap-theme.min.css"/>
	<!--<link rel="stylesheet" type="text/css" href="/resources/include/scorilo/css/justified-nav"/>-->
	<link rel="stylesheet" type="text/css" href="/resources/include/scorilo/css/style.css" >
	<link href="https://fonts.googleapis.com/css?family=Dosis:200,300,400,500,600,700" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Roboto:200,300,400,500,600,700" rel="stylesheet">
	<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="/resources/include/js/common.js"></script>
	<script type="text/javascript" src="/resources/include/scorilo/js/bootstrap.min.js"></script>
	<style>
		#boardListBtn{
			background: url( "/resources/images/common/listbtn.png" ) no-repeat;
	        border: none;
	        font-size : 13px;
	        color:#fff;
	        width: 60px;
	        height: 60px;
	        background-size: contain;
	        cursor: pointer;
	        line-height:200%;
	        color:black;
	        margin-bottom:25px;
		}
		#updateFormBtn{
			background: url( "/resources/images/common/updatebtn.png" ) no-repeat;
	        border: none;
	        font-size : 13px;
	        color:#fff;
	        width: 60px;
	        height: 60px;
	        background-size: contain;
	        cursor: pointer;
	        line-height:200%;
	        color:black;
	        margin-bottom:25px;
		}
		#boardDeleteBtn{
			background: url( "/resources/images/common/delbtn.png" ) no-repeat;
	        border: none;
	        font-size : 13px;
	        color:#fff;
	        width: 60px;
	        height: 60px;
	        background-size: contain;
	        cursor: pointer;
	        line-height:200%;
	        color:black;
	        margin-bottom:25px;
		}
		#boardListBtn,#boardDeleteBtn,#updateFormBtn:focus { outline: none; }	
	</style>
	<script type="text/javascript">
		$(function(){
			$("#boardListBtn").click(function(){
				location.href = "/diary/diaryBoardList";
			});
			
			$("#boardDeleteBtn").click(function(){
				if(confirm("정말 삭제하시겠습니까?")){
					goUrl="/diary/diaryDelete";
					$("#f_data").attr("action",goUrl);
					$("#f_data").submit();
				}return;
			});
			$("#updateFormBtn").click(function(){
				let goUrl = "";
				goUrl = "/diary/diaryBoardUpdate";
				$("#f_data").attr("action",goUrl);
				$("#f_data").submit();
				
			});//updateForm
		});
	</script>
</head>
<body>
	<header class="item header margin-top-0">
		<div class="wrapper">
	   		<div class="container">
	      		<div class="row">
	         		<div class="col-md-12 text-center">
	            		<div class="text-pageheader">
	               			<div class="subtext-image" data-scrollreveal="enter bottom over 1.7s after 0.0s">
	                   			Travel Diary
	               			</div>
	            		</div>
	         		</div>
	      		</div>
	   		</div>
		</div>
	</header>
	<div class="container toparea">
		<div class="contentTB text-center">
			<form name="f_data" id="f_data" method="post">
				<input type="hidden" name="d_no" value="${detail.d_no}"/>
				<input type="hidden" name="d_file" value="${detail.d_file }"/>
				<input type="hidden" name="d_thumb" value="${detail.d_thumb}">
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
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
					<jsp:include page="diaryReply.jsp"/>
		<div class="contentBtn text-right">
			<c:if test="${lmember.user_id==detail.user_id }">
				<input type="button" value="" id="updateFormBtn"class="btn btn-warning">
				<input type="button" value="" id="boardDeleteBtn"class="btn btn-warning">
			</c:if>
			<input type="button" value="" id="boardListBtn"class="btn btn-warning">
		</div>
	</div>
</body>
</html>